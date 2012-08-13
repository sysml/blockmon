-- application_ent.vhd : Combov2 NetCOPE application module entity
-- Copyright (C) 2009 CESNET
-- Author(s): Jan Stourac <xstour03@stud.fit.vutbr.cz>
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in
--    the documentation and/or other materials provided with the
--    distribution.
-- 3. Neither the name of the Company nor the names of its contributors
--    may be used to endorse or promote products derived from this
--    software without specific prior written permission.
--
-- This software is provided ``as is'', and any express or implied
-- warranties, including, but not limited to, the implied warranties of
-- merchantability and fitness for a particular purpose are disclaimed.
-- In no event shall the company or contributors be liable for any
-- direct, indirect, incidental, special, exemplary, or consequential
-- damages (including, but not limited to, procurement of substitute
-- goods or services; loss of use, data, or profits; or business
-- interruption) however caused and on any theory of liability, whether
-- in contract, strict liability, or tort (including negligence or
-- otherwise) arising in any way out of the use of this software, even
-- if advised of the possibility of such damage.
--
-- $Id$
--

-- --------------------------------------------------------------------
--                          Entity declaration
-- --------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity APPLICATION is
   port (
      -- ----------------------------------------------------------------------
      -- CLOCKs and RESETs
      -- ----------------------------------------------------------------------
      -- Clock signal for user interface
      CLK                  : in std_logic;
      RESET                : in std_logic;

      CLK_CORE             : in std_logic;
      RESET_CORE           : in std_logic;

      -- ----------------------------------------------------------------------
      -- NETWORK INTERFACE 0
      -- ----------------------------------------------------------------------
      -- Input buffer interface
      IBUF0_TX_SOF_N       :  in std_logic;
      IBUF0_TX_SOP_N       :  in std_logic;
      IBUF0_TX_EOP_N       :  in std_logic;
      IBUF0_TX_EOF_N       :  in std_logic;
      IBUF0_TX_SRC_RDY_N   :  in std_logic;
      IBUF0_TX_DST_RDY_N   : out std_logic;
      IBUF0_TX_DATA        :  in std_logic_vector(63 downto 0);
      IBUF0_TX_REM         :  in std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF0_CTRL_CLK       :  in std_logic;
      IBUF0_CTRL_DATA      : out std_logic_vector(63 downto 0);
      IBUF0_CTRL_REM       : out std_logic_vector(2 downto 0);
      IBUF0_CTRL_SRC_RDY_N : out std_logic;
      IBUF0_CTRL_SOP_N     : out std_logic;
      IBUF0_CTRL_EOP_N     : out std_logic;
      IBUF0_CTRL_DST_RDY_N :  in std_logic;
      IBUF0_CTRL_RDY       : out std_logic;

      -- IBUF status interface
      IBUF0_SOP            :  in std_logic;
      IBUF0_PAYLOAD_LEN    :  in std_logic_vector(15 downto 0);
      IBUF0_FRAME_ERROR    :  in std_logic; -- 0: OK, 1: Error occured
      IBUF0_CRC_CHECK_FAILED: in std_logic; -- 0: OK, 1: Bad CRC 
      IBUF0_MAC_CHECK_FAILED: in std_logic; -- 0: OK, 1: Bad MAC
      IBUF0_LEN_BELOW_MIN  :  in std_logic; -- 0: OK, 1: Length is below min
      IBUF0_LEN_OVER_MTU   :  in std_logic; -- 0: OK, 1: Length is over MTU
      IBUF0_STAT_DV        :  in std_logic;

      -- Output buffer interface
      OBUF0_RX_SOF_N       : out std_logic;
      OBUF0_RX_SOP_N       : out std_logic;
      OBUF0_RX_EOP_N       : out std_logic;
      OBUF0_RX_EOF_N       : out std_logic;
      OBUF0_RX_SRC_RDY_N   : out std_logic;
      OBUF0_RX_DST_RDY_N   :  in std_logic;
      OBUF0_RX_DATA        : out std_logic_vector(63 downto 0);
      OBUF0_RX_REM         : out std_logic_vector(2 downto 0);

      -- ----------------------------------------------------------------------
      -- NETWORK INTERFACE 1
      -- ----------------------------------------------------------------------
      -- Input buffer interface
      IBUF1_TX_SOF_N       :  in std_logic;
      IBUF1_TX_SOP_N       :  in std_logic;
      IBUF1_TX_EOP_N       :  in std_logic;
      IBUF1_TX_EOF_N       :  in std_logic;
      IBUF1_TX_SRC_RDY_N   :  in std_logic;
      IBUF1_TX_DST_RDY_N   : out std_logic;
      IBUF1_TX_DATA        :  in std_logic_vector(63 downto 0);
      IBUF1_TX_REM         :  in std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF1_CTRL_CLK       :  in std_logic;
      IBUF1_CTRL_DATA      : out std_logic_vector(63 downto 0);
      IBUF1_CTRL_REM       : out std_logic_vector(2 downto 0);
      IBUF1_CTRL_SRC_RDY_N : out std_logic;
      IBUF1_CTRL_SOP_N     : out std_logic;
      IBUF1_CTRL_EOP_N     : out std_logic;
      IBUF1_CTRL_DST_RDY_N :  in std_logic;
      IBUF1_CTRL_RDY       : out std_logic;

      -- IBUF status interface
      IBUF1_SOP            :  in std_logic;
      IBUF1_PAYLOAD_LEN    :  in std_logic_vector(15 downto 0);
      IBUF1_FRAME_ERROR    :  in std_logic; -- 0: OK, 1: Error occured
      IBUF1_CRC_CHECK_FAILED: in std_logic; -- 0: OK, 1: Bad CRC 
      IBUF1_MAC_CHECK_FAILED: in std_logic; -- 0: OK, 1: Bad MAC
      IBUF1_LEN_BELOW_MIN  :  in std_logic; -- 0: OK, 1: Length is below min
      IBUF1_LEN_OVER_MTU   :  in std_logic; -- 0: OK, 1: Length is over MTU
      IBUF1_STAT_DV        :  in std_logic;

      -- Output buffer interface
      OBUF1_RX_SOF_N       : out std_logic;
      OBUF1_RX_SOP_N       : out std_logic;
      OBUF1_RX_EOP_N       : out std_logic;
      OBUF1_RX_EOF_N       : out std_logic;
      OBUF1_RX_SRC_RDY_N   : out std_logic;
      OBUF1_RX_DST_RDY_N   :  in std_logic;
      OBUF1_RX_DATA        : out std_logic_vector(63 downto 0);
      OBUF1_RX_REM         : out std_logic_vector(2 downto 0);

      -- ----------------------------------------------------------------------
      -- DMA INTERFACE
      -- ----------------------------------------------------------------------
      -- network interfaces interface
      -- input interface
      RX0_DATA       :  in std_logic_vector(63 downto 0);
      RX0_DREM       :  in std_logic_vector(2 downto 0);
      RX0_SOF_N      :  in std_logic;
      RX0_EOF_N      :  in std_logic;
      RX0_SOP_N      :  in std_logic;
      RX0_EOP_N      :  in std_logic;
      RX0_SRC_RDY_N  :  in std_logic;
      RX0_DST_RDY_N  : out std_logic;

      RX1_DATA       :  in std_logic_vector(63 downto 0);
      RX1_DREM       :  in std_logic_vector(2 downto 0);
      RX1_SOF_N      :  in std_logic;
      RX1_EOF_N      :  in std_logic;
      RX1_SOP_N      :  in std_logic;
      RX1_EOP_N      :  in std_logic;
      RX1_SRC_RDY_N  :  in std_logic;
      RX1_DST_RDY_N  : out std_logic;

      -- output interfaces
      TX_DATA        : out std_logic_vector(63 downto 0);
      TX_DREM        : out std_logic_vector(2 downto 0);
      TX_SOF_N       : out std_logic;
      TX_EOF_N       : out std_logic;
      TX_SOP_N       : out std_logic;
      TX_EOP_N       : out std_logic;
      TX_SRC_RDY_N   : out std_logic;
      TX_DST_RDY_N   :  in std_logic_vector(7 downto 0);

      TX_CHANNEL     : out std_logic_vector(2 downto 0);


      -- ----------------------------------------------------------------------
      -- ICS INTERFACE
      -- ----------------------------------------------------------------------
      -- Internal Bus interface (Fast)
      IB_UP_DATA        : out std_logic_vector(63 downto 0);
      IB_UP_SOF_N       : out std_logic;
      IB_UP_EOF_N       : out std_logic;
      IB_UP_SRC_RDY_N   : out std_logic;
      IB_UP_DST_RDY_N   : in  std_logic;
      IB_DOWN_DATA      : in  std_logic_vector(63 downto 0);
      IB_DOWN_SOF_N     : in  std_logic;
      IB_DOWN_EOF_N     : in  std_logic;
      IB_DOWN_SRC_RDY_N : in  std_logic;
      IB_DOWN_DST_RDY_N : out std_logic;

      -- MI32 interface (Slow, efficient)
      MI32_DWR          : in  std_logic_vector(31 downto 0);
      MI32_ADDR         : in  std_logic_vector(31 downto 0);
      MI32_RD           : in  std_logic;
      MI32_WR           : in  std_logic;
      MI32_BE           : in  std_logic_vector(3 downto 0);
      MI32_DRD          : out std_logic_vector(31 downto 0);
      MI32_ARDY         : out std_logic;
      MI32_DRDY         : out std_logic;

      -- -------------------------------------------------------------------
      -- TIMESTAMPS FOR PACODAG
      -- -------------------------------------------------------------------
      TS             : in std_logic_vector(63 downto 0);
      TS_DV          : in std_logic;
      TS_CLK         : in std_logic
   );

end APPLICATION;
