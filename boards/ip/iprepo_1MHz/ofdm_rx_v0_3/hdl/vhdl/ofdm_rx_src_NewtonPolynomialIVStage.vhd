-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_NewtonPolynomialIVStage.vhd
-- Created: 2021-05-06 12:02:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_NewtonPolynomialIVStage
-- Source Path: Reciprocal/Reciprocal_iv/NewtonPolynomialIVStage
-- Hierarchy Level: 6
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_NewtonPolynomialIVStage IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        ain                               :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        mulin                             :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En21
        adderin                           :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En19
        xinitinterm                       :   OUT   std_logic_vector(22 DOWNTO 0)  -- sfix23_En19
        );
END ofdm_rx_src_NewtonPolynomialIVStage;


ARCHITECTURE rtl OF ofdm_rx_src_NewtonPolynomialIVStage IS

  -- Signals
  SIGNAL mulin_signed                     : signed(24 DOWNTO 0);  -- sfix25_En21
  SIGNAL ain_unsigned                     : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL mul_cast                         : signed(16 DOWNTO 0);  -- sfix17_En16
  SIGNAL mul_mul_temp                     : signed(41 DOWNTO 0);  -- sfix42_En37
  SIGNAL mul_cast_1                       : signed(40 DOWNTO 0);  -- sfix41_En37
  SIGNAL mulout                           : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL muloutreg                        : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL adderin_signed                   : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL sumout                           : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL xinitinterm_tmp                  : signed(22 DOWNTO 0);  -- sfix23_En19

BEGIN
  mulin_signed <= signed(mulin);

  ain_unsigned <= unsigned(ain);

  mul_cast <= signed(resize(ain_unsigned, 17));
  mul_mul_temp <= mulin_signed * mul_cast;
  mul_cast_1 <= mul_mul_temp(40 DOWNTO 0);
  mulout <= mul_cast_1(40 DOWNTO 18) + ('0' & mul_cast_1(17));

  mul_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      muloutreg <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        muloutreg <= mulout;
      END IF;
    END IF;
  END PROCESS mul_reg_process;


  adderin_signed <= signed(adderin);

  sumout <= muloutreg + adderin_signed;

  xinitinterm_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xinitinterm_tmp <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        xinitinterm_tmp <= sumout;
      END IF;
    END IF;
  END PROCESS xinitinterm_reg_process;


  xinitinterm <= std_logic_vector(xinitinterm_tmp);

END rtl;

