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

-- application_core.vhd : Application core module
-- Copyright (C) 2009 CESNET
-- Author(s):  Pavol Korcek <korcek@liberouter.org>
--             Petr Kastovsky <kastovsky@liberouter.org>
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
-- $Id: application_core.vhd 12117 2009-11-25 13:35:03Z kastovsky $
--

-- --------------------------------------------------------------------
--                          Entity declaration
-- --------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 
use work.lb_pkg.all;      -- Local Bus Package

entity application_core is
   port (
      CLK            : in std_logic; 
      RESET          : in std_logic;
      -- MI32
      mi32_dwr       : in  std_logic_vector(31 downto 0);
      mi32_addr      : in  std_logic_vector(31 downto 0);
      mi32_rd        : in  std_logic;
      mi32_wr        : in  std_logic;
      mi32_be        : in  std_logic_vector(3 downto 0);
      mi32_drd       : out std_logic_vector(31 downto 0);
      mi32_ardy      : out std_logic;
      mi32_drdy      : out std_logic;
      -- FL   
      fl_sof_n       : out std_logic;
      fl_sop_n       : out std_logic;
      fl_eop_n       : out std_logic;
      fl_eof_n       : out std_logic;
      fl_src_rdy_n   : out std_logic;
      fl_dst_rdy_n   : in  std_logic;
      fl_data        : out std_logic_vector(127 downto 0);
      fl_rem         : out std_logic_vector(3 downto 0)
   );

end application_core;

architecture full of application_core is

-- ----------------------------------------------------------------------------
--                            Signal declaration
-- ----------------------------------------------------------------------------
   constant gndvec    : std_logic_vector(31 downto 0) := X"00000000";
   signal status      : std_logic_vector(31 downto 0); -- status/control register
   signal init0       : std_logic_vector(31 downto 0); -- init vector 0
   signal init1       : std_logic_vector(31 downto 0); -- init vector 1
   signal pkt_length  : std_logic_vector(31 downto 0); -- actual sw packet length
   signal pkt_num0    : std_logic_vector(31 downto 0); -- number of packet to send (low register) 
   signal pkt_num1    : std_logic_vector(31 downto 0); -- number of packet to send (high register)
   signal pkt_send0   : std_logic_vector(31 downto 0); -- number of sent packets (low register)
   signal pkt_send1   : std_logic_vector(31 downto 0); -- number of sent packets (high register)

   signal seed        : std_logic_vector(63 downto 0);   -- initialization seed
   signal clear       : std_logic;

   signal length_shift_enable    : std_logic;                        -- shift to next random length
   signal length_fill_enable     : std_logic;                        -- filling with seed value enabled
   signal rnd_length             : std_logic_vector(10 downto 0);    -- random length output
   signal reg_length             : std_logic_vector(10 downto 0);    -- random length output
   signal length                 : std_logic_vector(10 downto 0);    -- finall length
   signal length_sel             : std_logic;                        -- length selector

   signal data_shift_enable      : std_logic;                        -- shift to next random data
   signal data_fill_enable       : std_logic;                        -- filling with seed value enabled
   signal rnd_data               : std_logic_vector(127 downto 0);   -- random data output
   signal last_data              : std_logic;                        -- last data send (EOF and BE active)
   signal last_be                : std_logic_vector(3 downto 0);     -- BE for network frame link
   signal num_packets            : std_logic_vector(63 downto 0);    -- number of packetss to send
   signal reg_send_packets       : std_logic_vector(63 downto 0);    -- number of actually sent packet
   signal last_pkt               : std_logic;

   signal status_run_set      : std_logic;
   signal status_stp_set      : std_logic;
   signal status_run_clr      : std_logic;
  
   signal gen_fsm_eop         : std_logic;
   signal gen_fsm_sop         : std_logic;
   signal gen_fsm_nd          : std_logic;
   signal gen_fsm_nl          : std_logic;
   signal gen_fsm_stopped     : std_logic;
   signal gen_fsm_src_rdy     : std_logic;
   signal gen_fsm_dst_rdy     : std_logic;

   signal mux_rem_sel         : std_logic;
   signal mux_data_sel        : std_logic;
-- ----------------------------------------------------------------------------
--                             Architecture body
-- ----------------------------------------------------------------------------
begin

   -- -------------------------------------------------------------------------
   -- User registers
   -- -------------------------------------------------------------------------
   mi32_drdy <= mi32_rd;
   mi32_ardy <= mi32_wr or mi32_rd;

   REGISTERS_U : process(CLK)
      begin
      if (CLK = '1' and CLK'event) then
         if (RESET = '1') then
            status(31 downto 1)   <= (others => '0');
            init0       <= X"ABCDEF12"; -- init vector 0
            init1       <= X"34567890"; -- init vector 1
            pkt_length  <= X"00000001"; -- actual packet length
            pkt_num0    <= X"FFFFFFFF"; -- number of packet to send (low register) 
            pkt_num1    <= X"FFFFFFFF"; -- number of packet to send (high register)
           -- pkt_send0   <= X"00000000"; -- number of sent packets (low register)
           -- pkt_send1   <= X"00000000"; -- number of sent packets (high register)
   
         else
            
            status_run_set <= '0';
            status_stp_set <= '0';
            -- Write to my registers
            if (mi32_wr = '1') then
               case mi32_addr(4 downto 2) is
                  when "000" =>
                     status_run_set <= mi32_dwr(0);
                     status_stp_set <= not mi32_dwr(0);
                     status(31 downto 1) <= mi32_dwr(31 downto 1);
                  when "001" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           init0(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8);
                        end if;
                     end loop;
                  when "010" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           init1(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8);
                        end if;
                     end loop;
                  when "011" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           pkt_length(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8);
                        end if;
                     end loop;
                  when "100" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           pkt_num0(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8);
                        end if;
                     end loop;
                  when "101" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           pkt_num1(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8);
                        end if;
                     end loop;
                  when "110" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           --pkt_send0(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8); -- r
                        end if;
                     end loop;
                  when "111" =>
                     for i in 0 to 3 loop
                        if mi32_be(i) = '1' then
                           --pkt_send1(i*8+7 downto i*8) <= mi32_dwr(i*8+7 downto i*8); -- r   
                        end if;
                     end loop;
   
                  when others => null;
               end case;
            end if;
   
            -- Read from my registers
            case mi32_addr(4 downto 2) is
               when "000"    => mi32_drd <= status; 
               when "001"    => mi32_drd <= init0;
               when "010"    => mi32_drd <= init1;
               when "011"    => mi32_drd <= pkt_length;
               when "100"    => mi32_drd <= pkt_num0;
               when "101"    => mi32_drd <= pkt_num1;
               when "110"    => mi32_drd <= pkt_send0;
               when "111"    => mi32_drd <= pkt_send1;
   
               when others   => mi32_drd <= X"DEADBEEF";
            end case;
         end if;
      end if;
   end process;


   status_run_clr <= gen_fsm_stopped or status_stp_set;
   -- register reg_status ------------------------------------------------------
   reg_statusp: process(CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if ( RESET = '1') then
            status(0) <= '0';
         elsif (status_run_set = '1') then
            status(0) <= '1';
         elsif (status_run_clr = '1') then
            status(0) <= '0';
         end if;
      end if;
   end process;

   -- -------------------------------------------------------------------------
   -- Generators
   -- -------------------------------------------------------------------------

   seed <= init1 & init0;

   PKT_LENGTH_GEN_U : entity work.pseudorand_length_gen
   port map (
      RESET    => RESET,
      CLK      => CLK,
      S_EN     => length_shift_enable,
      F_EN     => length_fill_enable,
      DIN      => seed(10 downto 0),
      DOUT     => rnd_length
   );

   PKT_DATA_GEN_U : entity work.pseudorand_data_gen
   port map (
      CLK      => CLK,
      S_EN     => data_shift_enable,
      F_EN     => data_fill_enable,
      DIN      => seed,
      DOUT     => rnd_data
   );

   -- -------------------------------------------------------------------------
   -- Internal registers
   -- -------------------------------------------------------------------------

   clear <= (last_data AND gen_fsm_dst_rdy) OR status_run_set;
   -- register  ---------------------------------------------------------------
   reg_lengthp: process(RESET, CLK)
   begin
      if (RESET = '1') then
         reg_length <= (others => '0');
      elsif (CLK'event AND CLK = '1') then
         if(clear = '1') then
            reg_length <= length;
         elsif(data_shift_enable = '1') then -- when request for next data 
            reg_length <= reg_length - 16; -- decrement
         end if;
      end if;
   end process;

   mux_data_sel <= status(2);
   -- multiplexor mux_data ------------------------------------------------------
   mux_datap: process(mux_data_sel, rnd_data)
   begin
      case mux_data_sel is
         when '0' => fl_data <= (others => '0');
         when '1' => fl_data <= rnd_data;
         when others => fl_data <= (others => 'X');
      end case;
   end process;

   length_sel <= status(1);
   -- multiplexor length ------------------------------------------------------
   length_muxp: process(length_sel, pkt_length(10 downto 0), rnd_length)
   begin
      case length_sel is
         when '0' => length <= pkt_length(10 downto 0); -- user length
         when '1' => length <= rnd_length;
         when others => length <= (others => '1');
      end case;
   end process;

   last_be     <= length(3 downto 0) - 1;  -- BE
   mux_rem_sel <= gen_fsm_eop;
   -- multiplexor mux_rem ------------------------------------------------------
   mux_remp: process(mux_rem_sel, last_be)
   begin
      case mux_rem_sel is
         when '0' => fl_rem <= (others => '1');
         when '1' => fl_rem <= last_be;
         when others => fl_rem <= (others => 'X');
      end case;
   end process;

   -- register  ---------------------------------------------------------------
   reg_send_packetsp: process(RESET, CLK)
   begin
      if (RESET = '1') then
         reg_send_packets <= (others => '0');
      elsif (CLK'event AND CLK = '1') then
         if (status_run_set = '1') then
            reg_send_packets <= (others => '0');
         elsif(length_shift_enable = '1') then -- when next packet send 
            reg_send_packets <= reg_send_packets + 1; -- increment
         end if;
      end if;
   end process;

   pkt_send0      <= reg_send_packets(31 downto 0);
   pkt_send1      <= reg_send_packets(63 downto 32);
   num_packets    <= pkt_num1 & pkt_num0; -- from SW

   -- -------------------------------------------------------------------------
   -- Comparators
   -- -------------------------------------------------------------------------

   last_data   <= '1' when (reg_length <= 16) else    -- last data in packet
                  '0';
 
   last_pkt    <= '1' when (reg_send_packets = num_packets) else  -- last packet to send
                  '0';


   GEN_FSM_I: entity work.GEN_FSM
   port map (
      -- global signals 
      CLK            => CLK,
      RESET          => RESET,

      -- input signals
      START          => status(0),
      PACKET_END     => last_data,
      TRANSMIT_END   => last_pkt,
      DST_RDY        => gen_fsm_dst_rdy,

      -- output signals
      SOP            => gen_fsm_sop,
      EOP            => gen_fsm_eop,
      NEXT_DATA      => gen_fsm_nd,
      NEXT_LEN       => gen_fsm_nl,
      SRC_RDY        => gen_fsm_src_rdy,
      STOPPED        => gen_fsm_stopped
   );

   gen_fsm_dst_rdy      <= not fl_dst_rdy_n;
   fl_src_rdy_n         <= not gen_fsm_src_rdy;
   length_shift_enable  <= gen_fsm_nl XOR status_run_set;
   data_shift_enable    <= gen_fsm_nd XOR status_run_set;
   length_fill_enable   <= gen_fsm_stopped;
   data_fill_enable     <= gen_fsm_stopped;
   fl_sof_n             <= not gen_fsm_sop;
   fl_sop_n             <= not gen_fsm_sop;
   fl_eof_n             <= not gen_fsm_eop;
   fl_eop_n             <= not gen_fsm_eop;

end architecture full;
