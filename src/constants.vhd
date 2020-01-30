library ieee;
use ieee.std_logic_1164.all;

package constants is
  -- ALU constants
  constant ALU_CONSTANT_0     : std_logic_vector(5 downto 0) := "101010";
  constant ALU_CONSTANT_1     : std_logic_vector(5 downto 0) := "111111";
  constant ALU_CONSTANT_NEG_1 : std_logic_vector(5 downto 0) := "111010";
  constant ALU_OUT_A          : std_logic_vector(5 downto 0) := "001100";
  constant ALU_OUT_B          : std_logic_vector(5 downto 0) := "110000";
  constant ALU_NOT_A          : std_logic_vector(5 downto 0) := "001101";
  constant ALU_NOT_B          : std_logic_vector(5 downto 0) := "110001";
  constant ALU_NEG_A          : std_logic_vector(5 downto 0) := "001111";
  constant ALU_NEG_B          : std_logic_vector(5 downto 0) := "110011";
  constant ALU_INC_A          : std_logic_vector(5 downto 0) := "011111";
  constant ALU_INC_B          : std_logic_vector(5 downto 0) := "110111";
  constant ALU_DEC_A          : std_logic_vector(5 downto 0) := "001110";
  constant ALU_DEC_B          : std_logic_vector(5 downto 0) := "110010";
  constant ALU_A_PLUS_B       : std_logic_vector(5 downto 0) := "000010";
  constant ALU_A_MIN_B        : std_logic_vector(5 downto 0) := "010011";
  constant ALU_B_MIN_A        : std_logic_vector(5 downto 0) := "000111";
  constant ALU_A_AND_B        : std_logic_vector(5 downto 0) := "000000";
  constant ALU_A_OR_B         : std_logic_vector(5 downto 0) := "010101";

  -- Jup constants (C-instruction)
  -- j1 j2 j3 Mnemonic Effect
  -- j1: (out < 0)
  -- j2: (out ¼ 0)
  -- j3: (out > 0)
  -- 0 0 0 null No jump
  -- 0 0 1 JGT If out > 0 jump
  -- 0 1 0 JEQ If out ¼ 0 jump
  -- 0 1 1 JGE If out b 0 jump
  -- 1 0 0 JLT If out < 0 jump
  -- 1 0 1 JNE If out 0 0 jump
  -- 1 1 0 JLE If out a 0 jump
  -- 1 1 1 JMP Jump
  constant NO_JMP : std_logic_vector(2 downto 0) := "000";
  constant GT_JMP : std_logic_vector(2 downto 0) := "001";
  constant EQ_JMP : std_logic_vector(2 downto 0) := "010";
  constant GE_JMP : std_logic_vector(2 downto 0) := "011";
  constant LT_JMP : std_logic_vector(2 downto 0) := "100";
  constant NE_JMP : std_logic_vector(2 downto 0) := "101";
  constant LE_JMP : std_logic_vector(2 downto 0) := "110";
  constant MP     : std_logic_vector(2 downto 0) := "111";


  --   d1 d2 d3 Mnemonic Destination (where to store the computed value)
  --   0 0 0 null The value is not stored anywhere
  --   001 M Memory[A] (memory register addressed by A)
  --   010 D D register
  --   0 1 1 MD Memory[A] and D register
  --   100 A A register
  --   1 0 1 AM A register and Memory[A]
  --   1 1 0 AD A register and D register
  --   1 1 1 AMD A register, Memory[A], and D register
end package constants;

package body constants is
end package body constants;
