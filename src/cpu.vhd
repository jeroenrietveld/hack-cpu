library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.constants.all;

entity cpu is

  port (
    I_clk         : in  std_logic;
    I_instruction : in  std_logic_vector(15 downto 0);
    I_M           : in  std_logic_vector(15 downto 0);
    I_reset       : in  std_logic_vector;
    O_M           : out std_logic_vector(15 downto 0);
    O_writeM      : out std_logic;
    O_addrM       : out std_logic_vector(14 downto 0);
    O_pc          : out std_logic_vector(14 downto 0));

end entity cpu;

architecture Behavioral of cpu is
  component alu is
    port (
      I_A, I_B                         : in  std_logic_vector(15 downto 0);
      I_zeroA, I_zeroB, I_notA, I_notB : in  std_logic;
      I_function, I_notO               : in  std_logic;
      O_out                            : out std_logic_vector(15 downto 0);
      O_zero, O_notGreater             : out std_logic);
  end component alu;

  component program_counter is
    port (
      I_clk   : in  std_logic;
      I_data  : in  std_logic_vector(15 downto 0);
      I_reset : in  std_logic;
      I_load  : in  std_logic;
      I_inc   : in  std_logic;
      O_data  : out std_logic_vector(15 downto 0));
  end component program_counter;

  signal Areg_data : std_logic_vector(15 downto 0);
  signal Areg_load : std_logic := '0';
  signal Areg_out  : std_logic_vector(15 downto 0);

  signal Dreg_data : std_logic_vector(15 downto 0);
  signal Dreg_load : std_logic := '0';
  signal Dreg_out  : std_logic_vector(15 downto 0);

  alias instr    : std_logic is I_instruction(15);  -- A(0) or C(1) instruction
  alias M_op     : std_logic is I_instruction(12);  -- Operation on memory?
  alias dest     : std_logic_vector(2 downto 0) is I_instruction(5 downto 3);  -- Destination (C-instruction)
  alias jump     : std_logic_vector(2 downto 0) is I_instruction(2 downto 0);  -- Jump (C-instruction)
  alias ALU_inst : std_logic_vector(5 downto 0) is instruction(11 downto 6);  -- Instruction for ALU

  signal notInstr                          : std_logic;
  signal DandC                             : std_logic;
  signal PC_jump, PC_notJump : std_logic;
  signal PC_temp : std_logic_vector(15 downto 0);
  signal ALU_out, ALU_zero, ALU_ng, I_aluB : std_logic_vector(15 downto 0);
begin  -- architecture Behavioral

  -- pc : program_counter port map(
  --   I_clk   => I_clk,
  --   I_data  => X"0000",                 -- TODO
  --   I_reset => I_reset,
  --   I_load  => '0',                     -- TODO
  --   I_inc   => '1',                     -- TODO
  --   O_pc    => O_data);
  alu : entity work.alu
    port map (
      Dreg_out, I_aluB,  -- Data input
      ALU_inst(5), ALU_inst(4), ALU_inst(3), ALU_inst(2), ALU_inst(1), ALU_inst(0), -- Instruction input
      ALU_out, ALU_zero, ALU_ng);  -- Outputs

  O_M <= ALU_out;  -- data output from CPU

  a_register : entity work.reg16_n port map(I_clk, Areg_data, Areg_load, Areg_out);
  d_register : entity work.reg16_n port map(I_clk, ALU_out, Dreg_load, Dreg_out);

  program_counter: entity work.program_counter
    port map (I_clk,
      Areg_data,
      I_reset,
      PC_jump,
      PC_notJump,
      PC_tmp);

  O_pc <= PC_tmp(14 downto 0);

  a_reg : process(I_instruction, ALU_out)
  begin
    notInstr <= not instr;
    if notInstr = '1' then               -- A-instruction
      Areg_data <= ALU_out;
      Areg_load <= '1';
    else                                -- C-instruction
      Areg_data <= I_instruction;
      Areg_load <= dest(2);
    end if;
  end process;

  d_reg : process(instr, dest(1))
  begin
    Dreg_load <= instr and dest(1);
  end process;

  -- Which 'B' input do we load into the ALU
  alu_mem : process(Areg_out, I_m, M_op)
  begin
    if M_op = '1' then
      I_aluB <= I_m
    else
      I_aluB <= Areg_out
    end if;
  end process;

  jump : process(ALU_ng, ALU_zero, instr)
    case jump is
      when NO_JMP => PC_jump <= '0';
      when GT_JMP => PC_jump <= ((not ALU_ng) and (not ALU_zero) and instr);
      when EQ_JMP => PC_jump <= ((not ALU_ng) and ALU_zero and instr);
      when GE_JMP => PC_jump <= ((not ALU_ng) or ALU_zero and instr);
      when LT_JMP => PC_jump <= (ALU_ng and (not ALU_zero) and instr);
      when NE_JMP => PC_jump <= ((not ALU_zero) and instr);
      when LE_JMP => PC_jump <= ((ALU_ng or ALU_zero) and instr);
      when JMP => PC_jump <= instr;
    end case;

    PC_notJump <= not PC_jump;
  begin

  end process;

end architecture Behavioral;
