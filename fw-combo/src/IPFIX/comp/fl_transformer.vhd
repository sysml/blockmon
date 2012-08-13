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

-- transformer.vhd: Implementation of FrameLink Transformer component.
-- Copyright (C) 2006 CESNET
-- Author(s): Martin Louda <sandin@liberouter.org>
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
-- $Id: transformer.vhd 14 2007-07-31 06:44:05Z kosek $
--
-- TODO:
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- library containing log2 function
use work.math_pack.all;

-- ------------------------------------------------------------------------
--                      Architecture declaration
-- ------------------------------------------------------------------------
architecture full of FL_TRANSFORMER is

begin

   -- ---------------------------------------------------------------------
   --                   Main logic
   -- ---------------------------------------------------------------------

   -- data widths are equal
   GEN_ARCH_EQUAL:
   if (RX_DATA_WIDTH = TX_DATA_WIDTH) generate
      TX_DATA        <= RX_DATA;
      TX_REM         <= RX_REM;
      TX_SOF_N       <= RX_SOF_N;
      TX_EOF_N       <= RX_EOF_N;
      TX_SOP_N       <= RX_SOP_N;
      TX_EOP_N       <= RX_EOP_N;
      TX_SRC_RDY_N   <= RX_SRC_RDY_N;
      RX_DST_RDY_N   <= TX_DST_RDY_N;
   end generate;

   -- RX data width > TX data width
   GEN_ARCH_DOWN:
   if (RX_DATA_WIDTH > TX_DATA_WIDTH) generate
      FL_TRANSFORMER_DOWN_U: entity work.FL_TRANSFORMER_DOWN
         generic map(
            RX_DATA_WIDTH  => RX_DATA_WIDTH,
            TX_DATA_WIDTH  => TX_DATA_WIDTH
         )
         port map(
            CLK            => CLK,
            RESET          => RESET,
            --
            RX_DATA        => RX_DATA,
            RX_REM         => RX_REM,
            RX_SOF_N       => RX_SOF_N,
            RX_EOF_N       => RX_EOF_N,
            RX_SOP_N       => RX_SOP_N,
            RX_EOP_N       => RX_EOP_N,
            RX_SRC_RDY_N   => RX_SRC_RDY_N,
            RX_DST_RDY_N   => RX_DST_RDY_N,
            --
            TX_DATA        => TX_DATA,
            TX_REM         => TX_REM,
            TX_SOF_N       => TX_SOF_N,
            TX_EOF_N       => TX_EOF_N,
            TX_SOP_N       => TX_SOP_N,
            TX_EOP_N       => TX_EOP_N,
            TX_SRC_RDY_N   => TX_SRC_RDY_N,
            TX_DST_RDY_N   => TX_DST_RDY_N
         );
   end generate;

   -- RX data width < TX data width
   GEN_ARCH_UP:
   if (RX_DATA_WIDTH < TX_DATA_WIDTH) generate
      FL_TRANSFORMER_UP_U: entity work.FL_TRANSFORMER_UP
         generic map(
            RX_DATA_WIDTH  => RX_DATA_WIDTH,
            TX_DATA_WIDTH  => TX_DATA_WIDTH
         )
         port map(
            CLK            => CLK,
            RESET          => RESET,
            --
            RX_DATA        => RX_DATA,
            RX_REM         => RX_REM,
            RX_SOF_N       => RX_SOF_N,
            RX_EOF_N       => RX_EOF_N,
            RX_SOP_N       => RX_SOP_N,
            RX_EOP_N       => RX_EOP_N,
            RX_SRC_RDY_N   => RX_SRC_RDY_N,
            RX_DST_RDY_N   => RX_DST_RDY_N,
            --
            TX_DATA        => TX_DATA,
            TX_REM         => TX_REM,
            TX_SOF_N       => TX_SOF_N,
            TX_EOF_N       => TX_EOF_N,
            TX_SOP_N       => TX_SOP_N,
            TX_EOP_N       => TX_EOP_N,
            TX_SRC_RDY_N   => TX_SRC_RDY_N,
            TX_DST_RDY_N   => TX_DST_RDY_N
         );
   end generate;

end architecture full;
