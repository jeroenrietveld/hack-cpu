library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16_n is

  port (
    I_clk  : in std_logic;
    I_data : in std_logic_vector(15 downto 0);
    I_load : in std_logic;
    O_data : out std_logic_vector(15 downto 0));

end reg16_n;

architecture Behavioral of reg16_n is
  signal reg : std_logic_vector(15 downto 0) := X"0000";
begin
  process(I_clk)
  begin
    O_data <= reg;

    if rising_edge(I_clk) then
      if I_load = '1' then
        reg <= I_data;
      end if;
    end if;
  end process;
end Behavioral;
