library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.constants.all;

entity alu is

  port (
    I_A          : in  std_logic_vector(15 downto 0);
    I_B          : in  std_logic_vector(15 downto 0);
    I_zeroA      : in  std_logic;
    I_zeroB      : in  std_logic;
    I_notA       : in  std_logic;
    I_notB       : in  std_logic;
    I_function   : in  std_logic;
    I_notO       : in  std_logic;       -- negate out
    O_out        : out std_logic_vector(15 downto 0);
    O_zero       : out std_logic;       -- True if out = 0
    O_notGreater : out std_logic);      -- True if out < 0

end entity alu;

architecture alu of alu is
  -- signal aluop : std_logic_vector(5 downto 0) := "000000";
begin  -- architecture alu

  process(I_A, I_B, I_zeroA, I_zeroB, I_notA, I_notB, I_function, I_notO)
    variable aluop : std_logic_vector(5 downto 0) := I_zeroA & I_notA & I_zeroB & I_notB & I_function & I_notO;
  begin
    aluop := I_zeroA & I_notA & I_zeroB & I_notB & I_function & I_notO;
    -- report integer'image(to_integer(unsigned(aluop)));
    alu_internals : case aluop is
      when ALU_CONSTANT_0     => O_out <= X"0000";
      when ALU_CONSTANT_1     => O_out <= X"0001";
      when ALU_CONSTANT_NEG_1 => O_out <= X"FFFF";
      when ALU_OUT_A          => O_out <= I_A;
      when ALU_OUT_B          => O_out <= I_B;
      when ALU_NOT_A          => O_out <= not I_A;
      when ALU_NOT_B          => O_out <= not I_B;
                                 -- TODO: Does this negate negative values correctly?
      when ALU_NEG_A          => O_out <= std_logic_vector(unsigned(not(I_A)) + 1);
      when ALU_NEG_B          => O_out <= std_logic_vector(unsigned(not(I_B)) + 1);
      when ALU_INC_A          => O_out <= std_logic_vector(to_signed(to_integer(signed(I_A)) + 1, I_A'length));
      when ALU_INC_B          => O_out <= std_logic_vector(to_signed(to_integer(signed(I_B)) + 1, I_B'length));
      when ALU_DEC_A          => O_out <= std_logic_vector(to_signed(to_integer(unsigned(I_A)) - 1, I_A'length));
      when ALU_DEC_B          => O_out <= std_logic_vector(to_signed(to_integer(unsigned(I_B)) - 1, I_B'length));
      when ALU_A_PLUS_B       => O_out <= std_logic_vector(to_signed(to_integer(unsigned(I_A)) + to_integer(unsigned(I_B)), I_A'length));
      when ALU_A_MIN_B        => O_out <= std_logic_vector(to_signed(to_integer(unsigned(I_A)) - to_integer(unsigned(I_B)), I_A'length));
      when ALU_B_MIN_A        => O_out <= std_logic_vector(to_signed(to_integer(unsigned(I_B)) - to_integer(unsigned(I_A)), I_A'length));
      when ALU_A_AND_B        => O_out <= I_A and I_B;
      when ALU_A_or_B         => O_out <= I_A or I_B;
      when others             => null;
    end case alu_internals;
  end process;
end architecture alu;
