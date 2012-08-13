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

-- barrel_bit_shifter.vhd: Barrel shifter with generic data width
-- Copyright (C) 2010 CESNET
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
-- $Id: barrel_bit_shifter.vhd 13189 2010-03-10 15:07:35Z pus $
--
-- TODO:
--

library IEEE;  
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

use work.math_pack.all;

-- ----------------------------------------------------------------------------
--                  ENTITY DECLARATION -- Barrel shifter                     -- 
-- ----------------------------------------------------------------------------

entity BARREL_BIT_SHIFTER is 
   generic (
      DATA_WIDTH  : integer := 8;
      -- set true to shift left, false to shift right
      SHIFT_LEFT  : boolean := true
   );
   port (
      -- Input interface ------------------------------------------------------
      DATA_IN     : in  std_logic_vector(DATA_WIDTH-1 downto 0);
      DATA_OUT    : out std_logic_vector(DATA_WIDTH-1 downto 0);
      SEL         : in  std_logic_vector(log2(DATA_WIDTH)-1 downto 0)
   );
end BARREL_BIT_SHIFTER;

-- ----------------------------------------------------------------------------
--                       ARCHITECTURE DECLARATION                            --
-- ----------------------------------------------------------------------------

architecture barrel_bit_shifter_arch of BARREL_BIT_SHIFTER is
      
begin
   
   multiplexors: for i in 0 to DATA_WIDTH-1 generate
      process (DATA_IN, SEL)
         variable sel_aux: integer;
      begin
         if (SHIFT_LEFT) then
            sel_aux := conv_integer('0'&SEL);
         else
            sel_aux := conv_integer('0'&(0-SEL));
         end if;
         
         DATA_OUT(i) <= DATA_IN((DATA_WIDTH-sel_aux+i) mod (DATA_WIDTH));
      end process;
   end generate;
   
end barrel_bit_shifter_arch;
