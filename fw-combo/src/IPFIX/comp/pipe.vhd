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
-- pipe.vhd: Internal Bus Pipeline
-- Copyright (C) 2008 CESNET
-- Author(s): Tomas Malek <tomalek@liberouter.org>
--            Vaclav Bartos <xbarto11@stud.fit.vutbr.cz>            
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
-- $Id: pipe.vhd 13969 2010-06-08 13:14:33Z washek $
--
-- TODO:
--

library IEEE;
use IEEE.std_logic_1164.all;

-- ----------------------------------------------------------------------------
--               ENTITY DECLARATION -- Internal Bus Pipeline                 --
-- ---------------------------------------------------------------------------- 

entity PIPE is
   generic(
      DATA_WIDTH     : integer := 64;
      USE_OUTREG     : boolean := false;
      FAKE_PIPE      : boolean := false -- wires only (to disable pipe easily)
   );   
   port(
      -- Common interface -----------------------------------------------------
      CLK            : in std_logic;
      RESET          : in std_logic;
      
      -- Input interface ------------------------------------------------------
      IN_DATA        : in  std_logic_vector(DATA_WIDTH-1 downto 0);
      IN_SRC_RDY     : in  std_logic;
      IN_DST_RDY     : out std_logic;
 
      -- Output interface -----------------------------------------------------
      OUT_DATA       : out std_logic_vector(DATA_WIDTH-1 downto 0);
      OUT_SRC_RDY    : out std_logic;
      OUT_DST_RDY    : in  std_logic
   );
end entity PIPE;



