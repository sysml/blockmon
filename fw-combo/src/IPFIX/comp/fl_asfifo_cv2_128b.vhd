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

-- fl_asfifo_cv2_128b.vhd : Async FL_FIFO composed of one virtex5 built-in FIFO
-- Copyright (C) 2009 CESNET
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
-- $Id: fl_asfifo_cv2_128b.vhd 14706 2010-07-28 06:21:36Z polcak_l $
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
library unisim;
use unisim.vcomponents.all;

-- ----------------------------------------------------------------------------
--                              Entity declaration
-- ----------------------------------------------------------------------------
entity FL_ASFIFO_CV2_128B is
   port(
      RX_CLK         : in  std_logic;
      TX_CLK         : in  std_logic;
      RX_RESET       : in  std_logic;
      TX_RESET       : in  std_logic;

      RX_DATA        : in  std_logic_vector(127 downto 0);
      RX_REM         : in  std_logic_vector(3 downto 0);
      RX_SOP_N       : in  std_logic;
      RX_EOP_N       : in  std_logic;
      RX_SOF_N       : in  std_logic;
      RX_EOF_N       : in  std_logic;
      RX_SRC_RDY_N   : in  std_logic;
      RX_DST_RDY_N   : out std_logic;

      TX_DATA        : out std_logic_vector(127 downto 0);
      TX_REM         : out std_logic_vector(3 downto 0);
      TX_SOP_N       : out std_logic;
      TX_EOP_N       : out std_logic;
      TX_SOF_N       : out std_logic;
      TX_EOF_N       : out std_logic;
      TX_SRC_RDY_N   : out std_logic;
      TX_DST_RDY_N   : in  std_logic
   );
end FL_ASFIFO_CV2_128B;
-- ----------------------------------------------------------------------------
--                              Architecture declaration
-- ----------------------------------------------------------------------------
architecture full of fl_asfifo_cv2_128b is

signal par0_in     : std_logic_vector(7 downto 0);
signal par0_out    : std_logic_vector(7 downto 0);
signal par1_in     : std_logic_vector(7 downto 0);
signal par1_out    : std_logic_vector(7 downto 0);

signal reset_both : std_logic;

signal sig_empty  : std_logic;
signal sig_full   : std_logic;
signal sig_empty0 : std_logic;
signal sig_full0  : std_logic;
signal sig_empty1 : std_logic;
signal sig_full1  : std_logic;
signal sig_rden   : std_logic;
signal sig_wren   : std_logic;

begin

   sig_full <= sig_full0 or sig_full1;
   sig_empty <= sig_empty0 or sig_empty1;

   reset_both <= RX_RESET or TX_RESET;

   par0_in  <= RX_SOP_N & RX_EOP_N & RX_SOF_N & RX_EOF_N & RX_REM;
   par1_in  <= X"00";
   RX_DST_RDY_N <= sig_full;
   sig_wren <= (not RX_SRC_RDY_N) and (not sig_full);

   FIFO36_72_inst0 : FIFO36_72
   generic map (
      ALMOST_FULL_OFFSET => X"0080",  -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DO_REG => 1,                    -- Enable output register (0 or 1)
                                      -- Must be 1 if EN_SYN = FALSE 
      EN_ECC_READ => FALSE,           -- Enable ECC decoder, TRUE or FALSE
      EN_ECC_WRITE => FALSE,          -- Enable ECC encoder, TRUE or FALSE
      EN_SYN => FALSE,                -- Specifies FIFO as Asynchronous (FALSE)
                                      -- or Synchronous (TRUE)
      FIRST_WORD_FALL_THROUGH => TRUE,-- Sets the FIFO FWFT to TRUE or FALSE
      SIM_MODE => "SAFE") -- Simulation: "SAFE" vs "FAST", see "Synthesis and Simulation
                          -- Design Guide" for details
   port map (
      ALMOSTEMPTY => open,          -- 1-bit almost empty output flag
      ALMOSTFULL => open,           -- 1-bit almost full output flag
      DBITERR => open,              -- 1-bit double bit error status output
      DO => TX_DATA(63 downto 0),   -- 64-bit data output
      DOP => par0_out,              -- 4-bit parity data output
      ECCPARITY => open,            -- 8-bit generated error correction parity
      EMPTY => sig_empty0,          -- 1-bit empty output flag
      FULL => sig_full0,             -- 1-bit full output flag
      RDCOUNT => open,              -- 9-bit read count output
      RDERR => open,                -- 1-bit read error output
      WRCOUNT => open,              -- 9-bit write count output
      WRERR => open,                -- 1-bit write error
      DI => RX_DATA(63 downto 0),   -- 64-bit data input
      DIP => par0_in,               -- 4-bit parity input
      RDCLK => TX_CLK,              -- 1-bit read clock input
      RDEN => sig_rden,             -- 1-bit read enable input
      RST => reset_both,            -- 1-bit reset input
      WRCLK => RX_CLK,              -- 1-bit write clock input
      WREN => sig_wren              -- 1-bit write enable input
   );

   FIFO36_72_inst1 : FIFO36_72
   generic map (
      ALMOST_FULL_OFFSET => X"0080",  -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET => X"0080", -- Sets the almost empty threshold
      DO_REG => 1,                    -- Enable output register (0 or 1)
                                      -- Must be 1 if EN_SYN = FALSE 
      EN_ECC_READ => FALSE,           -- Enable ECC decoder, TRUE or FALSE
      EN_ECC_WRITE => FALSE,          -- Enable ECC encoder, TRUE or FALSE
      EN_SYN => FALSE,                -- Specifies FIFO as Asynchronous (FALSE)
                                      -- or Synchronous (TRUE)
      FIRST_WORD_FALL_THROUGH => TRUE,-- Sets the FIFO FWFT to TRUE or FALSE
      SIM_MODE => "SAFE") -- Simulation: "SAFE" vs "FAST", see "Synthesis and Simulation
                          -- Design Guide" for details
   port map (
      ALMOSTEMPTY => open,          -- 1-bit almost empty output flag
      ALMOSTFULL => open,           -- 1-bit almost full output flag
      DBITERR => open,              -- 1-bit double bit error status output
      DO => TX_DATA(127 downto 64), -- 64-bit data output
      DOP => par1_out,              -- 4-bit parity data output
      ECCPARITY => open,            -- 8-bit generated error correction parity
      EMPTY => sig_empty1,                -- 1-bit empty output flag
      FULL => sig_full1,                 -- 1-bit full output flag
      RDCOUNT => open,              -- 9-bit read count output
      RDERR => open,                -- 1-bit read error output
      WRCOUNT => open,              -- 9-bit write count output
      WRERR => open,                -- 1-bit write error
      DI => RX_DATA(127 downto 64), -- 64-bit data input
      DIP => par1_in,               -- 4-bit parity input
      RDCLK => TX_CLK,              -- 1-bit read clock input
      RDEN => sig_rden,             -- 1-bit read enable input
      RST => reset_both,            -- 1-bit reset input
      WRCLK => RX_CLK,              -- 1-bit write clock input
      WREN => sig_wren              -- 1-bit write enable input
   );

   TX_REM      <= par0_out(3 downto 0);
   TX_EOF_N    <= par0_out(4);
   TX_SOF_N    <= par0_out(5);
   TX_EOP_N    <= par0_out(6);
   TX_SOP_N    <= par0_out(7);
   TX_SRC_RDY_N <= sig_empty;
   sig_rden    <= (not TX_DST_RDY_N) and (not sig_empty);

end architecture full;
