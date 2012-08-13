-- -----------------------------------------------------------------------
--
--   Company: INVEA-TECH a.s.
--
--   Project: IPFIX design
--
-- -----------------------------------------------------------------------
--
--   (c) Copyright 2011 INVEA-TECH a.s.
--   All rights reserved.
--
--   Please review the terms of the license agreement before using this
--   file. If you are not an authorized user, please destroy this
--   source code file and notify INVEA-TECH a.s. immediately that you
--   inadvertently received an unauthorized copy.
--
-- -----------------------------------------------------------------------
--

-- combov2_user_const.vhd: User constants for NetCOPE on ComboV2
-- Copyright (C) 2008 CESNET
-- Author(s): Viktor Pus <pus@liberouter.org>
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

library IEEE;
use IEEE.std_logic_1164.all;

package combov2_user_const is
   -- -------------------------------------------------------------------------
--   constant PCIE_EP_IFC_125   : boolean := true;-- true=125 MHz endpoint, false=250 MHz -- now this is obsolete

   -- -------------------------------------------------------------------------
   -- Clock frequencies setting
   -- -------------------------------------------------------------------------
   constant CLK_MULT          : integer := 9; -- Fvco = 62.5 MHz x CLK_MULT
   constant CLK_ICS_DIV       : integer := 3;   -- CLK_ICS freq. = Fvco / CLK_ICS_DIV
   constant CLK_USER0_DIV     : integer := 5;   -- CLK_USER0 freq. = Fvco / CLK_USER0_DIV
   constant CLK_USER1_DIV     : integer := 5;   -- CLK_USER1 freq. = Fvco / CLK_USER1_DIV
   constant CLK_USER2_DIV     : integer := 5;   -- CLK_USER2 freq. = Fvco / CLK_USER2_DIV
   constant CLK_USER3_DIV     : integer := 5;   -- CLK_USER3 freq. = Fvco / CLK_USER3_DIV
   constant CLK_USER4_DIV     : integer := 5;   -- CLK_USER4 freq. = Fvco / CLK_USER4_DIV

   -- -------------------------------------------------------------------------
   -- Design identification ---------------------------------------------------
   constant ID_PROJECT              : std_logic_vector( 15 downto 0):= X"F101";
   constant ID_SW_MAJOR             : std_logic_vector(  7 downto 0):=   X"03";
   constant ID_SW_MINOR             : std_logic_vector(  7 downto 0):=   X"0C";
   constant ID_HW_MAJOR             : std_logic_vector( 15 downto 0):= X"0007";
   constant ID_HW_MINOR             : std_logic_vector( 15 downto 0):= X"0000";
   -- F l e x i b l e _ F l o w M o n\0
   constant ID_PROJECT_TEXT : std_logic_vector(255 downto 0) :=
      X"466C657869626C655F466C6F774D6F6E00000000000000000000000000000000";

   constant ID_TX_CHANNELS          : std_logic_vector(  7 downto 0):=   X"00";
   constant ID_RX_CHANNELS          : std_logic_vector(  7 downto 0):=   X"08";
   -- -------------------------------------------------------------------------

   -- Network Module setting (constant INBANDFCS) is done in NetCOPE's network module

   -- -------------------------------------------------------------------------
   -- DMA Module setting
   -- straight zero copy DMA - Non-generic version
   -- constant DMA_TYPE          : String := "SZE";
   -- straight zero copy DMA - Generic version
   constant DMA_TYPE          : String := "GEN";
   -- packet DMA through linux kernel stack
   -- constant DMA_TYPE          : String := "PAC";

   -- -------------------------------------------------------------------------
   -- Timestamp unit setting
   -- Set to false if you don't need timestamps
   -- Synchronize your choice with ../top/combov2/Makefile (USE_TIMESTAMP)
   constant TIMESTAMP_UNIT          : boolean := true;
   -- constant TIMESTAMP_UNIT          : boolean := false;

   -- -------------------------------------------------------------------------
   -- Support for JUMBO packets 
   -- (un)comment all three lines together
   -- Synchronize your choice with ../top/combov2/Makefile (JUMBO)
   constant JUMBO		    : boolean := true;
   constant MAX_MTU_RX : std_logic_vector(31 downto 0) := X"00003FE0";
   constant MAX_MTU_TX : std_logic_vector(31 downto 0) := X"00003FE0";

   -- constant JUMBO : boolean := false;
   -- constant MAX_MTU_RX : std_logic_vector(31 downto 0) := X"00000FE0";
   -- constant MAX_MTU_TX : std_logic_vector(31 downto 0) := X"00000FE0";

end combov2_user_const;

package body combov2_user_const is

end combov2_user_const;


