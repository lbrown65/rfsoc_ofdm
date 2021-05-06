-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_NCO_HDL_Optimized.vhd
-- Created: 2021-05-06 10:39:12
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_NCO_HDL_Optimized
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/CoarseFreqCorr/NCO HDL Optimized
-- Hierarchy Level: 3
-- 
-- NCO HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_NCO_HDL_Optimized IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        inc                               :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        validIn                           :   IN    std_logic;
        complexexp_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        complexexp_im                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validOut                          :   OUT   std_logic
        );
END ofdm_rx_src_NCO_HDL_Optimized;


ARCHITECTURE rtl OF ofdm_rx_src_NCO_HDL_Optimized IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_DitherGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          validIn                         :   IN    std_logic;
          dither                          :   OUT   std_logic_vector(3 DOWNTO 0)  -- ufix4
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_WaveformGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          phaseIdx                        :   IN    std_logic_vector(11 DOWNTO 0);  -- ufix12_E4
          exp_re                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          exp_im                          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_DitherGen
    USE ENTITY work.ofdm_rx_src_DitherGen(rtl);

  FOR ALL : ofdm_rx_src_WaveformGen
    USE ENTITY work.ofdm_rx_src_WaveformGen(rtl);

  -- Signals
  SIGNAL outsel_reg_reg                   : std_logic_vector(0 TO 4);  -- ufix1 [5]
  SIGNAL outsel                           : std_logic;
  SIGNAL outzero_re                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL outzero_im                       : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL const0                           : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL inc_unsigned                     : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL pInc                             : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL validPInc                        : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL accphase_reg                     : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL addpInc                          : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL pOffset                          : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL accoffset                        : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL accoffsete_reg                   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL dither                           : std_logic_vector(3 DOWNTO 0);  -- ufix4
  SIGNAL dither_unsigned                  : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL casteddither                     : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL dither_reg                       : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL accumulator                      : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL accQuantized                     : unsigned(11 DOWNTO 0);  -- ufix12_E4
  SIGNAL outs_re                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outs_im                          : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL outs_re_signed                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL outs_im_signed                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validouts_re                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL validouts_im                     : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complexexp_re_tmp                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL complexexp_im_tmp                : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_dither_inst : ofdm_rx_src_DitherGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              validIn => validIn,
              dither => dither  -- ufix4
              );

  u_Wave_inst : ofdm_rx_src_WaveformGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              phaseIdx => std_logic_vector(accQuantized),  -- ufix12_E4
              exp_re => outs_re,  -- sfix16_En14
              exp_im => outs_im  -- sfix16_En14
              );

  outsel_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      outsel_reg_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        outsel_reg_reg(0) <= validIn;
        outsel_reg_reg(1 TO 4) <= outsel_reg_reg(0 TO 3);
      END IF;
    END IF;
  END PROCESS outsel_reg_process;

  outsel <= outsel_reg_reg(4);

  outzero_re <= to_signed(16#0000#, 16);
  outzero_im <= to_signed(16#0000#, 16);

  -- Constant Zero
  const0 <= to_signed(16#0000#, 16);

  inc_unsigned <= unsigned(inc);

  pInc <= signed(inc_unsigned);

  
  validPInc <= const0 WHEN validIn = '0' ELSE
      pInc;

  -- Add phase increment
  addpInc <= accphase_reg + validPInc;

  -- Phase increment accumulator register
  AccPhaseRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accphase_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        accphase_reg <= addpInc;
      END IF;
    END IF;
  END PROCESS AccPhaseRegister_process;


  pOffset <= to_signed(16#0000#, 16);

  -- Add phase offset
  accoffset <= accphase_reg + pOffset;

  -- Phase offset accumulator register
  AccOffsetRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      accoffsete_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        accoffsete_reg <= accoffset;
      END IF;
    END IF;
  END PROCESS AccOffsetRegister_process;


  dither_unsigned <= unsigned(dither);

  casteddither <= signed(resize(dither_unsigned, 16));

  -- Dither input register
  DitherRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dither_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        dither_reg <= casteddither;
      END IF;
    END IF;
  END PROCESS DitherRegister_process;


  -- Add dither
  accumulator <= accoffsete_reg + dither_reg;

  -- Phase quantization
  accQuantized <= unsigned(accumulator(15 DOWNTO 4));

  outs_re_signed <= signed(outs_re);

  outs_im_signed <= signed(outs_im);

  
  validouts_re <= outzero_re WHEN outsel = '0' ELSE
      outs_re_signed;
  
  validouts_im <= outzero_im WHEN outsel = '0' ELSE
      outs_im_signed;

  -- Output register
  OutputRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      complexexp_re_tmp <= to_signed(16#0000#, 16);
      complexexp_im_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        complexexp_re_tmp <= validouts_re;
        complexexp_im_tmp <= validouts_im;
      END IF;
    END IF;
  END PROCESS OutputRegister_process;


  complexexp_re <= std_logic_vector(complexexp_re_tmp);

  complexexp_im <= std_logic_vector(complexexp_im_tmp);

  -- validOut register
  validOut_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        validOut <= outsel;
      END IF;
    END IF;
  END PROCESS validOut_reg_process;


END rtl;

