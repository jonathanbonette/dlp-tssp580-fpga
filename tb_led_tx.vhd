-- tb_led_tx.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_led_tx is
end tb_led_tx;

architecture test of tb_led_tx is
  signal clk     : std_logic := '0';
  signal rst     : std_logic := '0';
  signal led_out : std_logic;
  
  constant clk_period : time := 1 us;  -- clock de 1 MHz (1 us de período)
  
begin

  -- Instancia o DUT (Device Under Test) com parâmetros reduzidos para simulação
  uut: entity work.led_tx
    generic map(
      MOD_PERIOD     => 100, -- período total de 100 ciclos (100 µs)
      MOD_ON_TIME    => 50,  -- 50% ativo (50 µs ligado, 50 µs desligado)
      IR_HALF_PERIOD => 5    -- gera uma portadora com período de 10 ciclos (100 kHz)
    )
    port map(
      clk     => clk,
      rst     => rst,
      led_out => led_out
    );

  -- Geração do clock
  clk_process: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;
  
  -- Processo de estímulo
  stim_proc: process
  begin
    -- Aplica reset
    rst <= '1';
    wait for 20 us;
    rst <= '0';
    
    -- Aguarda tempo suficiente para observar alguns ciclos da modulação
    wait for 500 us;
    
    -- Encerra a simulação
    assert false report "Fim da simulação" severity failure;
  end process;

end test;
