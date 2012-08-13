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

-- fsm_slave.vhd: FSM controlling asynchronous transfer at slave side
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
-- $Id: fsm_slave.vhd 13034 2010-03-02 16:03:47Z pus $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- ----------------------------------------------------------------------------
--                            Entity declaration
-- ----------------------------------------------------------------------------
entity MI32_ASYNC_FSMS is
   port(
      RESET : in std_logic;
      CLK   : in std_logic;

      REQ   : in std_logic;
      DRDY  : in std_logic;
      ARDY  : in std_logic;

      ACK   : out std_logic;
      EN    : out std_logic
   );
end entity MI32_ASYNC_FSMS;

-- ----------------------------------------------------------------------------
--                               Architecture
-- ----------------------------------------------------------------------------
architecture full of MI32_ASYNC_FSMS is

type t_fsmm is (wait_for_req, wait_for_drdy, wait_for_nreq);

signal fsm        : t_fsmm;
signal fsm_next   : t_fsmm;

begin

   fsm_p : process(CLK, RESET)
   begin
      if RESET = '1' then
         fsm <= wait_for_req;
      elsif CLK'event and CLK = '1' then
         fsm <= fsm_next;
      end if;
   end process;

   fsm_next_p : process(fsm, REQ, DRDY, ARDY)
   begin
      fsm_next <= fsm;
      case fsm is
      when wait_for_req =>
         if REQ = '1' and ARDY = '1' then
            if DRDY = '1' then
               fsm_next <= wait_for_nreq;
            else
               fsm_next <= wait_for_drdy;
            end if;
         end if;

      when wait_for_drdy =>
         if DRDY = '1' then
            fsm_next <= wait_for_nreq;
         end if;

      when wait_for_nreq =>
         if REQ = '0' then
            fsm_next <= wait_for_req;
         end if;
      end case;
   end process;

ACK <= '1' when fsm = wait_for_nreq else
       '0';

EN <= '1' when fsm = wait_for_req and REQ = '1' else
      '0';

end architecture full;
