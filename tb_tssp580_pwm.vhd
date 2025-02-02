-- ===============================================================
-- Arquivo: tb_tssp580_pwm.vhd
-- Descrição: Testbench para simular o comportamento do módulo tssp580_pwm
--            Ele gera o clock e o sinal de reset, instanciando o módulo e
--            permitindo observar o sinal PWM na simulação
-- Autor: Jonathan & Matheus
-- Data: 2025-02-02
-- ===============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entidade do testbench (não possui portas, pois serve apenas para simulação)
entity tb_tssp580_pwm is
end tb_tssp580_pwm;

architecture Behavioral of tb_tssp580_pwm is
    -- Declaração do componente a ser testado
    component tssp580_pwm is
        Port(
            clk     : in  std_logic;
            reset   : in  std_logic;
            pwm_out : out std_logic
        );
    end component;

    -- Sinais para conectar o dut acima
    signal clk     : std_logic := '0';  -- Inicialmente, o clock é '0'
    signal reset   : std_logic := '1';  -- Começa com o reset ativo
    signal pwm_out : std_logic;         -- Sinal que observará a saída PWM

    -- Constante que define o período do clock para a simulação.
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Processo para gerar o sinal de clock
    -- Alterna o sinal 'clk' entre '0' e '1' com o período definido
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;        -- Espera metade do período
        clk <= '1';
        wait for CLK_PERIOD / 2;        -- Espera a outra metade do período
    end process;

    -- Instanciação da DUT
    DUT : tssp580_pwm
        port map(
            clk     => clk,             -- Conecta o sinal de clock
            reset   => reset,           -- Conecta o sinal de reset
            pwm_out => pwm_out          -- Conecta a saída PWM para monitoramento
        );

    -- Processo de estímulo para o reset e duração da simulação
    stim_proc : process
    begin
        -- Inicialmente, o reset é mantido ativo para reinicializar o DUT
        reset <= '1';
        wait for 20 ns;                 -- Mantém o reset ativo por 20 ns
        reset <= '0';                   -- Desativa o reset, permitindo que o DUT comece a operar

        -- Permite que a simulação continue por tempo suficiente para observar o PWM
        wait for 1000 ns;

        -- Finaliza a simulação
        wait;
    end process;

end Behavioral;
