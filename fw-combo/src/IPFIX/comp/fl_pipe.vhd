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

--
-- pipe.vhd: FrameLink Pipeline
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
-- $Id: pipe.vhd 4097 2008-07-29 07:59:45Z xvozen00 $
--
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

use work.math_pack.all;

-- ----------------------------------------------------------------------------
--                               ENTITY DECLARATION 
-- ---------------------------------------------------------------------------- 

entity FL_PIPE is
   generic(
      -- FrameLink Data Width
      DATA_WIDTH     : integer:= 64;
      USE_OUTREG     : boolean:= false
   );   
   port(
      -- Common interface 
      CLK            : in std_logic;
      RESET          : in std_logic;
      
      -- Input interface
      RX_SOF_N       : in  std_logic;
      RX_SOP_N       : in  std_logic;
      RX_EOP_N       : in  std_logic;
      RX_EOF_N       : in  std_logic;
      RX_SRC_RDY_N   : in  std_logic;
      RX_DST_RDY_N   : out std_logic;
      RX_DATA        : in  std_logic_vector(DATA_WIDTH-1 downto 0);
      RX_REM         : in  std_logic_vector(abs(log2(DATA_WIDTH/8)-1) downto 0);
 
      -- Output interface
      TX_SOF_N       : out std_logic;
      TX_EOP_N       : out std_logic;
      TX_SOP_N       : out std_logic;
      TX_EOF_N       : out std_logic;
      TX_SRC_RDY_N   : out std_logic;
      TX_DST_RDY_N   : in  std_logic;
      TX_DATA        : out std_logic_vector(DATA_WIDTH-1 downto 0);
      TX_REM         : out std_logic_vector(abs(log2(DATA_WIDTH/8)-1) downto 0)
   );
end entity FL_PIPE;

-- ----------------------------------------------------------------------------
--                            ARCHITECTURE DECLARATION 
-- ----------------------------------------------------------------------------
architecture fl_pipe_arch of FL_PIPE is

   -- function added by xvozen00 (with change on lines 75 - added 'abs')
   -- to replace log2(DATA_WIDTH/8) and handle DATA_WIDTH = 8
   function REM_WIDTH
      return integer is
   begin
      if ((DATA_WIDTH/8) <= 1) then return 2;
      else return log2(DATA_WIDTH/8);
      end if;
   end function;

   constant PIPE_WIDTH        : integer := DATA_WIDTH+REM_WIDTH+4;

   signal pipe_in_data        : std_logic_vector(PIPE_WIDTH-1 downto 0);
   signal pipe_in_src_rdy     : std_logic;
   signal pipe_in_dst_rdy     : std_logic;

   signal pipe_out_data       : std_logic_vector(PIPE_WIDTH-1 downto 0);
   signal pipe_out_src_rdy    : std_logic;
   signal pipe_out_dst_rdy    : std_logic;
   
begin
   pipe_in_data      <= RX_SOF_N & RX_SOP_N & RX_EOP_N & RX_EOF_N & RX_REM & RX_DATA;
   pipe_in_src_rdy   <= not RX_SRC_RDY_N;
   RX_DST_RDY_N      <= not pipe_in_dst_rdy;

   TX_SOF_N          <= pipe_out_data(DATA_WIDTH+REM_WIDTH+3);
   TX_SOP_N          <= pipe_out_data(DATA_WIDTH+REM_WIDTH+2);
   TX_EOP_N          <= pipe_out_data(DATA_WIDTH+REM_WIDTH+1);
   TX_EOF_N          <= pipe_out_data(DATA_WIDTH+REM_WIDTH+0);
   TX_DATA           <= pipe_out_data(DATA_WIDTH-1 downto 0);
   TX_REM            <= pipe_out_data(DATA_WIDTH+REM_WIDTH-1 
                        downto DATA_WIDTH);
   TX_SRC_RDY_N      <= not pipe_out_src_rdy;
   pipe_out_dst_rdy  <= not TX_DST_RDY_N;

   -- -------------------------------------------------------------------------
   --                                  PIPE                                  --
   -- -------------------------------------------------------------------------
   PIPE : entity work.PIPE
   generic map(
      DATA_WIDTH  => PIPE_WIDTH,
      USE_OUTREG  => USE_OUTREG
   )
   port map(
      CLK         => CLK,
      RESET       => RESET,
      
      IN_DATA      => pipe_in_data,
      IN_SRC_RDY   => pipe_in_src_rdy,
      IN_DST_RDY   => pipe_in_dst_rdy,

      OUT_DATA     => pipe_out_data,
      OUT_SRC_RDY  => pipe_out_src_rdy,
      OUT_DST_RDY  => pipe_out_dst_rdy
   );
   
end fl_pipe_arch;

