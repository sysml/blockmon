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

-- pseudorand_data_gen.vhd : LFSR based pseudorandom generator module
-- Copyright (C) 2009 CESNET
-- Author(s): Pavol Korcek <korcek@liberouter.org>
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
-- $Id: pseudorand_data_gen.vhd 11967 2009-11-11 22:34:43Z korcek $
--

library ieee;
use ieee.std_logic_1164.all;
use work.lfsr_pkg.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity pseudorand_data_gen is
  
  generic (
    LFSR_LENGTH      : integer     := 64;             -- internal LFSR width 
    OUTPUT_WIDTH     : integer     := 128;            -- output data width
    TAPS             : LFSR_TAPS   :=(64,63,61,60)   -- polynomial
  );
  port (
    CLK     : in  std_logic;  -- clock signal
    S_EN    : in  std_logic;  -- shift enable
    F_EN    : in  std_logic;  -- fill enable
    DIN     : in  std_logic_vector(LFSR_LENGTH-1 downto 0); -- seed
    DOUT    : out std_logic_vector(OUTPUT_WIDTH-1 downto 0) -- data out
  );

end entity pseudorand_data_gen;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------

architecture beh of pseudorand_data_gen is

      signal init0   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init1   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init2   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init3   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init4   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init5   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init6   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init7   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init8   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init9   : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init10  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init11  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init12  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init13  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init14  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init15  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init16  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init17  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init18  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init19  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init20  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init21  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init22  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init23  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init24  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init25  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init26  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init27  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init28  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init29  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init30  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init31  : std_logic_vector(LFSR_LENGTH-1 downto 0);

      signal init32  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init33  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init34  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init35  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init36  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init37  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init38  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init39  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init40  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init41  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init42  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init43  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init44  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init45  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init46  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init47  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init48  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init49  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init50  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init51  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init52  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init53  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init54  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init55  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init56  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init57  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init58  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init59  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init60  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init61  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init62  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init63  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      
      signal init64  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init65  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init66  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init67  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init68  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init69  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init70  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init71  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init72  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init73  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init74  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init75  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init76  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init77  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init78  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init79  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init80  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init81  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init82  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init83  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init84  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init85  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init86  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init87  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init88  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init89  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init90  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init91  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init92  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init93  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init94  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init95  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init96  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init97  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init98  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init99  : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init100 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init101 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init102 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init103 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init104 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init105 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init106 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init107 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init108 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init109 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init110 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init111 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init112 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init113 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init114 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init115 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init116 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init117 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init118 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init119 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init120 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init121 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init122 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init123 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init124 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init125 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init126 : std_logic_vector(LFSR_LENGTH-1 downto 0);
      signal init127 : std_logic_vector(LFSR_LENGTH-1 downto 0);


begin

	inst0_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init0,
			DOUT        => DOUT(0)
		);
	init0 <= DIN(7) & DIN(28) & DIN(61) & DIN(33) & DIN(1) & DIN(52) & DIN(2) & DIN(14) & 
		DIN(17) & DIN(20) & DIN(52) & DIN(27) & DIN(6) & DIN(13) & DIN(50) & DIN(43) & 
		DIN(20) & DIN(30) & DIN(41) & DIN(24) & DIN(23) & DIN(5) & DIN(29) & DIN(37) & 
		DIN(26) & DIN(35) & DIN(24) & DIN(49) & DIN(55) & DIN(13) & DIN(50) & DIN(38) & 
		DIN(26) & DIN(9) & DIN(31) & DIN(51) & DIN(35) & DIN(46) & DIN(26) & DIN(54) & 
		DIN(13) & DIN(39) & DIN(40) & DIN(27) & DIN(56) & DIN(20) & DIN(2) & DIN(60) & 
		DIN(6) & DIN(35) & DIN(59) & DIN(50) & DIN(43) & DIN(58) & DIN(13) & DIN(41) & 
		DIN(44) & DIN(10) & DIN(63) & DIN(17) & DIN(51) & DIN(41) & DIN(6) & DIN(39);

	inst1_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init1,
			DOUT        => DOUT(1)
		);
	init1 <= DIN(51) & DIN(49) & DIN(43) & DIN(49) & DIN(21) & DIN(15) & DIN(25) & DIN(40) & 
		DIN(59) & DIN(28) & DIN(57) & DIN(9) & DIN(33) & DIN(62) & DIN(24) & DIN(53) & 
		DIN(20) & DIN(60) & DIN(60) & DIN(5) & DIN(38) & DIN(17) & DIN(41) & DIN(59) & 
		DIN(58) & DIN(42) & DIN(58) & DIN(59) & DIN(3) & DIN(62) & DIN(26) & DIN(2) & 
		DIN(28) & DIN(27) & DIN(24) & DIN(44) & DIN(20) & DIN(60) & DIN(47) & DIN(50) & 
		DIN(59) & DIN(59) & DIN(48) & DIN(44) & DIN(42) & DIN(28) & DIN(56) & DIN(15) & 
		DIN(22) & DIN(43) & DIN(28) & DIN(42) & DIN(23) & DIN(62) & DIN(1) & DIN(62) & 
		DIN(39) & DIN(60) & DIN(33) & DIN(1) & DIN(33) & DIN(62) & DIN(41) & DIN(48);

	inst2_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init2,
			DOUT        => DOUT(2)
		);
	init2 <= DIN(53) & DIN(61) & DIN(27) & DIN(58) & DIN(25) & DIN(34) & DIN(47) & DIN(59) & 
		DIN(28) & DIN(21) & DIN(7) & DIN(8) & DIN(16) & DIN(35) & DIN(13) & DIN(51) & 
		DIN(59) & DIN(47) & DIN(16) & DIN(27) & DIN(50) & DIN(44) & DIN(20) & DIN(42) & 
		DIN(28) & DIN(9) & DIN(30) & DIN(17) & DIN(36) & DIN(36) & DIN(48) & DIN(59) & 
		DIN(35) & DIN(57) & DIN(11) & DIN(30) & DIN(5) & DIN(26) & DIN(51) & DIN(20) & 
		DIN(5) & DIN(36) & DIN(59) & DIN(28) & DIN(40) & DIN(30) & DIN(35) & DIN(31) & 
		DIN(61) & DIN(36) & DIN(7) & DIN(8) & DIN(16) & DIN(11) & DIN(11) & DIN(10) & 
		DIN(37) & DIN(58) & DIN(33) & DIN(41) & DIN(0) & DIN(55) & DIN(47) & DIN(5);

	inst3_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init3,
			DOUT        => DOUT(3)
		);
	init3 <= DIN(41) & DIN(14) & DIN(2) & DIN(61) & DIN(9) & DIN(21) & DIN(50) & DIN(15) & 
		DIN(30) & DIN(36) & DIN(48) & DIN(34) & DIN(47) & DIN(51) & DIN(20) & DIN(54) & 
		DIN(19) & DIN(28) & DIN(4) & DIN(59) & DIN(51) & DIN(53) & DIN(48) & DIN(62) & 
		DIN(34) & DIN(21) & DIN(26) & DIN(42) & DIN(43) & DIN(33) & DIN(6) & DIN(44) & 
		DIN(5) & DIN(44) & DIN(11) & DIN(58) & DIN(55) & DIN(14) & DIN(31) & DIN(60) & 
		DIN(52) & DIN(61) & DIN(13) & DIN(57) & DIN(32) & DIN(56) & DIN(50) & DIN(24) & 
		DIN(40) & DIN(14) & DIN(10) & DIN(53) & DIN(19) & DIN(27) & DIN(36) & DIN(56) & 
		DIN(41) & DIN(56) & DIN(35) & DIN(63) & DIN(28) & DIN(26) & DIN(33) & DIN(11);

	inst4_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init4,
			DOUT        => DOUT(4)
		);
	init4 <= DIN(3) & DIN(6) & DIN(58) & DIN(32) & DIN(57) & DIN(11) & DIN(44) & DIN(52) & 
		DIN(4) & DIN(7) & DIN(50) & DIN(59) & DIN(44) & DIN(5) & DIN(35) & DIN(32) & 
		DIN(54) & DIN(48) & DIN(4) & DIN(10) & DIN(44) & DIN(28) & DIN(50) & DIN(30) & 
		DIN(7) & DIN(54) & DIN(20) & DIN(45) & DIN(45) & DIN(63) & DIN(4) & DIN(35) & 
		DIN(13) & DIN(47) & DIN(51) & DIN(4) & DIN(6) & DIN(37) & DIN(2) & DIN(9) & 
		DIN(27) & DIN(45) & DIN(23) & DIN(12) & DIN(14) & DIN(51) & DIN(27) & DIN(44) & 
		DIN(4) & DIN(40) & DIN(24) & DIN(14) & DIN(21) & DIN(60) & DIN(10) & DIN(26) & 
		DIN(8) & DIN(20) & DIN(41) & DIN(10) & DIN(50) & DIN(20) & DIN(48) & DIN(8);

	inst5_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init5,
			DOUT        => DOUT(5)
		);
	init5 <= DIN(37) & DIN(41) & DIN(60) & DIN(27) & DIN(46) & DIN(4) & DIN(23) & DIN(50) & 
		DIN(16) & DIN(25) & DIN(49) & DIN(59) & DIN(20) & DIN(58) & DIN(19) & DIN(4) & 
		DIN(8) & DIN(51) & DIN(37) & DIN(17) & DIN(62) & DIN(12) & DIN(62) & DIN(42) & 
		DIN(41) & DIN(26) & DIN(26) & DIN(16) & DIN(35) & DIN(38) & DIN(41) & DIN(9) & 
		DIN(58) & DIN(56) & DIN(4) & DIN(60) & DIN(52) & DIN(62) & DIN(1) & DIN(20) & 
		DIN(5) & DIN(54) & DIN(40) & DIN(16) & DIN(50) & DIN(32) & DIN(30) & DIN(55) & 
		DIN(52) & DIN(25) & DIN(19) & DIN(20) & DIN(35) & DIN(35) & DIN(16) & DIN(25) & 
		DIN(55) & DIN(51) & DIN(39) & DIN(25) & DIN(44) & DIN(49) & DIN(5) & DIN(62);

	inst6_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init6,
			DOUT        => DOUT(6)
		);
	init6 <= DIN(59) & DIN(60) & DIN(0) & DIN(60) & DIN(49) & DIN(38) & DIN(12) & DIN(12) & 
		DIN(49) & DIN(5) & DIN(36) & DIN(23) & DIN(44) & DIN(0) & DIN(21) & DIN(6) & 
		DIN(44) & DIN(45) & DIN(17) & DIN(19) & DIN(25) & DIN(23) & DIN(14) & DIN(9) & 
		DIN(37) & DIN(60) & DIN(30) & DIN(4) & DIN(41) & DIN(0) & DIN(34) & DIN(63) & 
		DIN(10) & DIN(26) & DIN(48) & DIN(37) & DIN(53) & DIN(7) & DIN(40) & DIN(25) & 
		DIN(24) & DIN(36) & DIN(2) & DIN(38) & DIN(20) & DIN(40) & DIN(53) & DIN(24) & 
		DIN(20) & DIN(58) & DIN(5) & DIN(16) & DIN(50) & DIN(18) & DIN(42) & DIN(32) & 
		DIN(19) & DIN(30) & DIN(34) & DIN(41) & DIN(53) & DIN(8) & DIN(15) & DIN(37);

	inst7_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init7,
			DOUT        => DOUT(7)
		);
	init7 <= DIN(31) & DIN(52) & DIN(1) & DIN(22) & DIN(37) & DIN(17) & DIN(9) & DIN(55) & 
		DIN(29) & DIN(56) & DIN(10) & DIN(37) & DIN(24) & DIN(2) & DIN(57) & DIN(5) & 
		DIN(44) & DIN(18) & DIN(22) & DIN(45) & DIN(24) & DIN(39) & DIN(3) & DIN(36) & 
		DIN(36) & DIN(7) & DIN(1) & DIN(53) & DIN(35) & DIN(54) & DIN(20) & DIN(9) & 
		DIN(15) & DIN(47) & DIN(13) & DIN(45) & DIN(52) & DIN(17) & DIN(45) & DIN(56) & 
		DIN(31) & DIN(7) & DIN(44) & DIN(19) & DIN(22) & DIN(39) & DIN(47) & DIN(63) & 
		DIN(58) & DIN(47) & DIN(41) & DIN(52) & DIN(3) & DIN(60) & DIN(34) & DIN(47) & 
		DIN(35) & DIN(11) & DIN(33) & DIN(26) & DIN(38) & DIN(36) & DIN(60) & DIN(34);

	inst8_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init8,
			DOUT        => DOUT(8)
		);
	init8 <= DIN(63) & DIN(1) & DIN(6) & DIN(17) & DIN(35) & DIN(5) & DIN(13) & DIN(25) & 
		DIN(36) & DIN(62) & DIN(17) & DIN(24) & DIN(20) & DIN(26) & DIN(22) & DIN(34) & 
		DIN(0) & DIN(11) & DIN(57) & DIN(12) & DIN(25) & DIN(19) & DIN(18) & DIN(45) & 
		DIN(25) & DIN(42) & DIN(23) & DIN(12) & DIN(26) & DIN(40) & DIN(3) & DIN(46) & 
		DIN(30) & DIN(0) & DIN(3) & DIN(9) & DIN(33) & DIN(15) & DIN(8) & DIN(11) & 
		DIN(42) & DIN(55) & DIN(2) & DIN(50) & DIN(25) & DIN(10) & DIN(40) & DIN(52) & 
		DIN(50) & DIN(38) & DIN(58) & DIN(44) & DIN(58) & DIN(40) & DIN(22) & DIN(13) & 
		DIN(16) & DIN(46) & DIN(9) & DIN(44) & DIN(10) & DIN(2) & DIN(42) & DIN(21);

	inst9_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init9,
			DOUT        => DOUT(9)
		);
	init9 <= DIN(60) & DIN(36) & DIN(27) & DIN(7) & DIN(42) & DIN(12) & DIN(60) & DIN(57) & 
		DIN(61) & DIN(50) & DIN(14) & DIN(62) & DIN(12) & DIN(41) & DIN(13) & DIN(63) & 
		DIN(39) & DIN(27) & DIN(3) & DIN(62) & DIN(61) & DIN(33) & DIN(43) & DIN(1) & 
		DIN(63) & DIN(36) & DIN(62) & DIN(42) & DIN(54) & DIN(15) & DIN(39) & DIN(53) & 
		DIN(58) & DIN(14) & DIN(11) & DIN(49) & DIN(15) & DIN(9) & DIN(43) & DIN(62) & 
		DIN(38) & DIN(37) & DIN(49) & DIN(13) & DIN(1) & DIN(50) & DIN(60) & DIN(41) & 
		DIN(30) & DIN(34) & DIN(19) & DIN(60) & DIN(33) & DIN(7) & DIN(2) & DIN(21) & 
		DIN(46) & DIN(47) & DIN(3) & DIN(1) & DIN(21) & DIN(25) & DIN(42) & DIN(9);

	inst10_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init10,
			DOUT        => DOUT(10)
		);
	init10 <= DIN(12) & DIN(30) & DIN(23) & DIN(48) & DIN(31) & DIN(10) & DIN(9) & DIN(35) & 
		DIN(57) & DIN(6) & DIN(2) & DIN(47) & DIN(45) & DIN(46) & DIN(33) & DIN(14) & 
		DIN(22) & DIN(5) & DIN(62) & DIN(61) & DIN(54) & DIN(22) & DIN(50) & DIN(37) & 
		DIN(22) & DIN(1) & DIN(24) & DIN(21) & DIN(14) & DIN(43) & DIN(63) & DIN(27) & 
		DIN(62) & DIN(13) & DIN(39) & DIN(60) & DIN(17) & DIN(3) & DIN(33) & DIN(10) & 
		DIN(24) & DIN(20) & DIN(14) & DIN(31) & DIN(23) & DIN(27) & DIN(16) & DIN(25) & 
		DIN(15) & DIN(39) & DIN(11) & DIN(16) & DIN(0) & DIN(48) & DIN(13) & DIN(1) & 
		DIN(51) & DIN(44) & DIN(22) & DIN(50) & DIN(45) & DIN(50) & DIN(52) & DIN(2);

	inst11_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init11,
			DOUT        => DOUT(11)
		);
	init11 <= DIN(40) & DIN(42) & DIN(59) & DIN(44) & DIN(40) & DIN(30) & DIN(57) & DIN(59) & 
		DIN(12) & DIN(36) & DIN(38) & DIN(43) & DIN(46) & DIN(26) & DIN(19) & DIN(28) & 
		DIN(8) & DIN(1) & DIN(13) & DIN(36) & DIN(29) & DIN(43) & DIN(34) & DIN(7) & 
		DIN(32) & DIN(37) & DIN(47) & DIN(19) & DIN(30) & DIN(45) & DIN(55) & DIN(60) & 
		DIN(2) & DIN(29) & DIN(51) & DIN(44) & DIN(17) & DIN(21) & DIN(21) & DIN(33) & 
		DIN(53) & DIN(11) & DIN(24) & DIN(18) & DIN(18) & DIN(18) & DIN(15) & DIN(35) & 
		DIN(36) & DIN(33) & DIN(2) & DIN(22) & DIN(11) & DIN(61) & DIN(24) & DIN(13) & 
		DIN(7) & DIN(1) & DIN(27) & DIN(33) & DIN(43) & DIN(26) & DIN(9) & DIN(22);

	inst12_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init12,
			DOUT        => DOUT(12)
		);
	init12 <= DIN(19) & DIN(28) & DIN(43) & DIN(50) & DIN(24) & DIN(15) & DIN(42) & DIN(6) & 
		DIN(28) & DIN(12) & DIN(48) & DIN(21) & DIN(22) & DIN(56) & DIN(7) & DIN(27) & 
		DIN(13) & DIN(29) & DIN(7) & DIN(13) & DIN(34) & DIN(13) & DIN(32) & DIN(3) & 
		DIN(27) & DIN(53) & DIN(49) & DIN(13) & DIN(39) & DIN(10) & DIN(34) & DIN(32) & 
		DIN(4) & DIN(27) & DIN(8) & DIN(17) & DIN(51) & DIN(30) & DIN(22) & DIN(7) & 
		DIN(54) & DIN(56) & DIN(14) & DIN(58) & DIN(43) & DIN(42) & DIN(20) & DIN(0) & 
		DIN(59) & DIN(58) & DIN(44) & DIN(31) & DIN(50) & DIN(43) & DIN(18) & DIN(13) & 
		DIN(14) & DIN(38) & DIN(43) & DIN(7) & DIN(6) & DIN(6) & DIN(24) & DIN(51);

	inst13_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init13,
			DOUT        => DOUT(13)
		);
	init13 <= DIN(0) & DIN(59) & DIN(41) & DIN(10) & DIN(31) & DIN(51) & DIN(60) & DIN(17) & 
		DIN(15) & DIN(10) & DIN(45) & DIN(30) & DIN(48) & DIN(25) & DIN(23) & DIN(28) & 
		DIN(34) & DIN(28) & DIN(57) & DIN(0) & DIN(55) & DIN(15) & DIN(37) & DIN(46) & 
		DIN(49) & DIN(40) & DIN(43) & DIN(33) & DIN(13) & DIN(54) & DIN(49) & DIN(53) & 
		DIN(27) & DIN(54) & DIN(14) & DIN(14) & DIN(35) & DIN(50) & DIN(35) & DIN(49) & 
		DIN(26) & DIN(20) & DIN(7) & DIN(19) & DIN(55) & DIN(59) & DIN(35) & DIN(34) & 
		DIN(37) & DIN(42) & DIN(26) & DIN(9) & DIN(29) & DIN(61) & DIN(2) & DIN(16) & 
		DIN(27) & DIN(53) & DIN(48) & DIN(24) & DIN(26) & DIN(58) & DIN(39) & DIN(13);

	inst14_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init14,
			DOUT        => DOUT(14)
		);
	init14 <= DIN(1) & DIN(9) & DIN(2) & DIN(32) & DIN(46) & DIN(47) & DIN(48) & DIN(46) & 
		DIN(29) & DIN(59) & DIN(23) & DIN(21) & DIN(38) & DIN(51) & DIN(9) & DIN(33) & 
		DIN(30) & DIN(7) & DIN(10) & DIN(40) & DIN(53) & DIN(13) & DIN(10) & DIN(63) & 
		DIN(49) & DIN(8) & DIN(3) & DIN(22) & DIN(61) & DIN(22) & DIN(32) & DIN(33) & 
		DIN(27) & DIN(18) & DIN(48) & DIN(0) & DIN(18) & DIN(53) & DIN(23) & DIN(8) & 
		DIN(21) & DIN(36) & DIN(12) & DIN(4) & DIN(20) & DIN(2) & DIN(23) & DIN(54) & 
		DIN(18) & DIN(61) & DIN(30) & DIN(53) & DIN(27) & DIN(2) & DIN(60) & DIN(27) & 
		DIN(10) & DIN(45) & DIN(54) & DIN(28) & DIN(59) & DIN(13) & DIN(49) & DIN(26);

	inst15_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init15,
			DOUT        => DOUT(15)
		);
	init15 <= DIN(42) & DIN(39) & DIN(21) & DIN(2) & DIN(57) & DIN(63) & DIN(58) & DIN(46) & 
		DIN(42) & DIN(60) & DIN(36) & DIN(53) & DIN(44) & DIN(10) & DIN(49) & DIN(10) & 
		DIN(13) & DIN(41) & DIN(63) & DIN(37) & DIN(6) & DIN(39) & DIN(6) & DIN(5) & 
		DIN(45) & DIN(46) & DIN(15) & DIN(28) & DIN(11) & DIN(37) & DIN(21) & DIN(40) & 
		DIN(45) & DIN(22) & DIN(8) & DIN(11) & DIN(21) & DIN(62) & DIN(9) & DIN(52) & 
		DIN(16) & DIN(26) & DIN(4) & DIN(34) & DIN(61) & DIN(8) & DIN(11) & DIN(40) & 
		DIN(34) & DIN(24) & DIN(31) & DIN(1) & DIN(57) & DIN(24) & DIN(54) & DIN(17) & 
		DIN(35) & DIN(41) & DIN(7) & DIN(35) & DIN(56) & DIN(63) & DIN(32) & DIN(34);

	inst16_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init16,
			DOUT        => DOUT(16)
		);
	init16 <= DIN(17) & DIN(47) & DIN(29) & DIN(41) & DIN(14) & DIN(41) & DIN(13) & DIN(24) & 
		DIN(31) & DIN(25) & DIN(55) & DIN(23) & DIN(30) & DIN(22) & DIN(10) & DIN(17) & 
		DIN(30) & DIN(57) & DIN(40) & DIN(28) & DIN(20) & DIN(10) & DIN(12) & DIN(57) & 
		DIN(58) & DIN(36) & DIN(29) & DIN(15) & DIN(3) & DIN(40) & DIN(42) & DIN(40) & 
		DIN(33) & DIN(52) & DIN(27) & DIN(54) & DIN(10) & DIN(52) & DIN(32) & DIN(7) & 
		DIN(59) & DIN(33) & DIN(13) & DIN(13) & DIN(55) & DIN(17) & DIN(40) & DIN(2) & 
		DIN(37) & DIN(30) & DIN(16) & DIN(27) & DIN(16) & DIN(39) & DIN(28) & DIN(43) & 
		DIN(33) & DIN(53) & DIN(36) & DIN(27) & DIN(7) & DIN(54) & DIN(12) & DIN(43);

	inst17_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init17,
			DOUT        => DOUT(17)
		);
	init17 <= DIN(32) & DIN(54) & DIN(23) & DIN(38) & DIN(42) & DIN(3) & DIN(4) & DIN(38) & 
		DIN(1) & DIN(16) & DIN(0) & DIN(39) & DIN(43) & DIN(2) & DIN(27) & DIN(29) & 
		DIN(36) & DIN(40) & DIN(7) & DIN(29) & DIN(19) & DIN(7) & DIN(32) & DIN(15) & 
		DIN(38) & DIN(29) & DIN(52) & DIN(33) & DIN(47) & DIN(35) & DIN(40) & DIN(58) & 
		DIN(12) & DIN(19) & DIN(34) & DIN(4) & DIN(2) & DIN(51) & DIN(38) & DIN(25) & 
		DIN(37) & DIN(61) & DIN(12) & DIN(13) & DIN(30) & DIN(51) & DIN(22) & DIN(7) & 
		DIN(21) & DIN(0) & DIN(60) & DIN(4) & DIN(33) & DIN(3) & DIN(27) & DIN(5) & 
		DIN(46) & DIN(17) & DIN(57) & DIN(53) & DIN(23) & DIN(20) & DIN(23) & DIN(8);

	inst18_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init18,
			DOUT        => DOUT(18)
		);
	init18 <= DIN(2) & DIN(34) & DIN(0) & DIN(16) & DIN(43) & DIN(7) & DIN(55) & DIN(52) & 
		DIN(47) & DIN(21) & DIN(19) & DIN(61) & DIN(30) & DIN(54) & DIN(15) & DIN(13) & 
		DIN(26) & DIN(49) & DIN(60) & DIN(38) & DIN(63) & DIN(45) & DIN(13) & DIN(42) & 
		DIN(3) & DIN(28) & DIN(28) & DIN(53) & DIN(63) & DIN(22) & DIN(8) & DIN(50) & 
		DIN(54) & DIN(57) & DIN(24) & DIN(55) & DIN(24) & DIN(34) & DIN(32) & DIN(50) & 
		DIN(55) & DIN(29) & DIN(46) & DIN(17) & DIN(28) & DIN(29) & DIN(17) & DIN(52) & 
		DIN(50) & DIN(14) & DIN(25) & DIN(21) & DIN(42) & DIN(48) & DIN(13) & DIN(13) & 
		DIN(29) & DIN(6) & DIN(45) & DIN(13) & DIN(32) & DIN(15) & DIN(25) & DIN(63);

	inst19_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init19,
			DOUT        => DOUT(19)
		);
	init19 <= DIN(56) & DIN(53) & DIN(26) & DIN(9) & DIN(58) & DIN(37) & DIN(18) & DIN(7) & 
		DIN(50) & DIN(61) & DIN(21) & DIN(15) & DIN(19) & DIN(43) & DIN(35) & DIN(30) & 
		DIN(47) & DIN(13) & DIN(60) & DIN(49) & DIN(21) & DIN(16) & DIN(1) & DIN(42) & 
		DIN(63) & DIN(3) & DIN(59) & DIN(20) & DIN(4) & DIN(58) & DIN(54) & DIN(47) & 
		DIN(59) & DIN(53) & DIN(55) & DIN(50) & DIN(51) & DIN(21) & DIN(50) & DIN(35) & 
		DIN(41) & DIN(42) & DIN(43) & DIN(53) & DIN(59) & DIN(22) & DIN(34) & DIN(62) & 
		DIN(56) & DIN(43) & DIN(47) & DIN(43) & DIN(17) & DIN(62) & DIN(47) & DIN(43) & 
		DIN(63) & DIN(1) & DIN(30) & DIN(21) & DIN(62) & DIN(1) & DIN(56) & DIN(9);

	inst20_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init20,
			DOUT        => DOUT(20)
		);
	init20 <= DIN(43) & DIN(28) & DIN(12) & DIN(33) & DIN(47) & DIN(25) & DIN(7) & DIN(19) & 
		DIN(30) & DIN(35) & DIN(17) & DIN(45) & DIN(56) & DIN(52) & DIN(13) & DIN(21) & 
		DIN(9) & DIN(43) & DIN(8) & DIN(45) & DIN(28) & DIN(37) & DIN(53) & DIN(43) & 
		DIN(50) & DIN(10) & DIN(54) & DIN(48) & DIN(52) & DIN(17) & DIN(48) & DIN(9) & 
		DIN(44) & DIN(51) & DIN(26) & DIN(28) & DIN(58) & DIN(36) & DIN(2) & DIN(49) & 
		DIN(42) & DIN(29) & DIN(31) & DIN(35) & DIN(43) & DIN(34) & DIN(13) & DIN(28) & 
		DIN(15) & DIN(34) & DIN(56) & DIN(49) & DIN(51) & DIN(43) & DIN(53) & DIN(2) & 
		DIN(21) & DIN(36) & DIN(0) & DIN(43) & DIN(37) & DIN(61) & DIN(47) & DIN(16);

	inst21_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init21,
			DOUT        => DOUT(21)
		);
	init21 <= DIN(48) & DIN(38) & DIN(35) & DIN(8) & DIN(22) & DIN(17) & DIN(13) & DIN(3) & 
		DIN(43) & DIN(47) & DIN(59) & DIN(38) & DIN(0) & DIN(13) & DIN(40) & DIN(36) & 
		DIN(61) & DIN(14) & DIN(26) & DIN(26) & DIN(44) & DIN(5) & DIN(4) & DIN(31) & 
		DIN(57) & DIN(26) & DIN(27) & DIN(26) & DIN(11) & DIN(60) & DIN(49) & DIN(40) & 
		DIN(15) & DIN(17) & DIN(58) & DIN(19) & DIN(38) & DIN(30) & DIN(7) & DIN(5) & 
		DIN(47) & DIN(46) & DIN(61) & DIN(27) & DIN(16) & DIN(26) & DIN(10) & DIN(35) & 
		DIN(34) & DIN(21) & DIN(21) & DIN(12) & DIN(12) & DIN(42) & DIN(4) & DIN(30) & 
		DIN(14) & DIN(31) & DIN(41) & DIN(35) & DIN(44) & DIN(31) & DIN(45) & DIN(60);

	inst22_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init22,
			DOUT        => DOUT(22)
		);
	init22 <= DIN(11) & DIN(6) & DIN(11) & DIN(48) & DIN(45) & DIN(43) & DIN(55) & DIN(41) & 
		DIN(59) & DIN(36) & DIN(7) & DIN(19) & DIN(39) & DIN(55) & DIN(57) & DIN(46) & 
		DIN(18) & DIN(13) & DIN(48) & DIN(19) & DIN(34) & DIN(63) & DIN(61) & DIN(27) & 
		DIN(11) & DIN(52) & DIN(46) & DIN(49) & DIN(24) & DIN(7) & DIN(27) & DIN(27) & 
		DIN(24) & DIN(32) & DIN(57) & DIN(4) & DIN(48) & DIN(19) & DIN(33) & DIN(40) & 
		DIN(60) & DIN(16) & DIN(26) & DIN(57) & DIN(37) & DIN(43) & DIN(62) & DIN(63) & 
		DIN(43) & DIN(49) & DIN(22) & DIN(7) & DIN(52) & DIN(8) & DIN(44) & DIN(26) & 
		DIN(28) & DIN(39) & DIN(21) & DIN(61) & DIN(46) & DIN(59) & DIN(34) & DIN(20);

	inst23_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init23,
			DOUT        => DOUT(23)
		);
	init23 <= DIN(6) & DIN(61) & DIN(0) & DIN(35) & DIN(17) & DIN(3) & DIN(13) & DIN(12) & 
		DIN(16) & DIN(61) & DIN(19) & DIN(14) & DIN(26) & DIN(5) & DIN(2) & DIN(33) & 
		DIN(50) & DIN(27) & DIN(47) & DIN(51) & DIN(27) & DIN(52) & DIN(45) & DIN(9) & 
		DIN(12) & DIN(53) & DIN(39) & DIN(56) & DIN(30) & DIN(4) & DIN(32) & DIN(35) & 
		DIN(44) & DIN(61) & DIN(22) & DIN(5) & DIN(50) & DIN(16) & DIN(57) & DIN(2) & 
		DIN(34) & DIN(14) & DIN(11) & DIN(57) & DIN(18) & DIN(39) & DIN(50) & DIN(63) & 
		DIN(0) & DIN(58) & DIN(6) & DIN(18) & DIN(40) & DIN(56) & DIN(34) & DIN(20) & 
		DIN(22) & DIN(35) & DIN(23) & DIN(59) & DIN(24) & DIN(35) & DIN(13) & DIN(39);

	inst24_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init24,
			DOUT        => DOUT(24)
		);
	init24 <= DIN(18) & DIN(31) & DIN(54) & DIN(48) & DIN(50) & DIN(62) & DIN(15) & DIN(38) & 
		DIN(13) & DIN(44) & DIN(26) & DIN(62) & DIN(27) & DIN(18) & DIN(61) & DIN(22) & 
		DIN(26) & DIN(56) & DIN(36) & DIN(48) & DIN(14) & DIN(55) & DIN(8) & DIN(5) & 
		DIN(60) & DIN(60) & DIN(43) & DIN(53) & DIN(10) & DIN(6) & DIN(28) & DIN(34) & 
		DIN(45) & DIN(55) & DIN(32) & DIN(12) & DIN(49) & DIN(35) & DIN(11) & DIN(14) & 
		DIN(17) & DIN(8) & DIN(1) & DIN(5) & DIN(56) & DIN(4) & DIN(50) & DIN(42) & 
		DIN(42) & DIN(45) & DIN(39) & DIN(9) & DIN(58) & DIN(12) & DIN(26) & DIN(7) & 
		DIN(49) & DIN(37) & DIN(25) & DIN(40) & DIN(25) & DIN(36) & DIN(1) & DIN(33);

	inst25_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init25,
			DOUT        => DOUT(25)
		);
	init25 <= DIN(35) & DIN(29) & DIN(41) & DIN(48) & DIN(49) & DIN(27) & DIN(33) & DIN(23) & 
		DIN(31) & DIN(50) & DIN(51) & DIN(19) & DIN(52) & DIN(14) & DIN(22) & DIN(29) & 
		DIN(53) & DIN(6) & DIN(32) & DIN(27) & DIN(17) & DIN(53) & DIN(62) & DIN(50) & 
		DIN(36) & DIN(26) & DIN(55) & DIN(3) & DIN(4) & DIN(51) & DIN(42) & DIN(51) & 
		DIN(44) & DIN(14) & DIN(14) & DIN(26) & DIN(60) & DIN(47) & DIN(36) & DIN(12) & 
		DIN(61) & DIN(37) & DIN(60) & DIN(23) & DIN(24) & DIN(16) & DIN(61) & DIN(26) & 
		DIN(53) & DIN(43) & DIN(29) & DIN(31) & DIN(17) & DIN(36) & DIN(59) & DIN(33) & 
		DIN(22) & DIN(4) & DIN(24) & DIN(16) & DIN(7) & DIN(28) & DIN(37) & DIN(18);

	inst26_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init26,
			DOUT        => DOUT(26)
		);
	init26 <= DIN(23) & DIN(55) & DIN(4) & DIN(13) & DIN(4) & DIN(60) & DIN(20) & DIN(37) & 
		DIN(24) & DIN(57) & DIN(46) & DIN(35) & DIN(15) & DIN(19) & DIN(16) & DIN(60) & 
		DIN(22) & DIN(47) & DIN(29) & DIN(45) & DIN(3) & DIN(12) & DIN(26) & DIN(51) & 
		DIN(49) & DIN(13) & DIN(4) & DIN(49) & DIN(18) & DIN(9) & DIN(47) & DIN(10) & 
		DIN(51) & DIN(8) & DIN(57) & DIN(31) & DIN(36) & DIN(27) & DIN(54) & DIN(52) & 
		DIN(42) & DIN(27) & DIN(19) & DIN(18) & DIN(60) & DIN(33) & DIN(31) & DIN(41) & 
		DIN(44) & DIN(17) & DIN(19) & DIN(15) & DIN(27) & DIN(12) & DIN(47) & DIN(0) & 
		DIN(59) & DIN(58) & DIN(1) & DIN(8) & DIN(22) & DIN(39) & DIN(17) & DIN(19);

	inst27_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init27,
			DOUT        => DOUT(27)
		);
	init27 <= DIN(46) & DIN(5) & DIN(19) & DIN(54) & DIN(25) & DIN(21) & DIN(62) & DIN(33) & 
		DIN(47) & DIN(62) & DIN(46) & DIN(22) & DIN(3) & DIN(55) & DIN(17) & DIN(44) & 
		DIN(24) & DIN(6) & DIN(4) & DIN(28) & DIN(9) & DIN(47) & DIN(49) & DIN(9) & 
		DIN(49) & DIN(54) & DIN(39) & DIN(31) & DIN(61) & DIN(17) & DIN(40) & DIN(56) & 
		DIN(44) & DIN(62) & DIN(55) & DIN(56) & DIN(38) & DIN(0) & DIN(51) & DIN(25) & 
		DIN(59) & DIN(55) & DIN(4) & DIN(22) & DIN(31) & DIN(11) & DIN(40) & DIN(59) & 
		DIN(60) & DIN(21) & DIN(43) & DIN(0) & DIN(62) & DIN(59) & DIN(34) & DIN(17) & 
		DIN(56) & DIN(22) & DIN(55) & DIN(5) & DIN(37) & DIN(42) & DIN(1) & DIN(52);

	inst28_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init28,
			DOUT        => DOUT(28)
		);
	init28 <= DIN(62) & DIN(44) & DIN(30) & DIN(58) & DIN(27) & DIN(13) & DIN(13) & DIN(5) & 
		DIN(42) & DIN(37) & DIN(2) & DIN(62) & DIN(22) & DIN(21) & DIN(16) & DIN(41) & 
		DIN(23) & DIN(32) & DIN(42) & DIN(47) & DIN(52) & DIN(34) & DIN(25) & DIN(52) & 
		DIN(50) & DIN(8) & DIN(56) & DIN(31) & DIN(1) & DIN(44) & DIN(61) & DIN(4) & 
		DIN(17) & DIN(17) & DIN(45) & DIN(22) & DIN(34) & DIN(40) & DIN(2) & DIN(44) & 
		DIN(14) & DIN(45) & DIN(46) & DIN(45) & DIN(62) & DIN(47) & DIN(63) & DIN(40) & 
		DIN(44) & DIN(8) & DIN(22) & DIN(0) & DIN(48) & DIN(16) & DIN(59) & DIN(19) & 
		DIN(7) & DIN(12) & DIN(34) & DIN(61) & DIN(27) & DIN(44) & DIN(22) & DIN(59);

	inst29_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init29,
			DOUT        => DOUT(29)
		);
	init29 <= DIN(31) & DIN(42) & DIN(56) & DIN(57) & DIN(18) & DIN(20) & DIN(44) & DIN(20) & 
		DIN(46) & DIN(12) & DIN(53) & DIN(2) & DIN(6) & DIN(34) & DIN(36) & DIN(6) & 
		DIN(58) & DIN(42) & DIN(8) & DIN(16) & DIN(7) & DIN(31) & DIN(54) & DIN(14) & 
		DIN(14) & DIN(61) & DIN(63) & DIN(45) & DIN(55) & DIN(18) & DIN(36) & DIN(38) & 
		DIN(24) & DIN(36) & DIN(13) & DIN(61) & DIN(38) & DIN(32) & DIN(31) & DIN(43) & 
		DIN(5) & DIN(18) & DIN(30) & DIN(0) & DIN(40) & DIN(57) & DIN(62) & DIN(42) & 
		DIN(35) & DIN(40) & DIN(26) & DIN(57) & DIN(17) & DIN(57) & DIN(15) & DIN(33) & 
		DIN(5) & DIN(44) & DIN(8) & DIN(17) & DIN(58) & DIN(0) & DIN(25) & DIN(27);

	inst30_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init30,
			DOUT        => DOUT(30)
		);
	init30 <= DIN(55) & DIN(29) & DIN(33) & DIN(60) & DIN(35) & DIN(3) & DIN(62) & DIN(6) & 
		DIN(4) & DIN(42) & DIN(33) & DIN(63) & DIN(41) & DIN(17) & DIN(39) & DIN(60) & 
		DIN(46) & DIN(26) & DIN(4) & DIN(14) & DIN(20) & DIN(46) & DIN(18) & DIN(20) & 
		DIN(19) & DIN(1) & DIN(28) & DIN(9) & DIN(55) & DIN(4) & DIN(53) & DIN(59) & 
		DIN(58) & DIN(30) & DIN(62) & DIN(29) & DIN(62) & DIN(19) & DIN(36) & DIN(5) & 
		DIN(1) & DIN(16) & DIN(24) & DIN(45) & DIN(34) & DIN(12) & DIN(56) & DIN(32) & 
		DIN(6) & DIN(21) & DIN(60) & DIN(0) & DIN(27) & DIN(17) & DIN(56) & DIN(10) & 
		DIN(10) & DIN(24) & DIN(20) & DIN(60) & DIN(10) & DIN(23) & DIN(61) & DIN(29);

	inst31_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init31,
			DOUT        => DOUT(31)
		);
	init31 <= DIN(51) & DIN(47) & DIN(35) & DIN(27) & DIN(9) & DIN(62) & DIN(36) & DIN(57) & 
		DIN(15) & DIN(10) & DIN(10) & DIN(29) & DIN(19) & DIN(30) & DIN(40) & DIN(34) & 
		DIN(55) & DIN(30) & DIN(18) & DIN(15) & DIN(61) & DIN(20) & DIN(14) & DIN(24) & 
		DIN(4) & DIN(39) & DIN(55) & DIN(2) & DIN(21) & DIN(5) & DIN(19) & DIN(24) & 
		DIN(38) & DIN(37) & DIN(55) & DIN(16) & DIN(46) & DIN(26) & DIN(47) & DIN(50) & 
		DIN(55) & DIN(44) & DIN(52) & DIN(49) & DIN(39) & DIN(10) & DIN(15) & DIN(40) & 
		DIN(33) & DIN(62) & DIN(1) & DIN(37) & DIN(16) & DIN(38) & DIN(33) & DIN(1) & 
		DIN(18) & DIN(50) & DIN(47) & DIN(61) & DIN(31) & DIN(46) & DIN(33) & DIN(22);

	inst32_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init32,
			DOUT        => DOUT(32)
		);
	init32 <= DIN(54) & DIN(36) & DIN(58) & DIN(34) & DIN(22) & DIN(37) & DIN(2) & DIN(63) & 
		DIN(3) & DIN(18) & DIN(11) & DIN(60) & DIN(44) & DIN(22) & DIN(25) & DIN(63) & 
		DIN(48) & DIN(0) & DIN(28) & DIN(39) & DIN(58) & DIN(24) & DIN(6) & DIN(22) & 
		DIN(11) & DIN(4) & DIN(5) & DIN(13) & DIN(0) & DIN(7) & DIN(29) & DIN(20) & 
		DIN(14) & DIN(21) & DIN(31) & DIN(23) & DIN(34) & DIN(48) & DIN(51) & DIN(7) & 
		DIN(38) & DIN(53) & DIN(35) & DIN(45) & DIN(38) & DIN(25) & DIN(34) & DIN(9) & 
		DIN(6) & DIN(4) & DIN(32) & DIN(36) & DIN(13) & DIN(2) & DIN(17) & DIN(62) & 
		DIN(4) & DIN(61) & DIN(48) & DIN(44) & DIN(57) & DIN(8) & DIN(52) & DIN(55);

	inst33_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init33,
			DOUT        => DOUT(33)
		);
	init33 <= DIN(46) & DIN(56) & DIN(31) & DIN(16) & DIN(36) & DIN(33) & DIN(30) & DIN(41) & 
		DIN(25) & DIN(15) & DIN(40) & DIN(51) & DIN(23) & DIN(12) & DIN(15) & DIN(29) & 
		DIN(52) & DIN(62) & DIN(47) & DIN(25) & DIN(25) & DIN(23) & DIN(23) & DIN(51) & 
		DIN(47) & DIN(21) & DIN(42) & DIN(46) & DIN(14) & DIN(57) & DIN(52) & DIN(30) & 
		DIN(19) & DIN(62) & DIN(50) & DIN(59) & DIN(8) & DIN(14) & DIN(1) & DIN(38) & 
		DIN(56) & DIN(27) & DIN(35) & DIN(57) & DIN(24) & DIN(17) & DIN(46) & DIN(27) & 
		DIN(37) & DIN(24) & DIN(2) & DIN(38) & DIN(40) & DIN(1) & DIN(9) & DIN(1) & 
		DIN(7) & DIN(49) & DIN(58) & DIN(48) & DIN(37) & DIN(54) & DIN(43) & DIN(24);

	inst34_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init34,
			DOUT        => DOUT(34)
		);
	init34 <= DIN(27) & DIN(53) & DIN(35) & DIN(57) & DIN(32) & DIN(10) & DIN(8) & DIN(30) & 
		DIN(32) & DIN(15) & DIN(59) & DIN(6) & DIN(58) & DIN(57) & DIN(10) & DIN(15) & 
		DIN(16) & DIN(29) & DIN(11) & DIN(26) & DIN(8) & DIN(20) & DIN(51) & DIN(16) & 
		DIN(18) & DIN(11) & DIN(7) & DIN(40) & DIN(61) & DIN(22) & DIN(22) & DIN(34) & 
		DIN(21) & DIN(25) & DIN(49) & DIN(2) & DIN(42) & DIN(57) & DIN(35) & DIN(26) & 
		DIN(20) & DIN(2) & DIN(60) & DIN(43) & DIN(41) & DIN(44) & DIN(3) & DIN(54) & 
		DIN(21) & DIN(55) & DIN(38) & DIN(56) & DIN(2) & DIN(40) & DIN(8) & DIN(41) & 
		DIN(14) & DIN(49) & DIN(18) & DIN(27) & DIN(1) & DIN(61) & DIN(49) & DIN(19);

	inst35_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init35,
			DOUT        => DOUT(35)
		);
	init35 <= DIN(29) & DIN(10) & DIN(42) & DIN(42) & DIN(42) & DIN(33) & DIN(2) & DIN(3) & 
		DIN(52) & DIN(15) & DIN(0) & DIN(63) & DIN(60) & DIN(8) & DIN(19) & DIN(7) & 
		DIN(47) & DIN(53) & DIN(13) & DIN(29) & DIN(18) & DIN(12) & DIN(20) & DIN(62) & 
		DIN(27) & DIN(41) & DIN(54) & DIN(4) & DIN(6) & DIN(2) & DIN(32) & DIN(51) & 
		DIN(32) & DIN(8) & DIN(40) & DIN(38) & DIN(45) & DIN(51) & DIN(3) & DIN(52) & 
		DIN(19) & DIN(56) & DIN(44) & DIN(53) & DIN(24) & DIN(29) & DIN(58) & DIN(18) & 
		DIN(35) & DIN(1) & DIN(8) & DIN(20) & DIN(49) & DIN(43) & DIN(8) & DIN(23) & 
		DIN(35) & DIN(52) & DIN(35) & DIN(19) & DIN(34) & DIN(24) & DIN(11) & DIN(57);

	inst36_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init36,
			DOUT        => DOUT(36)
		);
	init36 <= DIN(20) & DIN(14) & DIN(45) & DIN(26) & DIN(41) & DIN(15) & DIN(43) & DIN(14) & 
		DIN(15) & DIN(7) & DIN(30) & DIN(56) & DIN(12) & DIN(15) & DIN(36) & DIN(21) & 
		DIN(52) & DIN(30) & DIN(31) & DIN(24) & DIN(21) & DIN(48) & DIN(16) & DIN(18) & 
		DIN(49) & DIN(61) & DIN(29) & DIN(15) & DIN(60) & DIN(51) & DIN(2) & DIN(58) & 
		DIN(37) & DIN(30) & DIN(46) & DIN(26) & DIN(0) & DIN(36) & DIN(48) & DIN(22) & 
		DIN(58) & DIN(15) & DIN(20) & DIN(55) & DIN(27) & DIN(5) & DIN(54) & DIN(27) & 
		DIN(9) & DIN(46) & DIN(8) & DIN(2) & DIN(63) & DIN(19) & DIN(53) & DIN(34) & 
		DIN(0) & DIN(41) & DIN(13) & DIN(2) & DIN(14) & DIN(36) & DIN(12) & DIN(10);

	inst37_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init37,
			DOUT        => DOUT(37)
		);
	init37 <= DIN(34) & DIN(27) & DIN(51) & DIN(4) & DIN(30) & DIN(48) & DIN(39) & DIN(17) & 
		DIN(2) & DIN(24) & DIN(50) & DIN(45) & DIN(50) & DIN(34) & DIN(4) & DIN(26) & 
		DIN(33) & DIN(34) & DIN(33) & DIN(24) & DIN(13) & DIN(54) & DIN(52) & DIN(13) & 
		DIN(0) & DIN(46) & DIN(44) & DIN(34) & DIN(61) & DIN(59) & DIN(20) & DIN(30) & 
		DIN(60) & DIN(3) & DIN(29) & DIN(13) & DIN(46) & DIN(15) & DIN(31) & DIN(20) & 
		DIN(38) & DIN(16) & DIN(41) & DIN(23) & DIN(1) & DIN(34) & DIN(57) & DIN(8) & 
		DIN(21) & DIN(42) & DIN(36) & DIN(0) & DIN(54) & DIN(6) & DIN(33) & DIN(30) & 
		DIN(49) & DIN(48) & DIN(14) & DIN(30) & DIN(63) & DIN(17) & DIN(1) & DIN(47);

	inst38_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init38,
			DOUT        => DOUT(38)
		);
	init38 <= DIN(12) & DIN(30) & DIN(49) & DIN(28) & DIN(0) & DIN(62) & DIN(2) & DIN(41) & 
		DIN(45) & DIN(3) & DIN(5) & DIN(33) & DIN(34) & DIN(18) & DIN(59) & DIN(19) & 
		DIN(33) & DIN(46) & DIN(54) & DIN(30) & DIN(18) & DIN(59) & DIN(31) & DIN(17) & 
		DIN(33) & DIN(2) & DIN(49) & DIN(32) & DIN(51) & DIN(8) & DIN(18) & DIN(48) & 
		DIN(30) & DIN(51) & DIN(26) & DIN(23) & DIN(16) & DIN(63) & DIN(35) & DIN(12) & 
		DIN(32) & DIN(51) & DIN(37) & DIN(15) & DIN(49) & DIN(13) & DIN(29) & DIN(3) & 
		DIN(27) & DIN(59) & DIN(63) & DIN(1) & DIN(26) & DIN(28) & DIN(32) & DIN(1) & 
		DIN(15) & DIN(41) & DIN(13) & DIN(2) & DIN(41) & DIN(31) & DIN(22) & DIN(7);

	inst39_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init39,
			DOUT        => DOUT(39)
		);
	init39 <= DIN(49) & DIN(41) & DIN(8) & DIN(11) & DIN(3) & DIN(46) & DIN(11) & DIN(32) & 
		DIN(32) & DIN(41) & DIN(46) & DIN(46) & DIN(8) & DIN(58) & DIN(62) & DIN(15) & 
		DIN(51) & DIN(17) & DIN(28) & DIN(14) & DIN(6) & DIN(60) & DIN(36) & DIN(15) & 
		DIN(61) & DIN(40) & DIN(15) & DIN(28) & DIN(62) & DIN(10) & DIN(26) & DIN(38) & 
		DIN(38) & DIN(26) & DIN(0) & DIN(35) & DIN(14) & DIN(33) & DIN(50) & DIN(50) & 
		DIN(33) & DIN(52) & DIN(48) & DIN(56) & DIN(6) & DIN(45) & DIN(51) & DIN(37) & 
		DIN(10) & DIN(32) & DIN(42) & DIN(55) & DIN(63) & DIN(60) & DIN(0) & DIN(33) & 
		DIN(41) & DIN(5) & DIN(2) & DIN(24) & DIN(35) & DIN(63) & DIN(38) & DIN(3);

	inst40_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init40,
			DOUT        => DOUT(40)
		);
	init40 <= DIN(42) & DIN(12) & DIN(31) & DIN(5) & DIN(62) & DIN(3) & DIN(19) & DIN(18) & 
		DIN(24) & DIN(10) & DIN(46) & DIN(56) & DIN(5) & DIN(57) & DIN(35) & DIN(31) & 
		DIN(35) & DIN(55) & DIN(40) & DIN(60) & DIN(20) & DIN(42) & DIN(18) & DIN(0) & 
		DIN(32) & DIN(58) & DIN(8) & DIN(36) & DIN(40) & DIN(13) & DIN(12) & DIN(37) & 
		DIN(14) & DIN(28) & DIN(50) & DIN(44) & DIN(43) & DIN(8) & DIN(35) & DIN(32) & 
		DIN(5) & DIN(53) & DIN(21) & DIN(37) & DIN(21) & DIN(43) & DIN(55) & DIN(39) & 
		DIN(35) & DIN(61) & DIN(41) & DIN(20) & DIN(10) & DIN(24) & DIN(55) & DIN(60) & 
		DIN(18) & DIN(59) & DIN(24) & DIN(2) & DIN(62) & DIN(48) & DIN(51) & DIN(34);

	inst41_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init41,
			DOUT        => DOUT(41)
		);
	init41 <= DIN(54) & DIN(18) & DIN(18) & DIN(26) & DIN(35) & DIN(29) & DIN(24) & DIN(32) & 
		DIN(18) & DIN(34) & DIN(61) & DIN(13) & DIN(42) & DIN(28) & DIN(26) & DIN(4) & 
		DIN(20) & DIN(50) & DIN(12) & DIN(3) & DIN(15) & DIN(14) & DIN(22) & DIN(12) & 
		DIN(51) & DIN(32) & DIN(48) & DIN(20) & DIN(62) & DIN(63) & DIN(7) & DIN(28) & 
		DIN(47) & DIN(53) & DIN(2) & DIN(3) & DIN(10) & DIN(54) & DIN(35) & DIN(5) & 
		DIN(56) & DIN(32) & DIN(50) & DIN(38) & DIN(8) & DIN(40) & DIN(55) & DIN(16) & 
		DIN(35) & DIN(62) & DIN(45) & DIN(3) & DIN(27) & DIN(54) & DIN(27) & DIN(31) & 
		DIN(34) & DIN(49) & DIN(12) & DIN(34) & DIN(16) & DIN(18) & DIN(25) & DIN(44);

	inst42_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init42,
			DOUT        => DOUT(42)
		);
	init42 <= DIN(35) & DIN(37) & DIN(18) & DIN(31) & DIN(18) & DIN(30) & DIN(45) & DIN(24) & 
		DIN(32) & DIN(13) & DIN(49) & DIN(61) & DIN(17) & DIN(38) & DIN(50) & DIN(54) & 
		DIN(46) & DIN(9) & DIN(23) & DIN(3) & DIN(10) & DIN(21) & DIN(51) & DIN(15) & 
		DIN(39) & DIN(21) & DIN(33) & DIN(61) & DIN(6) & DIN(0) & DIN(40) & DIN(4) & 
		DIN(19) & DIN(52) & DIN(50) & DIN(57) & DIN(61) & DIN(31) & DIN(39) & DIN(35) & 
		DIN(60) & DIN(10) & DIN(11) & DIN(27) & DIN(56) & DIN(41) & DIN(30) & DIN(43) & 
		DIN(63) & DIN(2) & DIN(16) & DIN(59) & DIN(46) & DIN(30) & DIN(46) & DIN(42) & 
		DIN(14) & DIN(32) & DIN(20) & DIN(2) & DIN(45) & DIN(52) & DIN(18) & DIN(25);

	inst43_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init43,
			DOUT        => DOUT(43)
		);
	init43 <= DIN(58) & DIN(48) & DIN(61) & DIN(10) & DIN(11) & DIN(45) & DIN(0) & DIN(32) & 
		DIN(0) & DIN(26) & DIN(8) & DIN(50) & DIN(7) & DIN(13) & DIN(17) & DIN(12) & 
		DIN(51) & DIN(62) & DIN(2) & DIN(23) & DIN(60) & DIN(30) & DIN(45) & DIN(48) & 
		DIN(41) & DIN(12) & DIN(59) & DIN(56) & DIN(54) & DIN(28) & DIN(57) & DIN(48) & 
		DIN(37) & DIN(16) & DIN(10) & DIN(42) & DIN(45) & DIN(37) & DIN(24) & DIN(14) & 
		DIN(19) & DIN(58) & DIN(33) & DIN(59) & DIN(26) & DIN(19) & DIN(10) & DIN(28) & 
		DIN(2) & DIN(35) & DIN(42) & DIN(12) & DIN(53) & DIN(32) & DIN(52) & DIN(49) & 
		DIN(22) & DIN(31) & DIN(62) & DIN(6) & DIN(55) & DIN(41) & DIN(37) & DIN(58);

	inst44_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init44,
			DOUT        => DOUT(44)
		);
	init44 <= DIN(1) & DIN(38) & DIN(10) & DIN(15) & DIN(14) & DIN(31) & DIN(41) & DIN(44) & 
		DIN(46) & DIN(51) & DIN(8) & DIN(7) & DIN(8) & DIN(18) & DIN(33) & DIN(61) & 
		DIN(28) & DIN(21) & DIN(59) & DIN(24) & DIN(16) & DIN(6) & DIN(38) & DIN(23) & 
		DIN(4) & DIN(50) & DIN(32) & DIN(26) & DIN(58) & DIN(7) & DIN(28) & DIN(50) & 
		DIN(24) & DIN(43) & DIN(38) & DIN(33) & DIN(49) & DIN(54) & DIN(36) & DIN(38) & 
		DIN(43) & DIN(54) & DIN(38) & DIN(10) & DIN(54) & DIN(12) & DIN(2) & DIN(3) & 
		DIN(5) & DIN(53) & DIN(50) & DIN(57) & DIN(1) & DIN(52) & DIN(55) & DIN(42) & 
		DIN(56) & DIN(24) & DIN(61) & DIN(8) & DIN(47) & DIN(49) & DIN(12) & DIN(55);

	inst45_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init45,
			DOUT        => DOUT(45)
		);
	init45 <= DIN(21) & DIN(29) & DIN(48) & DIN(34) & DIN(44) & DIN(55) & DIN(29) & DIN(34) & 
		DIN(0) & DIN(63) & DIN(35) & DIN(24) & DIN(46) & DIN(2) & DIN(25) & DIN(10) & 
		DIN(16) & DIN(13) & DIN(47) & DIN(37) & DIN(9) & DIN(37) & DIN(27) & DIN(3) & 
		DIN(56) & DIN(38) & DIN(55) & DIN(35) & DIN(1) & DIN(50) & DIN(52) & DIN(51) & 
		DIN(49) & DIN(56) & DIN(5) & DIN(10) & DIN(55) & DIN(30) & DIN(63) & DIN(40) & 
		DIN(16) & DIN(32) & DIN(63) & DIN(36) & DIN(50) & DIN(12) & DIN(27) & DIN(43) & 
		DIN(4) & DIN(9) & DIN(10) & DIN(6) & DIN(45) & DIN(53) & DIN(11) & DIN(21) & 
		DIN(37) & DIN(5) & DIN(46) & DIN(14) & DIN(1) & DIN(60) & DIN(46) & DIN(39);

	inst46_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init46,
			DOUT        => DOUT(46)
		);
	init46 <= DIN(56) & DIN(58) & DIN(46) & DIN(10) & DIN(26) & DIN(12) & DIN(43) & DIN(31) & 
		DIN(0) & DIN(42) & DIN(20) & DIN(23) & DIN(22) & DIN(1) & DIN(11) & DIN(36) & 
		DIN(46) & DIN(62) & DIN(21) & DIN(51) & DIN(31) & DIN(8) & DIN(18) & DIN(11) & 
		DIN(12) & DIN(63) & DIN(38) & DIN(52) & DIN(53) & DIN(39) & DIN(56) & DIN(46) & 
		DIN(31) & DIN(33) & DIN(30) & DIN(59) & DIN(12) & DIN(1) & DIN(11) & DIN(41) & 
		DIN(20) & DIN(19) & DIN(12) & DIN(50) & DIN(19) & DIN(13) & DIN(15) & DIN(58) & 
		DIN(30) & DIN(12) & DIN(33) & DIN(20) & DIN(60) & DIN(19) & DIN(37) & DIN(23) & 
		DIN(10) & DIN(63) & DIN(60) & DIN(7) & DIN(7) & DIN(22) & DIN(15) & DIN(36);

	inst47_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init47,
			DOUT        => DOUT(47)
		);
	init47 <= DIN(14) & DIN(9) & DIN(62) & DIN(4) & DIN(22) & DIN(40) & DIN(26) & DIN(8) & 
		DIN(10) & DIN(43) & DIN(41) & DIN(54) & DIN(22) & DIN(22) & DIN(13) & DIN(32) & 
		DIN(3) & DIN(15) & DIN(63) & DIN(8) & DIN(39) & DIN(31) & DIN(23) & DIN(35) & 
		DIN(45) & DIN(37) & DIN(52) & DIN(47) & DIN(18) & DIN(14) & DIN(3) & DIN(10) & 
		DIN(51) & DIN(22) & DIN(41) & DIN(13) & DIN(30) & DIN(47) & DIN(31) & DIN(20) & 
		DIN(21) & DIN(19) & DIN(40) & DIN(53) & DIN(18) & DIN(62) & DIN(33) & DIN(59) & 
		DIN(40) & DIN(32) & DIN(48) & DIN(4) & DIN(50) & DIN(50) & DIN(47) & DIN(62) & 
		DIN(19) & DIN(38) & DIN(44) & DIN(7) & DIN(26) & DIN(45) & DIN(33) & DIN(38);

	inst48_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init48,
			DOUT        => DOUT(48)
		);
	init48 <= DIN(46) & DIN(3) & DIN(16) & DIN(7) & DIN(40) & DIN(5) & DIN(55) & DIN(14) & 
		DIN(8) & DIN(49) & DIN(50) & DIN(16) & DIN(1) & DIN(62) & DIN(50) & DIN(26) & 
		DIN(20) & DIN(63) & DIN(27) & DIN(32) & DIN(34) & DIN(51) & DIN(57) & DIN(37) & 
		DIN(14) & DIN(34) & DIN(40) & DIN(49) & DIN(51) & DIN(11) & DIN(43) & DIN(39) & 
		DIN(27) & DIN(11) & DIN(15) & DIN(26) & DIN(60) & DIN(6) & DIN(28) & DIN(56) & 
		DIN(48) & DIN(52) & DIN(30) & DIN(39) & DIN(42) & DIN(51) & DIN(62) & DIN(52) & 
		DIN(29) & DIN(40) & DIN(38) & DIN(60) & DIN(37) & DIN(23) & DIN(61) & DIN(29) & 
		DIN(47) & DIN(29) & DIN(5) & DIN(12) & DIN(48) & DIN(32) & DIN(23) & DIN(1);

	inst49_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init49,
			DOUT        => DOUT(49)
		);
	init49 <= DIN(10) & DIN(44) & DIN(55) & DIN(34) & DIN(20) & DIN(53) & DIN(8) & DIN(55) & 
		DIN(32) & DIN(49) & DIN(43) & DIN(19) & DIN(2) & DIN(35) & DIN(61) & DIN(33) & 
		DIN(36) & DIN(24) & DIN(50) & DIN(53) & DIN(53) & DIN(1) & DIN(56) & DIN(44) & 
		DIN(36) & DIN(58) & DIN(63) & DIN(39) & DIN(30) & DIN(4) & DIN(35) & DIN(40) & 
		DIN(24) & DIN(2) & DIN(26) & DIN(28) & DIN(20) & DIN(23) & DIN(12) & DIN(13) & 
		DIN(47) & DIN(7) & DIN(22) & DIN(33) & DIN(63) & DIN(36) & DIN(47) & DIN(47) & 
		DIN(35) & DIN(49) & DIN(61) & DIN(9) & DIN(29) & DIN(62) & DIN(45) & DIN(61) & 
		DIN(28) & DIN(58) & DIN(3) & DIN(54) & DIN(44) & DIN(33) & DIN(14) & DIN(59);

	inst50_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init50,
			DOUT        => DOUT(50)
		);
	init50 <= DIN(30) & DIN(39) & DIN(26) & DIN(50) & DIN(5) & DIN(57) & DIN(54) & DIN(62) & 
		DIN(34) & DIN(39) & DIN(46) & DIN(45) & DIN(43) & DIN(20) & DIN(0) & DIN(39) & 
		DIN(26) & DIN(4) & DIN(14) & DIN(51) & DIN(10) & DIN(25) & DIN(9) & DIN(49) & 
		DIN(8) & DIN(55) & DIN(10) & DIN(44) & DIN(27) & DIN(36) & DIN(9) & DIN(44) & 
		DIN(34) & DIN(33) & DIN(59) & DIN(7) & DIN(23) & DIN(15) & DIN(15) & DIN(53) & 
		DIN(59) & DIN(26) & DIN(45) & DIN(4) & DIN(58) & DIN(60) & DIN(25) & DIN(39) & 
		DIN(58) & DIN(53) & DIN(42) & DIN(25) & DIN(17) & DIN(17) & DIN(39) & DIN(27) & 
		DIN(28) & DIN(38) & DIN(35) & DIN(47) & DIN(2) & DIN(40) & DIN(48) & DIN(27);

	inst51_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init51,
			DOUT        => DOUT(51)
		);
	init51 <= DIN(3) & DIN(33) & DIN(55) & DIN(4) & DIN(7) & DIN(55) & DIN(17) & DIN(17) & 
		DIN(21) & DIN(4) & DIN(53) & DIN(37) & DIN(61) & DIN(18) & DIN(43) & DIN(51) & 
		DIN(17) & DIN(25) & DIN(24) & DIN(61) & DIN(50) & DIN(17) & DIN(41) & DIN(50) & 
		DIN(36) & DIN(25) & DIN(1) & DIN(42) & DIN(19) & DIN(41) & DIN(57) & DIN(62) & 
		DIN(25) & DIN(0) & DIN(51) & DIN(54) & DIN(34) & DIN(12) & DIN(28) & DIN(48) & 
		DIN(7) & DIN(35) & DIN(57) & DIN(9) & DIN(1) & DIN(18) & DIN(27) & DIN(20) & 
		DIN(39) & DIN(7) & DIN(20) & DIN(63) & DIN(45) & DIN(16) & DIN(49) & DIN(58) & 
		DIN(6) & DIN(24) & DIN(49) & DIN(21) & DIN(16) & DIN(57) & DIN(11) & DIN(35);

	inst52_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init52,
			DOUT        => DOUT(52)
		);
	init52 <= DIN(45) & DIN(8) & DIN(18) & DIN(56) & DIN(58) & DIN(27) & DIN(13) & DIN(29) & 
		DIN(39) & DIN(4) & DIN(55) & DIN(56) & DIN(2) & DIN(8) & DIN(25) & DIN(17) & 
		DIN(46) & DIN(63) & DIN(22) & DIN(57) & DIN(34) & DIN(46) & DIN(48) & DIN(57) & 
		DIN(23) & DIN(63) & DIN(40) & DIN(61) & DIN(1) & DIN(40) & DIN(13) & DIN(53) & 
		DIN(13) & DIN(55) & DIN(42) & DIN(29) & DIN(52) & DIN(9) & DIN(38) & DIN(47) & 
		DIN(2) & DIN(47) & DIN(30) & DIN(48) & DIN(26) & DIN(26) & DIN(59) & DIN(53) & 
		DIN(29) & DIN(40) & DIN(9) & DIN(41) & DIN(23) & DIN(48) & DIN(17) & DIN(25) & 
		DIN(62) & DIN(63) & DIN(48) & DIN(12) & DIN(27) & DIN(22) & DIN(10) & DIN(48);

	inst53_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init53,
			DOUT        => DOUT(53)
		);
	init53 <= DIN(40) & DIN(3) & DIN(6) & DIN(18) & DIN(8) & DIN(3) & DIN(44) & DIN(46) & 
		DIN(45) & DIN(15) & DIN(38) & DIN(15) & DIN(44) & DIN(57) & DIN(63) & DIN(38) & 
		DIN(52) & DIN(50) & DIN(24) & DIN(39) & DIN(40) & DIN(19) & DIN(52) & DIN(47) & 
		DIN(60) & DIN(0) & DIN(12) & DIN(30) & DIN(46) & DIN(24) & DIN(49) & DIN(22) & 
		DIN(58) & DIN(3) & DIN(37) & DIN(26) & DIN(22) & DIN(29) & DIN(8) & DIN(30) & 
		DIN(35) & DIN(44) & DIN(16) & DIN(5) & DIN(5) & DIN(12) & DIN(14) & DIN(13) & 
		DIN(10) & DIN(5) & DIN(51) & DIN(57) & DIN(23) & DIN(52) & DIN(34) & DIN(29) & 
		DIN(17) & DIN(52) & DIN(45) & DIN(24) & DIN(29) & DIN(46) & DIN(48) & DIN(32);

	inst54_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init54,
			DOUT        => DOUT(54)
		);
	init54 <= DIN(6) & DIN(58) & DIN(58) & DIN(43) & DIN(12) & DIN(53) & DIN(44) & DIN(21) & 
		DIN(23) & DIN(47) & DIN(36) & DIN(12) & DIN(59) & DIN(55) & DIN(45) & DIN(53) & 
		DIN(56) & DIN(29) & DIN(21) & DIN(8) & DIN(57) & DIN(47) & DIN(23) & DIN(59) & 
		DIN(61) & DIN(24) & DIN(22) & DIN(50) & DIN(2) & DIN(4) & DIN(28) & DIN(26) & 
		DIN(46) & DIN(5) & DIN(63) & DIN(55) & DIN(29) & DIN(60) & DIN(48) & DIN(11) & 
		DIN(52) & DIN(45) & DIN(31) & DIN(6) & DIN(63) & DIN(16) & DIN(32) & DIN(48) & 
		DIN(36) & DIN(38) & DIN(49) & DIN(61) & DIN(50) & DIN(62) & DIN(37) & DIN(10) & 
		DIN(22) & DIN(18) & DIN(22) & DIN(39) & DIN(22) & DIN(22) & DIN(27) & DIN(55);

	inst55_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init55,
			DOUT        => DOUT(55)
		);
	init55 <= DIN(28) & DIN(2) & DIN(20) & DIN(46) & DIN(4) & DIN(12) & DIN(63) & DIN(29) & 
		DIN(9) & DIN(10) & DIN(49) & DIN(50) & DIN(34) & DIN(57) & DIN(7) & DIN(14) & 
		DIN(25) & DIN(12) & DIN(31) & DIN(5) & DIN(12) & DIN(40) & DIN(30) & DIN(1) & 
		DIN(40) & DIN(20) & DIN(12) & DIN(49) & DIN(3) & DIN(6) & DIN(16) & DIN(46) & 
		DIN(61) & DIN(8) & DIN(47) & DIN(39) & DIN(2) & DIN(52) & DIN(44) & DIN(23) & 
		DIN(40) & DIN(55) & DIN(43) & DIN(19) & DIN(32) & DIN(59) & DIN(47) & DIN(20) & 
		DIN(0) & DIN(55) & DIN(39) & DIN(10) & DIN(63) & DIN(10) & DIN(53) & DIN(55) & 
		DIN(17) & DIN(6) & DIN(32) & DIN(21) & DIN(9) & DIN(8) & DIN(63) & DIN(22);

	inst56_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init56,
			DOUT        => DOUT(56)
		);
	init56 <= DIN(0) & DIN(29) & DIN(60) & DIN(56) & DIN(38) & DIN(50) & DIN(56) & DIN(19) & 
		DIN(4) & DIN(58) & DIN(21) & DIN(4) & DIN(0) & DIN(35) & DIN(3) & DIN(36) & 
		DIN(59) & DIN(13) & DIN(57) & DIN(5) & DIN(56) & DIN(8) & DIN(22) & DIN(50) & 
		DIN(48) & DIN(52) & DIN(12) & DIN(29) & DIN(29) & DIN(13) & DIN(41) & DIN(8) & 
		DIN(55) & DIN(10) & DIN(0) & DIN(18) & DIN(46) & DIN(62) & DIN(62) & DIN(0) & 
		DIN(57) & DIN(50) & DIN(1) & DIN(28) & DIN(40) & DIN(54) & DIN(43) & DIN(54) & 
		DIN(20) & DIN(49) & DIN(46) & DIN(6) & DIN(24) & DIN(34) & DIN(38) & DIN(18) & 
		DIN(22) & DIN(62) & DIN(52) & DIN(21) & DIN(22) & DIN(31) & DIN(8) & DIN(37);

	inst57_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init57,
			DOUT        => DOUT(57)
		);
	init57 <= DIN(12) & DIN(35) & DIN(20) & DIN(41) & DIN(18) & DIN(15) & DIN(48) & DIN(40) & 
		DIN(11) & DIN(21) & DIN(58) & DIN(63) & DIN(32) & DIN(62) & DIN(43) & DIN(63) & 
		DIN(7) & DIN(17) & DIN(51) & DIN(21) & DIN(56) & DIN(10) & DIN(38) & DIN(3) & 
		DIN(29) & DIN(4) & DIN(7) & DIN(52) & DIN(26) & DIN(20) & DIN(34) & DIN(35) & 
		DIN(16) & DIN(4) & DIN(56) & DIN(42) & DIN(4) & DIN(27) & DIN(46) & DIN(12) & 
		DIN(53) & DIN(59) & DIN(20) & DIN(33) & DIN(55) & DIN(26) & DIN(12) & DIN(50) & 
		DIN(25) & DIN(40) & DIN(47) & DIN(53) & DIN(45) & DIN(34) & DIN(59) & DIN(40) & 
		DIN(41) & DIN(51) & DIN(18) & DIN(55) & DIN(3) & DIN(30) & DIN(43) & DIN(38);

	inst58_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init58,
			DOUT        => DOUT(58)
		);
	init58 <= DIN(21) & DIN(62) & DIN(42) & DIN(27) & DIN(35) & DIN(9) & DIN(23) & DIN(62) & 
		DIN(53) & DIN(55) & DIN(45) & DIN(10) & DIN(41) & DIN(43) & DIN(16) & DIN(3) & 
		DIN(53) & DIN(43) & DIN(23) & DIN(63) & DIN(38) & DIN(41) & DIN(52) & DIN(33) & 
		DIN(3) & DIN(58) & DIN(14) & DIN(50) & DIN(57) & DIN(6) & DIN(7) & DIN(58) & 
		DIN(27) & DIN(32) & DIN(3) & DIN(37) & DIN(20) & DIN(32) & DIN(17) & DIN(43) & 
		DIN(14) & DIN(1) & DIN(58) & DIN(38) & DIN(54) & DIN(37) & DIN(44) & DIN(54) & 
		DIN(4) & DIN(45) & DIN(11) & DIN(5) & DIN(38) & DIN(57) & DIN(18) & DIN(17) & 
		DIN(1) & DIN(8) & DIN(43) & DIN(62) & DIN(43) & DIN(39) & DIN(55) & DIN(54);

	inst59_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init59,
			DOUT        => DOUT(59)
		);
	init59 <= DIN(7) & DIN(8) & DIN(60) & DIN(24) & DIN(13) & DIN(41) & DIN(47) & DIN(3) & 
		DIN(44) & DIN(4) & DIN(36) & DIN(9) & DIN(60) & DIN(14) & DIN(62) & DIN(50) & 
		DIN(45) & DIN(42) & DIN(21) & DIN(23) & DIN(63) & DIN(35) & DIN(17) & DIN(23) & 
		DIN(39) & DIN(54) & DIN(6) & DIN(42) & DIN(2) & DIN(31) & DIN(33) & DIN(46) & 
		DIN(59) & DIN(19) & DIN(41) & DIN(9) & DIN(61) & DIN(43) & DIN(31) & DIN(34) & 
		DIN(8) & DIN(22) & DIN(11) & DIN(10) & DIN(32) & DIN(20) & DIN(29) & DIN(22) & 
		DIN(43) & DIN(49) & DIN(6) & DIN(40) & DIN(60) & DIN(27) & DIN(17) & DIN(61) & 
		DIN(52) & DIN(39) & DIN(9) & DIN(19) & DIN(36) & DIN(14) & DIN(5) & DIN(49);

	inst60_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init60,
			DOUT        => DOUT(60)
		);
	init60 <= DIN(57) & DIN(49) & DIN(59) & DIN(49) & DIN(10) & DIN(18) & DIN(17) & DIN(1) & 
		DIN(48) & DIN(56) & DIN(53) & DIN(39) & DIN(45) & DIN(18) & DIN(12) & DIN(37) & 
		DIN(27) & DIN(54) & DIN(1) & DIN(45) & DIN(27) & DIN(43) & DIN(62) & DIN(51) & 
		DIN(2) & DIN(58) & DIN(31) & DIN(49) & DIN(53) & DIN(47) & DIN(50) & DIN(7) & 
		DIN(39) & DIN(41) & DIN(32) & DIN(9) & DIN(34) & DIN(24) & DIN(12) & DIN(9) & 
		DIN(11) & DIN(35) & DIN(26) & DIN(8) & DIN(55) & DIN(22) & DIN(36) & DIN(45) & 
		DIN(26) & DIN(22) & DIN(47) & DIN(40) & DIN(40) & DIN(4) & DIN(19) & DIN(17) & 
		DIN(5) & DIN(48) & DIN(63) & DIN(45) & DIN(8) & DIN(9) & DIN(39) & DIN(30);

	inst61_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init61,
			DOUT        => DOUT(61)
		);
	init61 <= DIN(11) & DIN(38) & DIN(0) & DIN(55) & DIN(2) & DIN(44) & DIN(3) & DIN(11) & 
		DIN(18) & DIN(1) & DIN(15) & DIN(41) & DIN(10) & DIN(38) & DIN(17) & DIN(20) & 
		DIN(46) & DIN(49) & DIN(19) & DIN(28) & DIN(63) & DIN(36) & DIN(23) & DIN(49) & 
		DIN(16) & DIN(8) & DIN(37) & DIN(41) & DIN(21) & DIN(3) & DIN(1) & DIN(20) & 
		DIN(36) & DIN(19) & DIN(51) & DIN(55) & DIN(26) & DIN(2) & DIN(59) & DIN(41) & 
		DIN(55) & DIN(41) & DIN(24) & DIN(54) & DIN(56) & DIN(31) & DIN(1) & DIN(17) & 
		DIN(50) & DIN(47) & DIN(5) & DIN(13) & DIN(20) & DIN(15) & DIN(12) & DIN(38) & 
		DIN(51) & DIN(33) & DIN(40) & DIN(0) & DIN(31) & DIN(46) & DIN(33) & DIN(45);

	inst62_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init62,
			DOUT        => DOUT(62)
		);
	init62 <= DIN(41) & DIN(6) & DIN(2) & DIN(10) & DIN(27) & DIN(42) & DIN(22) & DIN(50) & 
		DIN(30) & DIN(8) & DIN(8) & DIN(9) & DIN(60) & DIN(11) & DIN(56) & DIN(59) & 
		DIN(32) & DIN(40) & DIN(9) & DIN(30) & DIN(34) & DIN(62) & DIN(45) & DIN(48) & 
		DIN(33) & DIN(46) & DIN(17) & DIN(33) & DIN(45) & DIN(22) & DIN(56) & DIN(30) & 
		DIN(43) & DIN(23) & DIN(52) & DIN(41) & DIN(12) & DIN(14) & DIN(41) & DIN(21) & 
		DIN(12) & DIN(61) & DIN(17) & DIN(1) & DIN(43) & DIN(16) & DIN(49) & DIN(2) & 
		DIN(6) & DIN(11) & DIN(49) & DIN(50) & DIN(29) & DIN(63) & DIN(31) & DIN(0) & 
		DIN(0) & DIN(59) & DIN(41) & DIN(15) & DIN(43) & DIN(32) & DIN(42) & DIN(1);

	inst63_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init63,
			DOUT        => DOUT(63)
		);
	init63 <= DIN(53) & DIN(11) & DIN(14) & DIN(63) & DIN(29) & DIN(1) & DIN(38) & DIN(41) & 
		DIN(29) & DIN(20) & DIN(55) & DIN(3) & DIN(29) & DIN(48) & DIN(0) & DIN(24) & 
		DIN(7) & DIN(4) & DIN(27) & DIN(39) & DIN(5) & DIN(42) & DIN(0) & DIN(0) & 
		DIN(26) & DIN(0) & DIN(5) & DIN(40) & DIN(35) & DIN(9) & DIN(35) & DIN(53) & 
		DIN(46) & DIN(13) & DIN(25) & DIN(52) & DIN(36) & DIN(18) & DIN(50) & DIN(25) & 
		DIN(55) & DIN(7) & DIN(3) & DIN(5) & DIN(41) & DIN(59) & DIN(60) & DIN(31) & 
		DIN(63) & DIN(49) & DIN(39) & DIN(4) & DIN(16) & DIN(63) & DIN(59) & DIN(50) & 
		DIN(29) & DIN(60) & DIN(4) & DIN(45) & DIN(27) & DIN(22) & DIN(28) & DIN(58);

	inst64_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init64,
			DOUT        => DOUT(64)
		);
	init64 <= DIN(55) & DIN(59) & DIN(27) & DIN(33) & DIN(54) & DIN(61) & DIN(32) & DIN(35) & 
		DIN(21) & DIN(43) & DIN(29) & DIN(44) & DIN(19) & DIN(25) & DIN(41) & DIN(36) & 
		DIN(49) & DIN(59) & DIN(45) & DIN(13) & DIN(41) & DIN(38) & DIN(41) & DIN(48) & 
		DIN(38) & DIN(10) & DIN(18) & DIN(14) & DIN(47) & DIN(30) & DIN(53) & DIN(21) & 
		DIN(5) & DIN(29) & DIN(1) & DIN(19) & DIN(40) & DIN(53) & DIN(5) & DIN(41) & 
		DIN(24) & DIN(4) & DIN(2) & DIN(46) & DIN(39) & DIN(46) & DIN(55) & DIN(36) & 
		DIN(17) & DIN(7) & DIN(36) & DIN(57) & DIN(0) & DIN(31) & DIN(30) & DIN(24) & 
		DIN(26) & DIN(51) & DIN(24) & DIN(26) & DIN(25) & DIN(24) & DIN(20) & DIN(49);

	inst65_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init65,
			DOUT        => DOUT(65)
		);
	init65 <= DIN(38) & DIN(55) & DIN(19) & DIN(39) & DIN(35) & DIN(31) & DIN(3) & DIN(32) & 
		DIN(33) & DIN(26) & DIN(55) & DIN(5) & DIN(39) & DIN(12) & DIN(10) & DIN(24) & 
		DIN(54) & DIN(57) & DIN(38) & DIN(12) & DIN(60) & DIN(13) & DIN(12) & DIN(35) & 
		DIN(37) & DIN(6) & DIN(55) & DIN(11) & DIN(42) & DIN(50) & DIN(27) & DIN(62) & 
		DIN(20) & DIN(52) & DIN(36) & DIN(3) & DIN(61) & DIN(41) & DIN(40) & DIN(28) & 
		DIN(50) & DIN(43) & DIN(59) & DIN(15) & DIN(22) & DIN(16) & DIN(50) & DIN(42) & 
		DIN(61) & DIN(25) & DIN(0) & DIN(25) & DIN(39) & DIN(5) & DIN(43) & DIN(26) & 
		DIN(28) & DIN(5) & DIN(48) & DIN(44) & DIN(30) & DIN(38) & DIN(26) & DIN(16);

	inst66_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init66,
			DOUT        => DOUT(66)
		);
	init66 <= DIN(36) & DIN(27) & DIN(15) & DIN(21) & DIN(15) & DIN(18) & DIN(48) & DIN(50) & 
		DIN(60) & DIN(3) & DIN(40) & DIN(13) & DIN(57) & DIN(61) & DIN(33) & DIN(15) & 
		DIN(51) & DIN(15) & DIN(28) & DIN(47) & DIN(36) & DIN(54) & DIN(53) & DIN(18) & 
		DIN(7) & DIN(53) & DIN(37) & DIN(36) & DIN(48) & DIN(6) & DIN(13) & DIN(15) & 
		DIN(12) & DIN(60) & DIN(37) & DIN(29) & DIN(22) & DIN(45) & DIN(10) & DIN(47) & 
		DIN(10) & DIN(43) & DIN(44) & DIN(42) & DIN(9) & DIN(18) & DIN(50) & DIN(4) & 
		DIN(42) & DIN(38) & DIN(58) & DIN(18) & DIN(47) & DIN(0) & DIN(44) & DIN(35) & 
		DIN(4) & DIN(31) & DIN(23) & DIN(33) & DIN(58) & DIN(16) & DIN(42) & DIN(46);

	inst67_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init67,
			DOUT        => DOUT(67)
		);
	init67 <= DIN(19) & DIN(35) & DIN(18) & DIN(13) & DIN(47) & DIN(3) & DIN(41) & DIN(23) & 
		DIN(24) & DIN(32) & DIN(14) & DIN(2) & DIN(38) & DIN(24) & DIN(29) & DIN(31) & 
		DIN(29) & DIN(59) & DIN(63) & DIN(48) & DIN(18) & DIN(29) & DIN(35) & DIN(56) & 
		DIN(46) & DIN(38) & DIN(59) & DIN(46) & DIN(13) & DIN(52) & DIN(36) & DIN(6) & 
		DIN(52) & DIN(15) & DIN(36) & DIN(24) & DIN(43) & DIN(9) & DIN(9) & DIN(21) & 
		DIN(57) & DIN(54) & DIN(37) & DIN(7) & DIN(58) & DIN(34) & DIN(31) & DIN(45) & 
		DIN(41) & DIN(34) & DIN(12) & DIN(26) & DIN(47) & DIN(61) & DIN(61) & DIN(63) & 
		DIN(25) & DIN(7) & DIN(10) & DIN(7) & DIN(0) & DIN(21) & DIN(33) & DIN(28);

	inst68_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init68,
			DOUT        => DOUT(68)
		);
	init68 <= DIN(50) & DIN(12) & DIN(59) & DIN(18) & DIN(47) & DIN(27) & DIN(10) & DIN(8) & 
		DIN(15) & DIN(37) & DIN(52) & DIN(17) & DIN(47) & DIN(35) & DIN(59) & DIN(17) & 
		DIN(42) & DIN(6) & DIN(2) & DIN(52) & DIN(55) & DIN(10) & DIN(27) & DIN(7) & 
		DIN(48) & DIN(61) & DIN(22) & DIN(6) & DIN(50) & DIN(3) & DIN(0) & DIN(32) & 
		DIN(29) & DIN(31) & DIN(8) & DIN(38) & DIN(12) & DIN(37) & DIN(20) & DIN(62) & 
		DIN(53) & DIN(17) & DIN(21) & DIN(30) & DIN(57) & DIN(53) & DIN(15) & DIN(54) & 
		DIN(15) & DIN(55) & DIN(25) & DIN(48) & DIN(26) & DIN(29) & DIN(48) & DIN(42) & 
		DIN(11) & DIN(19) & DIN(6) & DIN(18) & DIN(37) & DIN(32) & DIN(23) & DIN(55);

	inst69_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init69,
			DOUT        => DOUT(69)
		);
	init69 <= DIN(33) & DIN(32) & DIN(29) & DIN(25) & DIN(8) & DIN(41) & DIN(33) & DIN(44) & 
		DIN(40) & DIN(54) & DIN(10) & DIN(58) & DIN(57) & DIN(4) & DIN(21) & DIN(5) & 
		DIN(14) & DIN(22) & DIN(6) & DIN(40) & DIN(6) & DIN(42) & DIN(62) & DIN(7) & 
		DIN(56) & DIN(26) & DIN(11) & DIN(59) & DIN(45) & DIN(25) & DIN(24) & DIN(7) & 
		DIN(23) & DIN(51) & DIN(56) & DIN(28) & DIN(1) & DIN(43) & DIN(33) & DIN(46) & 
		DIN(60) & DIN(6) & DIN(36) & DIN(52) & DIN(54) & DIN(63) & DIN(63) & DIN(37) & 
		DIN(16) & DIN(28) & DIN(42) & DIN(62) & DIN(49) & DIN(36) & DIN(60) & DIN(61) & 
		DIN(45) & DIN(50) & DIN(34) & DIN(38) & DIN(1) & DIN(37) & DIN(15) & DIN(59);

	inst70_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init70,
			DOUT        => DOUT(70)
		);
	init70 <= DIN(61) & DIN(33) & DIN(8) & DIN(2) & DIN(5) & DIN(30) & DIN(1) & DIN(31) & 
		DIN(21) & DIN(31) & DIN(22) & DIN(37) & DIN(6) & DIN(55) & DIN(23) & DIN(25) & 
		DIN(0) & DIN(63) & DIN(55) & DIN(3) & DIN(33) & DIN(25) & DIN(27) & DIN(8) & 
		DIN(9) & DIN(10) & DIN(53) & DIN(33) & DIN(62) & DIN(12) & DIN(56) & DIN(58) & 
		DIN(27) & DIN(42) & DIN(1) & DIN(38) & DIN(9) & DIN(33) & DIN(9) & DIN(47) & 
		DIN(25) & DIN(31) & DIN(14) & DIN(45) & DIN(55) & DIN(24) & DIN(34) & DIN(61) & 
		DIN(30) & DIN(30) & DIN(39) & DIN(25) & DIN(16) & DIN(17) & DIN(19) & DIN(39) & 
		DIN(11) & DIN(41) & DIN(41) & DIN(4) & DIN(48) & DIN(14) & DIN(57) & DIN(53);

	inst71_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init71,
			DOUT        => DOUT(71)
		);
	init71 <= DIN(53) & DIN(12) & DIN(45) & DIN(16) & DIN(9) & DIN(50) & DIN(25) & DIN(6) & 
		DIN(52) & DIN(2) & DIN(12) & DIN(57) & DIN(49) & DIN(47) & DIN(62) & DIN(0) & 
		DIN(40) & DIN(35) & DIN(37) & DIN(6) & DIN(15) & DIN(1) & DIN(59) & DIN(20) & 
		DIN(29) & DIN(48) & DIN(16) & DIN(60) & DIN(6) & DIN(37) & DIN(54) & DIN(36) & 
		DIN(3) & DIN(59) & DIN(55) & DIN(2) & DIN(62) & DIN(22) & DIN(58) & DIN(59) & 
		DIN(17) & DIN(28) & DIN(58) & DIN(49) & DIN(7) & DIN(27) & DIN(27) & DIN(34) & 
		DIN(20) & DIN(36) & DIN(10) & DIN(59) & DIN(36) & DIN(11) & DIN(4) & DIN(33) & 
		DIN(42) & DIN(43) & DIN(5) & DIN(34) & DIN(34) & DIN(59) & DIN(45) & DIN(0);

	inst72_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init72,
			DOUT        => DOUT(72)
		);
	init72 <= DIN(31) & DIN(8) & DIN(42) & DIN(2) & DIN(17) & DIN(52) & DIN(21) & DIN(61) & 
		DIN(52) & DIN(53) & DIN(23) & DIN(4) & DIN(29) & DIN(36) & DIN(45) & DIN(12) & 
		DIN(37) & DIN(24) & DIN(7) & DIN(31) & DIN(53) & DIN(50) & DIN(23) & DIN(18) & 
		DIN(4) & DIN(51) & DIN(20) & DIN(29) & DIN(30) & DIN(23) & DIN(49) & DIN(29) & 
		DIN(55) & DIN(53) & DIN(44) & DIN(19) & DIN(0) & DIN(32) & DIN(38) & DIN(48) & 
		DIN(23) & DIN(51) & DIN(23) & DIN(17) & DIN(63) & DIN(20) & DIN(5) & DIN(6) & 
		DIN(35) & DIN(21) & DIN(7) & DIN(35) & DIN(45) & DIN(36) & DIN(62) & DIN(39) & 
		DIN(21) & DIN(61) & DIN(44) & DIN(1) & DIN(32) & DIN(59) & DIN(49) & DIN(36);

	inst73_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init73,
			DOUT        => DOUT(73)
		);
	init73 <= DIN(47) & DIN(9) & DIN(39) & DIN(47) & DIN(21) & DIN(27) & DIN(16) & DIN(61) & 
		DIN(46) & DIN(57) & DIN(14) & DIN(4) & DIN(51) & DIN(20) & DIN(47) & DIN(42) & 
		DIN(14) & DIN(15) & DIN(57) & DIN(12) & DIN(12) & DIN(44) & DIN(55) & DIN(22) & 
		DIN(4) & DIN(59) & DIN(40) & DIN(59) & DIN(52) & DIN(43) & DIN(10) & DIN(63) & 
		DIN(51) & DIN(12) & DIN(31) & DIN(24) & DIN(44) & DIN(23) & DIN(46) & DIN(42) & 
		DIN(6) & DIN(58) & DIN(21) & DIN(8) & DIN(6) & DIN(32) & DIN(49) & DIN(2) & 
		DIN(2) & DIN(13) & DIN(21) & DIN(54) & DIN(40) & DIN(60) & DIN(46) & DIN(9) & 
		DIN(7) & DIN(60) & DIN(49) & DIN(52) & DIN(56) & DIN(62) & DIN(32) & DIN(27);

	inst74_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init74,
			DOUT        => DOUT(74)
		);
	init74 <= DIN(38) & DIN(16) & DIN(31) & DIN(3) & DIN(45) & DIN(3) & DIN(20) & DIN(59) & 
		DIN(22) & DIN(46) & DIN(48) & DIN(24) & DIN(29) & DIN(0) & DIN(43) & DIN(10) & 
		DIN(62) & DIN(54) & DIN(5) & DIN(1) & DIN(53) & DIN(20) & DIN(50) & DIN(30) & 
		DIN(50) & DIN(51) & DIN(0) & DIN(29) & DIN(0) & DIN(15) & DIN(63) & DIN(35) & 
		DIN(35) & DIN(28) & DIN(47) & DIN(50) & DIN(45) & DIN(38) & DIN(11) & DIN(61) & 
		DIN(16) & DIN(48) & DIN(45) & DIN(19) & DIN(1) & DIN(52) & DIN(5) & DIN(61) & 
		DIN(1) & DIN(48) & DIN(14) & DIN(23) & DIN(34) & DIN(63) & DIN(29) & DIN(21) & 
		DIN(51) & DIN(49) & DIN(30) & DIN(28) & DIN(44) & DIN(35) & DIN(52) & DIN(49);

	inst75_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init75,
			DOUT        => DOUT(75)
		);
	init75 <= DIN(38) & DIN(0) & DIN(14) & DIN(19) & DIN(61) & DIN(52) & DIN(31) & DIN(24) & 
		DIN(1) & DIN(60) & DIN(18) & DIN(16) & DIN(5) & DIN(15) & DIN(52) & DIN(10) & 
		DIN(34) & DIN(5) & DIN(62) & DIN(13) & DIN(52) & DIN(51) & DIN(36) & DIN(45) & 
		DIN(38) & DIN(49) & DIN(43) & DIN(26) & DIN(51) & DIN(62) & DIN(0) & DIN(19) & 
		DIN(3) & DIN(26) & DIN(51) & DIN(37) & DIN(51) & DIN(35) & DIN(6) & DIN(48) & 
		DIN(54) & DIN(3) & DIN(28) & DIN(59) & DIN(45) & DIN(46) & DIN(11) & DIN(20) & 
		DIN(17) & DIN(11) & DIN(41) & DIN(7) & DIN(13) & DIN(51) & DIN(2) & DIN(12) & 
		DIN(62) & DIN(45) & DIN(25) & DIN(32) & DIN(59) & DIN(38) & DIN(31) & DIN(30);

	inst76_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init76,
			DOUT        => DOUT(76)
		);
	init76 <= DIN(8) & DIN(44) & DIN(24) & DIN(55) & DIN(4) & DIN(51) & DIN(35) & DIN(42) & 
		DIN(53) & DIN(16) & DIN(31) & DIN(9) & DIN(57) & DIN(9) & DIN(61) & DIN(59) & 
		DIN(51) & DIN(45) & DIN(14) & DIN(46) & DIN(35) & DIN(49) & DIN(29) & DIN(34) & 
		DIN(53) & DIN(18) & DIN(32) & DIN(7) & DIN(59) & DIN(17) & DIN(61) & DIN(17) & 
		DIN(40) & DIN(36) & DIN(19) & DIN(25) & DIN(62) & DIN(19) & DIN(11) & DIN(43) & 
		DIN(22) & DIN(22) & DIN(12) & DIN(62) & DIN(21) & DIN(16) & DIN(44) & DIN(5) & 
		DIN(10) & DIN(29) & DIN(17) & DIN(0) & DIN(59) & DIN(11) & DIN(2) & DIN(46) & 
		DIN(23) & DIN(15) & DIN(10) & DIN(41) & DIN(41) & DIN(25) & DIN(62) & DIN(15);

	inst77_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init77,
			DOUT        => DOUT(77)
		);
	init77 <= DIN(26) & DIN(41) & DIN(2) & DIN(4) & DIN(58) & DIN(8) & DIN(43) & DIN(33) & 
		DIN(23) & DIN(63) & DIN(32) & DIN(29) & DIN(23) & DIN(19) & DIN(7) & DIN(26) & 
		DIN(58) & DIN(0) & DIN(60) & DIN(43) & DIN(51) & DIN(39) & DIN(26) & DIN(33) & 
		DIN(5) & DIN(54) & DIN(30) & DIN(18) & DIN(53) & DIN(11) & DIN(61) & DIN(22) & 
		DIN(46) & DIN(57) & DIN(24) & DIN(25) & DIN(49) & DIN(44) & DIN(1) & DIN(58) & 
		DIN(40) & DIN(13) & DIN(22) & DIN(61) & DIN(24) & DIN(6) & DIN(30) & DIN(15) & 
		DIN(13) & DIN(21) & DIN(17) & DIN(18) & DIN(33) & DIN(36) & DIN(3) & DIN(51) & 
		DIN(1) & DIN(18) & DIN(21) & DIN(30) & DIN(29) & DIN(3) & DIN(62) & DIN(21);

	inst78_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init78,
			DOUT        => DOUT(78)
		);
	init78 <= DIN(43) & DIN(48) & DIN(30) & DIN(57) & DIN(3) & DIN(41) & DIN(59) & DIN(20) & 
		DIN(15) & DIN(38) & DIN(40) & DIN(56) & DIN(11) & DIN(4) & DIN(13) & DIN(18) & 
		DIN(55) & DIN(34) & DIN(58) & DIN(8) & DIN(14) & DIN(52) & DIN(32) & DIN(20) & 
		DIN(41) & DIN(57) & DIN(22) & DIN(10) & DIN(5) & DIN(63) & DIN(4) & DIN(50) & 
		DIN(45) & DIN(53) & DIN(62) & DIN(46) & DIN(26) & DIN(21) & DIN(44) & DIN(22) & 
		DIN(26) & DIN(36) & DIN(43) & DIN(57) & DIN(12) & DIN(43) & DIN(24) & DIN(47) & 
		DIN(20) & DIN(5) & DIN(40) & DIN(58) & DIN(11) & DIN(39) & DIN(62) & DIN(31) & 
		DIN(52) & DIN(23) & DIN(5) & DIN(18) & DIN(17) & DIN(15) & DIN(52) & DIN(63);

	inst79_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init79,
			DOUT        => DOUT(79)
		);
	init79 <= DIN(48) & DIN(58) & DIN(10) & DIN(3) & DIN(49) & DIN(33) & DIN(5) & DIN(10) & 
		DIN(36) & DIN(55) & DIN(2) & DIN(32) & DIN(45) & DIN(36) & DIN(23) & DIN(55) & 
		DIN(20) & DIN(52) & DIN(41) & DIN(61) & DIN(29) & DIN(31) & DIN(52) & DIN(24) & 
		DIN(12) & DIN(12) & DIN(13) & DIN(2) & DIN(51) & DIN(54) & DIN(25) & DIN(45) & 
		DIN(9) & DIN(40) & DIN(62) & DIN(38) & DIN(61) & DIN(13) & DIN(8) & DIN(4) & 
		DIN(10) & DIN(30) & DIN(9) & DIN(54) & DIN(15) & DIN(35) & DIN(14) & DIN(23) & 
		DIN(23) & DIN(10) & DIN(9) & DIN(5) & DIN(18) & DIN(39) & DIN(11) & DIN(10) & 
		DIN(25) & DIN(22) & DIN(41) & DIN(5) & DIN(45) & DIN(48) & DIN(47) & DIN(35);

	inst80_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init80,
			DOUT        => DOUT(80)
		);
	init80 <= DIN(40) & DIN(60) & DIN(31) & DIN(37) & DIN(41) & DIN(17) & DIN(18) & DIN(58) & 
		DIN(52) & DIN(58) & DIN(20) & DIN(25) & DIN(19) & DIN(16) & DIN(4) & DIN(55) & 
		DIN(49) & DIN(38) & DIN(29) & DIN(50) & DIN(53) & DIN(39) & DIN(10) & DIN(59) & 
		DIN(5) & DIN(23) & DIN(42) & DIN(33) & DIN(1) & DIN(56) & DIN(49) & DIN(3) & 
		DIN(18) & DIN(14) & DIN(18) & DIN(47) & DIN(29) & DIN(24) & DIN(37) & DIN(26) & 
		DIN(39) & DIN(4) & DIN(21) & DIN(28) & DIN(31) & DIN(30) & DIN(26) & DIN(63) & 
		DIN(49) & DIN(54) & DIN(39) & DIN(58) & DIN(33) & DIN(51) & DIN(17) & DIN(36) & 
		DIN(22) & DIN(50) & DIN(48) & DIN(62) & DIN(37) & DIN(35) & DIN(49) & DIN(35);

	inst81_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init81,
			DOUT        => DOUT(81)
		);
	init81 <= DIN(57) & DIN(4) & DIN(52) & DIN(18) & DIN(61) & DIN(19) & DIN(30) & DIN(6) & 
		DIN(27) & DIN(39) & DIN(47) & DIN(7) & DIN(25) & DIN(42) & DIN(6) & DIN(5) & 
		DIN(24) & DIN(0) & DIN(5) & DIN(32) & DIN(13) & DIN(22) & DIN(44) & DIN(17) & 
		DIN(24) & DIN(30) & DIN(50) & DIN(12) & DIN(5) & DIN(58) & DIN(11) & DIN(39) & 
		DIN(7) & DIN(33) & DIN(51) & DIN(54) & DIN(56) & DIN(55) & DIN(23) & DIN(19) & 
		DIN(14) & DIN(5) & DIN(1) & DIN(20) & DIN(17) & DIN(6) & DIN(63) & DIN(56) & 
		DIN(51) & DIN(47) & DIN(52) & DIN(60) & DIN(62) & DIN(14) & DIN(31) & DIN(12) & 
		DIN(25) & DIN(56) & DIN(1) & DIN(30) & DIN(50) & DIN(42) & DIN(52) & DIN(17);

	inst82_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init82,
			DOUT        => DOUT(82)
		);
	init82 <= DIN(23) & DIN(36) & DIN(30) & DIN(52) & DIN(37) & DIN(46) & DIN(16) & DIN(38) & 
		DIN(56) & DIN(48) & DIN(27) & DIN(20) & DIN(13) & DIN(35) & DIN(15) & DIN(48) & 
		DIN(7) & DIN(48) & DIN(3) & DIN(50) & DIN(43) & DIN(0) & DIN(35) & DIN(42) & 
		DIN(22) & DIN(21) & DIN(47) & DIN(12) & DIN(19) & DIN(11) & DIN(46) & DIN(35) & 
		DIN(63) & DIN(47) & DIN(36) & DIN(63) & DIN(54) & DIN(32) & DIN(11) & DIN(36) & 
		DIN(35) & DIN(55) & DIN(5) & DIN(28) & DIN(28) & DIN(30) & DIN(45) & DIN(21) & 
		DIN(5) & DIN(3) & DIN(14) & DIN(0) & DIN(42) & DIN(14) & DIN(59) & DIN(10) & 
		DIN(1) & DIN(36) & DIN(29) & DIN(48) & DIN(12) & DIN(63) & DIN(62) & DIN(63);

	inst83_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init83,
			DOUT        => DOUT(83)
		);
	init83 <= DIN(4) & DIN(17) & DIN(6) & DIN(10) & DIN(55) & DIN(10) & DIN(63) & DIN(41) & 
		DIN(37) & DIN(24) & DIN(58) & DIN(53) & DIN(23) & DIN(57) & DIN(21) & DIN(60) & 
		DIN(48) & DIN(37) & DIN(60) & DIN(60) & DIN(2) & DIN(32) & DIN(23) & DIN(16) & 
		DIN(10) & DIN(35) & DIN(33) & DIN(39) & DIN(25) & DIN(50) & DIN(39) & DIN(58) & 
		DIN(26) & DIN(60) & DIN(11) & DIN(13) & DIN(36) & DIN(38) & DIN(47) & DIN(48) & 
		DIN(1) & DIN(1) & DIN(32) & DIN(27) & DIN(8) & DIN(48) & DIN(0) & DIN(52) & 
		DIN(35) & DIN(28) & DIN(37) & DIN(50) & DIN(21) & DIN(52) & DIN(47) & DIN(35) & 
		DIN(9) & DIN(46) & DIN(0) & DIN(31) & DIN(24) & DIN(43) & DIN(47) & DIN(12);

	inst84_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init84,
			DOUT        => DOUT(84)
		);
	init84 <= DIN(16) & DIN(62) & DIN(48) & DIN(35) & DIN(52) & DIN(59) & DIN(57) & DIN(23) & 
		DIN(10) & DIN(32) & DIN(0) & DIN(36) & DIN(62) & DIN(51) & DIN(60) & DIN(5) & 
		DIN(12) & DIN(45) & DIN(7) & DIN(26) & DIN(54) & DIN(1) & DIN(61) & DIN(59) & 
		DIN(44) & DIN(6) & DIN(60) & DIN(20) & DIN(18) & DIN(30) & DIN(19) & DIN(45) & 
		DIN(10) & DIN(53) & DIN(42) & DIN(29) & DIN(48) & DIN(25) & DIN(23) & DIN(38) & 
		DIN(34) & DIN(13) & DIN(39) & DIN(56) & DIN(39) & DIN(15) & DIN(62) & DIN(50) & 
		DIN(55) & DIN(5) & DIN(28) & DIN(59) & DIN(21) & DIN(55) & DIN(62) & DIN(24) & 
		DIN(52) & DIN(30) & DIN(1) & DIN(36) & DIN(20) & DIN(30) & DIN(3) & DIN(45);

	inst85_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init85,
			DOUT        => DOUT(85)
		);
	init85 <= DIN(50) & DIN(0) & DIN(28) & DIN(11) & DIN(47) & DIN(0) & DIN(0) & DIN(34) & 
		DIN(53) & DIN(51) & DIN(4) & DIN(12) & DIN(27) & DIN(34) & DIN(29) & DIN(27) & 
		DIN(10) & DIN(13) & DIN(27) & DIN(22) & DIN(60) & DIN(14) & DIN(30) & DIN(48) & 
		DIN(14) & DIN(20) & DIN(43) & DIN(39) & DIN(0) & DIN(39) & DIN(62) & DIN(39) & 
		DIN(16) & DIN(28) & DIN(11) & DIN(13) & DIN(11) & DIN(12) & DIN(29) & DIN(40) & 
		DIN(24) & DIN(34) & DIN(47) & DIN(0) & DIN(24) & DIN(15) & DIN(0) & DIN(52) & 
		DIN(17) & DIN(12) & DIN(55) & DIN(12) & DIN(0) & DIN(10) & DIN(5) & DIN(38) & 
		DIN(20) & DIN(3) & DIN(41) & DIN(25) & DIN(23) & DIN(34) & DIN(28) & DIN(3);

	inst86_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init86,
			DOUT        => DOUT(86)
		);
	init86 <= DIN(8) & DIN(35) & DIN(44) & DIN(35) & DIN(0) & DIN(11) & DIN(37) & DIN(57) & 
		DIN(28) & DIN(39) & DIN(14) & DIN(56) & DIN(24) & DIN(35) & DIN(20) & DIN(44) & 
		DIN(46) & DIN(35) & DIN(4) & DIN(5) & DIN(14) & DIN(62) & DIN(57) & DIN(20) & 
		DIN(2) & DIN(58) & DIN(53) & DIN(28) & DIN(56) & DIN(37) & DIN(20) & DIN(37) & 
		DIN(34) & DIN(33) & DIN(62) & DIN(7) & DIN(47) & DIN(62) & DIN(43) & DIN(36) & 
		DIN(14) & DIN(42) & DIN(36) & DIN(44) & DIN(53) & DIN(48) & DIN(40) & DIN(41) & 
		DIN(21) & DIN(6) & DIN(12) & DIN(58) & DIN(60) & DIN(62) & DIN(31) & DIN(38) & 
		DIN(2) & DIN(16) & DIN(7) & DIN(18) & DIN(2) & DIN(51) & DIN(39) & DIN(27);

	inst87_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init87,
			DOUT        => DOUT(87)
		);
	init87 <= DIN(37) & DIN(4) & DIN(0) & DIN(40) & DIN(31) & DIN(35) & DIN(51) & DIN(60) & 
		DIN(15) & DIN(33) & DIN(5) & DIN(29) & DIN(15) & DIN(25) & DIN(17) & DIN(55) & 
		DIN(9) & DIN(43) & DIN(44) & DIN(49) & DIN(30) & DIN(5) & DIN(45) & DIN(61) & 
		DIN(12) & DIN(12) & DIN(32) & DIN(24) & DIN(58) & DIN(1) & DIN(29) & DIN(61) & 
		DIN(36) & DIN(29) & DIN(53) & DIN(35) & DIN(20) & DIN(18) & DIN(55) & DIN(49) & 
		DIN(17) & DIN(44) & DIN(12) & DIN(24) & DIN(16) & DIN(37) & DIN(10) & DIN(24) & 
		DIN(13) & DIN(39) & DIN(4) & DIN(33) & DIN(57) & DIN(32) & DIN(29) & DIN(52) & 
		DIN(18) & DIN(31) & DIN(59) & DIN(61) & DIN(29) & DIN(0) & DIN(8) & DIN(1);

	inst88_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init88,
			DOUT        => DOUT(88)
		);
	init88 <= DIN(27) & DIN(31) & DIN(11) & DIN(5) & DIN(50) & DIN(47) & DIN(52) & DIN(35) & 
		DIN(55) & DIN(40) & DIN(20) & DIN(40) & DIN(59) & DIN(41) & DIN(11) & DIN(10) & 
		DIN(13) & DIN(16) & DIN(30) & DIN(15) & DIN(36) & DIN(11) & DIN(33) & DIN(47) & 
		DIN(1) & DIN(31) & DIN(38) & DIN(40) & DIN(60) & DIN(35) & DIN(60) & DIN(22) & 
		DIN(45) & DIN(28) & DIN(16) & DIN(15) & DIN(55) & DIN(12) & DIN(14) & DIN(15) & 
		DIN(45) & DIN(43) & DIN(28) & DIN(49) & DIN(28) & DIN(59) & DIN(44) & DIN(62) & 
		DIN(44) & DIN(19) & DIN(45) & DIN(53) & DIN(10) & DIN(2) & DIN(8) & DIN(25) & 
		DIN(35) & DIN(3) & DIN(44) & DIN(38) & DIN(54) & DIN(31) & DIN(5) & DIN(30);

	inst89_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init89,
			DOUT        => DOUT(89)
		);
	init89 <= DIN(25) & DIN(16) & DIN(12) & DIN(48) & DIN(23) & DIN(49) & DIN(9) & DIN(38) & 
		DIN(49) & DIN(2) & DIN(0) & DIN(54) & DIN(44) & DIN(9) & DIN(48) & DIN(58) & 
		DIN(9) & DIN(17) & DIN(28) & DIN(50) & DIN(46) & DIN(39) & DIN(38) & DIN(20) & 
		DIN(0) & DIN(42) & DIN(25) & DIN(40) & DIN(18) & DIN(40) & DIN(50) & DIN(41) & 
		DIN(57) & DIN(27) & DIN(38) & DIN(49) & DIN(0) & DIN(7) & DIN(38) & DIN(59) & 
		DIN(21) & DIN(55) & DIN(6) & DIN(50) & DIN(63) & DIN(30) & DIN(30) & DIN(23) & 
		DIN(35) & DIN(52) & DIN(12) & DIN(25) & DIN(39) & DIN(60) & DIN(59) & DIN(24) & 
		DIN(24) & DIN(48) & DIN(54) & DIN(41) & DIN(47) & DIN(23) & DIN(2) & DIN(7);

	inst90_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init90,
			DOUT        => DOUT(90)
		);
	init90 <= DIN(58) & DIN(0) & DIN(29) & DIN(51) & DIN(5) & DIN(55) & DIN(38) & DIN(9) & 
		DIN(42) & DIN(41) & DIN(26) & DIN(13) & DIN(3) & DIN(28) & DIN(57) & DIN(4) & 
		DIN(15) & DIN(40) & DIN(4) & DIN(57) & DIN(3) & DIN(14) & DIN(19) & DIN(24) & 
		DIN(33) & DIN(63) & DIN(9) & DIN(38) & DIN(24) & DIN(33) & DIN(17) & DIN(6) & 
		DIN(58) & DIN(38) & DIN(13) & DIN(60) & DIN(13) & DIN(61) & DIN(47) & DIN(29) & 
		DIN(37) & DIN(62) & DIN(19) & DIN(63) & DIN(12) & DIN(17) & DIN(63) & DIN(22) & 
		DIN(37) & DIN(54) & DIN(38) & DIN(43) & DIN(45) & DIN(20) & DIN(15) & DIN(59) & 
		DIN(38) & DIN(39) & DIN(21) & DIN(18) & DIN(39) & DIN(43) & DIN(57) & DIN(62);

	inst91_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init91,
			DOUT        => DOUT(91)
		);
	init91 <= DIN(55) & DIN(20) & DIN(1) & DIN(34) & DIN(52) & DIN(53) & DIN(47) & DIN(2) & 
		DIN(36) & DIN(60) & DIN(45) & DIN(6) & DIN(15) & DIN(15) & DIN(14) & DIN(43) & 
		DIN(27) & DIN(63) & DIN(33) & DIN(52) & DIN(51) & DIN(51) & DIN(7) & DIN(44) & 
		DIN(20) & DIN(1) & DIN(41) & DIN(47) & DIN(63) & DIN(52) & DIN(30) & DIN(20) & 
		DIN(32) & DIN(11) & DIN(51) & DIN(50) & DIN(17) & DIN(51) & DIN(21) & DIN(30) & 
		DIN(45) & DIN(30) & DIN(56) & DIN(36) & DIN(52) & DIN(15) & DIN(10) & DIN(39) & 
		DIN(11) & DIN(46) & DIN(45) & DIN(7) & DIN(30) & DIN(5) & DIN(3) & DIN(37) & 
		DIN(2) & DIN(53) & DIN(17) & DIN(42) & DIN(20) & DIN(18) & DIN(33) & DIN(46);

	inst92_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init92,
			DOUT        => DOUT(92)
		);
	init92 <= DIN(20) & DIN(51) & DIN(47) & DIN(53) & DIN(21) & DIN(57) & DIN(30) & DIN(23) & 
		DIN(57) & DIN(27) & DIN(25) & DIN(28) & DIN(13) & DIN(17) & DIN(47) & DIN(2) & 
		DIN(45) & DIN(62) & DIN(36) & DIN(15) & DIN(28) & DIN(21) & DIN(63) & DIN(37) & 
		DIN(34) & DIN(46) & DIN(15) & DIN(36) & DIN(17) & DIN(44) & DIN(44) & DIN(31) & 
		DIN(29) & DIN(54) & DIN(23) & DIN(62) & DIN(63) & DIN(2) & DIN(61) & DIN(29) & 
		DIN(14) & DIN(8) & DIN(45) & DIN(11) & DIN(36) & DIN(49) & DIN(30) & DIN(30) & 
		DIN(34) & DIN(14) & DIN(16) & DIN(55) & DIN(51) & DIN(17) & DIN(22) & DIN(62) & 
		DIN(29) & DIN(35) & DIN(55) & DIN(49) & DIN(14) & DIN(54) & DIN(8) & DIN(31);

	inst93_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init93,
			DOUT        => DOUT(93)
		);
	init93 <= DIN(28) & DIN(25) & DIN(43) & DIN(34) & DIN(35) & DIN(60) & DIN(7) & DIN(8) & 
		DIN(34) & DIN(31) & DIN(29) & DIN(61) & DIN(12) & DIN(43) & DIN(54) & DIN(17) & 
		DIN(51) & DIN(11) & DIN(47) & DIN(23) & DIN(45) & DIN(30) & DIN(42) & DIN(17) & 
		DIN(59) & DIN(59) & DIN(25) & DIN(40) & DIN(40) & DIN(54) & DIN(20) & DIN(58) & 
		DIN(54) & DIN(46) & DIN(27) & DIN(26) & DIN(26) & DIN(40) & DIN(43) & DIN(37) & 
		DIN(18) & DIN(50) & DIN(7) & DIN(59) & DIN(56) & DIN(43) & DIN(34) & DIN(28) & 
		DIN(30) & DIN(16) & DIN(45) & DIN(28) & DIN(35) & DIN(47) & DIN(56) & DIN(19) & 
		DIN(19) & DIN(34) & DIN(20) & DIN(46) & DIN(0) & DIN(37) & DIN(31) & DIN(28);

	inst94_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init94,
			DOUT        => DOUT(94)
		);
	init94 <= DIN(41) & DIN(8) & DIN(31) & DIN(24) & DIN(25) & DIN(45) & DIN(23) & DIN(41) & 
		DIN(24) & DIN(47) & DIN(36) & DIN(36) & DIN(43) & DIN(27) & DIN(56) & DIN(47) & 
		DIN(53) & DIN(42) & DIN(16) & DIN(13) & DIN(41) & DIN(29) & DIN(27) & DIN(57) & 
		DIN(29) & DIN(52) & DIN(56) & DIN(52) & DIN(58) & DIN(22) & DIN(53) & DIN(17) & 
		DIN(47) & DIN(49) & DIN(1) & DIN(48) & DIN(21) & DIN(39) & DIN(5) & DIN(51) & 
		DIN(4) & DIN(8) & DIN(44) & DIN(60) & DIN(38) & DIN(13) & DIN(30) & DIN(40) & 
		DIN(1) & DIN(51) & DIN(50) & DIN(48) & DIN(0) & DIN(39) & DIN(1) & DIN(41) & 
		DIN(58) & DIN(34) & DIN(63) & DIN(41) & DIN(39) & DIN(4) & DIN(16) & DIN(63);

	inst95_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init95,
			DOUT        => DOUT(95)
		);
	init95 <= DIN(6) & DIN(57) & DIN(9) & DIN(42) & DIN(0) & DIN(19) & DIN(44) & DIN(27) & 
		DIN(6) & DIN(54) & DIN(21) & DIN(17) & DIN(25) & DIN(60) & DIN(51) & DIN(37) & 
		DIN(60) & DIN(5) & DIN(21) & DIN(32) & DIN(1) & DIN(33) & DIN(60) & DIN(45) & 
		DIN(34) & DIN(2) & DIN(41) & DIN(48) & DIN(50) & DIN(2) & DIN(25) & DIN(28) & 
		DIN(57) & DIN(54) & DIN(62) & DIN(37) & DIN(13) & DIN(54) & DIN(6) & DIN(53) & 
		DIN(29) & DIN(24) & DIN(30) & DIN(52) & DIN(0) & DIN(46) & DIN(16) & DIN(28) & 
		DIN(3) & DIN(52) & DIN(36) & DIN(20) & DIN(63) & DIN(57) & DIN(4) & DIN(50) & 
		DIN(16) & DIN(38) & DIN(23) & DIN(22) & DIN(9) & DIN(35) & DIN(30) & DIN(20);

	inst96_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init96,
			DOUT        => DOUT(96)
		);
	init96 <= DIN(57) & DIN(2) & DIN(8) & DIN(3) & DIN(30) & DIN(10) & DIN(10) & DIN(29) & 
		DIN(19) & DIN(10) & DIN(38) & DIN(6) & DIN(10) & DIN(2) & DIN(37) & DIN(37) & 
		DIN(36) & DIN(59) & DIN(21) & DIN(24) & DIN(43) & DIN(1) & DIN(0) & DIN(0) & 
		DIN(42) & DIN(44) & DIN(42) & DIN(50) & DIN(26) & DIN(54) & DIN(55) & DIN(53) & 
		DIN(35) & DIN(62) & DIN(57) & DIN(1) & DIN(55) & DIN(0) & DIN(55) & DIN(13) & 
		DIN(0) & DIN(36) & DIN(32) & DIN(37) & DIN(29) & DIN(42) & DIN(16) & DIN(12) & 
		DIN(16) & DIN(19) & DIN(24) & DIN(43) & DIN(23) & DIN(19) & DIN(21) & DIN(55) & 
		DIN(18) & DIN(52) & DIN(59) & DIN(37) & DIN(18) & DIN(57) & DIN(60) & DIN(34);

	inst97_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init97,
			DOUT        => DOUT(97)
		);
	init97 <= DIN(32) & DIN(39) & DIN(61) & DIN(5) & DIN(13) & DIN(11) & DIN(34) & DIN(51) & 
		DIN(18) & DIN(1) & DIN(33) & DIN(28) & DIN(63) & DIN(25) & DIN(49) & DIN(26) & 
		DIN(37) & DIN(15) & DIN(27) & DIN(54) & DIN(56) & DIN(30) & DIN(45) & DIN(5) & 
		DIN(5) & DIN(32) & DIN(40) & DIN(5) & DIN(61) & DIN(12) & DIN(5) & DIN(27) & 
		DIN(26) & DIN(50) & DIN(35) & DIN(26) & DIN(57) & DIN(33) & DIN(18) & DIN(53) & 
		DIN(2) & DIN(7) & DIN(43) & DIN(37) & DIN(52) & DIN(33) & DIN(63) & DIN(46) & 
		DIN(23) & DIN(61) & DIN(9) & DIN(50) & DIN(24) & DIN(13) & DIN(29) & DIN(0) & 
		DIN(34) & DIN(28) & DIN(0) & DIN(34) & DIN(50) & DIN(19) & DIN(56) & DIN(63);

	inst98_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init98,
			DOUT        => DOUT(98)
		);
	init98 <= DIN(57) & DIN(40) & DIN(49) & DIN(28) & DIN(21) & DIN(7) & DIN(50) & DIN(5) & 
		DIN(62) & DIN(48) & DIN(50) & DIN(59) & DIN(60) & DIN(42) & DIN(26) & DIN(58) & 
		DIN(52) & DIN(58) & DIN(26) & DIN(27) & DIN(26) & DIN(19) & DIN(50) & DIN(19) & 
		DIN(49) & DIN(25) & DIN(40) & DIN(5) & DIN(56) & DIN(26) & DIN(7) & DIN(29) & 
		DIN(18) & DIN(41) & DIN(41) & DIN(16) & DIN(9) & DIN(2) & DIN(19) & DIN(3) & 
		DIN(52) & DIN(8) & DIN(33) & DIN(1) & DIN(54) & DIN(31) & DIN(32) & DIN(25) & 
		DIN(32) & DIN(7) & DIN(40) & DIN(6) & DIN(34) & DIN(25) & DIN(43) & DIN(43) & 
		DIN(33) & DIN(13) & DIN(62) & DIN(27) & DIN(8) & DIN(30) & DIN(51) & DIN(2);

	inst99_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init99,
			DOUT        => DOUT(99)
		);
	init99 <= DIN(28) & DIN(31) & DIN(31) & DIN(45) & DIN(8) & DIN(21) & DIN(0) & DIN(42) & 
		DIN(3) & DIN(59) & DIN(60) & DIN(14) & DIN(11) & DIN(22) & DIN(11) & DIN(33) & 
		DIN(47) & DIN(56) & DIN(42) & DIN(2) & DIN(34) & DIN(29) & DIN(48) & DIN(6) & 
		DIN(4) & DIN(24) & DIN(4) & DIN(7) & DIN(26) & DIN(21) & DIN(60) & DIN(47) & 
		DIN(23) & DIN(10) & DIN(45) & DIN(30) & DIN(17) & DIN(5) & DIN(45) & DIN(53) & 
		DIN(47) & DIN(38) & DIN(3) & DIN(42) & DIN(39) & DIN(18) & DIN(55) & DIN(44) & 
		DIN(22) & DIN(13) & DIN(18) & DIN(28) & DIN(24) & DIN(24) & DIN(2) & DIN(61) & 
		DIN(62) & DIN(47) & DIN(11) & DIN(42) & DIN(62) & DIN(49) & DIN(2) & DIN(56);

	inst100_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init100,
			DOUT        => DOUT(100)
		);
	init100 <= DIN(30) & DIN(63) & DIN(58) & DIN(21) & DIN(58) & DIN(26) & DIN(0) & DIN(16) & 
		DIN(23) & DIN(10) & DIN(5) & DIN(1) & DIN(29) & DIN(16) & DIN(43) & DIN(26) & 
		DIN(30) & DIN(16) & DIN(20) & DIN(58) & DIN(1) & DIN(36) & DIN(33) & DIN(19) & 
		DIN(35) & DIN(0) & DIN(15) & DIN(36) & DIN(2) & DIN(40) & DIN(22) & DIN(9) & 
		DIN(5) & DIN(31) & DIN(21) & DIN(42) & DIN(3) & DIN(53) & DIN(10) & DIN(22) & 
		DIN(45) & DIN(53) & DIN(22) & DIN(3) & DIN(50) & DIN(27) & DIN(6) & DIN(36) & 
		DIN(15) & DIN(48) & DIN(25) & DIN(46) & DIN(1) & DIN(32) & DIN(4) & DIN(62) & 
		DIN(62) & DIN(39) & DIN(14) & DIN(56) & DIN(34) & DIN(54) & DIN(52) & DIN(27);

	inst101_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init101,
			DOUT        => DOUT(101)
		);
	init101 <= DIN(11) & DIN(38) & DIN(29) & DIN(42) & DIN(34) & DIN(23) & DIN(49) & DIN(46) & 
		DIN(48) & DIN(56) & DIN(52) & DIN(30) & DIN(56) & DIN(20) & DIN(12) & DIN(9) & 
		DIN(12) & DIN(5) & DIN(31) & DIN(6) & DIN(27) & DIN(5) & DIN(43) & DIN(11) & 
		DIN(9) & DIN(32) & DIN(16) & DIN(7) & DIN(23) & DIN(56) & DIN(38) & DIN(32) & 
		DIN(4) & DIN(5) & DIN(57) & DIN(52) & DIN(39) & DIN(57) & DIN(58) & DIN(18) & 
		DIN(63) & DIN(31) & DIN(18) & DIN(47) & DIN(8) & DIN(7) & DIN(42) & DIN(6) & 
		DIN(42) & DIN(26) & DIN(27) & DIN(15) & DIN(60) & DIN(10) & DIN(59) & DIN(2) & 
		DIN(9) & DIN(23) & DIN(33) & DIN(54) & DIN(52) & DIN(32) & DIN(39) & DIN(16);

	inst102_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init102,
			DOUT        => DOUT(102)
		);
	init102 <= DIN(36) & DIN(57) & DIN(8) & DIN(7) & DIN(12) & DIN(48) & DIN(9) & DIN(34) & 
		DIN(36) & DIN(48) & DIN(21) & DIN(2) & DIN(58) & DIN(32) & DIN(17) & DIN(49) & 
		DIN(27) & DIN(25) & DIN(29) & DIN(52) & DIN(25) & DIN(29) & DIN(26) & DIN(34) & 
		DIN(41) & DIN(5) & DIN(10) & DIN(60) & DIN(11) & DIN(55) & DIN(57) & DIN(29) & 
		DIN(45) & DIN(23) & DIN(62) & DIN(42) & DIN(12) & DIN(24) & DIN(13) & DIN(34) & 
		DIN(54) & DIN(53) & DIN(48) & DIN(8) & DIN(5) & DIN(56) & DIN(20) & DIN(38) & 
		DIN(0) & DIN(0) & DIN(26) & DIN(55) & DIN(51) & DIN(21) & DIN(24) & DIN(45) & 
		DIN(58) & DIN(19) & DIN(2) & DIN(46) & DIN(10) & DIN(34) & DIN(30) & DIN(3);

	inst103_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init103,
			DOUT        => DOUT(103)
		);
	init103 <= DIN(7) & DIN(6) & DIN(43) & DIN(25) & DIN(6) & DIN(57) & DIN(27) & DIN(7) & 
		DIN(43) & DIN(23) & DIN(17) & DIN(37) & DIN(32) & DIN(11) & DIN(40) & DIN(11) & 
		DIN(41) & DIN(28) & DIN(11) & DIN(9) & DIN(9) & DIN(44) & DIN(58) & DIN(40) & 
		DIN(39) & DIN(5) & DIN(36) & DIN(23) & DIN(40) & DIN(61) & DIN(34) & DIN(46) & 
		DIN(0) & DIN(50) & DIN(61) & DIN(62) & DIN(13) & DIN(4) & DIN(54) & DIN(6) & 
		DIN(55) & DIN(6) & DIN(61) & DIN(21) & DIN(34) & DIN(12) & DIN(63) & DIN(32) & 
		DIN(18) & DIN(31) & DIN(14) & DIN(33) & DIN(4) & DIN(53) & DIN(4) & DIN(16) & 
		DIN(28) & DIN(39) & DIN(53) & DIN(58) & DIN(61) & DIN(48) & DIN(48) & DIN(1);

	inst104_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init104,
			DOUT        => DOUT(104)
		);
	init104 <= DIN(10) & DIN(11) & DIN(45) & DIN(54) & DIN(42) & DIN(43) & DIN(37) & DIN(23) & 
		DIN(49) & DIN(27) & DIN(46) & DIN(15) & DIN(22) & DIN(63) & DIN(9) & DIN(25) & 
		DIN(59) & DIN(27) & DIN(45) & DIN(28) & DIN(12) & DIN(12) & DIN(38) & DIN(9) & 
		DIN(20) & DIN(12) & DIN(17) & DIN(37) & DIN(60) & DIN(5) & DIN(49) & DIN(20) & 
		DIN(32) & DIN(1) & DIN(16) & DIN(19) & DIN(58) & DIN(10) & DIN(40) & DIN(33) & 
		DIN(4) & DIN(47) & DIN(6) & DIN(61) & DIN(4) & DIN(46) & DIN(44) & DIN(30) & 
		DIN(14) & DIN(33) & DIN(54) & DIN(3) & DIN(56) & DIN(26) & DIN(56) & DIN(47) & 
		DIN(16) & DIN(12) & DIN(52) & DIN(40) & DIN(36) & DIN(47) & DIN(3) & DIN(13);

	inst105_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init105,
			DOUT        => DOUT(105)
		);
	init105 <= DIN(1) & DIN(27) & DIN(44) & DIN(38) & DIN(9) & DIN(41) & DIN(28) & DIN(21) & 
		DIN(49) & DIN(28) & DIN(14) & DIN(46) & DIN(7) & DIN(51) & DIN(17) & DIN(9) & 
		DIN(8) & DIN(15) & DIN(58) & DIN(45) & DIN(36) & DIN(41) & DIN(28) & DIN(18) & 
		DIN(20) & DIN(37) & DIN(45) & DIN(27) & DIN(59) & DIN(21) & DIN(8) & DIN(26) & 
		DIN(18) & DIN(2) & DIN(10) & DIN(52) & DIN(56) & DIN(63) & DIN(7) & DIN(2) & 
		DIN(21) & DIN(27) & DIN(29) & DIN(62) & DIN(42) & DIN(2) & DIN(15) & DIN(27) & 
		DIN(43) & DIN(16) & DIN(17) & DIN(18) & DIN(21) & DIN(54) & DIN(36) & DIN(57) & 
		DIN(42) & DIN(24) & DIN(18) & DIN(33) & DIN(3) & DIN(6) & DIN(16) & DIN(30);

	inst106_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init106,
			DOUT        => DOUT(106)
		);
	init106 <= DIN(1) & DIN(31) & DIN(2) & DIN(32) & DIN(0) & DIN(10) & DIN(48) & DIN(21) & 
		DIN(19) & DIN(27) & DIN(23) & DIN(3) & DIN(16) & DIN(2) & DIN(14) & DIN(27) & 
		DIN(30) & DIN(54) & DIN(52) & DIN(40) & DIN(38) & DIN(0) & DIN(4) & DIN(31) & 
		DIN(20) & DIN(48) & DIN(18) & DIN(22) & DIN(63) & DIN(46) & DIN(52) & DIN(33) & 
		DIN(31) & DIN(56) & DIN(48) & DIN(42) & DIN(55) & DIN(20) & DIN(62) & DIN(16) & 
		DIN(11) & DIN(21) & DIN(52) & DIN(53) & DIN(36) & DIN(24) & DIN(39) & DIN(53) & 
		DIN(16) & DIN(52) & DIN(36) & DIN(7) & DIN(43) & DIN(20) & DIN(13) & DIN(62) & 
		DIN(48) & DIN(35) & DIN(34) & DIN(30) & DIN(15) & DIN(60) & DIN(49) & DIN(52);

	inst107_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init107,
			DOUT        => DOUT(107)
		);
	init107 <= DIN(50) & DIN(37) & DIN(35) & DIN(28) & DIN(33) & DIN(53) & DIN(19) & DIN(20) & 
		DIN(8) & DIN(41) & DIN(10) & DIN(59) & DIN(63) & DIN(10) & DIN(30) & DIN(42) & 
		DIN(29) & DIN(28) & DIN(45) & DIN(52) & DIN(43) & DIN(49) & DIN(25) & DIN(21) & 
		DIN(20) & DIN(52) & DIN(51) & DIN(31) & DIN(54) & DIN(17) & DIN(46) & DIN(22) & 
		DIN(4) & DIN(46) & DIN(9) & DIN(13) & DIN(45) & DIN(42) & DIN(10) & DIN(13) & 
		DIN(42) & DIN(0) & DIN(29) & DIN(20) & DIN(44) & DIN(1) & DIN(61) & DIN(41) & 
		DIN(49) & DIN(59) & DIN(27) & DIN(22) & DIN(29) & DIN(36) & DIN(34) & DIN(53) & 
		DIN(62) & DIN(34) & DIN(48) & DIN(31) & DIN(13) & DIN(0) & DIN(13) & DIN(55);

	inst108_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init108,
			DOUT        => DOUT(108)
		);
	init108 <= DIN(23) & DIN(45) & DIN(52) & DIN(41) & DIN(27) & DIN(29) & DIN(50) & DIN(26) & 
		DIN(56) & DIN(33) & DIN(60) & DIN(48) & DIN(49) & DIN(19) & DIN(58) & DIN(21) & 
		DIN(50) & DIN(46) & DIN(4) & DIN(12) & DIN(32) & DIN(60) & DIN(4) & DIN(61) & 
		DIN(18) & DIN(24) & DIN(7) & DIN(28) & DIN(24) & DIN(3) & DIN(63) & DIN(46) & 
		DIN(18) & DIN(23) & DIN(55) & DIN(1) & DIN(36) & DIN(17) & DIN(30) & DIN(8) & 
		DIN(48) & DIN(41) & DIN(53) & DIN(27) & DIN(33) & DIN(12) & DIN(17) & DIN(38) & 
		DIN(13) & DIN(7) & DIN(8) & DIN(35) & DIN(42) & DIN(43) & DIN(54) & DIN(54) & 
		DIN(0) & DIN(4) & DIN(29) & DIN(42) & DIN(48) & DIN(40) & DIN(55) & DIN(17);

	inst109_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init109,
			DOUT        => DOUT(109)
		);
	init109 <= DIN(7) & DIN(47) & DIN(46) & DIN(27) & DIN(4) & DIN(48) & DIN(31) & DIN(12) & 
		DIN(9) & DIN(16) & DIN(8) & DIN(12) & DIN(29) & DIN(33) & DIN(2) & DIN(3) & 
		DIN(50) & DIN(24) & DIN(38) & DIN(52) & DIN(32) & DIN(27) & DIN(48) & DIN(61) & 
		DIN(3) & DIN(26) & DIN(30) & DIN(54) & DIN(36) & DIN(59) & DIN(46) & DIN(44) & 
		DIN(43) & DIN(62) & DIN(60) & DIN(56) & DIN(38) & DIN(14) & DIN(4) & DIN(61) & 
		DIN(51) & DIN(39) & DIN(10) & DIN(25) & DIN(46) & DIN(41) & DIN(29) & DIN(62) & 
		DIN(56) & DIN(10) & DIN(4) & DIN(35) & DIN(24) & DIN(22) & DIN(31) & DIN(12) & 
		DIN(53) & DIN(34) & DIN(8) & DIN(56) & DIN(16) & DIN(48) & DIN(48) & DIN(51);

	inst110_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init110,
			DOUT        => DOUT(110)
		);
	init110 <= DIN(23) & DIN(19) & DIN(13) & DIN(39) & DIN(2) & DIN(3) & DIN(34) & DIN(14) & 
		DIN(1) & DIN(12) & DIN(7) & DIN(26) & DIN(59) & DIN(49) & DIN(18) & DIN(53) & 
		DIN(36) & DIN(27) & DIN(56) & DIN(35) & DIN(0) & DIN(27) & DIN(37) & DIN(41) & 
		DIN(49) & DIN(63) & DIN(56) & DIN(59) & DIN(57) & DIN(35) & DIN(53) & DIN(48) & 
		DIN(16) & DIN(9) & DIN(5) & DIN(52) & DIN(2) & DIN(21) & DIN(6) & DIN(39) & 
		DIN(17) & DIN(22) & DIN(8) & DIN(5) & DIN(13) & DIN(55) & DIN(61) & DIN(0) & 
		DIN(26) & DIN(28) & DIN(62) & DIN(23) & DIN(42) & DIN(38) & DIN(49) & DIN(54) & 
		DIN(6) & DIN(21) & DIN(6) & DIN(9) & DIN(18) & DIN(44) & DIN(43) & DIN(28);

	inst111_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init111,
			DOUT        => DOUT(111)
		);
	init111 <= DIN(18) & DIN(53) & DIN(39) & DIN(4) & DIN(0) & DIN(7) & DIN(45) & DIN(14) & 
		DIN(62) & DIN(40) & DIN(40) & DIN(28) & DIN(38) & DIN(6) & DIN(28) & DIN(50) & 
		DIN(38) & DIN(41) & DIN(6) & DIN(32) & DIN(48) & DIN(10) & DIN(44) & DIN(45) & 
		DIN(51) & DIN(20) & DIN(34) & DIN(63) & DIN(60) & DIN(51) & DIN(48) & DIN(13) & 
		DIN(53) & DIN(32) & DIN(23) & DIN(50) & DIN(9) & DIN(4) & DIN(37) & DIN(34) & 
		DIN(2) & DIN(34) & DIN(0) & DIN(52) & DIN(32) & DIN(51) & DIN(44) & DIN(6) & 
		DIN(56) & DIN(59) & DIN(51) & DIN(3) & DIN(23) & DIN(24) & DIN(11) & DIN(52) & 
		DIN(24) & DIN(47) & DIN(15) & DIN(46) & DIN(62) & DIN(16) & DIN(54) & DIN(2);

	inst112_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init112,
			DOUT        => DOUT(112)
		);
	init112 <= DIN(26) & DIN(11) & DIN(45) & DIN(42) & DIN(59) & DIN(14) & DIN(34) & DIN(2) & 
		DIN(1) & DIN(16) & DIN(49) & DIN(57) & DIN(63) & DIN(40) & DIN(29) & DIN(59) & 
		DIN(29) & DIN(42) & DIN(32) & DIN(46) & DIN(30) & DIN(12) & DIN(28) & DIN(4) & 
		DIN(29) & DIN(51) & DIN(48) & DIN(15) & DIN(59) & DIN(38) & DIN(45) & DIN(48) & 
		DIN(16) & DIN(31) & DIN(7) & DIN(56) & DIN(13) & DIN(18) & DIN(17) & DIN(8) & 
		DIN(17) & DIN(9) & DIN(27) & DIN(3) & DIN(11) & DIN(51) & DIN(27) & DIN(46) & 
		DIN(12) & DIN(20) & DIN(18) & DIN(26) & DIN(46) & DIN(41) & DIN(20) & DIN(14) & 
		DIN(56) & DIN(9) & DIN(34) & DIN(11) & DIN(22) & DIN(14) & DIN(40) & DIN(23);

	inst113_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init113,
			DOUT        => DOUT(113)
		);
	init113 <= DIN(56) & DIN(5) & DIN(0) & DIN(52) & DIN(41) & DIN(27) & DIN(34) & DIN(39) & 
		DIN(16) & DIN(26) & DIN(18) & DIN(47) & DIN(14) & DIN(12) & DIN(48) & DIN(4) & 
		DIN(8) & DIN(2) & DIN(43) & DIN(60) & DIN(19) & DIN(59) & DIN(14) & DIN(32) & 
		DIN(39) & DIN(11) & DIN(13) & DIN(2) & DIN(37) & DIN(6) & DIN(58) & DIN(4) & 
		DIN(28) & DIN(37) & DIN(18) & DIN(2) & DIN(11) & DIN(7) & DIN(20) & DIN(33) & 
		DIN(12) & DIN(6) & DIN(62) & DIN(10) & DIN(4) & DIN(46) & DIN(24) & DIN(11) & 
		DIN(47) & DIN(48) & DIN(46) & DIN(51) & DIN(19) & DIN(3) & DIN(19) & DIN(37) & 
		DIN(37) & DIN(7) & DIN(8) & DIN(33) & DIN(41) & DIN(21) & DIN(49) & DIN(26);

	inst114_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init114,
			DOUT        => DOUT(114)
		);
	init114 <= DIN(49) & DIN(23) & DIN(43) & DIN(53) & DIN(4) & DIN(37) & DIN(5) & DIN(43) & 
		DIN(24) & DIN(26) & DIN(18) & DIN(63) & DIN(24) & DIN(20) & DIN(8) & DIN(61) & 
		DIN(38) & DIN(43) & DIN(52) & DIN(39) & DIN(29) & DIN(56) & DIN(25) & DIN(18) & 
		DIN(4) & DIN(13) & DIN(51) & DIN(13) & DIN(20) & DIN(15) & DIN(36) & DIN(60) & 
		DIN(19) & DIN(6) & DIN(48) & DIN(25) & DIN(13) & DIN(43) & DIN(25) & DIN(25) & 
		DIN(2) & DIN(62) & DIN(55) & DIN(27) & DIN(46) & DIN(28) & DIN(8) & DIN(63) & 
		DIN(14) & DIN(60) & DIN(14) & DIN(10) & DIN(52) & DIN(12) & DIN(31) & DIN(55) & 
		DIN(56) & DIN(36) & DIN(41) & DIN(24) & DIN(60) & DIN(30) & DIN(11) & DIN(58);

	inst115_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init115,
			DOUT        => DOUT(115)
		);
	init115 <= DIN(0) & DIN(57) & DIN(39) & DIN(49) & DIN(4) & DIN(62) & DIN(8) & DIN(31) & 
		DIN(7) & DIN(55) & DIN(37) & DIN(5) & DIN(43) & DIN(16) & DIN(8) & DIN(10) & 
		DIN(20) & DIN(37) & DIN(59) & DIN(22) & DIN(26) & DIN(1) & DIN(33) & DIN(12) & 
		DIN(46) & DIN(23) & DIN(50) & DIN(2) & DIN(42) & DIN(17) & DIN(47) & DIN(15) & 
		DIN(53) & DIN(41) & DIN(40) & DIN(37) & DIN(55) & DIN(17) & DIN(58) & DIN(2) & 
		DIN(12) & DIN(20) & DIN(61) & DIN(33) & DIN(60) & DIN(35) & DIN(14) & DIN(61) & 
		DIN(11) & DIN(58) & DIN(53) & DIN(14) & DIN(19) & DIN(10) & DIN(25) & DIN(44) & 
		DIN(45) & DIN(33) & DIN(19) & DIN(26) & DIN(28) & DIN(6) & DIN(39) & DIN(15);

	inst116_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init116,
			DOUT        => DOUT(116)
		);
	init116 <= DIN(48) & DIN(22) & DIN(5) & DIN(5) & DIN(61) & DIN(27) & DIN(38) & DIN(59) & 
		DIN(50) & DIN(0) & DIN(32) & DIN(57) & DIN(30) & DIN(3) & DIN(9) & DIN(28) & 
		DIN(46) & DIN(17) & DIN(62) & DIN(29) & DIN(3) & DIN(49) & DIN(21) & DIN(0) & 
		DIN(56) & DIN(49) & DIN(56) & DIN(22) & DIN(40) & DIN(49) & DIN(20) & DIN(42) & 
		DIN(25) & DIN(42) & DIN(31) & DIN(2) & DIN(41) & DIN(38) & DIN(27) & DIN(56) & 
		DIN(33) & DIN(28) & DIN(48) & DIN(2) & DIN(21) & DIN(56) & DIN(29) & DIN(16) & 
		DIN(13) & DIN(13) & DIN(8) & DIN(3) & DIN(57) & DIN(35) & DIN(8) & DIN(34) & 
		DIN(9) & DIN(6) & DIN(1) & DIN(61) & DIN(24) & DIN(42) & DIN(11) & DIN(22);

	inst117_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init117,
			DOUT        => DOUT(117)
		);
	init117 <= DIN(31) & DIN(15) & DIN(16) & DIN(58) & DIN(11) & DIN(33) & DIN(30) & DIN(32) & 
		DIN(35) & DIN(24) & DIN(59) & DIN(42) & DIN(15) & DIN(50) & DIN(23) & DIN(2) & 
		DIN(26) & DIN(4) & DIN(20) & DIN(60) & DIN(15) & DIN(42) & DIN(40) & DIN(55) & 
		DIN(46) & DIN(36) & DIN(29) & DIN(16) & DIN(36) & DIN(52) & DIN(6) & DIN(36) & 
		DIN(4) & DIN(46) & DIN(28) & DIN(42) & DIN(62) & DIN(6) & DIN(37) & DIN(57) & 
		DIN(8) & DIN(9) & DIN(19) & DIN(13) & DIN(23) & DIN(19) & DIN(45) & DIN(30) & 
		DIN(52) & DIN(42) & DIN(20) & DIN(24) & DIN(60) & DIN(3) & DIN(26) & DIN(30) & 
		DIN(0) & DIN(40) & DIN(9) & DIN(0) & DIN(48) & DIN(24) & DIN(8) & DIN(26);

	inst118_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init118,
			DOUT        => DOUT(118)
		);
	init118 <= DIN(41) & DIN(39) & DIN(6) & DIN(22) & DIN(16) & DIN(17) & DIN(6) & DIN(15) & 
		DIN(59) & DIN(6) & DIN(30) & DIN(31) & DIN(17) & DIN(14) & DIN(34) & DIN(61) & 
		DIN(34) & DIN(60) & DIN(36) & DIN(31) & DIN(38) & DIN(61) & DIN(52) & DIN(18) & 
		DIN(48) & DIN(12) & DIN(19) & DIN(32) & DIN(52) & DIN(62) & DIN(56) & DIN(19) & 
		DIN(23) & DIN(53) & DIN(15) & DIN(1) & DIN(22) & DIN(0) & DIN(49) & DIN(27) & 
		DIN(53) & DIN(15) & DIN(61) & DIN(20) & DIN(44) & DIN(37) & DIN(25) & DIN(2) & 
		DIN(22) & DIN(39) & DIN(43) & DIN(20) & DIN(12) & DIN(39) & DIN(63) & DIN(16) & 
		DIN(24) & DIN(21) & DIN(40) & DIN(33) & DIN(38) & DIN(3) & DIN(4) & DIN(22);

	inst119_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init119,
			DOUT        => DOUT(119)
		);
	init119 <= DIN(30) & DIN(2) & DIN(23) & DIN(37) & DIN(2) & DIN(11) & DIN(18) & DIN(1) & 
		DIN(41) & DIN(39) & DIN(5) & DIN(29) & DIN(11) & DIN(27) & DIN(24) & DIN(63) & 
		DIN(43) & DIN(25) & DIN(16) & DIN(27) & DIN(43) & DIN(48) & DIN(45) & DIN(59) & 
		DIN(50) & DIN(60) & DIN(46) & DIN(20) & DIN(49) & DIN(31) & DIN(41) & DIN(56) & 
		DIN(0) & DIN(11) & DIN(19) & DIN(1) & DIN(34) & DIN(43) & DIN(59) & DIN(12) & 
		DIN(27) & DIN(42) & DIN(5) & DIN(12) & DIN(47) & DIN(63) & DIN(46) & DIN(16) & 
		DIN(45) & DIN(32) & DIN(46) & DIN(48) & DIN(62) & DIN(49) & DIN(12) & DIN(30) & 
		DIN(11) & DIN(15) & DIN(42) & DIN(56) & DIN(31) & DIN(30) & DIN(37) & DIN(62);

	inst120_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init120,
			DOUT        => DOUT(120)
		);
	init120 <= DIN(34) & DIN(32) & DIN(12) & DIN(26) & DIN(14) & DIN(61) & DIN(52) & DIN(61) & 
		DIN(11) & DIN(17) & DIN(3) & DIN(63) & DIN(48) & DIN(21) & DIN(6) & DIN(16) & 
		DIN(16) & DIN(51) & DIN(53) & DIN(40) & DIN(44) & DIN(54) & DIN(25) & DIN(36) & 
		DIN(34) & DIN(34) & DIN(45) & DIN(41) & DIN(23) & DIN(38) & DIN(30) & DIN(7) & 
		DIN(17) & DIN(15) & DIN(38) & DIN(17) & DIN(49) & DIN(35) & DIN(58) & DIN(12) & 
		DIN(33) & DIN(46) & DIN(57) & DIN(32) & DIN(5) & DIN(18) & DIN(26) & DIN(39) & 
		DIN(7) & DIN(63) & DIN(15) & DIN(8) & DIN(20) & DIN(54) & DIN(55) & DIN(56) & 
		DIN(11) & DIN(7) & DIN(11) & DIN(16) & DIN(20) & DIN(15) & DIN(33) & DIN(0);

	inst121_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init121,
			DOUT        => DOUT(121)
		);
	init121 <= DIN(1) & DIN(21) & DIN(43) & DIN(9) & DIN(24) & DIN(7) & DIN(23) & DIN(6) & 
		DIN(5) & DIN(5) & DIN(1) & DIN(29) & DIN(2) & DIN(56) & DIN(42) & DIN(60) & 
		DIN(59) & DIN(8) & DIN(57) & DIN(62) & DIN(22) & DIN(12) & DIN(6) & DIN(52) & 
		DIN(46) & DIN(2) & DIN(8) & DIN(57) & DIN(43) & DIN(17) & DIN(29) & DIN(56) & 
		DIN(61) & DIN(36) & DIN(50) & DIN(18) & DIN(2) & DIN(18) & DIN(5) & DIN(39) & 
		DIN(3) & DIN(8) & DIN(51) & DIN(6) & DIN(61) & DIN(34) & DIN(2) & DIN(61) & 
		DIN(50) & DIN(45) & DIN(55) & DIN(34) & DIN(29) & DIN(4) & DIN(44) & DIN(53) & 
		DIN(23) & DIN(54) & DIN(28) & DIN(51) & DIN(20) & DIN(57) & DIN(6) & DIN(43);

	inst122_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init122,
			DOUT        => DOUT(122)
		);
	init122 <= DIN(55) & DIN(60) & DIN(22) & DIN(51) & DIN(50) & DIN(58) & DIN(22) & DIN(48) & 
		DIN(31) & DIN(14) & DIN(26) & DIN(14) & DIN(31) & DIN(10) & DIN(21) & DIN(55) & 
		DIN(0) & DIN(33) & DIN(15) & DIN(19) & DIN(47) & DIN(32) & DIN(16) & DIN(57) & 
		DIN(45) & DIN(22) & DIN(60) & DIN(55) & DIN(51) & DIN(12) & DIN(8) & DIN(4) & 
		DIN(10) & DIN(28) & DIN(29) & DIN(1) & DIN(26) & DIN(7) & DIN(22) & DIN(17) & 
		DIN(47) & DIN(15) & DIN(57) & DIN(40) & DIN(10) & DIN(52) & DIN(39) & DIN(45) & 
		DIN(50) & DIN(47) & DIN(2) & DIN(54) & DIN(51) & DIN(58) & DIN(60) & DIN(53) & 
		DIN(35) & DIN(48) & DIN(47) & DIN(47) & DIN(2) & DIN(44) & DIN(39) & DIN(8);

	inst123_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init123,
			DOUT        => DOUT(123)
		);
	init123 <= DIN(12) & DIN(57) & DIN(33) & DIN(29) & DIN(58) & DIN(9) & DIN(54) & DIN(25) & 
		DIN(40) & DIN(11) & DIN(15) & DIN(58) & DIN(18) & DIN(62) & DIN(34) & DIN(10) & 
		DIN(13) & DIN(24) & DIN(27) & DIN(43) & DIN(46) & DIN(55) & DIN(29) & DIN(59) & 
		DIN(19) & DIN(49) & DIN(24) & DIN(2) & DIN(51) & DIN(21) & DIN(2) & DIN(47) & 
		DIN(63) & DIN(24) & DIN(39) & DIN(32) & DIN(33) & DIN(43) & DIN(10) & DIN(46) & 
		DIN(57) & DIN(16) & DIN(24) & DIN(8) & DIN(49) & DIN(9) & DIN(46) & DIN(34) & 
		DIN(42) & DIN(36) & DIN(13) & DIN(51) & DIN(36) & DIN(44) & DIN(35) & DIN(17) & 
		DIN(61) & DIN(3) & DIN(0) & DIN(4) & DIN(22) & DIN(42) & DIN(8) & DIN(30);

	inst124_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init124,
			DOUT        => DOUT(124)
		);
	init124 <= DIN(20) & DIN(48) & DIN(14) & DIN(37) & DIN(54) & DIN(57) & DIN(4) & DIN(32) & 
		DIN(49) & DIN(28) & DIN(42) & DIN(7) & DIN(46) & DIN(62) & DIN(19) & DIN(26) & 
		DIN(57) & DIN(42) & DIN(20) & DIN(47) & DIN(20) & DIN(13) & DIN(6) & DIN(8) & 
		DIN(20) & DIN(54) & DIN(24) & DIN(5) & DIN(21) & DIN(31) & DIN(20) & DIN(47) & 
		DIN(57) & DIN(20) & DIN(33) & DIN(22) & DIN(8) & DIN(40) & DIN(53) & DIN(42) & 
		DIN(46) & DIN(44) & DIN(52) & DIN(20) & DIN(4) & DIN(40) & DIN(5) & DIN(10) & 
		DIN(22) & DIN(7) & DIN(40) & DIN(12) & DIN(57) & DIN(16) & DIN(48) & DIN(14) & 
		DIN(33) & DIN(57) & DIN(49) & DIN(38) & DIN(37) & DIN(0) & DIN(14) & DIN(35);

	inst125_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init125,
			DOUT        => DOUT(125)
		);
	init125 <= DIN(11) & DIN(51) & DIN(7) & DIN(62) & DIN(15) & DIN(5) & DIN(0) & DIN(13) & 
		DIN(24) & DIN(50) & DIN(26) & DIN(17) & DIN(26) & DIN(32) & DIN(14) & DIN(35) & 
		DIN(23) & DIN(39) & DIN(22) & DIN(22) & DIN(47) & DIN(7) & DIN(39) & DIN(17) & 
		DIN(49) & DIN(35) & DIN(8) & DIN(11) & DIN(52) & DIN(12) & DIN(43) & DIN(13) & 
		DIN(36) & DIN(1) & DIN(62) & DIN(1) & DIN(45) & DIN(14) & DIN(51) & DIN(7) & 
		DIN(23) & DIN(58) & DIN(3) & DIN(55) & DIN(8) & DIN(38) & DIN(13) & DIN(1) & 
		DIN(56) & DIN(15) & DIN(46) & DIN(30) & DIN(21) & DIN(4) & DIN(9) & DIN(38) & 
		DIN(47) & DIN(60) & DIN(32) & DIN(39) & DIN(40) & DIN(41) & DIN(15) & DIN(34);

	inst126_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init126,
			DOUT        => DOUT(126)
		);
	init126 <= DIN(30) & DIN(15) & DIN(60) & DIN(30) & DIN(42) & DIN(56) & DIN(29) & DIN(54) & 
		DIN(63) & DIN(15) & DIN(10) & DIN(4) & DIN(16) & DIN(35) & DIN(9) & DIN(30) & 
		DIN(20) & DIN(0) & DIN(7) & DIN(23) & DIN(18) & DIN(15) & DIN(39) & DIN(6) & 
		DIN(47) & DIN(31) & DIN(17) & DIN(37) & DIN(7) & DIN(34) & DIN(3) & DIN(0) & 
		DIN(37) & DIN(4) & DIN(1) & DIN(51) & DIN(57) & DIN(14) & DIN(44) & DIN(59) & 
		DIN(63) & DIN(39) & DIN(59) & DIN(49) & DIN(14) & DIN(9) & DIN(23) & DIN(61) & 
		DIN(46) & DIN(55) & DIN(47) & DIN(11) & DIN(32) & DIN(8) & DIN(53) & DIN(10) & 
		DIN(24) & DIN(46) & DIN(34) & DIN(7) & DIN(61) & DIN(63) & DIN(63) & DIN(50);

	inst127_u: entity work.lfsr_serial
		generic map(
			LFSR_LENGTH => LFSR_LENGTH,
			TAPS        => TAPS
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init127,
			DOUT        => DOUT(127)
		);
	init127 <= DIN(43) & DIN(2) & DIN(28) & DIN(5) & DIN(36) & DIN(27) & DIN(16) & DIN(5) & 
		DIN(55) & DIN(43) & DIN(35) & DIN(50) & DIN(48) & DIN(58) & DIN(9) & DIN(44) & 
		DIN(16) & DIN(48) & DIN(49) & DIN(42) & DIN(38) & DIN(26) & DIN(14) & DIN(59) & 
		DIN(23) & DIN(51) & DIN(23) & DIN(43) & DIN(41) & DIN(3) & DIN(38) & DIN(38) & 
		DIN(30) & DIN(1) & DIN(52) & DIN(30) & DIN(35) & DIN(37) & DIN(34) & DIN(5) & 
		DIN(59) & DIN(41) & DIN(40) & DIN(4) & DIN(42) & DIN(25) & DIN(58) & DIN(37) & 
		DIN(9) & DIN(23) & DIN(28) & DIN(43) & DIN(3) & DIN(27) & DIN(36) & DIN(44) & 
		DIN(9) & DIN(20) & DIN(4) & DIN(3) & DIN(37) & DIN(37) & DIN(50) & DIN(63);



end architecture beh; 


