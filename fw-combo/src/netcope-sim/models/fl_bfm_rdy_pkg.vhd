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

-- fl_bfm_rdy_pkg.vhd: RDY signal functions package for sim and monitor
-- Copyright (C) 2007 CESNET
-- Author(s): Vlastimil Kosar <xkosar02@stud.fit.vutbr.cz>
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
-- $Id: fl_bfm_rdy_pkg.vhd 12021 2011-04-15 08:23:45Z kastovsky $
--
-- TODO:
--
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

-- ----------------------------------------------------------------------------
--                        RDY functions package
-- ----------------------------------------------------------------------------
PACKAGE fl_bfm_rdy_pkg IS
TYPE RDYSignalDriver IS (EVER, ONOFF, RND);
PROCEDURE DriveRdyN50_50(signal CLK       : IN  std_logic;
                         signal RDY_N : OUT std_logic);
			 
PROCEDURE DriveRdyNAll(signal CLK       : IN  std_logic;
                       signal RDY_N : OUT std_logic);
		       
PROCEDURE DriveRdyNRnd(signal CLK       : IN  std_logic;
                       signal RDY_N : OUT std_logic);
		       
PROCEDURE SetSeed(Seed : in integer);
END fl_bfm_rdy_pkg;
-- ----------------------------------------------------------------------------
--                      FrameLink Bus BFM Package BODY
-- ----------------------------------------------------------------------------
PACKAGE BODY fl_bfm_rdy_pkg IS
SHARED VARIABLE number: integer := 399751;

PROCEDURE SetSeed(Seed : in integer) IS
   BEGIN
      number := Seed; 
   END;

PROCEDURE Random(RND : out integer) IS
   BEGIN
      number := number * 69069 + 1;
      RND := (number rem 7);
   END;

PROCEDURE DriveRdyN50_50(signal CLK       : IN  std_logic;
                         signal RDY_N : OUT std_logic) IS
  BEGIN
    RDY_N <= '0';
    wait until (CLK'event and CLK='1');
    RDY_N <= '1';
    wait until (CLK'event and CLK='1');
  END;

PROCEDURE DriveRdyNAll(signal CLK       : IN  std_logic;
                       signal RDY_N : OUT std_logic) IS
  BEGIN
    RDY_N <= '0';
    wait until (CLK'event and CLK='1');
  END;
  
PROCEDURE DriveRdyNRnd(signal CLK       : IN  std_logic;
                       signal RDY_N : OUT std_logic) IS
VARIABLE RNDVAL: integer;
VARIABLE VALUE: std_logic;
   BEGIN
      Random(RNDVAL);
      if (RNDVAL rem 2 = 0) then
        VALUE := '0';
      else
        VALUE := '1';
      end if;
      Random(RNDVAL);
      for i in 1 to RNDVAL loop
         RDY_N <= VALUE;
         wait until (CLK'event and CLK='1');
      end loop;
   END;
       

END fl_bfm_rdy_pkg;
