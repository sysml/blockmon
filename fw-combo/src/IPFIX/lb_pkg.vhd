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

-- lb_pkg.vhd: Local Bus Package
-- Copyright (C) 2006 CESNET
-- Author(s): Petr Kobiersky <xkobie00@stud.fit.vutbr.cz>
--            Viktor Pus <pus@liberouter.org>
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
-- $Id: lb_pkg.vhd 433 2007-09-12 19:18:54Z solanka $
--
-- TODO:
--
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
use std.textio.all;

-- ----------------------------------------------------------------------------
--                        Internal Bus Package
-- ----------------------------------------------------------------------------
package lb_pkg is
   
   -- Local 16 bit Bus
   type t_local_bus16 is record
      DWR        : std_logic_vector(15 downto 0);
      BE         : std_logic_vector(1 downto 0);
      ADS_N      : std_logic;
      RD_N       : std_logic;
      WR_N       : std_logic;
      DRD        : std_logic_vector(15 downto 0);
      RDY_N      : std_logic;
      ERR_N      : std_logic;
      ABORT_N    : std_logic;
   end record;

   -- Local 8 bit Bus
   type t_local_bus8 is record
      DWR        : std_logic_vector(7 downto 0);
      BE         : std_logic;
      ADS_N      : std_logic;
      RD_N       : std_logic;
      WR_N       : std_logic;
      DRD        : std_logic_vector(7 downto 0);
      RDY_N      : std_logic;
      ERR_N      : std_logic;
      ABORT_N    : std_logic;
   end record;

   -- Universal 32 bit memory interface
   type t_mi32 is record
      DWR      : std_logic_vector(31 downto 0);           -- Input Data
      ADDR     : std_logic_vector(31 downto 0);           -- Address
      RD       : std_logic;                               -- Read Request
      WR       : std_logic;                               -- Write Request
      BE       : std_logic_vector(3  downto 0);           -- Byte Enable
      DRD      : std_logic_vector(31 downto 0);           -- Output Data
      ARDY     : std_logic;                               -- Address Ready
      DRDY     : std_logic;                               -- Data Ready   
   end record;   

   -- Local Bus Frequency
   constant LOCAL_BUS_FREQUENCY : integer := 100;

end lb_pkg;


-- ----------------------------------------------------------------------------
--                        Internal Bus Package
-- ----------------------------------------------------------------------------
package body lb_pkg is
       
end lb_pkg;

