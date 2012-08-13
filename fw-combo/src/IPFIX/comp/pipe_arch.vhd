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
-- pipe_arch.vhd : Internal Bus Pipeline
-- Copyright (C) 2008 CESNET
-- Author(s): Tomas Malek <tomalek@liberouter.org>
--            Vaclav Bartos <xbarto11@stud.fit.vutbr.cz>
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
-- $Id: pipe_arch.vhd 14522 2010-07-20 13:54:06Z xkosar02 $
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
--             ARCHITECTURE DECLARATION  --  Internal Bus Pipeline           --
-- ----------------------------------------------------------------------------

architecture pipe_arch of PIPE is

   -- -------------------------------------------------------------------------
   --                           Signal declaration                           --
   -- -------------------------------------------------------------------------

   type   fsm_states is (S_0, S_1, S_2, S_RESET);
   signal present_state, next_state : fsm_states; 
   
   signal ce,addr        : std_logic;
   signal dout           : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal reg_dout       : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal dout_rdy       : std_logic;
   signal reg_dout_rdy   : std_logic;
   signal outreg_we      : std_logic;

   
begin
   
NOT_FAKE: if (FAKE_PIPE = false) generate
   
   -- -------------------------------------------------------------------------
   --                               DATA PATH                                --
   -- -------------------------------------------------------------------------
   
   SH_REG_DATA_WIDTH : for i in 0 to DATA_WIDTH-1 generate
   begin
      SH_REG_DATA : entity work.SH_REG_ELEM
      port map(
         CLK     => CLK,
         CE      => ce,
         ADDR(0) => addr,
         ADDR(3 downto 1) => "000",

         DIN     => IN_DATA(i),
         DOUT    => dout(i)
      );
   end generate;
   
   
   -- without output registers
   OUTREG_NO : if (USE_OUTREG = false) generate
      
      outreg_we   <= OUT_DST_RDY;
      
      OUT_DATA    <= dout;
      OUT_SRC_RDY <= dout_rdy;
      
   end generate;
   
   
   -- with output registers
   OUTREG_YES : if (USE_OUTREG = true) generate
      
      reg_doutp: process(CLK)
      begin
         if (CLK'event and CLK = '1') then
            if (outreg_we = '1') then
               reg_dout <= dout;
            end if;
         end if;
      end process;
      
      reg_dout_rdyp: process(CLK)
      begin
         if (CLK'event and CLK = '1') then
            if (RESET = '1') then
               reg_dout_rdy <= '0';
            elsif (outreg_we = '1') then
               reg_dout_rdy <= dout_rdy;
            end if;
         end if;
      end process;
      
      outreg_we <= OUT_DST_RDY or not reg_dout_rdy;
      
      OUT_DATA    <= reg_dout;
      OUT_SRC_RDY <= reg_dout_rdy;
      
   end generate;
   
   
   -- -------------------------------------------------------------------------
   --                              CONTROL FSM                               --
   -- -------------------------------------------------------------------------
   
   -- synchronize logic -------------------------------------------------------
   synchlogp : process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if (RESET = '1') then
            present_state <= S_RESET;
         else
            present_state <= next_state;
         end if;
      end if;
   end process;

   -- next state logic --------------------------------------------------------
   nextstatelogicp : process(present_state,IN_SRC_RDY,outreg_we)
   begin
      next_state <= present_state;

      case (present_state) is

         when  S_0 =>
            if (IN_SRC_RDY = '1') then
               next_state <= S_1;
            end if;
         
         when  S_1 =>
            if (IN_SRC_RDY = '1') and (outreg_we = '0') then
               next_state <= S_2;
            elsif (outreg_we = '1') and (IN_SRC_RDY = '0') then
               next_state <= S_0;
            end if;
         
         when  S_2 =>
            if (outreg_we = '1') then
               next_state <= S_1;
            end if;

         when S_RESET =>
            next_state <= S_0;

      end case;
   end process;

   -- output logic ------------------------------------------------------------
   outputlogicp : process(present_state,IN_SRC_RDY)
   begin

      case (present_state) is

         when  S_0 =>
            ce          <= IN_SRC_RDY;
            addr        <= '0';
            dout_rdy    <= '0';
            IN_DST_RDY  <= '1';

         when  S_1 =>
            ce          <= IN_SRC_RDY;
            addr        <= '0';
            dout_rdy    <= '1';
            IN_DST_RDY  <= '1';

         when  S_2 =>
            ce          <= '0';
            addr        <= '1';
            dout_rdy    <= '1';
            IN_DST_RDY  <= '0';

         when  S_RESET =>
            ce          <= '0';
            addr        <= 'X';
            dout_rdy    <= '0';
            IN_DST_RDY  <= '0';

      end case;
   end process;

end generate;

FAKE: if (FAKE_PIPE = true) generate
   OUT_DATA    <= IN_DATA;
   OUT_SRC_RDY <= IN_SRC_RDY;
   IN_DST_RDY  <= OUT_DST_RDY;
end generate;

end pipe_arch;


