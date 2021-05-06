-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Gradient.vhd
-- Created: 2021-05-06 12:02:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Gradient
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/GradientEstimate /Gradient
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_Gradient IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        diffIn                            :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
        diffOut                           :   OUT   std_logic_vector(22 DOWNTO 0)  -- sfix23_En20
        );
END ofdm_rx_src_Gradient;


ARCHITECTURE rtl OF ofdm_rx_src_Gradient IS

  -- Signals
  SIGNAL kconst                           : signed(27 DOWNTO 0);  -- sfix28_En30
  SIGNAL kconst_1                         : signed(27 DOWNTO 0);  -- sfix28_En30
  SIGNAL diffIn_signed                    : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay1_out1                      : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay1_out1_1                    : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL diffIn_1                         : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Add_sub_cast                     : signed(23 DOWNTO 0);  -- sfix24_En20
  SIGNAL Add_sub_cast_1                   : signed(23 DOWNTO 0);  -- sfix24_En20
  SIGNAL Add_sub_temp                     : signed(23 DOWNTO 0);  -- sfix24_En20
  SIGNAL Add_out1                         : signed(27 DOWNTO 0);  -- sfix28_En20
  SIGNAL Add_out1_1                       : signed(27 DOWNTO 0);  -- sfix28_En20
  SIGNAL Gain_mul_temp                    : signed(55 DOWNTO 0);  -- sfix56_En50
  SIGNAL Gain_out1                        : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Gain_out1_1                      : signed(22 DOWNTO 0);  -- sfix23_En20
  SIGNAL Delay3_bypass_reg                : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL Gain_out1_2                      : signed(22 DOWNTO 0);  -- sfix23_En20

BEGIN
  -- Estimate gardient of phase slope using . The no. of 
  -- gradient estimates is 3 since there are 4 pilots. 

  kconst <= to_signed(16#4924925#, 28);

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      kconst_1 <= to_signed(16#0000000#, 28);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        kconst_1 <= kconst;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  diffIn_signed <= signed(diffIn);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_out1 <= diffIn_signed;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Delay1_out1_1 <= Delay1_out1;

  diffIn_1 <= signed(diffIn);

  Add_sub_cast <= resize(Delay1_out1_1, 24);
  Add_sub_cast_1 <= resize(diffIn_1, 24);
  Add_sub_temp <= Add_sub_cast - Add_sub_cast_1;
  Add_out1 <= resize(Add_sub_temp, 28);

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Add_out1_1 <= to_signed(16#0000000#, 28);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Add_out1_1 <= Add_out1;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  Gain_mul_temp <= kconst_1 * Add_out1_1;
  Gain_out1 <= Gain_mul_temp(52 DOWNTO 30);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Gain_out1_1 <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Gain_out1_1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay3_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_bypass_reg <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay3_bypass_reg <= Gain_out1_1;
      END IF;
    END IF;
  END PROCESS Delay3_bypass_process;

  
  Gain_out1_2 <= Gain_out1_1 WHEN enb_1_256_1 = '1' ELSE
      Delay3_bypass_reg;

  diffOut <= std_logic_vector(Gain_out1_2);

END rtl;

