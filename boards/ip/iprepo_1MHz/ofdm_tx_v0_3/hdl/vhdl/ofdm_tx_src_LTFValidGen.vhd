-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_LTFValidGen.vhd
-- Created: 2021-05-05 09:22:16
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_LTFValidGen
-- Source Path: OFDM_Tx_HW/OFDMTx/CPAdd/LTFExtend/LTFValidGen
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_LTFValidGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        In1                               :   IN    std_logic;
        Out1                              :   OUT   std_logic
        );
END ofdm_tx_src_LTFValidGen;


ARCHITECTURE rtl OF ofdm_tx_src_LTFValidGen IS

  -- Signals
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL AND1_out1                        : std_logic;

BEGIN
  NOT_out1 <=  NOT In1;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 319
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(16#000#, 9);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF NOT_out1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(16#000#, 9);
        ELSIF In1 = '1' THEN 
          IF HDL_Counter_out1 >= to_unsigned(16#13F#, 9) THEN 
            HDL_Counter_out1 <= to_unsigned(16#000#, 9);
          ELSE 
            HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(16#001#, 9);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Constant_out1 <= '1' WHEN HDL_Counter_out1 >= to_unsigned(16#0A0#, 9) ELSE
      '0';

  
  Compare_To_Constant1_out1 <= '1' WHEN HDL_Counter_out1 <= to_unsigned(16#13F#, 9) ELSE
      '0';

  AND_out1 <= Compare_To_Constant_out1 AND Compare_To_Constant1_out1;

  AND1_out1 <= AND_out1 AND In1;

  Out1 <= AND1_out1;

END rtl;

