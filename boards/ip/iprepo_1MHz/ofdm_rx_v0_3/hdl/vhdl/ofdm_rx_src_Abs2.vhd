-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Abs2.vhd
-- Created: 2021-05-06 12:02:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Abs2
-- Source Path: OFDM_Rx_HW/OFDMRx/ChannelEstEq/Equalise/Abs2
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_Abs2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        ChEstIn_re                        :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        ChEstIn_im                        :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        Out1                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- ufix16_En14
        );
END ofdm_rx_src_Abs2;


ARCHITECTURE rtl OF ofdm_rx_src_Abs2 IS

  -- Signals
  SIGNAL ChEstIn_re_signed                : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL ChEstIn_im_signed                : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex_to_Real_Imag_out1        : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex_to_Real_Imag_out1_1      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex_to_Real_Imag_out1_2      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Product_out1                     : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Product_out1_1                   : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Delay2_bypass_reg                : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Product_out1_2                   : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Complex_to_Real_Imag_out2        : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex_to_Real_Imag_out2_1      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex_to_Real_Imag_out2_2      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Product1_out1                    : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Product1_out1_1                  : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Delay3_bypass_reg                : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Product1_out1_2                  : signed(33 DOWNTO 0);  -- sfix34_En28
  SIGNAL Add_add_cast                     : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Add_add_cast_1                   : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Add_add_temp                     : signed(34 DOWNTO 0);  -- sfix35_En28
  SIGNAL Add_out1                         : unsigned(15 DOWNTO 0);  -- ufix16_En14
  SIGNAL Add_out1_1                       : unsigned(15 DOWNTO 0);  -- ufix16_En14

BEGIN
  ChEstIn_re_signed <= signed(ChEstIn_re);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex_to_Real_Imag_out1 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Complex_to_Real_Imag_out1 <= ChEstIn_re_signed;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  Complex_to_Real_Imag_out1_1 <= Complex_to_Real_Imag_out1;

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex_to_Real_Imag_out1_2 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Complex_to_Real_Imag_out1_2 <= Complex_to_Real_Imag_out1_1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  Product_out1 <= Complex_to_Real_Imag_out1_2 * Complex_to_Real_Imag_out1_2;

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_out1_1 <= to_signed(0, 34);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_out1_1 <= Product_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay2_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_bypass_reg <= to_signed(0, 34);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay2_bypass_reg <= Product_out1_1;
      END IF;
    END IF;
  END PROCESS Delay2_bypass_process;

  
  Product_out1_2 <= Product_out1_1 WHEN enb_1_256_1 = '1' ELSE
      Delay2_bypass_reg;

  ChEstIn_im_signed <= signed(ChEstIn_im);

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex_to_Real_Imag_out2 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Complex_to_Real_Imag_out2 <= ChEstIn_im_signed;
      END IF;
    END IF;
  END PROCESS delayMatch2_process;


  Complex_to_Real_Imag_out2_1 <= Complex_to_Real_Imag_out2;

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex_to_Real_Imag_out2_2 <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Complex_to_Real_Imag_out2_2 <= Complex_to_Real_Imag_out2_1;
      END IF;
    END IF;
  END PROCESS reduced_1_process;


  Product1_out1 <= Complex_to_Real_Imag_out2_2 * Complex_to_Real_Imag_out2_2;

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product1_out1_1 <= to_signed(0, 34);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product1_out1_1 <= Product1_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Delay3_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_bypass_reg <= to_signed(0, 34);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay3_bypass_reg <= Product1_out1_1;
      END IF;
    END IF;
  END PROCESS Delay3_bypass_process;

  
  Product1_out1_2 <= Product1_out1_1 WHEN enb_1_256_1 = '1' ELSE
      Delay3_bypass_reg;

  Add_add_cast <= resize(Product_out1_2, 35);
  Add_add_cast_1 <= resize(Product1_out1_2, 35);
  Add_add_temp <= Add_add_cast + Add_add_cast_1;
  Add_out1 <= unsigned(Add_add_temp(29 DOWNTO 14));

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Add_out1_1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Add_out1_1 <= Add_out1;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  Out1 <= std_logic_vector(Add_out1_1);

END rtl;

