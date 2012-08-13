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

-- fsm_master.vhd: FSM controlling asynchronous transfer at master side
-- Copyright (C) 2006 CESNET
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
-- $Id: fsm_master.vhd 14 2007-07-31 06:44:05Z kosek $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- ----------------------------------------------------------------------------
--                            Entity declaration
-- ----------------------------------------------------------------------------
entity MI32_ASYNC_FSMM is
   port(
      RESET : in std_logic;
      CLK   : in std_logic;
      RD    : in std_logic;
      WR    : in std_logic;
      ACK   : in std_logic;

      REQ   : out std_logic;
      ARDY  : out std_logic;
      DONE  : out std_logic
   );
end entity MI32_ASYNC_FSMM;

-- ----------------------------------------------------------------------------
--                               Architecture
-- ----------------------------------------------------------------------------
architecture full of MI32_ASYNC_FSMM is

type t_fsmm is (wait_for_op, wait_for_ack, wait_for_nack);

signal fsm        : t_fsmm;
signal fsm_next   : t_fsmm;

signal sig_req    : std_logic;
signal sig_ardy   : std_logic;

begin
   
   fsm_p : process(CLK, RESET)
   begin
      if RESET = '1' then
         fsm <= wait_for_op;
      elsif CLK'event and CLK = '1' then
         fsm <= fsm_next;
      end if;
   end process;

   fsm_next_p : process(fsm, RD, WR, ACK)
   begin
      fsm_next <= fsm;
      case fsm is
      when wait_for_op =>
         if RD = '1' or WR = '1' then
            fsm_next <= wait_for_ack;
         end if;

      when wait_for_ack =>
         if ACK = '1' then
            fsm_next <= wait_for_nack;
         end if;

      when wait_for_nack =>
         if ACK = '0' then
            fsm_next <= wait_for_op;
         end if;
      end case;
   end process;

   REQ <= '1' when fsm = wait_for_ack else
          '0';

   ARDY <= '1' when fsm = wait_for_op else
           '0';

   
   DONE <= '1' when fsm = wait_for_ack and ACK = '1' else
           '0';

end architecture full;
