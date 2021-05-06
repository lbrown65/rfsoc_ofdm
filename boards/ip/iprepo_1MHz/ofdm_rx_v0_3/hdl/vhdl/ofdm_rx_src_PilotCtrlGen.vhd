-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_PilotCtrlGen.vhd
-- Created: 2021-05-06 12:02:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_PilotCtrlGen
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/PilotCtrlGen
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_PilotCtrlGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataIn_im                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        validIn                           :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataOut_im                        :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        pilotOut_re                       :   OUT   std_logic_vector(1 DOWNTO 0);  -- sfix2
        pilotOut_im                       :   OUT   std_logic_vector(1 DOWNTO 0);  -- sfix2
        pilotEnd                          :   OUT   std_logic;
        dataValid                         :   OUT   std_logic
        );
END ofdm_rx_src_PilotCtrlGen;


ARCHITECTURE rtl OF ofdm_rx_src_PilotCtrlGen IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_SymbolCounter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          ValidIn                         :   IN    std_logic;
          Symbl_cnt                       :   OUT   std_logic_vector(6 DOWNTO 0)  -- ufix7
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_SampleCounter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          Valid_In                        :   IN    std_logic;
          Sample_Cnt                      :   OUT   std_logic_vector(5 DOWNTO 0)  -- ufix6
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_pilotGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          symbCount                       :   IN    std_logic_vector(6 DOWNTO 0);  -- ufix7
          sampleCount                     :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          valid                           :   IN    std_logic;
          pilOut_re                       :   OUT   std_logic_vector(1 DOWNTO 0);  -- sfix2
          pilOut_im                       :   OUT   std_logic_vector(1 DOWNTO 0)  -- sfix2
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_CtrlSigGen
    PORT( valid                           :   IN    std_logic;
          sampleCount                     :   IN    std_logic_vector(5 DOWNTO 0);  -- ufix6
          dataValid                       :   OUT   std_logic;
          pilotEnd                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_SymbolCounter
    USE ENTITY work.ofdm_rx_src_SymbolCounter(rtl);

  FOR ALL : ofdm_rx_src_SampleCounter
    USE ENTITY work.ofdm_rx_src_SampleCounter(rtl);

  FOR ALL : ofdm_rx_src_pilotGen
    USE ENTITY work.ofdm_rx_src_pilotGen(rtl);

  FOR ALL : ofdm_rx_src_CtrlSigGen
    USE ENTITY work.ofdm_rx_src_CtrlSigGen(rtl);

  -- Signals
  SIGNAL dataIn_re_1                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL dataIn_im_1                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL out_0_pipe_in_pipe_reg_re        : vector_of_signed18(0 TO 1);  -- sfix18_En15 [2]
  SIGNAL out_0_pipe_in_pipe_reg_im        : vector_of_signed18(0 TO 1);  -- sfix18_En15 [2]
  SIGNAL dataIn_re_2                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL dataIn_im_2                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL Delay2_bypass_reg_re             : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL Delay2_bypass_reg_im             : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL dataIn_re_3                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL dataIn_im_3                      : signed(17 DOWNTO 0);  -- sfix18_En15
  SIGNAL validIn_1                        : std_logic;
  SIGNAL SymbolCounter_out1               : std_logic_vector(6 DOWNTO 0);  -- ufix7
  SIGNAL SampleCounter_out1               : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL Delay1_out1                      : std_logic;
  SIGNAL pilotGen_out1_re                 : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL pilotGen_out1_im                 : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL pilotGen_out1_re_signed          : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL pilotGen_out1_im_signed          : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL crp_out_delay_reg_re             : vector_of_signed2(0 TO 1);  -- sfix2 [2]
  SIGNAL crp_out_delay_reg_im             : vector_of_signed2(0 TO 1);  -- sfix2 [2]
  SIGNAL pilotGen_out1_re_1               : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL pilotGen_out1_im_1               : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Delay3_bypass_reg_re             : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL Delay3_bypass_reg_im             : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL pilotGen_out1_re_2               : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL pilotGen_out1_im_2               : signed(1 DOWNTO 0);  -- sfix2
  SIGNAL SampleCounter_out1_1             : std_logic_vector(5 DOWNTO 0);  -- ufix6
  SIGNAL CtrlSigGen_out1                  : std_logic;
  SIGNAL CtrlSigGen_out2                  : std_logic;
  SIGNAL CtrlSigGen_out2_1                : std_logic;
  SIGNAL CtrlSigGen_out2_2                : std_logic;
  SIGNAL CtrlSigGen_out2_3                : std_logic;
  SIGNAL CtrlSigGen_out1_1                : std_logic;
  SIGNAL CtrlSigGen_out1_2                : std_logic;
  SIGNAL CtrlSigGen_out1_3                : std_logic;

BEGIN
  u_SymbolCounter : ofdm_rx_src_SymbolCounter
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              ValidIn => validIn_1,
              Symbl_cnt => SymbolCounter_out1  -- ufix7
              );

  u_SampleCounter : ofdm_rx_src_SampleCounter
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              Valid_In => validIn_1,
              Sample_Cnt => SampleCounter_out1  -- ufix6
              );

  u_pilotGen : ofdm_rx_src_pilotGen
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              symbCount => SymbolCounter_out1,  -- ufix7
              sampleCount => SampleCounter_out1,  -- ufix6
              valid => Delay1_out1,
              pilOut_re => pilotGen_out1_re,  -- sfix2
              pilOut_im => pilotGen_out1_im  -- sfix2
              );

  u_CtrlSigGen : ofdm_rx_src_CtrlSigGen
    PORT MAP( valid => Delay1_out1,
              sampleCount => SampleCounter_out1_1,  -- ufix6
              dataValid => CtrlSigGen_out1,
              pilotEnd => CtrlSigGen_out2
              );

  dataIn_re_1 <= signed(dataIn_re);

  dataIn_im_1 <= signed(dataIn_im);

  out_0_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      out_0_pipe_in_pipe_reg_re <= (OTHERS => to_signed(16#00000#, 18));
      out_0_pipe_in_pipe_reg_im <= (OTHERS => to_signed(16#00000#, 18));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        out_0_pipe_in_pipe_reg_im(0) <= dataIn_im_1;
        out_0_pipe_in_pipe_reg_im(1) <= out_0_pipe_in_pipe_reg_im(0);
        out_0_pipe_in_pipe_reg_re(0) <= dataIn_re_1;
        out_0_pipe_in_pipe_reg_re(1) <= out_0_pipe_in_pipe_reg_re(0);
      END IF;
    END IF;
  END PROCESS out_0_pipe_in_pipe_process;

  dataIn_re_2 <= out_0_pipe_in_pipe_reg_re(1);
  dataIn_im_2 <= out_0_pipe_in_pipe_reg_im(1);

  Delay2_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_bypass_reg_re <= to_signed(16#00000#, 18);
      Delay2_bypass_reg_im <= to_signed(16#00000#, 18);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay2_bypass_reg_im <= dataIn_im_2;
        Delay2_bypass_reg_re <= dataIn_re_2;
      END IF;
    END IF;
  END PROCESS Delay2_bypass_process;

  
  dataIn_re_3 <= dataIn_re_2 WHEN enb_1_256_1 = '1' ELSE
      Delay2_bypass_reg_re;
  
  dataIn_im_3 <= dataIn_im_2 WHEN enb_1_256_1 = '1' ELSE
      Delay2_bypass_reg_im;

  dataOut_re <= std_logic_vector(dataIn_re_3);

  dataOut_im <= std_logic_vector(dataIn_im_3);

  in_1_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validIn_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        validIn_1 <= validIn;
      END IF;
    END IF;
  END PROCESS in_1_pipe_in_pipe_process;


  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_out1 <= validIn_1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  pilotGen_out1_re_signed <= signed(pilotGen_out1_re);

  pilotGen_out1_im_signed <= signed(pilotGen_out1_im);

  crp_out_delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      crp_out_delay_reg_re <= (OTHERS => to_signed(16#0#, 2));
      crp_out_delay_reg_im <= (OTHERS => to_signed(16#0#, 2));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        crp_out_delay_reg_im(0) <= pilotGen_out1_im_signed;
        crp_out_delay_reg_im(1) <= crp_out_delay_reg_im(0);
        crp_out_delay_reg_re(0) <= pilotGen_out1_re_signed;
        crp_out_delay_reg_re(1) <= crp_out_delay_reg_re(0);
      END IF;
    END IF;
  END PROCESS crp_out_delay_process;

  pilotGen_out1_re_1 <= crp_out_delay_reg_re(1);
  pilotGen_out1_im_1 <= crp_out_delay_reg_im(1);

  Delay3_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_bypass_reg_re <= to_signed(16#0#, 2);
      Delay3_bypass_reg_im <= to_signed(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay3_bypass_reg_im <= pilotGen_out1_im_1;
        Delay3_bypass_reg_re <= pilotGen_out1_re_1;
      END IF;
    END IF;
  END PROCESS Delay3_bypass_process;

  
  pilotGen_out1_re_2 <= pilotGen_out1_re_1 WHEN enb_1_256_1 = '1' ELSE
      Delay3_bypass_reg_re;
  
  pilotGen_out1_im_2 <= pilotGen_out1_im_1 WHEN enb_1_256_1 = '1' ELSE
      Delay3_bypass_reg_im;

  pilotOut_re <= std_logic_vector(pilotGen_out1_re_2);

  pilotOut_im <= std_logic_vector(pilotGen_out1_im_2);

  SampleCounter_out1_1 <= std_logic_vector(unsigned(SampleCounter_out1));

  out_2_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out2_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        CtrlSigGen_out2_1 <= CtrlSigGen_out2;
      END IF;
    END IF;
  END PROCESS out_2_pipe_in_pipe_process;


  Delay11_output_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out2_2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        CtrlSigGen_out2_2 <= CtrlSigGen_out2_1;
      END IF;
    END IF;
  END PROCESS Delay11_output_process;


  delay1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out2_3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        CtrlSigGen_out2_3 <= CtrlSigGen_out2_2;
      END IF;
    END IF;
  END PROCESS delay1_1_process;


  out_3_pipe_in_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        CtrlSigGen_out1_1 <= CtrlSigGen_out1;
      END IF;
    END IF;
  END PROCESS out_3_pipe_in_pipe_process;


  Delay7_output_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out1_2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        CtrlSigGen_out1_2 <= CtrlSigGen_out1_1;
      END IF;
    END IF;
  END PROCESS Delay7_output_process;


  delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      CtrlSigGen_out1_3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        CtrlSigGen_out1_3 <= CtrlSigGen_out1_2;
      END IF;
    END IF;
  END PROCESS delay_process;


  pilotEnd <= CtrlSigGen_out2_3;

  dataValid <= CtrlSigGen_out1_3;

END rtl;

