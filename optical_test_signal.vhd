-- ===============================================================
-- Arquivo: optical_test_signal.vhd
-- Descrição: Gera um sinal de teste óptico conforme o datasheet:
--            7 pulsos de 600µs de duração, dentro de um período
--            total de 60ms, com um clock de 50MHz (20 ns por ciclo).
-- Autor: Jonathan & Matheus
-- Data: 2025-02-02
-- ===============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity optical_test_signal is
    Port (
        clk      : in  std_logic;  -- Clock do sistema (50MHz: 20 ns por ciclo)
        reset    : in  std_logic;  -- Reset (ativo em '1')
        test_sig : out std_logic   -- Saída do sinal óptico de teste
    );
end optical_test_signal;

architecture Behavioral of optical_test_signal is
    -- ---------------------------------------------------------------
    -- Parâmetros "reais" baseados no datasheet:
    -- ---------------------------------------------------------------
    -- Período total (T): 60 ms
    -- Número de ciclos para 60 ms: 60e-3 / 20e-9 = 3.000.000 ciclos
    constant MAIN_PERIOD : integer := 3000000;
    
    -- Número de pulsos: 7
    constant NUM_PULSES  : integer := 7;
    
    -- Largura de cada pulso (600 µs):
    -- 600e-6 / 20e-9 = 30.000 ciclos
    constant PULSE_ON   : integer := 30000;
    
    -- Intervalo entre inícios de pulsos, assumindo distribuição uniforme:
    -- PULSE_INTERVAL = MAIN_PERIOD / NUM_PULSES
    -- (Nesse caso, 3000000 / 7 ≈ 428571 ciclos)
    constant PULSE_INTERVAL : integer := MAIN_PERIOD / NUM_PULSES;
    
    -- Contador principal que contará de 0 até MAIN_PERIOD-1
    signal main_counter : integer range 0 to MAIN_PERIOD - 1 := 0;
    
begin
    process(clk, reset)
    begin
        if reset = '1' then
            main_counter <= 0;
            test_sig <= '0';
        elsif rising_edge(clk) then
            -- Incrementa o contador a cada ciclo do clock
            if main_counter = MAIN_PERIOD - 1 then
                main_counter <= 0;  -- Reinicia a cada 60 ms
            else
                main_counter <= main_counter + 1;
            end if;
            
            -- Se o contador estiver dentro dos intervalos destinados aos pulsos:
            if main_counter < NUM_PULSES * PULSE_INTERVAL then
                -- Dentro de cada intervalo, se o resto (mod) for menor que PULSE_ON,
                -- então estamos no pulso (nível alto), senão, nível baixo.
                if (main_counter mod PULSE_INTERVAL) < PULSE_ON then
                    test_sig <= '1';
                else
                    test_sig <= '0';
                end if;
            else
                test_sig <= '0';
            end if;
        end if;
    end process;
    
end Behavioral;
