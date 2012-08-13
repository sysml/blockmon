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

-- lfsr_serial.vhd : LFSR based serial output pseudorandom generator module
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
-- $Id: lfsr_serial.vhd 12095 2009-11-24 15:12:11Z kastovsky $
--

library ieee;
use ieee.std_logic_1164.all;
use work.lfsr_pkg.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------

entity lfsr_serial is
  
  generic (
    LFSR_LENGTH   : integer     := 16;          -- internal LFSR width
    TAPS          : LFSR_TAPS   :=(16,15,13,4)  -- polynomial
 );
  port (
    CLK     : in  std_logic;  -- clock signal
    S_EN    : in  std_logic;  -- shift enable
    F_EN    : in  std_logic;  -- fill enable
    DIN     : in  std_logic_vector(LFSR_LENGTH-1 downto 0); -- seed
    DOUT    : out std_logic   -- data out
  );

end entity lfsr_serial;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------

architecture beh of lfsr_serial is

    signal reg : std_logic_vector((LFSR_LENGTH-1) downto 0);
  
begin 

    lfsr1 : process (CLK)

    variable fb : std_logic;
            
        begin
        if (CLK'event and CLK ='1') then
        -- rising edge        
            if S_EN='1' then 
            -- shift enable 
               -- compute new bit (xor) 
               fb := '0';
               for j in TAPS'range loop
                     if fb=reg(TAPS(j)-1) then
                        fb := '0';
                     else
                        fb := '1';
                     end if;
               end loop; -- j
               for k in reg'left downto 1 loop
                     reg(k) <= reg(k-1);
               end loop; -- k
               reg(0) <= fb;
                
            elsif F_EN ='1' then
            -- for insert seed
               reg <= DIN;
            end if;
            DOUT <= reg(LFSR_LENGTH-1);
        end if;
   end process lfsr1;

end architecture beh; 
