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

-- mi32_async_arch.vhd: Envelope for mi_32_async_arch_norec.vhd using t_mi32
--                      inout record
-- Copyright (C) 2008 CESNET
-- Author(s): Jiri Matousek <xmatou06@stud.fit.vutbr.cz>
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
-- $Id: mi32_async_arch.vhd 6110 2008-10-26 22:48:24Z xmatou06 $
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- library with MI_32 interface definition
use work.lb_pkg.all;

-- ----------------------------------------------------------------------------
--                               Architecture
-- ----------------------------------------------------------------------------
architecture full of MI32_ASYNC is
begin

	-- -------------------------------------------------------------------------
	--                    Instantiation of mi32_async_norec
	-- -------------------------------------------------------------------------

	mi32_async_norec_i: entity work.MI32_ASYNC_NOREC
		port map(
	      RESET          => RESET,
	      -- Master interface
	      CLK_M          => CLK_M,
	      MI_M_DWR      	=> MI_M.DWR,			-- Input Data
	      MI_M_ADDR     	=> MI_M.ADDR,      	-- Address
	      MI_M_RD       	=> MI_M.RD,          -- Read Request
	      MI_M_WR       	=> MI_M.WR,          -- Write Request
	      MI_M_BE       	=> MI_M.BE,          -- Byte Enable
	      MI_M_DRD      	=> MI_M.DRD,         -- Output Data
	      MI_M_ARDY     	=> MI_M.ARDY,        -- Address Ready
	      MI_M_DRDY     	=> MI_M.DRDY,        -- Data Ready
	      -- Slave interface
	      CLK_S          => CLK_S,
	      MI_S_DWR      	=> MI_S.DWR,			-- Input Data
	      MI_S_ADDR     	=> MI_S.ADDR,      	-- Address
	      MI_S_RD       	=> MI_S.RD,          -- Read Request
	      MI_S_WR       	=> MI_S.WR,          -- Write Request
	      MI_S_BE       	=> MI_S.BE,          -- Byte Enable
	      MI_S_DRD      	=> MI_S.DRD,         -- Output Data
	      MI_S_ARDY     	=> MI_S.ARDY,        -- Address Ready
	      MI_S_DRDY     	=> MI_S.DRDY         -- Data Ready
		);

end architecture full;
