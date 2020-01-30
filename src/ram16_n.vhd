library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram16_n is

  generic (
    N : positive := 8);                 -- Amount of addresses

  port (
    I_clk  : in std_logic;
    I_data : in std_logic_vector(15 downto 0);
    I_addr : in natural;
    I_load : in std_logic;
    O_data : out std_logic_vector(15 downto 0));

end entity ram16_n;

architecture arch of ram16_n is
  type RegisterFile is array(0 to N) of std_logic_vector(15 downto 0);
  signal registers : RegisterFile := (others => X"0000");
begin  -- architecture arch

  O_data <= registers(I_addr);

  process(I_clk)
  begin
    if rising_edge(I_clk) then
      if I_load = '1' then
        registers(I_addr) <= I_data;
      end if;
    end if;
  end process;

end architecture arch;
