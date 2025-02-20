library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter is
  generic(
    THRESHOLD : integer := 20;  -- Número de ciclos consecutivos necessários para confirmar 0
    MAX_COUNT : integer := 20   -- Valor máximo que o contador pode atingir (saturação)
  );
  port(
    clk             : in  std_logic;
    rst             : in  std_logic;
    sensor_in       : in  std_logic;  -- Entrada do sensor (com ruídos)
    sensor_filtered : out std_logic   -- Saída filtrada
  );
end filter;

architecture Behavioral of filter is
  signal counter : integer := 0;
begin
  process(clk, rst)
  begin
    if rst = '1' then
      counter         <= 0;
      sensor_filtered <= '1';  -- Estado normal: sensor inativo = '1'
    elsif rising_edge(clk) then
      if sensor_in = '0' then
        -- incrementa o contador até saturaro limite
        if counter < MAX_COUNT then 
          counter <= counter + 1;
        end if;
      else  -- sensor_in = '1'
        -- decrementa o contador (não reseta imediatamente)
        if counter > 0 then
          counter <= counter - 1;
        end if;
      end if;
      
      -- se o contador atingir o threshold, consideramos 0
      if counter >= THRESHOLD then
        sensor_filtered <= '0';
      else
        sensor_filtered <= '1';
      end if;
    end if;
  end process;
end Behavioral;
