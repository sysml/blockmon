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
-- sh_reg.vhd: Shift Register
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
-- $Id: sh_reg.vhd 24 2007-07-31 11:19:09Z kosek $
--
-- TODO:
--
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity sh_reg is
   generic(
      NUM_BITS    : integer := 16;
      INIT        : std_logic_vector(15 downto 0) := X"0000";
      INIT_EXT00  : std_logic_vector(63 downto 0) := X"0000000000000000"      
   );
   port(
      CLK      : in  std_logic;

      DIN      : in  std_logic;
      CE       : in  std_logic;
      DOUT     : out std_logic
   );
end entity sh_reg;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of sh_reg is

   constant NUM_ELEMS : integer := (NUM_BITS+15)/16;

   type t_vector4 is array (0 to NUM_ELEMS-1) of std_logic_vector(3 downto 0);
   type t_vector_dw is array (0 to NUM_ELEMS) of std_logic;
   signal regsh_do   : t_vector_dw;
   signal regsh_addr : t_vector4;

begin

regsh_do(0) <= DIN;

SH_REG_XU : for i in 0 to NUM_ELEMS-1 generate
   -- addr generation
   regsh_addr(i) <= "1111" when (i < NUM_ELEMS-1) else
                    conv_std_logic_vector((NUM_BITS mod 16)+15, 4);

   init_16p: if i = 0 generate
      SH_REG_U : entity work.sh_reg_elem
      generic map(
         SH_INIT  => INIT
      )
      port map(
         CLK      => CLK,
         DIN      => regsh_do(i),
         CE       => CE,
         ADDR     => regsh_addr(i),
         DOUT     => regsh_do(i+1)
      );      
   end generate;
   
   init_ext00p: if i > 0 generate
      SH_REG_U : entity work.sh_reg_elem
      generic map(
         SH_INIT  => INIT_EXT00((i*16)-1 downto (i-1)*16)
      )
      port map(
         CLK      => CLK,
         DIN      => regsh_do(i),
         CE       => CE,
         ADDR     => regsh_addr(i),
         DOUT     => regsh_do(i+1)
      );            
   end generate;          

end generate;

DOUT <= regsh_do(NUM_ELEMS);

end architecture behavioral;

