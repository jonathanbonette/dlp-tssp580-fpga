-- tb_led_tx_sensor_noise.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_noise is
end tb_noise;

architecture test of tb_noise is
  -- Sinais para simulação
  signal clk        : std_logic := '0';
  signal rst        : std_logic := '0';
  signal led_out    : std_logic;  -- Saída do módulo led_tx (pulsos de 38 kHz durante o burst)
  signal sensor_out : std_logic := '1';  -- Saída simulada do sensor (normalmente '1')
  
  -- Constante: clock de 1 MHz (período de 1 µs)
  constant clk_period : time := 1 us;
  
begin

  -- Instanciação do DUT (led_tx) com parâmetros reduzidos para simulação:
  -- MOD_PERIOD = 100 µs; MOD_ON_TIME = 50 µs; IR_HALF_PERIOD = 5 (resultando em 100 kHz de portadora)
  uut: entity work.led_tx
    generic map(
      MOD_PERIOD     => 100,  -- Período total de 100 µs
      MOD_ON_TIME    => 50,   -- Burst ativo durante 50 µs
      IR_HALF_PERIOD => 5     -- Gera uma portadora com período de 10 µs (100 kHz)
    )
    port map(
      clk     => clk,
      rst     => rst,
      led_out => led_out
    );

  -- Geração do clock de 1 MHz
  clk_process: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  -- Processo de estímulo para o reset
  stim_proc: process
  begin
    rst <= '1';
    wait for 20 us;
    rst <= '0';
    wait;
  end process;

  --
  sensor_proc: process
  begin
    sensor_out <= '1';
    wait for 30 us;   
    
      -- 1 ciclo
        -- Início do burst: sensor detecta o LED e deveria ir para '0'
      sensor_out <= '0';
      wait for 10 us; 
      
      -- Ruído: sensor vai para '1' brevemente
      sensor_out <= '1';
      wait for 3 us;      -- Duração do ruido
      
      sensor_out <= '0';
      wait for 17 us;

      -- Ruído: sensor vai para '1' brevemente
      sensor_out <= '1';
      wait for 1 us;      -- Duração do ruido

      sensor_out <= '0';
      wait for 7 us;

      -- Ruído: sensor vai para '1' brevemente
      sensor_out <= '1';
      wait for 161 us;      -- Duração do ruido


-- 2 ciclo
         

        sensor_out <= '0';
        wait for 3 us;      -- Duração do ruido    

        sensor_out <= '1';
        wait for 2 us;      -- Duração do ruido    

        sensor_out <= '0';
        wait for 10 us;        -- Duração do ruido    

        sensor_out <= '1';
        wait for 1 us;      -- Duração do ruido

        sensor_out <= '0';
        wait for 25 us;      -- Duração do ruido

        sensor_out <= '1';
        wait;      -- Duração do ruido
  end process;
  
end test;
