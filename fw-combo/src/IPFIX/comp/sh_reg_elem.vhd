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
-- sh_reg_elem.vhd: Shift Register Element
-- Copyright (C) 2003 CESNET
-- Author(s): Martinek Tomas <martinek@liberouter.org>
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
-- $Id: sh_reg_elem.vhd 24 2007-07-31 11:19:09Z kosek $
--
-- TODO:
--
--
library IEEE;
use IEEE.std_logic_1164.all;

-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity sh_reg_elem is
   generic(
      SH_INIT  : std_logic_vector(15 downto 0) := X"0000"
   );
   port(
      CLK      : in  std_logic;
      DIN      : in  std_logic;
      CE       : in  std_logic;
      ADDR     : in  std_logic_vector(3 downto 0);
      DOUT     : out std_logic
   );
end entity sh_reg_elem;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of sh_reg_elem is

-- component declaration
component SRL16E
   generic(
      INIT : bit_vector(15 downto 0) := X"0000"
   );
   port (
      D    : in std_logic;
      CE   : in std_logic;
      CLK  : in std_logic;
      A0   : in std_logic;
      A1   : in std_logic;
      A2   : in std_logic;
      A3   : in std_logic;
      Q    : out std_logic
   );
end component;

   function stdlogic2hstring(value: in std_logic_vector) return string is
      variable quad : std_logic_vector(0 to 3);
      constant ne   : integer := value'length/4;
      variable bv   : std_logic_vector(0 to value'length-1) := value;
      variable s    : string(1 to ne);
   begin
      for i in 0 to ne-1 loop
         quad := bv(4*i to 4*i+3);
         case quad is
            when X"0" => s(i+1) := '0';
            when X"1" => s(i+1) := '1';
            when X"2" => s(i+1) := '2';
            when X"3" => s(i+1) := '3';
            when X"4" => s(i+1) := '4';
            when X"5" => s(i+1) := '5';
            when X"6" => s(i+1) := '6';
            when X"7" => s(i+1) := '7';
            when X"8" => s(i+1) := '8';
            when X"9" => s(i+1) := '9';
            when X"A" => s(i+1) := 'A';
            when X"B" => s(i+1) := 'B';
            when X"C" => s(i+1) := 'C';
            when X"D" => s(i+1) := 'D';
            when X"E" => s(i+1) := 'E';
            when X"F" => s(i+1) := 'F';
            when others => s(i+1) := '0';
         end case;
      end loop;
      return s;
   end function;

   attribute INIT: string;
   attribute INIT of U_SRL16E: label is stdlogic2hstring(SH_INIT);


-- ----------------------------------------------------------------------------
begin

U_SRL16E: SRL16E
generic map(
   INIT => to_bitvector(SH_INIT)
)
port map (
	D      => DIN,
	CE     => CE,
	CLK    => CLK,
	A0     => ADDR(0),
	A1     => ADDR(1),
	A2     => ADDR(2),
	A3     => ADDR(3),
	Q      => DOUT
);

end architecture behavioral;
-- ----------------------------------------------------------------------------

