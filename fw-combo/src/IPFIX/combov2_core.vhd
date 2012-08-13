-- combov2_core.vhd : Combov2 NetCOPE core
-- Copyright (C) 2008 CESNET
-- Author(s): Martin Kosek <kosek@liberouter.org>
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

-- ----------------------------------------------------------------------------
--                             Entity declaration
-- ----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.combov2_core_const.all;
use work.combov2_user_const.all;
use work.math_pack.all;
use work.ibuf_general_pkg.all;
use work.fl_pkg.all;
use work.addr_space.all;

architecture full of COMBOV2_CORE is

-- ----------------------------------------------------------------------------
--                          Components declaration
-- ----------------------------------------------------------------------------
component network_mod_10g2_64 is
   port(
      -- Clock signal for user interface
      USER_CLK             :  in std_logic;
      -- FrameLink reset
      FL_RESET             :  in std_logic;
      -- ICS reset
      BUSRESET             :  in std_logic;

      -- 2 XGMII INTERFACES
      -- RX
      XGMII_RESET          :  in std_logic_vector(  1 downto 0);
      XGMII_RXCLK          :  in std_logic_vector(  1 downto 0);
      XGMII_RXD            :  in std_logic_vector(127 downto 0);
      XGMII_RXC            :  in std_logic_vector( 15 downto 0);
      -- TX
      XGMII_TXCLK          :  in std_logic_vector(  1 downto 0);
      XGMII_TXD            : out std_logic_vector(127 downto 0);
      XGMII_TXC            : out std_logic_vector( 15 downto 0);

      -- USER INTERFACE
      -- Network interface 0
      IBUF0_TX_SOF_N       : out std_logic;
      IBUF0_TX_SOP_N       : out std_logic;
      IBUF0_TX_EOP_N       : out std_logic;
      IBUF0_TX_EOF_N       : out std_logic;
      IBUF0_TX_SRC_RDY_N   : out std_logic;
      IBUF0_TX_DST_RDY_N   :  in std_logic;
      IBUF0_TX_DATA        : out std_logic_vector(63 downto 0);
      IBUF0_TX_REM         : out std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF0_CTRL_CLK       : out std_logic;
      IBUF0_CTRL_DATA      :  in std_logic_vector(63 downto 0);
      IBUF0_CTRL_REM       :  in std_logic_vector(2 downto 0);
      IBUF0_CTRL_SRC_RDY_N :  in std_logic;
      IBUF0_CTRL_SOP_N     :  in std_logic;
      IBUF0_CTRL_EOP_N     :  in std_logic;
      IBUF0_CTRL_DST_RDY_N : out std_logic;
      IBUF0_CTRL_RDY       :  in std_logic;

      -- IBUF status interface
      IBUF0_SOP            : out std_logic;
      IBUF0_PAYLOAD_LEN    : out std_logic_vector(15 downto 0);
      IBUF0_FRAME_ERROR    : out std_logic; -- 0: OK, 1: Error occured
      IBUF0_CRC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad CRC 
      IBUF0_MAC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad MAC
      IBUF0_LEN_BELOW_MIN  : out std_logic; -- 0: OK, 1: Length is below min
      IBUF0_LEN_OVER_MTU   : out std_logic; -- 0: OK, 1: Length is over MTU
      IBUF0_STAT_DV        : out std_logic;
      -- Signals active in '1' for one cycle for every processed packet
      IBUF0_FRAME_RECEIVED    : out std_logic;
      IBUF0_FRAME_DISCARDED   : out std_logic;
      -- When active in '1' frame was discarded due to buffer overflow. Can be active only together
      -- with FRAME_DISCARDED
      IBUF0_BUFFER_OVF        : out std_logic;

      -- Sampling unit interface
      IBUF0_SAU_ACCEPT     :  in std_logic;
      IBUF0_SAU_DV         :  in std_logic;
      
      -- Output buffer interface
      OBUF0_RX_SOF_N       :  in std_logic;
      OBUF0_RX_SOP_N       :  in std_logic;
      OBUF0_RX_EOP_N       :  in std_logic;
      OBUF0_RX_EOF_N       :  in std_logic;
      OBUF0_RX_SRC_RDY_N   :  in std_logic;
      OBUF0_RX_DST_RDY_N   : out std_logic;
      OBUF0_RX_DATA        :  in std_logic_vector(63 downto 0);
      OBUF0_RX_REM         :  in std_logic_vector(2 downto 0);
      
      -- Network interface 1 --------------------------------------------------
      IBUF1_TX_SOF_N       : out std_logic;
      IBUF1_TX_SOP_N       : out std_logic;
      IBUF1_TX_EOP_N       : out std_logic;
      IBUF1_TX_EOF_N       : out std_logic;
      IBUF1_TX_SRC_RDY_N   : out std_logic;
      IBUF1_TX_DST_RDY_N   :  in std_logic;
      IBUF1_TX_DATA        : out std_logic_vector(63 downto 0);
      IBUF1_TX_REM         : out std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF1_CTRL_CLK       : out std_logic;
      IBUF1_CTRL_DATA      :  in std_logic_vector(63 downto 0);
      IBUF1_CTRL_REM       :  in std_logic_vector(2 downto 0);
      IBUF1_CTRL_SRC_RDY_N :  in std_logic;
      IBUF1_CTRL_SOP_N     :  in std_logic;
      IBUF1_CTRL_EOP_N     :  in std_logic;
      IBUF1_CTRL_DST_RDY_N : out std_logic;
      IBUF1_CTRL_RDY       :  in std_logic;

      -- IBUF status interface
      IBUF1_SOP            : out std_logic;
      IBUF1_PAYLOAD_LEN    : out std_logic_vector(15 downto 0);
      IBUF1_FRAME_ERROR    : out std_logic; -- 0: OK, 1: Error occured
      IBUF1_CRC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad CRC 
      IBUF1_MAC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad MAC
      IBUF1_LEN_BELOW_MIN  : out std_logic; -- 0: OK, 1: Length is below min
      IBUF1_LEN_OVER_MTU   : out std_logic; -- 0: OK, 1: Length is over MTU
      IBUF1_STAT_DV        : out std_logic;
      -- Signals active in '1' for one cycle for every processed packet
      IBUF1_FRAME_RECEIVED    : out std_logic;
      IBUF1_FRAME_DISCARDED   : out std_logic;
      -- When active in '1' frame was discarded due to buffer overflow. Can be active only together
      -- with FRAME_DISCARDED
      IBUF1_BUFFER_OVF        : out std_logic;

      -- Sampling unit interface
      IBUF1_SAU_ACCEPT     :  in std_logic;
      IBUF1_SAU_DV         :  in std_logic;

      -- Output buffer interface
      OBUF1_RX_SOF_N       :  in std_logic;
      OBUF1_RX_SOP_N       :  in std_logic;
      OBUF1_RX_EOP_N       :  in std_logic;
      OBUF1_RX_EOF_N       :  in std_logic;
      OBUF1_RX_SRC_RDY_N   :  in std_logic;
      OBUF1_RX_DST_RDY_N   : out std_logic;
      OBUF1_RX_DATA        :  in std_logic_vector(63 downto 0);
      OBUF1_RX_REM         :  in std_logic_vector(2 downto 0);

      -- Led interface
      IBUF_LED             : out std_logic_vector(1 downto 0);
      OBUF_LED             : out std_logic_vector(1 downto 0);
      
      -- Link presence interface
      LINK0         : out std_logic;
      LINK1         : out std_logic;

      -- MI32 interface
      MI32_DWR             : in  std_logic_vector(31 downto 0);
      MI32_ADDR            : in  std_logic_vector(31 downto 0);
      MI32_RD              : in  std_logic;
      MI32_WR              : in  std_logic;
      MI32_BE              : in  std_logic_vector(3 downto 0);
      MI32_DRD             : out std_logic_vector(31 downto 0);
      MI32_ARDY            : out std_logic;
      MI32_DRDY            : out std_logic
   );
end component;

component NETWORK_MOD_10G2_64_16KBYTE is
   port(
      -- Clock signal for user interface
      USER_CLK             :  in std_logic;
      -- FrameLink reset
      FL_RESET             :  in std_logic;
      -- ICS reset
      BUSRESET             :  in std_logic;

      -- 2 XGMII INTERFACES
      -- RX
      XGMII_RESET          :  in std_logic_vector(  1 downto 0);
      XGMII_RXCLK          :  in std_logic_vector(  1 downto 0);
      XGMII_RXD            :  in std_logic_vector(127 downto 0);
      XGMII_RXC            :  in std_logic_vector( 15 downto 0);
      -- TX
      XGMII_TXCLK          :  in std_logic_vector(  1 downto 0);
      XGMII_TXD            : out std_logic_vector(127 downto 0);
      XGMII_TXC            : out std_logic_vector( 15 downto 0);

      -- USER INTERFACE
      -- Network interface 0
      IBUF0_TX_SOF_N       : out std_logic;
      IBUF0_TX_SOP_N       : out std_logic;
      IBUF0_TX_EOP_N       : out std_logic;
      IBUF0_TX_EOF_N       : out std_logic;
      IBUF0_TX_SRC_RDY_N   : out std_logic;
      IBUF0_TX_DST_RDY_N   :  in std_logic;
      IBUF0_TX_DATA        : out std_logic_vector(63 downto 0);
      IBUF0_TX_REM         : out std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF0_CTRL_CLK       : out std_logic;
      IBUF0_CTRL_DATA      :  in std_logic_vector(63 downto 0);
      IBUF0_CTRL_REM       :  in std_logic_vector(2 downto 0);
      IBUF0_CTRL_SRC_RDY_N :  in std_logic;
      IBUF0_CTRL_SOP_N     :  in std_logic;
      IBUF0_CTRL_EOP_N     :  in std_logic;
      IBUF0_CTRL_DST_RDY_N : out std_logic;
      IBUF0_CTRL_RDY       :  in std_logic;

      -- IBUF status interface
      IBUF0_SOP            : out std_logic;
      IBUF0_PAYLOAD_LEN    : out std_logic_vector(15 downto 0);
      IBUF0_FRAME_ERROR    : out std_logic; -- 0: OK, 1: Error occured
      IBUF0_CRC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad CRC 
      IBUF0_MAC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad MAC
      IBUF0_LEN_BELOW_MIN  : out std_logic; -- 0: OK, 1: Length is below min
      IBUF0_LEN_OVER_MTU   : out std_logic; -- 0: OK, 1: Length is over MTU
      IBUF0_STAT_DV        : out std_logic;
      -- Signals active in '1' for one cycle for every processed packet
      IBUF0_FRAME_RECEIVED    : out std_logic;
      IBUF0_FRAME_DISCARDED   : out std_logic;
      -- When active in '1' frame was discarded due to buffer overflow. Can be active only together
      -- with FRAME_DISCARDED
      IBUF0_BUFFER_OVF        : out std_logic;

      -- Sampling unit interface
      IBUF0_SAU_ACCEPT     :  in std_logic;
      IBUF0_SAU_DV         :  in std_logic;
      
      -- Output buffer interface
      OBUF0_RX_SOF_N       :  in std_logic;
      OBUF0_RX_SOP_N       :  in std_logic;
      OBUF0_RX_EOP_N       :  in std_logic;
      OBUF0_RX_EOF_N       :  in std_logic;
      OBUF0_RX_SRC_RDY_N   :  in std_logic;
      OBUF0_RX_DST_RDY_N   : out std_logic;
      OBUF0_RX_DATA        :  in std_logic_vector(63 downto 0);
      OBUF0_RX_REM         :  in std_logic_vector(2 downto 0);
      
      -- Network interface 1 --------------------------------------------------
      IBUF1_TX_SOF_N       : out std_logic;
      IBUF1_TX_SOP_N       : out std_logic;
      IBUF1_TX_EOP_N       : out std_logic;
      IBUF1_TX_EOF_N       : out std_logic;
      IBUF1_TX_SRC_RDY_N   : out std_logic;
      IBUF1_TX_DST_RDY_N   :  in std_logic;
      IBUF1_TX_DATA        : out std_logic_vector(63 downto 0);
      IBUF1_TX_REM         : out std_logic_vector(2 downto 0);

      -- PACODAG interface
      IBUF1_CTRL_CLK       : out std_logic;
      IBUF1_CTRL_DATA      :  in std_logic_vector(63 downto 0);
      IBUF1_CTRL_REM       :  in std_logic_vector(2 downto 0);
      IBUF1_CTRL_SRC_RDY_N :  in std_logic;
      IBUF1_CTRL_SOP_N     :  in std_logic;
      IBUF1_CTRL_EOP_N     :  in std_logic;
      IBUF1_CTRL_DST_RDY_N : out std_logic;
      IBUF1_CTRL_RDY       :  in std_logic;

      -- IBUF status interface
      IBUF1_SOP            : out std_logic;
      IBUF1_PAYLOAD_LEN    : out std_logic_vector(15 downto 0);
      IBUF1_FRAME_ERROR    : out std_logic; -- 0: OK, 1: Error occured
      IBUF1_CRC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad CRC 
      IBUF1_MAC_CHECK_FAILED:out std_logic; -- 0: OK, 1: Bad MAC
      IBUF1_LEN_BELOW_MIN  : out std_logic; -- 0: OK, 1: Length is below min
      IBUF1_LEN_OVER_MTU   : out std_logic; -- 0: OK, 1: Length is over MTU
      IBUF1_STAT_DV        : out std_logic;
      -- Signals active in '1' for one cycle for every processed packet
      IBUF1_FRAME_RECEIVED    : out std_logic;
      IBUF1_FRAME_DISCARDED   : out std_logic;
      -- When active in '1' frame was discarded due to buffer overflow. Can be active only together
      -- with FRAME_DISCARDED
      IBUF1_BUFFER_OVF        : out std_logic;

      -- Sampling unit interface
      IBUF1_SAU_ACCEPT     :  in std_logic;
      IBUF1_SAU_DV         :  in std_logic;

      -- Output buffer interface
      OBUF1_RX_SOF_N       :  in std_logic;
      OBUF1_RX_SOP_N       :  in std_logic;
      OBUF1_RX_EOP_N       :  in std_logic;
      OBUF1_RX_EOF_N       :  in std_logic;
      OBUF1_RX_SRC_RDY_N   :  in std_logic;
      OBUF1_RX_DST_RDY_N   : out std_logic;
      OBUF1_RX_DATA        :  in std_logic_vector(63 downto 0);
      OBUF1_RX_REM         :  in std_logic_vector(2 downto 0);

      -- Led interface
      IBUF_LED             : out std_logic_vector(1 downto 0);
      OBUF_LED             : out std_logic_vector(1 downto 0);
      
      -- Link presence interface
      LINK0         : out std_logic;
      LINK1         : out std_logic;

      -- MI32 interface
      MI32_DWR             : in  std_logic_vector(31 downto 0);
      MI32_ADDR            : in  std_logic_vector(31 downto 0);
      MI32_RD              : in  std_logic;
      MI32_WR              : in  std_logic;
      MI32_BE              : in  std_logic_vector(3 downto 0);
      MI32_DRD             : out std_logic_vector(31 downto 0);
      MI32_ARDY            : out std_logic;
      MI32_DRDY            : out std_logic
   );
end component;

component DMA_MOD_2X64B_RXTX_16KBYTE_GEN is
   port(
      -- ICS Clock (IB and LB)
      CLK            : in  std_logic;
      RESET          : in  std_logic;

      RX_INTERRUPT   : out std_logic;
      TX_INTERRUPT   : out std_logic;
      
      -- network interfaces interface
      -- input interface
      RX0_DATA       : in  std_logic_vector(63 downto 0);
      RX0_DREM       : in  std_logic_vector(2 downto 0);
      RX0_SOF_N      : in  std_logic;
      RX0_EOF_N      : in  std_logic;
      RX0_SOP_N      : in  std_logic;
      RX0_EOP_N      : in  std_logic;
      RX0_SRC_RDY_N  : in  std_logic;
      RX0_DST_RDY_N  : out std_logic;

      RX1_DATA       : in  std_logic_vector(63 downto 0);
      RX1_DREM       : in  std_logic_vector(2 downto 0);
      RX1_SOF_N      : in  std_logic;
      RX1_EOF_N      : in  std_logic;
      RX1_SOP_N      : in  std_logic;
      RX1_EOP_N      : in  std_logic;
      RX1_SRC_RDY_N  : in  std_logic;
      RX1_DST_RDY_N  : out std_logic;

      -- output interfaces
      TX0_DATA       : out std_logic_vector(63 downto 0);
      TX0_DREM       : out std_logic_vector(2 downto 0);
      TX0_SOF_N      : out std_logic;
      TX0_EOF_N      : out std_logic;
      TX0_SOP_N      : out std_logic;
      TX0_EOP_N      : out std_logic;
      TX0_SRC_RDY_N  : out std_logic;
      TX0_DST_RDY_N  : in  std_logic;

      TX1_DATA       : out std_logic_vector(63 downto 0);
      TX1_DREM       : out std_logic_vector(2 downto 0);
      TX1_SOF_N      : out std_logic;
      TX1_EOF_N      : out std_logic;
      TX1_SOP_N      : out std_logic;
      TX1_EOP_N      : out std_logic;
      TX1_SRC_RDY_N  : out std_logic;
      TX1_DST_RDY_N  : in  std_logic;

      -- Internal Bus
      IB_DOWN_DATA      : in  std_logic_vector(63 downto 0);
      IB_DOWN_SOF_N     : in  std_logic;
      IB_DOWN_EOF_N     : in  std_logic;
      IB_DOWN_SRC_RDY_N : in std_logic;
      IB_DOWN_DST_RDY_N : out std_logic;
      IB_UP_DATA        : out std_logic_vector(63 downto 0);
      IB_UP_SOF_N       : out std_logic;
      IB_UP_EOF_N       : out std_logic;
      IB_UP_SRC_RDY_N   : out std_logic;
      IB_UP_DST_RDY_N   : in  std_logic;

      -- MI32 interface
      MI32_DWR          : in  std_logic_vector(31 downto 0);
      MI32_ADDR         : in  std_logic_vector(31 downto 0);
      MI32_RD           : in  std_logic;
      MI32_WR           : in  std_logic;
      MI32_BE           : in  std_logic_vector(3 downto 0);
      MI32_DRD          : out std_logic_vector(31 downto 0);
      MI32_ARDY         : out std_logic;
      MI32_DRDY         : out std_logic
   );
end component;


component DMA_MOD_2x64b_RXTX_GEN is
   port(
      -- ICS Clock (IB and LB)
      CLK            : in  std_logic;
      RESET          : in  std_logic;

      RX_INTERRUPT   : out std_logic;
      TX_INTERRUPT   : out std_logic;
      
      -- network interfaces interface
      -- input interface
      RX0_DATA       : in  std_logic_vector(63 downto 0);
      RX0_DREM       : in  std_logic_vector(2 downto 0);
      RX0_SOF_N      : in  std_logic;
      RX0_EOF_N      : in  std_logic;
      RX0_SOP_N      : in  std_logic;
      RX0_EOP_N      : in  std_logic;
      RX0_SRC_RDY_N  : in  std_logic;
      RX0_DST_RDY_N  : out std_logic;

      RX1_DATA       : in  std_logic_vector(63 downto 0);
      RX1_DREM       : in  std_logic_vector(2 downto 0);
      RX1_SOF_N      : in  std_logic;
      RX1_EOF_N      : in  std_logic;
      RX1_SOP_N      : in  std_logic;
      RX1_EOP_N      : in  std_logic;
      RX1_SRC_RDY_N  : in  std_logic;
      RX1_DST_RDY_N  : out std_logic;

      -- output interfaces
      TX0_DATA       : out std_logic_vector(63 downto 0);
      TX0_DREM       : out std_logic_vector(2 downto 0);
      TX0_SOF_N      : out std_logic;
      TX0_EOF_N      : out std_logic;
      TX0_SOP_N      : out std_logic;
      TX0_EOP_N      : out std_logic;
      TX0_SRC_RDY_N  : out std_logic;
      TX0_DST_RDY_N  : in  std_logic;

      TX1_DATA       : out std_logic_vector(63 downto 0);
      TX1_DREM       : out std_logic_vector(2 downto 0);
      TX1_SOF_N      : out std_logic;
      TX1_EOF_N      : out std_logic;
      TX1_SOP_N      : out std_logic;
      TX1_EOP_N      : out std_logic;
      TX1_SRC_RDY_N  : out std_logic;
      TX1_DST_RDY_N  : in  std_logic;

      -- Internal Bus
      IB_DOWN_DATA      : in  std_logic_vector(63 downto 0);
      IB_DOWN_SOF_N     : in  std_logic;
      IB_DOWN_EOF_N     : in  std_logic;
      IB_DOWN_SRC_RDY_N : in std_logic;
      IB_DOWN_DST_RDY_N : out std_logic;
      IB_UP_DATA        : out std_logic_vector(63 downto 0);
      IB_UP_SOF_N       : out std_logic;
      IB_UP_EOF_N       : out std_logic;
      IB_UP_SRC_RDY_N   : out std_logic;
      IB_UP_DST_RDY_N   : in  std_logic;

      -- MI32 interface
      MI32_DWR          : in  std_logic_vector(31 downto 0);
      MI32_ADDR         : in  std_logic_vector(31 downto 0);
      MI32_RD           : in  std_logic;
      MI32_WR           : in  std_logic;
      MI32_BE           : in  std_logic_vector(3 downto 0);
      MI32_DRD          : out std_logic_vector(31 downto 0);
      MI32_ARDY         : out std_logic;
      MI32_DRDY         : out std_logic
   );
end component;

component DMA_MOD_64b_8RX2TX_GEN is
   port(
      -- ICS Clock and RESET - drives the whole module
      CLK            : in  std_logic;
      RESET          : in  std_logic;

      -- Synchronous at CLK
      RX_INTERRUPT   : out std_logic;
      TX_INTERRUPT   : out std_logic;

      -- input interface
      RX_DATA       : in  std_logic_vector(63 downto 0);
      RX_DREM       : in  std_logic_vector(2 downto 0);
      RX_SOF_N      : in  std_logic;
      RX_EOF_N      : in  std_logic;
      RX_SOP_N      : in  std_logic;
      RX_EOP_N      : in  std_logic;
      RX_SRC_RDY_N  : in  std_logic;
      RX_DST_RDY_N  : out std_logic_vector(7 downto 0);
      -- Determine the number of channel. Must be valid for each data word.
      RX_CHANNEL    : in  std_logic_vector(2 downto 0);

      -- output interfaces
      TX0_DATA       : out std_logic_vector(63 downto 0);
      TX0_DREM       : out std_logic_vector(2 downto 0);
      TX0_SOF_N      : out std_logic;
      TX0_EOF_N      : out std_logic;
      TX0_SOP_N      : out std_logic;
      TX0_EOP_N      : out std_logic;
      TX0_SRC_RDY_N  : out std_logic;
      TX0_DST_RDY_N  : in  std_logic;

      TX1_DATA       : out std_logic_vector(63 downto 0);
      TX1_DREM       : out std_logic_vector(2 downto 0);
      TX1_SOF_N      : out std_logic;
      TX1_EOF_N      : out std_logic;
      TX1_SOP_N      : out std_logic;
      TX1_EOP_N      : out std_logic;
      TX1_SRC_RDY_N  : out std_logic;
      TX1_DST_RDY_N  : in  std_logic;

      -- Internal Bus - CLK (ICS Clock)
      IB_DOWN_DATA   : in  std_logic_vector(63 downto 0);
      IB_DOWN_SOF_N  : in  std_logic;
      IB_DOWN_EOF_N  : in  std_logic;
      IB_DOWN_SRC_RDY_N:in std_logic;
      IB_DOWN_DST_RDY_N:out std_logic;
      IB_UP_DATA     : out std_logic_vector(63 downto 0);
      IB_UP_SOF_N    : out std_logic;
      IB_UP_EOF_N    : out std_logic;
      IB_UP_SRC_RDY_N: out std_logic;
      IB_UP_DST_RDY_N: in  std_logic;

      -- MI32 Interface
      MI32_DWR         : in  std_logic_vector(31 downto 0);
      MI32_ADDR        : in  std_logic_vector(31 downto 0);
      MI32_BE          : in  std_logic_vector(3 downto 0);
      MI32_RD          : in  std_logic;
      MI32_WR          : in  std_logic;
      MI32_DRDY        : out std_logic;
      MI32_ARDY        : out std_logic;
      MI32_DRD         : out std_logic_vector(31 downto 0)
   );
end component;

component GICS_IB_SWITCH_SLAVE_SYNTH is
port(
   CLK                  : in  std_logic;
   RESET                : in  std_logic;

   PORT0_UP_DATA        : out std_logic_vector(63 downto 0);
   PORT0_UP_SOF_N       : out std_logic;
   PORT0_UP_EOF_N       : out std_logic;
   PORT0_UP_SRC_RDY_N   : out std_logic;
   PORT0_UP_DST_RDY_N   : in  std_logic;
   PORT0_DOWN_DATA      : in  std_logic_vector(63 downto 0);
   PORT0_DOWN_SOF_N     : in  std_logic;
   PORT0_DOWN_EOF_N     : in  std_logic;
   PORT0_DOWN_SRC_RDY_N : in  std_logic;
   PORT0_DOWN_DST_RDY_N : out std_logic;

   PORT1_UP_DATA        : in  std_logic_vector(63 downto 0);
   PORT1_UP_SOF_N       : in  std_logic;
   PORT1_UP_EOF_N       : in  std_logic;
   PORT1_UP_SRC_RDY_N   : in  std_logic;
   PORT1_UP_DST_RDY_N   : out std_logic;
   PORT1_DOWN_DATA      : out std_logic_vector(63 downto 0);
   PORT1_DOWN_SOF_N     : out std_logic;
   PORT1_DOWN_EOF_N     : out std_logic;
   PORT1_DOWN_SRC_RDY_N : out std_logic;
   PORT1_DOWN_DST_RDY_N : in  std_logic;

   PORT2_UP_DATA        : in  std_logic_vector(63 downto 0);
   PORT2_UP_SOF_N       : in  std_logic;
   PORT2_UP_EOF_N       : in  std_logic;
   PORT2_UP_SRC_RDY_N   : in  std_logic;
   PORT2_UP_DST_RDY_N   : out std_logic;
   PORT2_DOWN_DATA      : out std_logic_vector(63 downto 0);
   PORT2_DOWN_SOF_N     : out std_logic;
   PORT2_DOWN_EOF_N     : out std_logic;
   PORT2_DOWN_SRC_RDY_N : out std_logic;
   PORT2_DOWN_DST_RDY_N : in  std_logic
);
end component GICS_IB_SWITCH_SLAVE_SYNTH;

-- input buffer for differencial pair
component IBUFDS
port (
   O  : out std_logic;
   I  : in  std_logic;
   IB : in  std_logic
);
end component;

-- output buffer for differencial pair
component OBUFDS
port (
   OB : out std_logic;
   O  : out std_logic;
   I  : in  std_logic
);
end component;

-- output buffer
component OBUF
port (
   O  : out std_logic;
   I  : in  std_logic
);
end component;

-- ----------------------------------------------------------------------------
--                            Signal declaration
-- ----------------------------------------------------------------------------

   -- ------------------------------------------------------------------------
   --                          DMA module signals
   -- ------------------------------------------------------------------------
   -- DMA module buffers FrameLink
   signal swbuf0_tx           : t_fl64;
   signal swbuf1_tx           : t_fl64;


   signal swbuf_rx            : t_fl64;
   signal swbuf_rx_dst_rdy_n  : std_logic_vector(7 downto 0);
   signal swbuf_rx_channel    : std_logic_vector(2 downto 0);
   
   -- Interrupts signals
   signal rx_interrupt        : std_logic;
   signal tx_interrupt        : std_logic;
   signal reg_rx_interrupt    : std_logic;
   signal reg_tx_interrupt    : std_logic;
   signal reg_sysmon_alarm    : std_logic;
   signal sysmon_alarm_pulse  : std_logic;
   signal reg_sysmon_alarm_pulse : std_logic;

   signal link0               : std_logic;
   signal link1               : std_logic;
   signal regasync_link0      : std_logic;
   signal regasync_link1      : std_logic;
   signal reg_link0           : std_logic;
   signal reg_link1           : std_logic;
   signal link0_change        : std_logic;
   signal link1_change        : std_logic;
   signal reg_link_change    : std_logic;

   signal interrupts          : std_logic_vector(31 downto 0);

   -- ------------------------------------------------------------------------
   --                        Network module signals
   -- ------------------------------------------------------------------------
   signal ibuf0_pacodag_clk       : std_logic;
   signal ibuf0_pacodag_data      : std_logic_vector(63 downto 0);
   signal ibuf0_pacodag_rem       : std_logic_vector(2 downto 0);
   signal ibuf0_pacodag_src_rdy_n : std_logic;
   signal ibuf0_pacodag_sop_n     : std_logic;
   signal ibuf0_pacodag_eop_n     : std_logic;
   signal ibuf0_pacodag_dst_rdy_n : std_logic;
   signal ibuf0_pacodag_rdy       : std_logic; -- PCD is ready for next request
   signal ibuf0_pacodag_sop       : std_logic;
   signal ibuf0_pacodag_stat      : t_ibuf_general_stat;
   signal ibuf0_pacodag_stat_dv   : std_logic;

   signal ibuf0_sau_accept    : std_logic;
   signal ibuf0_sau_dv        : std_logic;

   signal ibuf1_pacodag_clk       : std_logic;
   signal ibuf1_pacodag_data      : std_logic_vector(63 downto 0);
   signal ibuf1_pacodag_rem       : std_logic_vector(2 downto 0);
   signal ibuf1_pacodag_src_rdy_n : std_logic;
   signal ibuf1_pacodag_sop_n     : std_logic;
   signal ibuf1_pacodag_eop_n     : std_logic;
   signal ibuf1_pacodag_dst_rdy_n : std_logic;
   signal ibuf1_pacodag_rdy       : std_logic; -- PCD is ready for next request
   signal ibuf1_pacodag_sop       : std_logic;
   signal ibuf1_pacodag_stat      : t_ibuf_general_stat;
   signal ibuf1_pacodag_stat_dv   : std_logic;
   signal ibuf1_sau_accept    : std_logic;
   signal ibuf1_sau_dv        : std_logic;

   attribute buffer_type:string;
   attribute buffer_type of ibuf1_pacodag_clk:signal is "none";
   attribute buffer_type of ibuf0_pacodag_clk:signal is "none";

   -- IBUFs/OBUFs to output FrameLink
   signal obuf0_rx     : t_fl64;
   signal obuf1_rx     : t_fl64;
   signal ibuf0_tx     : t_fl64;
   signal ibuf1_tx     : t_fl64;

   -- ------------------------------------------------------------------------
   --                            Other signals
   -- ------------------------------------------------------------------------

   -- Internal bus signals ---------------------
   signal ibus_down_data         : std_logic_vector(63 downto 0);
   signal ibus_down_sof_n        : std_logic;
   signal ibus_down_eof_n        : std_logic;
   signal ibus_down_src_rdy_n    : std_logic;
   signal ibus_down_dst_rdy_n    : std_logic;
   signal ibus_up_data           : std_logic_vector(63 downto 0);
   signal ibus_up_sof_n          : std_logic;
   signal ibus_up_eof_n          : std_logic;
   signal ibus_up_src_rdy_n      : std_logic;
   signal ibus_up_dst_rdy_n      : std_logic;

   signal app_ib_up_data         : std_logic_vector(63 downto 0);
   signal app_ib_up_sof_n        : std_logic;
   signal app_ib_up_eof_n        : std_logic;
   signal app_ib_up_src_rdy_n    : std_logic;
   signal app_ib_up_dst_rdy_n    : std_logic;
   signal app_ib_down_data       : std_logic_vector(63 downto 0);
   signal app_ib_down_sof_n      : std_logic;
   signal app_ib_down_eof_n      : std_logic;
   signal app_ib_down_src_rdy_n  : std_logic;
   signal app_ib_down_dst_rdy_n  : std_logic;

   signal mi32_dma_ardy_aux      : std_logic;
   signal mi32_dma_drdy_aux      : std_logic;
   signal mi32_dma_drd_aux       : std_logic_vector(31 downto 0);

   signal mi32_net_ardy_aux      : std_logic;
   signal mi32_net_drdy_aux      : std_logic;
   signal mi32_net_drd_aux       : std_logic_vector(31 downto 0);

   signal mi32_user_ardy_aux     : std_logic;
   signal mi32_user_drdy_aux     : std_logic;
   signal mi32_user_drd_aux      : std_logic_vector(31 downto 0);

   -- attributes to prevent optimization in precision
   attribute dont_touch : string;
   attribute dont_touch of MCLK0_IBUFDS : label is "true";
   attribute dont_touch of MCLK1_IBUFDS : label is "true";
   attribute dont_touch of XCLK0_IBUFDS : label is "true";
   attribute dont_touch of XCLK1_IBUFDS : label is "true";
   attribute dont_touch of GCLK100_IBUFDS : label is "true";
   attribute dont_touch of GCLK250_IBUFDS : label is "true";

-- ----------------------------------------------------------------------------
--                             Architecture body
-- ----------------------------------------------------------------------------
begin
   -- -------------------------------------------------------------------------
   --                        USER APPLICATION MODULE
   -- -------------------------------------------------------------------------
   APPLICATION_I : entity work.APPLICATION
   port map(
      -- ----------------------------------------------------------------------
      -- CLOCKs and RESETs
      -- ----------------------------------------------------------------------
      -- Clock signal for user interface
      CLK                     => CLK_ICS,
      RESET                   => RESET_ICS,

      CLK_CORE                => CLK_USER0,
      RESET_CORE              => RESET_USER0,

      -- ----------------------------------------------------------------------
      -- NETWORK INTERFACE 0
      -- ----------------------------------------------------------------------
      -- Input buffer interface
      IBUF0_TX_SOF_N          => ibuf0_tx.SOF_N,
      IBUF0_TX_SOP_N          => ibuf0_tx.SOP_N,
      IBUF0_TX_EOP_N          => ibuf0_tx.EOP_N,
      IBUF0_TX_EOF_N          => ibuf0_tx.EOF_N,
      IBUF0_TX_SRC_RDY_N      => ibuf0_tx.SRC_RDY_N,
      IBUF0_TX_DST_RDY_N      => ibuf0_tx.DST_RDY_N,
      IBUF0_TX_DATA           => ibuf0_tx.DATA,
      IBUF0_TX_REM            => ibuf0_tx.DREM,

      -- PACODAG interface
      IBUF0_CTRL_CLK          => ibuf0_pacodag_clk,
      IBUF0_CTRL_DATA         => ibuf0_pacodag_data,
      IBUF0_CTRL_REM          => ibuf0_pacodag_rem,
      IBUF0_CTRL_SRC_RDY_N    => ibuf0_pacodag_src_rdy_n,
      IBUF0_CTRL_SOP_N        => ibuf0_pacodag_sop_n,
      IBUF0_CTRL_EOP_N        => ibuf0_pacodag_eop_n,
      IBUF0_CTRL_DST_RDY_N    => ibuf0_pacodag_dst_rdy_n,
      IBUF0_CTRL_RDY          => ibuf0_pacodag_rdy,

      -- IBUF status interface
      IBUF0_SOP               => ibuf0_pacodag_sop,
      IBUF0_PAYLOAD_LEN       => ibuf0_pacodag_stat.payload_len,
      IBUF0_FRAME_ERROR       => ibuf0_pacodag_stat.frame_error,
      IBUF0_CRC_CHECK_FAILED  => ibuf0_pacodag_stat.crc_check_failed,
      IBUF0_MAC_CHECK_FAILED  => ibuf0_pacodag_stat.mac_check_failed,
      IBUF0_LEN_BELOW_MIN     => ibuf0_pacodag_stat.len_below_min,
      IBUF0_LEN_OVER_MTU      => ibuf0_pacodag_stat.len_over_mtu,
      IBUF0_STAT_DV           => ibuf0_pacodag_stat_dv,

      -- Output buffer interface
      OBUF0_RX_SOF_N          => obuf0_rx.SOF_N,
      OBUF0_RX_SOP_N          => obuf0_rx.SOP_N,
      OBUF0_RX_EOP_N          => obuf0_rx.EOP_N,
      OBUF0_RX_EOF_N          => obuf0_rx.EOF_N,
      OBUF0_RX_SRC_RDY_N      => obuf0_rx.SRC_RDY_N,
      OBUF0_RX_DST_RDY_N      => obuf0_rx.DST_RDY_N,
      OBUF0_RX_DATA           => obuf0_rx.DATA,
      OBUF0_RX_REM            => obuf0_rx.DREM,

      -- ----------------------------------------------------------------------
      -- NETWORK INTERFACE 1
      -- ----------------------------------------------------------------------
      -- Input buffer interface
      IBUF1_TX_SOF_N          => ibuf1_tx.SOF_N,
      IBUF1_TX_SOP_N          => ibuf1_tx.SOP_N,
      IBUF1_TX_EOP_N          => ibuf1_tx.EOP_N,
      IBUF1_TX_EOF_N          => ibuf1_tx.EOF_N,
      IBUF1_TX_SRC_RDY_N      => ibuf1_tx.SRC_RDY_N,
      IBUF1_TX_DST_RDY_N      => ibuf1_tx.DST_RDY_N,
      IBUF1_TX_DATA           => ibuf1_tx.DATA,
      IBUF1_TX_REM            => ibuf1_tx.DREM,

      -- PACODAG interface
      IBUF1_CTRL_CLK          => ibuf1_pacodag_clk,
      IBUF1_CTRL_DATA         => ibuf1_pacodag_data,
      IBUF1_CTRL_REM          => ibuf1_pacodag_rem,
      IBUF1_CTRL_SRC_RDY_N    => ibuf1_pacodag_src_rdy_n,
      IBUF1_CTRL_SOP_N        => ibuf1_pacodag_sop_n,
      IBUF1_CTRL_EOP_N        => ibuf1_pacodag_eop_n,
      IBUF1_CTRL_DST_RDY_N    => ibuf1_pacodag_dst_rdy_n,
      IBUF1_CTRL_RDY          => ibuf1_pacodag_rdy,

      -- IBUF status interface
      IBUF1_SOP               => ibuf1_pacodag_sop,
      IBUF1_PAYLOAD_LEN       => ibuf1_pacodag_stat.payload_len,
      IBUF1_FRAME_ERROR       => ibuf1_pacodag_stat.frame_error,
      IBUF1_CRC_CHECK_FAILED  => ibuf1_pacodag_stat.crc_check_failed,
      IBUF1_MAC_CHECK_FAILED  => ibuf1_pacodag_stat.mac_check_failed,
      IBUF1_LEN_BELOW_MIN     => ibuf1_pacodag_stat.len_below_min,
      IBUF1_LEN_OVER_MTU      => ibuf1_pacodag_stat.len_over_mtu,
      IBUF1_STAT_DV           => ibuf1_pacodag_stat_dv,

      -- Output buffer interface
      OBUF1_RX_SOF_N          => obuf1_rx.SOF_N,
      OBUF1_RX_SOP_N          => obuf1_rx.SOP_N,
      OBUF1_RX_EOP_N          => obuf1_rx.EOP_N,
      OBUF1_RX_EOF_N          => obuf1_rx.EOF_N,
      OBUF1_RX_SRC_RDY_N      => obuf1_rx.SRC_RDY_N,
      OBUF1_RX_DST_RDY_N      => obuf1_rx.DST_RDY_N,
      OBUF1_RX_DATA           => obuf1_rx.DATA,
      OBUF1_RX_REM            => obuf1_rx.DREM,

      -- ----------------------------------------------------------------------
      -- DMA INTERFACE
      -- ----------------------------------------------------------------------
      -- network interfaces interface
      -- input interface
      RX0_DATA                => swbuf0_tx.DATA,
      RX0_DREM                => swbuf0_tx.DREM,
      RX0_SOF_N               => swbuf0_tx.SOF_N,
      RX0_EOF_N               => swbuf0_tx.EOF_N,
      RX0_SOP_N               => swbuf0_tx.SOP_N,
      RX0_EOP_N               => swbuf0_tx.EOP_N,
      RX0_SRC_RDY_N           => swbuf0_tx.SRC_RDY_N,
      RX0_DST_RDY_N           => swbuf0_tx.DST_RDY_N,

      RX1_DATA                => swbuf1_tx.DATA,
      RX1_DREM                => swbuf1_tx.DREM,
      RX1_SOF_N               => swbuf1_tx.SOF_N,
      RX1_EOF_N               => swbuf1_tx.EOF_N,
      RX1_SOP_N               => swbuf1_tx.SOP_N,
      RX1_EOP_N               => swbuf1_tx.EOP_N,
      RX1_SRC_RDY_N           => swbuf1_tx.SRC_RDY_N,
      RX1_DST_RDY_N           => swbuf1_tx.DST_RDY_N,

      -- output interfaces
      TX_DATA                => swbuf_rx.DATA,
      TX_DREM                => swbuf_rx.DREM,
      TX_SOF_N               => swbuf_rx.SOF_N,
      TX_EOF_N               => swbuf_rx.EOF_N,
      TX_SOP_N               => swbuf_rx.SOP_N,
      TX_EOP_N               => swbuf_rx.EOP_N,
      TX_SRC_RDY_N           => swbuf_rx.SRC_RDY_N,
      TX_DST_RDY_N           => swbuf_rx_dst_rdy_n,

      TX_CHANNEL             => swbuf_rx_channel,

      -- ----------------------------------------------------------------------
      -- ICS INTERFACE
      -- ----------------------------------------------------------------------
      -- Internal Bus interface (Fast)
      IB_UP_DATA        => app_ib_up_data,
      IB_UP_SOF_N       => app_ib_up_sof_n,
      IB_UP_EOF_N       => app_ib_up_eof_n,
      IB_UP_SRC_RDY_N   => app_ib_up_src_rdy_n,
      IB_UP_DST_RDY_N   => app_ib_up_dst_rdy_n,
      IB_DOWN_DATA      => app_ib_down_data,
      IB_DOWN_SOF_N     => app_ib_down_sof_n,
      IB_DOWN_EOF_N     => app_ib_down_eof_n,
      IB_DOWN_SRC_RDY_N => app_ib_down_src_rdy_n,
      IB_DOWN_DST_RDY_N => app_ib_down_dst_rdy_n,

      -- MI32 interface (Slow, efficient)
      MI32_DWR          => MI32_USER_DWR,
      MI32_ADDR         => MI32_USER_ADDR,
      MI32_RD           => MI32_USER_RD,
      MI32_WR           => MI32_USER_WR,
      MI32_BE           => MI32_USER_BE,
      MI32_DRD          => mi32_user_drd_aux,
      MI32_ARDY         => mi32_user_ardy_aux,
      MI32_DRDY         => mi32_user_drdy_aux,

      -- ----------------------------------------------------------------------
      -- TIMESTAMPS FOR PACODAG
      -- ----------------------------------------------------------------------
      TS                      => TS_NS,
      TS_DV                   => TS_DV,
      TS_CLK                  => TS_CLK
   );
   
   MI32_USER_DRD  <= mi32_user_drd_aux;
   MI32_USER_ARDY <= mi32_user_ardy_aux;
   MI32_USER_DRDY <= mi32_user_drdy_aux;
   
   -- -------------------------------------------------------------------------
   --                            EMPTY SAU
   -- -------------------------------------------------------------------------
   ibuf0_sau_accept <= '1';
   ibuf0_sau_dv     <= '1';
   ibuf1_sau_accept <= '1';
   ibuf1_sau_dv     <= '1';

   -- -------------------------------------------------------------------------
   --                            NETWORK MODULE
   -- -------------------------------------------------------------------------
      NETWORK_MODULE_I : NETWORK_MOD_10G2_64
      port map(
         USER_CLK          => CLK_ICS,
         FL_RESET          => RESET_ICS,
         BUSRESET          => RESET_ICS,

         -- 2 XGMII interfaces
         -- RX
         XGMII_RESET    => XGMII_RESET,
         XGMII_RXCLK    => XGMII_RXCLK,
         XGMII_RXD      => XGMII_RXD,
         XGMII_RXC      => XGMII_RXC,

         -- TX
         XGMII_TXCLK    => XGMII_TXCLK,
         XGMII_TXD      => XGMII_TXD,
         XGMII_TXC      => XGMII_TXC,

         -- USER INTERFACE
         -- Network interface 0
         IBUF0_TX_SOF_N       => ibuf0_tx.sof_n,
         IBUF0_TX_SOP_N       => ibuf0_tx.sop_n,
         IBUF0_TX_EOP_N       => ibuf0_tx.eop_n,
         IBUF0_TX_EOF_N       => ibuf0_tx.eof_n,
         IBUF0_TX_SRC_RDY_N   => ibuf0_tx.src_rdy_n,
         IBUF0_TX_DST_RDY_N   => ibuf0_tx.dst_rdy_n,
         IBUF0_TX_DATA        => ibuf0_tx.data,
         IBUF0_TX_REM         => ibuf0_tx.drem,

         -- PACODAG interface
         IBUF0_CTRL_CLK       => ibuf0_pacodag_clk,
         IBUF0_CTRL_DATA      => ibuf0_pacodag_data,
         IBUF0_CTRL_REM       => ibuf0_pacodag_rem,
         IBUF0_CTRL_SRC_RDY_N => ibuf0_pacodag_src_rdy_n,
         IBUF0_CTRL_SOP_N     => ibuf0_pacodag_sop_n,
         IBUF0_CTRL_EOP_N     => ibuf0_pacodag_eop_n,
         IBUF0_CTRL_DST_RDY_N => ibuf0_pacodag_dst_rdy_n,
         IBUF0_CTRL_RDY       => ibuf0_pacodag_rdy,

         -- IBUF status interface
         IBUF0_SOP            => ibuf0_pacodag_sop,
         IBUF0_PAYLOAD_LEN    => ibuf0_pacodag_stat.payload_len,
         IBUF0_FRAME_ERROR    => ibuf0_pacodag_stat.frame_error,
         IBUF0_CRC_CHECK_FAILED=>ibuf0_pacodag_stat.crc_check_failed,
         IBUF0_MAC_CHECK_FAILED=>ibuf0_pacodag_stat.mac_check_failed,
         IBUF0_LEN_BELOW_MIN  => ibuf0_pacodag_stat.len_below_min,
         IBUF0_LEN_OVER_MTU   => ibuf0_pacodag_stat.len_over_mtu,
         IBUF0_STAT_DV        => ibuf0_pacodag_stat_dv,
         IBUF0_FRAME_RECEIVED    => open,
         IBUF0_FRAME_DISCARDED   => open,
         IBUF0_BUFFER_OVF        => open,

         -- Sampling unit interface
         IBUF0_SAU_ACCEPT     => ibuf0_sau_accept,
         IBUF0_SAU_DV         => ibuf0_sau_dv,
         
         -- Output buffer interface
         OBUF0_RX_SOF_N       => obuf0_rx.sof_n,
         OBUF0_RX_SOP_N       => obuf0_rx.sop_n,
         OBUF0_RX_EOP_N       => obuf0_rx.eop_n,
         OBUF0_RX_EOF_N       => obuf0_rx.eof_n,
         OBUF0_RX_SRC_RDY_N   => obuf0_rx.src_rdy_n,
         OBUF0_RX_DST_RDY_N   => obuf0_rx.dst_rdy_n,
         OBUF0_RX_DATA        => obuf0_rx.data,
         OBUF0_RX_REM         => obuf0_rx.drem,
         
         -- Network interface 1 --------------------------------------------------
         IBUF1_TX_SOF_N       => ibuf1_tx.sof_n,
         IBUF1_TX_SOP_N       => ibuf1_tx.sop_n,
         IBUF1_TX_EOP_N       => ibuf1_tx.eop_n,
         IBUF1_TX_EOF_N       => ibuf1_tx.eof_n,
         IBUF1_TX_SRC_RDY_N   => ibuf1_tx.src_rdy_n,
         IBUF1_TX_DST_RDY_N   => ibuf1_tx.dst_rdy_n,
         IBUF1_TX_DATA        => ibuf1_tx.data,
         IBUF1_TX_REM         => ibuf1_tx.drem,

         -- PACODAG interface
         IBUF1_CTRL_CLK       => ibuf1_pacodag_clk,
         IBUF1_CTRL_DATA      => ibuf1_pacodag_data,
         IBUF1_CTRL_REM       => ibuf1_pacodag_rem,
         IBUF1_CTRL_SRC_RDY_N => ibuf1_pacodag_src_rdy_n,
         IBUF1_CTRL_SOP_N     => ibuf1_pacodag_sop_n,
         IBUF1_CTRL_EOP_N     => ibuf1_pacodag_eop_n,
         IBUF1_CTRL_DST_RDY_N => ibuf1_pacodag_dst_rdy_n,
         IBUF1_CTRL_RDY       => ibuf1_pacodag_rdy,

         -- IBUF status interface
         IBUF1_SOP            => ibuf1_pacodag_sop,
         IBUF1_PAYLOAD_LEN    => ibuf1_pacodag_stat.payload_len,
         IBUF1_FRAME_ERROR    => ibuf1_pacodag_stat.frame_error,
         IBUF1_CRC_CHECK_FAILED=>ibuf1_pacodag_stat.crc_check_failed,
         IBUF1_MAC_CHECK_FAILED=>ibuf1_pacodag_stat.mac_check_failed,
         IBUF1_LEN_BELOW_MIN  => ibuf1_pacodag_stat.len_below_min,
         IBUF1_LEN_OVER_MTU   => ibuf1_pacodag_stat.len_over_mtu,
         IBUF1_STAT_DV        => ibuf1_pacodag_stat_dv,
         IBUF1_FRAME_RECEIVED    => open,
         IBUF1_FRAME_DISCARDED   => open,
         IBUF1_BUFFER_OVF        => open,

         -- Sampling unit interface
         IBUF1_SAU_ACCEPT     => ibuf1_sau_accept,
         IBUF1_SAU_DV         => ibuf1_sau_dv,

         -- Output buffer interface
         OBUF1_RX_SOF_N       => obuf1_rx.sof_n,
         OBUF1_RX_SOP_N       => obuf1_rx.sop_n,
         OBUF1_RX_EOP_N       => obuf1_rx.eop_n,
         OBUF1_RX_EOF_N       => obuf1_rx.eof_n,
         OBUF1_RX_SRC_RDY_N   => obuf1_rx.src_rdy_n,
         OBUF1_RX_DST_RDY_N   => obuf1_rx.dst_rdy_n,
         OBUF1_RX_DATA        => obuf1_rx.data,
         OBUF1_RX_REM         => obuf1_rx.drem,

         -- Led interface
         IBUF_LED             => IBUF_LED,
         OBUF_LED             => OBUF_LED,

         -- Link presence interface
         LINK0         => link0,
         LINK1         => link1,

         -- MI32 interface
         MI32_DWR             => MI32_NET_DWR,
         MI32_ADDR            => MI32_NET_ADDR,
         MI32_RD              => MI32_NET_RD,
         MI32_WR              => MI32_NET_WR,
         MI32_BE              => MI32_NET_BE,
         MI32_DRD             => mi32_net_drd_aux,
         MI32_ARDY            => mi32_net_ardy_aux,
         MI32_DRDY            => mi32_net_drdy_aux
      );
   
   MI32_NET_DRD  <= mi32_net_drd_aux;
   MI32_NET_ARDY <= mi32_net_ardy_aux;
   MI32_NET_DRDY <= mi32_net_drdy_aux;
   
 
   -- -------------------------------------------------------------------------
   --                              DMA engine
   -- -------------------------------------------------------------------------
      DMA_MOD_I : DMA_MOD_64B_8RX2TX_GEN
      port map(
         -- Common interface
         CLK            => CLK_ICS,
         RESET          => RESET_ICS,

         RX_INTERRUPT   => rx_interrupt,
         TX_INTERRUPT   => tx_interrupt,
         -- network interfaces interface
         -- input interface
         RX_SOF_N       => swbuf_rx.sof_n,
         RX_SOP_N       => swbuf_rx.sop_n,
         RX_EOP_N       => swbuf_rx.eop_n,
         RX_EOF_N       => swbuf_rx.eof_n,
         RX_SRC_RDY_N   => swbuf_rx.src_rdy_n,
         RX_DST_RDY_N   => swbuf_rx_dst_rdy_n,
         RX_DATA        => swbuf_rx.data,
         RX_DREM        => swbuf_rx.drem,

         RX_CHANNEL      => swbuf_rx_channel,

         -- output interfaces
         TX0_SOF_N       => swbuf0_tx.sof_n,
         TX0_SOP_N       => swbuf0_tx.sop_n,
         TX0_EOP_N       => swbuf0_tx.eop_n,
         TX0_EOF_N       => swbuf0_tx.eof_n,
         TX0_SRC_RDY_N   => swbuf0_tx.src_rdy_n,
         TX0_DST_RDY_N   => swbuf0_tx.dst_rdy_n,
         TX0_DATA        => swbuf0_tx.data,
         TX0_DREM        => swbuf0_tx.drem,

         TX1_SOF_N       => swbuf1_tx.sof_n,
         TX1_SOP_N       => swbuf1_tx.sop_n,
         TX1_EOP_N       => swbuf1_tx.eop_n,
         TX1_EOF_N       => swbuf1_tx.eof_n,
         TX1_SRC_RDY_N   => swbuf1_tx.src_rdy_n,
         TX1_DST_RDY_N   => swbuf1_tx.dst_rdy_n,
         TX1_DATA        => swbuf1_tx.data,
         TX1_DREM        => swbuf1_tx.drem,

         -- Internal Bus
         IB_DOWN_DATA      => ibus_down_data,
         IB_DOWN_SOF_N     => ibus_down_sof_n,
         IB_DOWN_EOF_N     => ibus_down_eof_n,
         IB_DOWN_SRC_RDY_N => ibus_down_src_rdy_n,
         IB_DOWN_DST_RDY_N => ibus_down_dst_rdy_n,
         IB_UP_DATA        => ibus_up_data,
         IB_UP_SOF_N       => ibus_up_sof_n,
         IB_UP_EOF_N       => ibus_up_eof_n,
         IB_UP_SRC_RDY_N   => ibus_up_src_rdy_n,
         IB_UP_DST_RDY_N   => ibus_up_dst_rdy_n,

         -- MI32 interface
         MI32_DWR          => MI32_DMA_DWR,
         MI32_ADDR         => MI32_DMA_ADDR,
         MI32_RD           => MI32_DMA_RD,
         MI32_WR           => MI32_DMA_WR,
         MI32_BE           => MI32_DMA_BE,
         MI32_DRD          => mi32_dma_drd_aux,
         MI32_ARDY         => mi32_dma_ardy_aux,
         MI32_DRDY         => mi32_dma_drdy_aux
      );
   
   MI32_DMA_DRD  <= mi32_dma_drd_aux;
   MI32_DMA_ARDY <= mi32_dma_ardy_aux;
   MI32_DMA_DRDY <= mi32_dma_drdy_aux;
   
   -- -------------------------------------------------------------------------
   --                            INTERNAL BUS SWITCH
   -- -------------------------------------------------------------------------
   ib_switch_i : GICS_IB_SWITCH_SLAVE_SYNTH
      port map(
         CLK                  => CLK_ICS,
         RESET                => RESET_ICS,

         PORT0_UP_DATA        => IB_UP_DATA,
         PORT0_UP_SOF_N       => IB_UP_SOF_N,
         PORT0_UP_EOF_N       => IB_UP_EOF_N,
         PORT0_UP_SRC_RDY_N   => IB_UP_SRC_RDY_N,
         PORT0_UP_DST_RDY_N   => IB_UP_DST_RDY_N,
         PORT0_DOWN_DATA      => IB_DOWN_DATA,
         PORT0_DOWN_SOF_N     => IB_DOWN_SOF_N,
         PORT0_DOWN_EOF_N     => IB_DOWN_EOF_N,
         PORT0_DOWN_SRC_RDY_N => IB_DOWN_SRC_RDY_N,
         PORT0_DOWN_DST_RDY_N => IB_DOWN_DST_RDY_N,

         PORT1_UP_DATA        => ibus_up_data,
         PORT1_UP_SOF_N       => ibus_up_sof_n,
         PORT1_UP_EOF_N       => ibus_up_eof_n,
         PORT1_UP_SRC_RDY_N   => ibus_up_src_rdy_n,
         PORT1_UP_DST_RDY_N   => ibus_up_dst_rdy_n,
         PORT1_DOWN_DATA      => ibus_down_data,
         PORT1_DOWN_SOF_N     => ibus_down_sof_n,
         PORT1_DOWN_EOF_N     => ibus_down_eof_n,
         PORT1_DOWN_SRC_RDY_N => ibus_down_src_rdy_n,
         PORT1_DOWN_DST_RDY_N => ibus_down_dst_rdy_n,

         PORT2_UP_DATA        => app_ib_up_data,
         PORT2_UP_SOF_N       => app_ib_up_sof_n,
         PORT2_UP_EOF_N       => app_ib_up_eof_n,
         PORT2_UP_SRC_RDY_N   => app_ib_up_src_rdy_n,
         PORT2_UP_DST_RDY_N   => app_ib_up_dst_rdy_n,
         PORT2_DOWN_DATA      => app_ib_down_data,
         PORT2_DOWN_SOF_N     => app_ib_down_sof_n,
         PORT2_DOWN_EOF_N     => app_ib_down_eof_n,
         PORT2_DOWN_SRC_RDY_N => app_ib_down_src_rdy_n,
         PORT2_DOWN_DST_RDY_N => app_ib_down_dst_rdy_n
      );
   
   -- -------------------------------------------------------------------------
   -- Interrupt signal handling
   -- No need to reset, because interrupts are ignored for a few cycles
   -- in ID module
   process(CLK_ICS)
   begin
      if CLK_ICS'event and CLK_ICS = '1' then
         reg_rx_interrupt <= rx_interrupt;
         reg_tx_interrupt <= tx_interrupt;

         reg_sysmon_alarm <= SYSMON_ALARM;
         reg_sysmon_alarm_pulse <= sysmon_alarm_pulse;

         regasync_link0 <= link0;
         regasync_link1 <= link1;
         reg_link0 <= regasync_link0;
         reg_link1 <= regasync_link1;
         reg_link_change <= link0_change or link1_change;
      end if;
   end process;

   -- Detect rising edge
   sysmon_alarm_pulse <= '1' when (reg_sysmon_alarm='0' and SYSMON_ALARM='1')
                    else '0';

   -- Detect change
   link0_change <= reg_link0 xor regasync_link0;
   link1_change <= reg_link1 xor regasync_link1;

   interrupts <= X"0000000" & 
                 reg_link_change &
                 reg_sysmon_alarm_pulse &
                 reg_tx_interrupt & reg_rx_interrupt ;


   INTERRUPT <= interrupts;
   -- INTR_RDY open -- TODO: deal with INTR_RDY=0, because otherwise
   -- an interrupt may be lost


-- ------------------------------------------------------------------------
-- These signals are unused in NIC, but may be used in other projects
-- ------------------------------------------------------------------------
   -- Clocks
   MCLK0_IBUFDS : IBUFDS
   port map(
      I  => MCLK0_P,
      IB => MCLK0_N,
      O  => open
   );
   MCLK1_IBUFDS : IBUFDS
   port map(
      I  => MCLK1_P,
      IB => MCLK1_N,
      O  => open
   );
   GCLK250_IBUFDS : IBUFDS
   port map(
      I  => GCLK250_P,
      IB => GCLK250_N,
      O  => open
   );
   GCLK100_IBUFDS : IBUFDS
   port map(
      I  => GCLK100_P,
      IB => GCLK100_N,
      O  => open
   );
   XCLK1_IBUFDS : IBUFDS
   port map(
      I  => XCLK1_P,
      IB => XCLK1_N,
      O  => open
   );
   XCLK0_IBUFDS : IBUFDS
   port map(
      I  => XCLK0_P,
      IB => XCLK0_N,
      O  => open
   );

   -- SRAM (no errors reported)

   -- DRAM
   DSCL_OBUF : OBUF
   port map(
      O  => DSCL,
      I  => reset_ics
   );
   DWE_N_OBUF : OBUF
   port map(
      O  => DWE_N,
      I  => reset_ics
   );
   DCAS_N_OBUF : OBUF
   port map(
      O  => DCAS_N,
      I  => reset_ics
   );
   DRAS_N_OBUF : OBUF
   port map(
      O  => DRAS_N,
      I  => reset_ics
   );
   DCK0_P_OBUF : OBUF
   port map(
      O  => DCK0_P,
      I  => reset_ics
   );
   DCK0_N_OBUF : OBUF
   port map(
      O  => DCK0_N,
      I  => reset_ics
   );
   DCK1_P_OBUF : OBUF
   port map(
      O  => DCK1_P,
      I  => reset_ics
   );
   DCK1_N_OBUF : OBUF
   port map(
      O  => DCK1_N,
      I  => reset_ics
   );
   DA_OBUF_GEN: for i in 0 to 13 generate
      DA_OBUF : OBUF
      port map(
         O  => DA(i),
         I  => reset_ics
      );
   end generate;
   DDM_OBUF_GEN: for i in 0 to 7 generate
      DDM_OBUF : OBUF
      port map(
         O  => DDM(i),
         I  => reset_ics
      );
   end generate;
   DBA_OBUF_GEN: for i in 0 to 2 generate
      DBA_OBUF : OBUF
      port map(
         O  => DBA(i),
         I  => reset_ics
      );
   end generate;
   DSA_OBUF_GEN: for i in 0 to 1 generate
      DSA_OBUF : OBUF
      port map(
         O  => DSA(i),
         I  => reset_ics
      );
   end generate;
   DDODT_OBUF_GEN: for i in 0 to 1 generate
      DDODT_OBUF : OBUF
      port map(
         O  => DDODT(i),
         I  => reset_ics
      );
   end generate;
   DCS_N_OBUF_GEN: for i in 0 to 1 generate
      DCS_N_OBUF : OBUF
      port map(
         O  => DCS_N(i),
         I  => reset_ics
      );
   end generate;
   DCKE_OBUF_GEN: for i in 0 to 1 generate
      DCKE_OBUF : OBUF
      port map(
         O  => DCKE(i),
         I  => reset_ics
      );
   end generate;

   -- Misc
   FQTXD_OBUF : OBUF
   port map(
      O  => FQTXD,
      I  => reset_ics
   );
   FQLED_OBUF_GEN: for i in 0 to 3 generate
      FQLED_OBUF : OBUF
      port map(
         O  => FQLED(i),
         I  => reset_ics
      );
   end generate;



end architecture full;

