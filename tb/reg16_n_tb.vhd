-------------------------------------------------------------------------------
-- Title      : Testbench for design "reg16_n"
-- Project    :
-------------------------------------------------------------------------------
-- File       : reg16_n_tb.vhd
-- Author     : Jeroen Rietveld  <jeroenrietveld@Macbook-Pro-Jeroen.local>
-- Company    :
-- Created    : 2019-07-05
-- Last update: 2019-07-05
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-05  1.0      jeroenrietveld  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity reg16_n_tb is

end entity reg16_n_tb;

-------------------------------------------------------------------------------

architecture arch of reg16_n_tb is
  -- component ports
  signal I_data : std_logic_vector(15 downto 0);
  signal I_load : std_logic;
  signal O_data : std_logic_vector(15 downto 0);

  -- clock
  signal Clk : std_logic := '1';

  constant clk_period : time := 20 ns;
begin  -- architecture arch

  -- component instantiation
  DUT : entity work.reg16_n
    port map (
      I_Clk  => Clk,
      I_data => I_data,
      I_load => I_load,
      O_data => O_data);

  -- clock generation
  Clk <= not Clk after clk_period / 2;

  process
    type pattern_type is record
      I_data : integer;
      I_load : std_logic;
      O_data : integer;
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      ((0, '0', 0),
       (0, '1', 0),
       (-32123, '0', 0),
       (11111, '0', 0),
       (-32123, '1', 0),
       (-32123, '1', -32123),
       (-32123, '0', -32123),
       (12345, '1', -32123),
       (0, '0', 12345),
       (0, '1', 12345),
       (1, '0', 0),
       (1, '1', 0),
       (2, '0', 1),
       (2, '1', 1),
       (4, '0', 2),
       (4, '1', 2),
       (8, '0', 4),
       (8, '1', 4),
       (16, '0', 8),
       (16, '1', 8),
       (32, '0', 16),
       (32, '1', 16),
       (64, '0', 32),
       (64, '1', 32),
       (128, '0', 64),
       (128, '1', 64),
       (256, '0', 128),
       (256, '1', 128),
       (512, '0', 256),
       (512, '1', 256),
       (1024, '0', 512),
       (1024, '1', 512),
       (2048, '0', 1024),
       (2048, '1', 1024),
       (4096, '0', 2048),
       (4096, '1', 2048),
       (8192, '0', 4096),
       (8192, '1', 4096),
       (16384, '0', 8192),
       (16384, '1', 8192),
       (-32768, '0', 16384),
       (-32768, '1', 16384),
       (-2, '0', -32768),
       (-2, '1', -32768),
       (-3, '0', -2),
       (-3, '1', -2),
       (-5, '0', -3),
       (-5, '1', -3),
       (-9, '0', -5),
       (-9, '1', -5),
       (-17, '0', -9),
       (-17, '1', -9),
       (-33, '0', -17),
       (-33, '1', -17),
       (-65, '0', -33),
       (-65, '1', -33),
       (-129, '0', -65),
       (-129, '1', -65),
       (-257, '0', -129),
       (-257, '1', -129),
       (-513, '0', -257),
       (-513, '1', -257),
       (-1025, '0', -513),
       (-1025, '1', -513),
       (-2049, '0', -1025),
       (-2049, '1', -1025),
       (-4097, '0', -2049),
       (-4097, '1', -2049),
       (-8193, '0', -4097),
       (-8193, '1', -4097),
       (-16385, '0', -8193),
       (-16385, '1', -8193),
       (32767, '0', -16385),
       (32767, '1', -16385));
  begin
    wait for clk_period;
    wait for clk_period/2;

    for i in patterns'range loop
      I_data  <= std_logic_vector(to_signed(patterns(i).I_data, I_data'length));
      I_load  <= patterns(i).I_load;

      wait for 1 ns;

      assert O_data = std_logic_vector(to_signed(patterns(i).O_data, O_data'length))
        report "Incorrect O_data, expected " & integer'image(patterns(i).O_data) &
        " but got " & integer'image(to_integer(signed(O_data))) &
        " on iteration " & integer'image(i)
        severity error;

      wait for clk_period - 1 ns;
    end loop;

    assert false report "end of test" severity failure;
  end process;

end architecture arch;

-------------------------------------------------------------------------------

configuration reg16_n_tb_arch_cfg of reg16_n_tb is
  for arch
  end for;
end reg16_n_tb_arch_cfg;

-------------------------------------------------------------------------------
