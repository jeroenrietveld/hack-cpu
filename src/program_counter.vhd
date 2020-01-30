library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is

  port (
    I_clk   : in std_logic;
    I_data  : in std_logic_vector(15 downto 0);
    I_reset : in std_logic;
    I_load  : in std_logic;
    I_inc   : in std_logic;
    O_data  : out std_logic_vector(15 downto 0));

end entity program_counter;

architecture Behavioral of program_counter is
  signal counter : integer := 0;
begin  -- architecture Behavioral
  process(I_clk)
  begin
    O_data <= std_logic_vector(to_signed(counter, O_data'length));

    if rising_edge(I_clk) then
      if (I_reset = '1') then
        counter <= 0;
      elsif (I_load = '1') then
        counter <= to_integer(signed(I_data));
      elsif (I_inc = '1') then
        counter <= counter + 1;
      end if;
    end if;
  end process;

end architecture Behavioral;
