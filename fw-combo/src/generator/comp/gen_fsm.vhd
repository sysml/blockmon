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

-- gen_fsm.vhd: FSM for generating fl packets
-- Copyright (C) 2009 CESNET
-- Author(s): Petr Kastovsky <kastovsky@liberouter.org>
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
-- $Id: gen_fsm.vhd 12117 2009-11-25 13:35:03Z kastovsky $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.math_pack.all;

-- ----------------------------------------------------------------------------
--                            Entity declaration
-- ----------------------------------------------------------------------------
entity GEN_FSM is
   port(
      -- global signals 
      CLK            : in std_logic;
      RESET          : in std_logic;

      -- input signals
      START          : in  std_logic;  -- start is set
      PACKET_END     : in  std_logic;  -- end of packet
      TRANSMIT_END   : in  std_logic;  -- end of transmission
      DST_RDY        : in  std_logic;  -- desrtination is ready
      
      -- output signals
      SOP            : out std_logic;
      EOP            : out std_logic;
      NEXT_DATA      : out std_logic;  -- get next data
      NEXT_LEN       : out std_logic;  -- get next length
      SRC_RDY        : out std_logic;  -- source is ready
      STOPPED        : out std_logic   -- we are stopped
   );
end entity GEN_FSM;


-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture full of GEN_FSM is

   -- ------------------ Types declaration ------------------------------------
   type t_state is ( S_STP, S_RUN, S_PS, S_PT, S_PE );
      -- S_STP - stopped
      -- S_RUN - running
      -- S_PS  - packet start
      -- S_PT  - packet transmission
      -- S_PE  - packet end
   
   -- ------------------ Signals declaration ----------------------------------
   signal present_state, next_state : t_state;

begin

   -- --------------- Sync logic -------------------------------------------
   sync_logic  : process( CLK )
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            present_state <= S_STP;
         else
            present_state <= next_state;
         end if;
      end if;
   end process sync_logic;

   -- ------------------ Next state logic -------------------------------------
   next_state_logic : process( present_state, START, PACKET_END, TRANSMIT_END,
                                 DST_RDY)
   begin
   case (present_state) is

      -- ---------------------------------------------
      when S_STP =>
         if (START = '1') then
            next_state <= S_RUN;
         else
            next_state <= S_STP;
         end if;

      -- ---------------------------------------------
      when S_RUN =>
         if (DST_RDY = '1') then
            next_state <= S_PS;
         else
            next_state <= S_RUN;
         end if;

      -- ---------------------------------------------
      when S_PS =>
         if (DST_RDY = '1') then
            next_state <= S_PT;
         else
            next_state <= S_PS;
         end if;

      -- ---------------------------------------------
      when S_PT =>
         next_state <= S_PT;
         if (DST_RDY = '1') then 
            if (PACKET_END = '1') then
               if (START = '1') then
                  next_state <= S_PE;
               else
                  next_state <= S_STP;
               end if;
            end if;
            if (TRANSMIT_END = '1') then
               next_state <= S_STP;
            end if;
         end if;

      -- ---------------------------------------------
      when S_PE =>
         if (TRANSMIT_END = '1') then
            next_state <= S_STP;
         else
            if (DST_RDY = '1') then
               next_state <= S_PS;
            else
               next_state <= S_PE;
            end if;
         end if;
       
      -- ---------------------------------------------
      when others =>
         next_state <= S_STP;

      -- ---------------------------------------------
      end case;
   end process next_state_logic;

   -- ------------------ Output logic -----------------------------------------
   output_logic: process( present_state, START, PACKET_END, TRANSMIT_END,
                                 DST_RDY)
   begin
  
      -- ---------------------------------------------
      -- Initial values
      -- no active signals
      -- ---------------------------------------------
      NEXT_DATA      <= '0';
      NEXT_LEN       <= '0';
      SRC_RDY        <= '0';
      STOPPED        <= '0';
      SOP            <= '0';
      EOP            <= '0';

      case (present_state) is

      -- ---------------------------------------------
      when S_STP =>
         if (START = '0') then
            STOPPED   <= '1';
         end if;

      -- ---------------------------------------------
      when S_RUN =>
         SRC_RDY   <= '1';
         if (DST_RDY = '1') then
            NEXT_DATA <= '1';
            SOP <= '1';
         end if;

      -- ---------------------------------------------
      when S_PS =>
         SRC_RDY   <= '1';
         if (DST_RDY = '1') then
            NEXT_DATA <= '1';
         end if;

      -- ---------------------------------------------
      when S_PT =>
         SRC_RDY   <= '1';
         if (DST_RDY = '1') then 
            NEXT_DATA <= '1';
            if (PACKET_END = '1') then
               EOP <= '1';
               NEXT_LEN <= '1';
               if (START = '0') then
                  STOPPED <= '1';
               end if;
            end if;
            if (TRANSMIT_END = '1') then
               STOPPED <= '1';
            end if;

         end if;

      -- ---------------------------------------------
      when S_PE =>
         if (TRANSMIT_END = '1') then
               STOPPED <= '1';
         else
            SRC_RDY   <= '1';
            if (DST_RDY = '1') then 
               NEXT_DATA <= '1';
               SOP <= '1';
            end if;
         end if;

      -- ---------------------------------------------
      when others =>
         null;

      -- ---------------------------------------------  
      end case;
   end process output_logic;

end architecture full;

