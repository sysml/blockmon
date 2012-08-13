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

-- pseudorand_length_gen.vhd : LFSR based pseudorandom generator module
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
-- $Id: pseudorand_length_gen.vhd 12090 2009-11-24 13:57:11Z korcek $
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 
use work.lfsr_pkg.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity pseudorand_length_gen is
  
  generic (
    TAPS_1024        : LFSR_TAPS    :=(10, 7);          
    TAPS_256         : LFSR_TAPS    :=(8,6,5,4);
    TAPS_128         : LFSR_TAPS    :=(7,6);
    TAPS_64          : LFSR_TAPS    :=(6,5)
  );
  port (
    RESET   : in  std_logic;  -- reset  
    CLK     : in  std_logic;  -- clock signal
    S_EN    : in  std_logic;  -- shift enable
    F_EN    : in  std_logic;  -- fill enable
    DIN     : in  std_logic_vector(10 downto 0);   -- seed
    DOUT    : out std_logic_vector(10 downto 0)    -- data out
  );

end entity pseudorand_length_gen;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------

architecture beh of pseudorand_length_gen is


      -- pseudorandom output registers
      signal reg_1024         : std_logic_vector(9 downto 0);  -- 0 - 1023
      signal reg_256          : std_logic_vector(7 downto 0);  -- 0 - 255
      signal reg_1024_and_256 : std_logic_vector(10 downto 0); -- 0 - 1278

      signal reg_128          : std_logic_vector(6 downto 0);  -- 0 - 127
      signal reg_64           : std_logic_vector(5 downto 0);  -- 0 - 63
      signal reg_128_and_64   : std_logic_vector(7 downto 0);  -- 0 - 190

      signal reg_last         : std_logic_vector(10 downto 0); -- 0 - 1468
      signal reg_add          : std_logic_vector(10 downto 0); -- 64 - 1532


      -- init vectors
      signal init_1024        : std_logic_vector(9 downto 0);
      signal init_256         : std_logic_vector(7 downto 0);
      signal init_128         : std_logic_vector(6 downto 0);
      signal init_64          : std_logic_vector(5 downto 0);

begin

   -- -------------------------------------------------------------------------
	inst1024_u: entity work.lfsr_parallel
		generic map(
			LFSR_LENGTH => 10,
			TAPS        => TAPS_1024
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init_1024,
			DOUT        => reg_1024 
		);

   init_1024 <= DIN(0) & DIN(2) & DIN(9) & DIN(8) & DIN(0) & DIN(1) & DIN(7)  & DIN(5) & DIN(3) & DIN(3); 
   -- -------------------------------------------------------------------------
	inst256_u: entity work.lfsr_parallel
		generic map(
			LFSR_LENGTH => 8,
			TAPS        => TAPS_256
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init_256,
			DOUT        => reg_256
		);

   init_256 <= DIN(7) & DIN(7) & DIN(6) & DIN(5) & DIN(1) & DIN(2) & DIN(2) & DIN(4); 
   -- -------------------------------------------------------------------------
	inst128_u: entity work.lfsr_parallel
		generic map(
			LFSR_LENGTH => 7,
			TAPS        => TAPS_128
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init_128,
			DOUT        => reg_128
		);

   init_128 <= DIN(6) & DIN(2) & DIN(3) & DIN(3) & DIN(3) & DIN(5) & DIN(9);
      
   -- -------------------------------------------------------------------------          
	inst64_u: entity work.lfsr_parallel
		generic map(
			LFSR_LENGTH => 6,
			TAPS        => TAPS_64
		)
		port map(
			CLK         => CLK,
			S_EN        => S_EN,
			F_EN        => F_EN,
			DIN         => init_64,
			DOUT        => reg_64
		);

	init_64 <= DIN(7) & DIN(8) & DIN(9) & DIN(9) & DIN(0)  & DIN(4); 


   -- register  ------------------------------------------------------
   reg_1024_and_256p: process(RESET, CLK)
   begin
      if(CLK'event and CLK = '1') then
         if (RESET = '1') then
            reg_1024_and_256 <= (others => '1');
         elsif (S_EN = '1' OR F_EN = '1') then
          reg_1024_and_256 <= ( '0' & reg_1024) + ( "000" & reg_256);
         end if;
      end if;
   end process;

   -- register  ------------------------------------------------------
   reg_128_and_64p: process(RESET, CLK)
   begin
      if(CLK'event and CLK = '1') then
         if (RESET = '1') then
            reg_128_and_64 <= (others => '1');
         elsif (S_EN = '1' OR F_EN = '1') then
            reg_128_and_64 <= ( '0' & reg_128) + ( "00" & reg_64);
         end if;
      end if;

   end process;

   -- register  ------------------------------------------------------
   reg_lastp: process(RESET, CLK)
   begin
      if(CLK'event and CLK = '1') then
         if (RESET = '1') then
            reg_last <= (others => '0');
         elsif (S_EN = '1' OR F_EN = '1') then
            reg_last <= (reg_1024_and_256) + ( "000" & reg_128_and_64);
         end if;
      end if;
   end process;

   -- register  ------------------------------------------------------
   reg_add_64p: process(RESET, CLK)
   begin
      if(CLK'event and CLK = '1') then
         if (RESET = '1') then
            reg_add <= (others => '0');
         elsif (S_EN = '1' OR F_EN = '1') then
            reg_add <= reg_last + conv_std_logic_vector(56, reg_last'length);
         end if;
      end if;
   end process;

   DOUT <= reg_add;

end architecture beh; 


