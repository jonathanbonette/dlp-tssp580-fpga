-- ===============================================================
-- Arquivo: tssp580_pwm.vhd
-- Descrição: Módulo VHDL que simula a saída PWM de um receptor IR,
--            representando, de forma simplificada, o comportamento do
--            módulo TSSP580
-- Autor: Jonathan & Matheus
-- Data: 2025-02-02
-- ===============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tssp580_pwm is
    Port(
        clk     : in  std_logic;        -- clk: sinal de clock
        reset   : in  std_logic;        -- reset: sinal para reinicialização do circuito
        pwm_out : out std_logic         -- pwm_out: saída digital que simula o sinal PWM
    );
end tssp580_pwm;

-- Arquitetura comportamental que descreve o funcionamento do módulo.
architecture Behavioral of tssp580_pwm is
    -- Constante que define o período total do ciclo PWM
    constant PWM_PERIOD : integer                           := 100;
    -- Contador é usado para determinar em qual parte do ciclo o PWM se encontra
    signal counter      : integer range 0 to PWM_PERIOD - 1 := 0;
begin
    -- Processo principal que gera o PWM
    -- O processo é sensível a 'clk' e 'reset', ou seja, ele reage a mudanças nesses sinais
    process(clk, reset)
    begin
        -- Caso o reset esteja ativo, reinicia o contador e força a saída para '0'
        if reset = '1' then
            counter <= 0;
            pwm_out <= '0';
        -- Em cada borda de subida do clock, o processo executa a lógica de contagem e geração do PWM
        elsif rising_edge(clk) then
            -- Verifica se o contador atingiu o fim do período
            if counter = PWM_PERIOD - 1 then
                counter <= 0;           -- Reinicia o contador para iniciar um novo ciclo PWM
            else
                counter <= counter + 1; -- Incrementa o contador
            end if;

            -- Geração do sinal PWM com 50% de duty cycle:
            -- Se o valor do contador for menor que a metade do período, a saída é '1'
            -- Caso contrário, a saída é '0'
            if counter < (PWM_PERIOD / 2) then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;

-- ===============================================================
-- Explicação Geral:

--   Clock e Reset:
--   O processo observa os sinais clk e reset. Quando o reset está ativo, 
--   o contador é zerado e a saída é forçada a '0', 
--   garantindo que o sistema inicie em um estado conhecido

-- Contador e PWM:
--   A cada borda de subida do clock, o contador incrementa. 
--   Ao atingir o valor máximo definido por PWM_PERIOD - 1, 
--   ele reinicia para 0. Enquanto o contador estiver abaixo de PWM_PERIOD/2,
--   a saída pwm_out fica em '1', simulando a parte "ativa" do PWM; 
--   depois, fica em '0', simulando a parte "inativa". 
--   Isso resulta em um duty cycle de 50%.
-- ===============================================================
