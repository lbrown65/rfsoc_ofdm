-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_QAM32_Generator.vhd
-- Created: 2021-05-05 09:22:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_QAM32_Generator
-- Source Path: OFDM_Tx_HW/OFDMTx/DataGenerator/RF Signal Generator/Variable Modulator/QAM32 Generator
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_QAM32_Generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        Data                              :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Reset_1                           :   IN    std_logic;
        Enable                            :   IN    std_logic;
        I_symbols                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        Q_symbols                         :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END ofdm_tx_src_QAM32_Generator;


ARCHITECTURE rtl OF ofdm_tx_src_QAM32_Generator IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_complement_re_block1
    PORT( d_in                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          d_out                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_complement_block
    PORT( d_in                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          d_out                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_complement_im_block1
    PORT( d_in                            :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          d_out                           :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_complement_re_block1
    USE ENTITY work.ofdm_tx_src_complement_re_block1(rtl);

  FOR ALL : ofdm_tx_src_complement_block
    USE ENTITY work.ofdm_tx_src_complement_block(rtl);

  FOR ALL : ofdm_tx_src_complement_im_block1
    USE ENTITY work.ofdm_tx_src_complement_im_block1(rtl);

  -- Signals
  SIGNAL Reset_2                          : std_logic;
  SIGNAL Data_unsigned                    : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL Bit_Slice5_out1                  : std_logic;  -- ufix1
  SIGNAL Bit_Slice4_out1                  : std_logic;  -- ufix1
  SIGNAL Bit_Slice3_out1                  : std_logic;  -- ufix1
  SIGNAL Constant3_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant6_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch2_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Bit_Slice1_out1                  : std_logic;  -- ufix1
  SIGNAL Bit_Slice2_out1                  : std_logic;  -- ufix1
  SIGNAL Multiport_Switch4_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant2_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Constant4_out1                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch1_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch5_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch6_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complement_re_out1               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL complement_re_out1_signed        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch7_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_iv                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_delOut                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_ectrl                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_toDelay                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_bypassIn                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_last_value                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complement_out1                  : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL complement_out1_signed           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch3_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complement_im_out1               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL complement_im_out1_signed        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Multiport_Switch8_out1           : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_iv                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_delOut                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_ectrl                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_toDelay                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_bypassIn                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_out1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_last_value                : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_complement_re : ofdm_tx_src_complement_re_block1
    PORT MAP( d_in => std_logic_vector(Multiport_Switch6_out1),  -- sfix16_En14
              d_out => complement_re_out1  -- sfix16_En14
              );

  u_complement : ofdm_tx_src_complement_block
    PORT MAP( d_in => std_logic_vector(Multiport_Switch2_out1),  -- sfix16_En14
              d_out => complement_out1  -- sfix16_En14
              );

  u_complement_im : ofdm_tx_src_complement_im_block1
    PORT MAP( d_in => std_logic_vector(Multiport_Switch3_out1),  -- sfix16_En14
              d_out => complement_im_out1  -- sfix16_En14
              );

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Reset_2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Reset_2 <= Reset_1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  Data_unsigned <= unsigned(Data);

  Bit_Slice5_out1 <= Data_unsigned(4);

  Bit_Slice4_out1 <= Data_unsigned(3);

  Bit_Slice3_out1 <= Data_unsigned(0);

  Constant3_out1 <= to_signed(16#0CCD#, 16);

  Constant6_out1 <= to_signed(16#2666#, 16);

  
  Multiport_Switch2_out1 <= Constant3_out1 WHEN Bit_Slice3_out1 = '0' ELSE
      Constant6_out1;

  Bit_Slice1_out1 <= Data_unsigned(2);

  Bit_Slice2_out1 <= Data_unsigned(1);

  
  Multiport_Switch4_out1 <= Constant3_out1 WHEN Bit_Slice2_out1 = '0' ELSE
      Constant6_out1;

  Constant2_out1 <= to_signed(16#4000#, 16);

  Constant4_out1 <= to_signed(-16#4000#, 16);

  
  Multiport_Switch1_out1 <= Constant2_out1 WHEN Bit_Slice2_out1 = '0' ELSE
      Constant4_out1;

  
  Multiport_Switch5_out1 <= Multiport_Switch4_out1 WHEN Bit_Slice1_out1 = '0' ELSE
      Multiport_Switch1_out1;

  
  Multiport_Switch6_out1 <= Multiport_Switch2_out1 WHEN Bit_Slice4_out1 = '0' ELSE
      Multiport_Switch5_out1;

  complement_re_out1_signed <= signed(complement_re_out1);

  
  Multiport_Switch7_out1 <= Multiport_Switch6_out1 WHEN Bit_Slice5_out1 = '0' ELSE
      complement_re_out1_signed;

  Delay1_iv <= to_signed(16#0000#, 16);

  
  Delay1_ectrl <= Delay1_delOut WHEN Enable = '0' ELSE
      Multiport_Switch7_out1;

  
  Delay1_toDelay <= Delay1_ectrl WHEN Reset_2 = '0' ELSE
      Delay1_iv;

  Delay1_lowered_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_delOut <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_delOut <= Delay1_toDelay;
      END IF;
    END IF;
  END PROCESS Delay1_lowered_process;


  
  Delay1_bypassIn <= Delay1_delOut WHEN Reset_2 = '0' ELSE
      Delay1_iv;

  Delay1_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_last_value <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_last_value <= Delay1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_bypass_process;


  
  Delay1_out1 <= Delay1_last_value WHEN Enable = '0' ELSE
      Delay1_bypassIn;

  I_symbols <= std_logic_vector(Delay1_out1);

  complement_out1_signed <= signed(complement_out1);

  
  Multiport_Switch3_out1 <= Multiport_Switch5_out1 WHEN Bit_Slice4_out1 = '0' ELSE
      complement_out1_signed;

  complement_im_out1_signed <= signed(complement_im_out1);

  
  Multiport_Switch8_out1 <= Multiport_Switch3_out1 WHEN Bit_Slice5_out1 = '0' ELSE
      complement_im_out1_signed;

  Delay2_iv <= to_signed(16#0000#, 16);

  
  Delay2_ectrl <= Delay2_delOut WHEN Enable = '0' ELSE
      Multiport_Switch8_out1;

  
  Delay2_toDelay <= Delay2_ectrl WHEN Reset_2 = '0' ELSE
      Delay2_iv;

  Delay2_lowered_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_delOut <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay2_delOut <= Delay2_toDelay;
      END IF;
    END IF;
  END PROCESS Delay2_lowered_process;


  
  Delay2_bypassIn <= Delay2_delOut WHEN Reset_2 = '0' ELSE
      Delay2_iv;

  Delay2_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_last_value <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay2_last_value <= Delay2_out1;
      END IF;
    END IF;
  END PROCESS Delay2_bypass_process;


  
  Delay2_out1 <= Delay2_last_value WHEN Enable = '0' ELSE
      Delay2_bypassIn;

  Q_symbols <= std_logic_vector(Delay2_out1);

END rtl;

