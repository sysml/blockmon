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

-- mi32_async_norec_ent.vhd: Comp for tranfering data between two unrelated
--                           clocks (interface without records)
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
-- $Id: mi32_async_norec_ent.vhd 6200 2008-11-01 18:54:06Z solanka $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- ----------------------------------------------------------------------------
--                            Entity declaration
-- ----------------------------------------------------------------------------
entity MI32_ASYNC_NOREC is
   port(
      RESET          : in  std_logic;
      -- Master interface
      CLK_M          : in  std_logic;
      MI_M_DWR      	: in  std_logic_vector(31 downto 0);   -- Input Data
      MI_M_ADDR     	: in  std_logic_vector(31 downto 0);   -- Address
      MI_M_RD       	: in  std_logic;                       -- Read Request
      MI_M_WR       	: in  std_logic;                       -- Write Request
      MI_M_BE       	: in  std_logic_vector(3  downto 0);   -- Byte Enable
      MI_M_DRD      	: out std_logic_vector(31 downto 0);    -- Output Data
      MI_M_ARDY     	: out std_logic;                       -- Address Ready
      MI_M_DRDY     	: out std_logic;                        -- Data Ready
      -- Slave interface
      CLK_S          : in  std_logic;
      MI_S_DWR      	: out std_logic_vector(31 downto 0);   -- Input Data
      MI_S_ADDR     	: out std_logic_vector(31 downto 0);   -- Address
      MI_S_RD       	: out std_logic;                       -- Read Request
      MI_S_WR       	: out std_logic;                       -- Write Request
      MI_S_BE       	: out std_logic_vector(3  downto 0);   -- Byte Enable
      MI_S_DRD      	: in  std_logic_vector(31 downto 0);   -- Output Data
      MI_S_ARDY     	: in  std_logic;                       -- Address Ready
      MI_S_DRDY     	: in  std_logic                        -- Data Ready
   );
end entity MI32_ASYNC_NOREC;
