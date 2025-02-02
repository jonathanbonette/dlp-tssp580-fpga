-- ===============================================================
-- Arquivo: tb_optical_test_signal.vhd
-- Descrição: Testbench para simular o módulo optical_test_signal
--            com os parâmetros reais (60ms e 600µs por pulso).
--            Permite observar um único período de 60ms.
-- Autor: Jonathan & Matheus
-- Data: 2025-02-02
-- ===============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_optical_test_signal is
    -- Testbench não possui portas
end tb_optical_test_signal;

architecture Behavioral of tb_optical_test_signal is

    component optical_test_signal is
        Port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            test_sig : out std_logic
        );
    end component;
    
    -- Sinais para conectar o DUT
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '1';
    signal test_sig : std_logic;
    
    -- Período do clock: 20 ns (50MHz)
    constant CLK_PERIOD : time := 20 ns;
    
begin
    -- Processo para gerar o clock
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;
    
    -- Instanciação do DUT (Device Under Test)
    UUT: optical_test_signal
        port map (
            clk      => clk,
            reset    => reset,
            test_sig => test_sig
        );
        
    -- Processo de estímulo para o reset e execução do período de 60ms
    stim_proc: process
    begin
        reset <= '1';
        wait for 100 ns;  -- Mantém o reset ativo por 100 ns
        reset <= '0';
        
        -- Executa a simulação por 60ms para observar um período completo
        wait for 60 ms;
        wait;
    end process;
    
end Behavioral;
