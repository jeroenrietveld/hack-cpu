library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end entity program_counter_tb;

architecture Behavioral of program_counter_tb is
  component program_counter is
    port (
      I_clk   : std_logic;
      I_data  : std_logic_vector(15 downto 0);
      I_reset : std_logic;
      I_load  : std_logic;
      I_inc   : std_logic;
      O_data  : std_logic_vector(15 downto 0));
  end component program_counter;

  signal I_clk   : std_logic                     := '1';
  signal I_data  : std_logic_vector(15 downto 0) := X"0000";
  signal I_reset : std_logic                     := '0';
  signal I_load  : std_logic                     := '0';
  signal I_inc   : std_logic                     := '0';
  signal O_data  : std_logic_vector(15 downto 0);

  -- constant clk_period : time := 10 ns;
  constant clk_period : time := 20 ns;
begin  -- architecture Behavioral

  program_counter_1 : entity work.program_counter
    port map (
      I_clk   => I_clk,
      I_data  => I_data,
      I_reset => I_reset,
      I_load  => I_load,
      I_inc   => I_inc,
      O_data  => O_data);

  clk_process : process is
  begin  -- process clk_process
    I_clk <= not I_clk;
    wait for clk_period/2;
  end process clk_process;

  process
    type pattern_type is record
      I_data                 : integer;
      I_reset, I_load, I_inc : std_logic;
      O_data                 : integer;
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      ((0, '0', '0', '0', 0),
       (0, '0', '0', '1', 0),
       (-32123, '0', '0', '1', 1),
       (-32123, '0', '1', '1', 2),
       (-32123, '0', '0', '1', -32123),
       (-32123, '0', '0', '1', -32122),
       (12345, '0', '1', '0', -32121),
       (12345, '1', '1', '0', 12345),
       (12345, '0', '1', '1', 0),
       (12345, '1', '1', '1', 12345),
       (12345, '0', '0', '1', 0),
       (12345, '1', '0', '1', 1),
       (0, '0', '1', '1', 0),
       (0, '0', '0', '1', 0),
       (22222, '1', '0', '0', 1));
  begin
    wait for clk_period;
    wait for clk_period/2;

    for i in patterns'range loop
      I_data  <= std_logic_vector(to_signed(patterns(i).I_data, I_data'length));
      I_reset <= patterns(i).I_reset;
      I_load  <= patterns(i).I_load;
      I_inc   <= patterns(i).I_inc;

      wait for 1 ns;

      assert O_data = std_logic_vector(to_signed(patterns(i).O_data, O_data'length))
        report "Incorrect O_data, expected " & integer'image(patterns(i).O_data) &
        " but got " & integer'image(to_integer(signed(O_data)))
        severity error;

      wait for clk_period - 1 ns;
    end loop;

    assert false report "end of test" severity failure;
  end process;
end architecture Behavioral;
