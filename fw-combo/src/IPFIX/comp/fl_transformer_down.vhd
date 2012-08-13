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

-- transformer_down.vhd: Implementation of DOWN architecture of FrameLink
-- Transformer component.
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
-- $Id: transformer_down.vhd 1659 2008-03-07 09:20:09Z sandin $
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
--                        Entity declaration
-- ------------------------------------------------------------------------
entity FL_TRANSFORMER_DOWN is
   generic(
      -- FrameLink data buses width
      -- only 8, 16, 32, 64 and 128 supported
      -- !! RX_DATA_WIDTH > TX_DATA_WIDTH !!
      RX_DATA_WIDTH  : integer;
      TX_DATA_WIDTH  : integer
   );
   port(
      CLK            : in  std_logic;
      RESET          : in  std_logic;

      -- RX interface
      RX_DATA        : in  std_logic_vector(RX_DATA_WIDTH-1 downto 0);
      RX_REM         : in  std_logic_vector(log2(RX_DATA_WIDTH/8)-1 downto 0);
      RX_SOF_N       : in  std_logic;
      RX_EOF_N       : in  std_logic;
      RX_SOP_N       : in  std_logic;
      RX_EOP_N       : in  std_logic;
      RX_SRC_RDY_N   : in  std_logic;
      RX_DST_RDY_N   : out std_logic;

      -- TX interface
      TX_DATA        : out std_logic_vector(TX_DATA_WIDTH-1 downto 0);
      TX_REM         : out std_logic_vector(log2(TX_DATA_WIDTH/8)-1 downto 0);
      TX_SOF_N       : out std_logic;
      TX_EOF_N       : out std_logic;
      TX_SOP_N       : out std_logic;
      TX_EOP_N       : out std_logic;
      TX_SRC_RDY_N   : out std_logic;
      TX_DST_RDY_N   : in  std_logic
   );
end entity FL_TRANSFORMER_DOWN;

-- ------------------------------------------------------------------------
--                      Architecture declaration
-- ------------------------------------------------------------------------
architecture full_down of FL_TRANSFORMER_DOWN is

   signal dst_rdy          : std_logic;
   signal valid_bytes      : std_logic_vector(log2(RX_DATA_WIDTH/8)-1 downto 0);
   signal reg_valid_bytes  : std_logic_vector(log2(RX_DATA_WIDTH/8)-1 downto 0);
   signal valid_count      : std_logic_vector(log2(RX_DATA_WIDTH/8)-1 downto 0);

   signal lblk             : std_logic;
   signal flag_sop         : std_logic;
   signal flag_eop         : std_logic;
   signal eop_n            : std_logic;
   signal sig_eop          : std_logic;
   signal flag_eof         : std_logic;
   signal sig_eof          : std_logic;
   signal got_valid        : std_logic;
   signal cnt_byte         : std_logic_vector(log2(RX_DATA_WIDTH/8)-1 downto 0);
   signal cnt_data         : std_logic_vector(log2(RX_DATA_WIDTH/TX_DATA_WIDTH)-1 downto 0);

   signal reg_data         : std_logic_vector(RX_DATA_WIDTH-1 downto 0)
      := (others => '0');
   signal reg_rem          : std_logic_vector(log2(TX_DATA_WIDTH/8)-1 downto 0)
      := (others => '0');
   signal aux_rem          : std_logic_vector(log2(TX_DATA_WIDTH/8)-1 downto 0);
   signal data_strobe      : std_logic;
   signal gen_mux_in       : std_logic_vector(RX_DATA_WIDTH-1 downto 0);

   signal src_rdy_n        : std_logic;

   signal first_word       : std_logic;

begin

   assert (RX_DATA_WIDTH > TX_DATA_WIDTH)
      report "FL_TRANSFORMER: Bad use of DOWN architecture - RX_DATA_WIDTH must be greater than TX_DATA_WIDTH."
      severity error;

   -- output ports
   TX_SOF_N       <= RX_SOF_N or (not dst_rdy);
   TX_SOP_N       <= RX_SOP_N or (not dst_rdy);
   TX_EOP_N       <= eop_n;
   TX_EOF_N       <= not (lblk and (sig_eof or flag_eof));
   TX_SRC_RDY_N   <= src_rdy_n;
   RX_DST_RDY_N   <= TX_DST_RDY_N or not first_word;

   TX_REM   <= aux_rem
      when data_strobe = '1'
      else reg_rem;

   first_word <= '1'
      when conv_integer(cnt_data) = 0
      else '0';

   dst_rdy <= first_word;

   aux_rem  <= (others => '1')
      when conv_integer(RX_REM(log2(RX_DATA_WIDTH/8)-1 downto log2(TX_DATA_WIDTH/8))) > 0
      else RX_REM(log2(TX_DATA_WIDTH/8)-1 downto 0);

   eop_n       <= not (lblk and (sig_eop or flag_eop));
   sig_eop     <= dst_rdy and (not RX_EOP_N) and (not RX_SRC_RDY_N);
   sig_eof     <= dst_rdy and (not RX_EOF_N) and (not RX_SRC_RDY_N);
   src_rdy_n   <= '1'
      when (RX_SRC_RDY_N = '1') and (dst_rdy = '1')
      else RX_SRC_RDY_N and (not flag_sop) and (not flag_eop);

   data_strobe <= dst_rdy and not RX_SRC_RDY_N;

   gen_mux_in  <= RX_DATA
      when data_strobe = '1'
      else reg_data;

   -- ---------------------------------------------------------------------
   --                   Components
   -- ---------------------------------------------------------------------
   GEN_MUX_U: entity work.GEN_MUX
      generic map(
         DATA_WIDTH  => TX_DATA_WIDTH,
         MUX_WIDTH   => RX_DATA_WIDTH/TX_DATA_WIDTH
      )
      port map(
         DATA_IN  => gen_mux_in,
         SEL      => cnt_data,
         DATA_OUT => TX_DATA
      );

   -- ---------------------------------------------------------------------
   --                   Main logic
   -- ---------------------------------------------------------------------

   valid_bytes <= RX_REM
      when (RX_EOP_N = '0') and (TX_DST_RDY_N = '0')
      else conv_std_logic_vector((RX_DATA_WIDTH/8)-1, log2(RX_DATA_WIDTH/8));

   valid_count <= valid_bytes
      when dst_rdy = '1'
      else reg_valid_bytes;

   got_valid <= '1'
      when not (valid_count > cnt_byte)
      else '0';

   -- last block identification
   lblk <= got_valid
      when (RX_SRC_RDY_N = '0') or (flag_sop = '1')
      else '1';

   cnt_bytep: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            cnt_byte <= conv_std_logic_vector((TX_DATA_WIDTH/8)-1, log2(RX_DATA_WIDTH/8));
         else
            if (TX_DST_RDY_N = '0' and src_rdy_n = '0') then
               if (lblk = '1') then
                  cnt_byte <= conv_std_logic_vector((TX_DATA_WIDTH/8)-1, log2(RX_DATA_WIDTH/8));
               else
                  cnt_byte <= cnt_byte + conv_std_logic_vector((TX_DATA_WIDTH/8), log2(RX_DATA_WIDTH/8));
               end if;
            end if;
         end if;
      end if;
   end process;

   cnt_datap: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            cnt_data <= (others => '0');
         else
            if ((TX_DST_RDY_N = '0') and (src_rdy_n = '0')) then
               if (lblk = '1') then
                  cnt_data <= (others => '0');
               else
                  cnt_data <= cnt_data + 1;
               end if;
            end if;
         end if;
      end if;
   end process;

   -- ---------------------------------------------------------------------
   --                   Registers
   -- ---------------------------------------------------------------------

   reg_valid_bytesp: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            reg_valid_bytes <= (others => '0');
         else
            if ((dst_rdy = '1') and ((RX_SRC_RDY_N = '0') or (flag_sop = '1'))) then
               reg_valid_bytes <= valid_bytes;
            end if;
         end if;
      end if;
   end process;

   reg_datap: process(CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (data_strobe = '1') then
            reg_data <= RX_DATA;
         end if;
      end if;
   end process;

   reg_remp: process(CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (data_strobe = '1') then
            reg_rem <= RX_REM(log2(TX_DATA_WIDTH/8)-1 downto 0);
         end if;
      end if;
   end process;

   flag_sopp: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            flag_sop <= '0';
         else
            if ((RX_SOP_N = '0') and (RX_SRC_RDY_N = '0')) then
               flag_sop <= '1';
            elsif (eop_n = '0') then
               flag_sop <= '0';
            end if;
         end if;
      end if;
   end process;

   flag_eopp: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            flag_eop <= '0';
         else
            if (lblk = '1' and TX_DST_RDY_N = '0') then
               flag_eop <= '0';
            elsif (sig_eop = '1') then
               flag_eop <= '1';
            end if;
         end if;
      end if;
   end process;

   flag_eofp: process(RESET, CLK)
   begin
      if (CLK'event AND CLK = '1') then
         if (RESET = '1') then
            flag_eof <= '0';
         else
            if (lblk = '1' and TX_DST_RDY_N = '0') then
               flag_eof <= '0';
            elsif (sig_eof = '1') then
               flag_eof <= '1';
            end if;
         end if;
      end if;
   end process;

end architecture full_down;
