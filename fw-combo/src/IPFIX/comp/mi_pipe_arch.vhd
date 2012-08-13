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

-- mi_pipe_arch.vhd: MI Pipe - wrapper to generic pipe
-- Copyright (C) 2010 CESNET
-- Author(s): Vaclav Bartos <washek@liberouter.org>
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
-- $Id: mi_pipe_arch.vhd 14019 2010-06-11 12:51:48Z washek $
--
-- TODO:
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

-- ----------------------------------------------------------------------------
--                          ARCHITECTURE DECLARATION                         --
-- ---------------------------------------------------------------------------- 

architecture mi_pipe_arch of MI_PIPE is

   signal in_data  : std_logic_vector(DATA_WIDTH + ADDR_WIDTH + DATA_WIDTH/8 + 1 downto 0);
   signal out_data : std_logic_vector(DATA_WIDTH + ADDR_WIDTH + DATA_WIDTH/8 + 1 downto 0);
   
   signal in_req      : std_logic;
   signal in_dst_rdy  : std_logic;
   signal out_src_rdy : std_logic;
   signal out_dst_rdy : std_logic;
   
   signal OUT_RD_aux  : std_logic;
   signal OUT_WR_aux  : std_logic;
   
begin
   
   in_data <= IN_WR & IN_RD & IN_BE & IN_ADDR & IN_DWR;
   
   OUT_DWR    <= out_data(DATA_WIDTH-1 downto 0); 
   OUT_ADDR   <= out_data(DATA_WIDTH+ADDR_WIDTH-1 downto DATA_WIDTH);
   OUT_BE     <= out_data(DATA_WIDTH+ADDR_WIDTH+DATA_WIDTH/8-1 downto DATA_WIDTH+ADDR_WIDTH);
   OUT_RD_aux <= out_data(DATA_WIDTH+ADDR_WIDTH+DATA_WIDTH/8)   and out_src_rdy;
   OUT_WR_aux <= out_data(DATA_WIDTH+ADDR_WIDTH+DATA_WIDTH/8+1) and out_src_rdy;
   
   OUT_RD <= OUT_RD_aux;
   OUT_WR <= OUT_WR_aux;
   
   in_req      <= IN_RD or IN_WR;
   out_dst_rdy <= ((not (OUT_RD_aux or OUT_WR_aux)) or OUT_ARDY); 
   
   PIPE: entity work.PIPE
   generic map(
      DATA_WIDTH  => DATA_WIDTH + ADDR_WIDTH + DATA_WIDTH/8 + 2,
      USE_OUTREG  => USE_OUTREG,
      FAKE_PIPE   => FAKE_PIPE
   )
   port map(
      CLK         => CLK,
      RESET       => RESET,
      
      IN_DATA     => in_data,
      IN_SRC_RDY  => in_req,
      IN_DST_RDY  => in_dst_rdy,
      
      OUT_DATA    => out_data,
      OUT_SRC_RDY => out_src_rdy,
      OUT_DST_RDY => out_dst_rdy
   );

   IN_ARDY <= in_dst_rdy and in_req;
   
   NOT_FAKE: if (FAKE_PIPE = false) generate
      in_drdp: process(CLK)
      begin
         if (CLK'event and CLK = '1') then
            IN_DRD <= OUT_DRD;
         end if;
      end process;
   
      in_drdyp: process(RESET, CLK)
      begin
         if (CLK'event and CLK = '1') then
            if (RESET = '1') then
               IN_DRDY <= '0';
            else
               IN_DRDY <= OUT_DRDY;
            end if;
         end if;
      end process;
   end generate;
   
   FAKE: if (FAKE_PIPE = true) generate
      IN_DRD  <= OUT_DRD;
      IN_DRDY <= OUT_DRDY;
   end generate;
   
end mi_pipe_arch;
