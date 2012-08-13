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

-- mi32_async_arch_norec.vhd: Architecture of mi32_async component without
--                            records
-- Copyright (C) 2006 CESNET
-- Author(s): Viktor Pus <pus@liberouter.org>
--            Jiri Matousek <xmatou06@stud.fit.vutbr.cz>
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
-- $Id: mi32_async_arch_norec.vhd 6111 2008-10-26 22:49:39Z xmatou06 $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- ----------------------------------------------------------------------------
--                               Architecture
-- ----------------------------------------------------------------------------
architecture full of MI32_ASYNC_NOREC is

-- Asynchronous signals
signal req                 : std_logic;
signal regasync_req_fall   : std_logic;
signal regasync_req_rise   : std_logic;
signal ack                 : std_logic;
signal regasync_ack_fall   : std_logic;
signal regasync_ack_rise   : std_logic;

-- Control signals
signal slave_en            : std_logic;
signal done                : std_logic;
signal mi_m_ardy2          : std_logic;
signal mi_s_drdy2          : std_logic;

-- Delayed signals in simulation
signal s_drdy_d            : std_logic;
signal s_drd_d             : std_logic_vector(31 downto 0);

-- Reigsters in direction Master -> Slave
signal reg_dwr             : std_logic_vector(31 downto 0);
signal reg_addr            : std_logic_vector(31 downto 0);
signal reg_rd              : std_logic;
signal reg_wr              : std_logic;
signal reg_be              : std_logic_vector(3 downto 0);

-- Registers in direction Slave -> Master
signal reg_drd             : std_logic_vector(31 downto 0);
signal reg_drdy            : std_logic;

begin

-- regasync_req_fall register
process(RESET, CLK_S)
begin
   if (RESET = '1') then
      regasync_req_fall <= '0';
   elsif (CLK_S'event AND CLK_S = '0') then
      regasync_req_fall <= req;
   end if;
end process;

-- regasync_req_rise register
process(RESET, CLK_S)
begin
   if (RESET = '1') then
      regasync_req_rise <= '0';
   elsif (CLK_S'event AND CLK_S = '1') then
      regasync_req_rise <= regasync_req_fall;
   end if;
end process;

-- regasync_ack_fall register
process(RESET, CLK_M)
begin
   if (RESET = '1') then
      regasync_ack_fall <= '0';
   elsif (CLK_M'event AND CLK_M = '0') then
      regasync_ack_fall <= ack;
   end if;
end process;

-- regasync_ack_rise register
process(RESET, CLK_M)
begin
   if (RESET = '1') then
      regasync_ack_rise <= '0';
   elsif (CLK_M'event AND CLK_M = '1') then
      regasync_ack_rise <= regasync_ack_fall;
   end if;
end process;

fsm_master : entity work.MI32_ASYNC_FSMM
port map(
   RESET => RESET,
   CLK   => CLK_M,
   RD    => MI_M_RD,
   WR    => MI_M_WR,
   ACK   => regasync_ack_rise,
   REQ   => req,
   ARDY  => mi_m_ardy2,
   DONE  => done
);

fsm_slave : entity work.MI32_ASYNC_FSMS
port map(
   RESET => RESET,
   CLK   => CLK_S,
   REQ   => regasync_req_rise,
   DRDY  => mi_s_drdy2,
   ARDY  => MI_S_ARDY,
   ACK   => ack,
   EN    => slave_en
);

-- process(CLK_S)
-- begin
   -- if reg_wr = '1' then
      -- mi_s_drdy2 <= '1';
   -- else
      -- mi_s_drdy2 <= MI_S.DRDY;
   -- end if;
-- end process;

mi_s_drdy2 <= '1' when reg_wr = '1' else
             MI_S_DRDY;

s_drdy_d <= MI_S_DRDY
            -- pragma translate off
            after 1 ns
            -- pragma translate on
            ;

s_drd_d <= MI_S_DRD
           -- pragma translate off
           after 1 ns
           -- pragma translate on
           ;

reg_master_to_slave : process(CLK_M, RESET)
begin
   if RESET = '1' then
      reg_dwr <= (others => '0');
      reg_addr <= (others => '0');
      reg_rd <= '0';
      reg_wr <= '0';
      reg_be <= (others => '0');
   elsif CLK_M'event and CLK_M = '1' then
      if mi_m_ardy2 = '1' and (MI_M_RD = '1' or MI_M_WR = '1') then
         reg_dwr <= MI_M_DWR;
         reg_addr <= MI_M_ADDR;
         reg_rd <= MI_M_RD;
         reg_wr <= MI_M_WR;
         reg_be <= MI_M_BE;
      end if;
   end if;
end process;

reg_slave_to_master : process(CLK_S, RESET)
begin
   if RESET = '1' then
      reg_drd <= (others => '0');
   elsif CLK_S'event and CLK_S = '1' then
      if mi_s_drdy2 = '1' then
         reg_drd <= s_drd_d;
      end if;
   end if;
end process;

reg_drdy_slave_to_master : process(CLK_S, RESET)
begin
   if RESET = '1' then
      reg_drdy <= '0';
   elsif CLK_S'event and CLK_S = '1' then
      if mi_s_drdy2 = '1' then
         reg_drdy <= s_drdy_d;
      end if;
   end if;
end process;

-- Port mapping
MI_M_ARDY <= mi_m_ardy2 and (MI_M_RD or MI_M_WR);
MI_M_DRDY <= reg_drdy when done = '1' else
             '0';
MI_M_DRD  <= reg_drd;

MI_S_DWR  <= reg_dwr;
MI_S_ADDR <= reg_addr;
MI_S_RD   <= reg_rd when slave_en = '1' else
             '0';
MI_S_WR   <= reg_wr when slave_en = '1' else
             '0';
MI_S_BE   <= reg_be;

end architecture full;
