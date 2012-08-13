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

-- mux.vhd: Generic multiplexer
-- Copyright (C) 2006 CESNET
-- Author(s): Martin Kosek <kosek@liberouter.org>
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
-- $Id: mux.vhd 14 2007-07-31 06:44:05Z kosek $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- library containing log2 function
use work.math_pack.all;

-- ----------------------------------------------------------------------------
--                            Entity declaration
-- ----------------------------------------------------------------------------
entity GEN_MUX is
   generic(
      DATA_WIDTH  : integer;
      MUX_WIDTH   : integer   -- multiplexer width (number of inputs)
   );
   port(
      DATA_IN     : in  std_logic_vector(DATA_WIDTH*MUX_WIDTH-1 downto 0);
      SEL         : in  std_logic_vector(log2(MUX_WIDTH)-1 downto 0);
      DATA_OUT    : out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end entity GEN_MUX;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture full of GEN_MUX is
begin

   genmuxp:process(SEL, DATA_IN)
   begin
      DATA_OUT <= DATA_IN(DATA_WIDTH-1 downto 0);
      
      for i in 0 to MUX_WIDTH-1 loop
         if(conv_std_logic_vector(i, log2(MUX_WIDTH)) = SEL) then
            DATA_OUT <= DATA_IN(((i+1)*DATA_WIDTH)-1 downto i*DATA_WIDTH);
         end if;
      end loop;
   end process;

end architecture full;

