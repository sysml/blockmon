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
-- mi_bfm.vhd : MI32 simulation component
-- Copyright (C) 2008 CESNET
-- Author(s): Jakub Sochor <xsocho06@stud.fit.vutbr.cz>
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
-- $Id: mi_bfm.vhd 12021 2011-04-15 08:23:45Z kastovsky $
--
-- TODO:
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

use work.mi_bfm_pkg.all;
use work.math_pack.all;

-- ----------------------------------------------------------------------------
--                             ENTITY DECLARATION                            --
-- ----------------------------------------------------------------------------

entity MI_BFM is
  port(
      -- Common interface -----------------------------------------------------
      CLK         : in std_logic;
      RESET       : in std_logic;

      -- Output MI interfaces -------------------------------------------------
      MI32_DWR     : out std_logic_vector(31 downto 0);
      MI32_ADDR    : out std_logic_vector(31 downto 0);
      MI32_BE      : out std_logic_vector(3 downto 0);
      MI32_DRD     : in  std_logic_vector(31 downto 0);
      MI32_RD      : out std_logic;
      MI32_WR      : out std_logic;
      MI32_ARDY    : in  std_logic;
      MI32_DRDY    : in  std_logic

   );
end entity MI_BFM;


architecture MI_BFM_ARCH of MI_BFM is

   signal commandStatus : TCommandStatus := ('0', '0', 'Z');

   procedure SendTransaction(variable trans : inout TTransaction;
                             signal CLK : in std_logic;
                             signal MI32_DWR : out std_logic_vector(31 downto 0);
                             signal MI32_ADDR : out std_logic_vector(31 downto 0);
                             signal MI32_BE : out std_logic_vector(3 downto 0);
                             signal MI32_WR : out std_logic;
                             signal MI32_RD : out std_logic;
                             signal MI32_DRD : in std_logic_vector(31 downto 0);
                             signal MI32_DRDY : in std_logic;
                             signal MI32_ARDY : in std_logic) is

      begin
         if (trans.DIRECTION = READ) then
            wait until (CLK'event and CLK = '1');
            MI32_ADDR <= trans.ADDR;
            MI32_BE <= trans.BE;
            MI32_RD <= '1';
            wait until (CLK'event and CLK = '1' and MI32_ARDY = '1');
            MI32_RD <= '0';
            MI32_ADDR <= (others => '0');
            MI32_BE  <= (others => '0');
            wait until (CLK'event and CLK = '1' and MI32_DRDY = '1');
            trans.DATA := MI32_DRD;
            wait until (CLK'event and CLK = '1');
         else
            MI32_ADDR <= trans.ADDR;
            MI32_BE <= trans.BE;
            MI32_DWR <= trans.DATA;
            MI32_WR <= '1';
            while (MI32_ARDY = '0') loop
               wait until MI32_ARDY = '1';
            end loop;
            wait until (CLK'event and CLK = '0');
            wait until (CLK'event and CLK = '1');
            MI32_WR <= '0';
            MI32_ADDR <= (others => '0');
            MI32_DWR <= (others => '0');
            MI32_BE  <= (others => '0');
         end if;
      end procedure;


   begin

      status.REQ_ACK <= commandStatus.REQ_ACK;
      status.BUSY <= commandStatus.BUSY;
      commandStatus.REQ <= status.REQ;

      sim: process
         variable transaction : TTransaction;
      begin
         MI32_DWR <= (others => '0');
         MI32_ADDR <= (others => '0');
         MI32_BE  <= (others => '0');
         MI32_RD <= '0';
         MI32_WR <= '0';

         loop
            commandStatus.BUSY <= '0';
            wait until commandStatus.REQ = '1';
            commandStatus.BUSY <= '1';
            commandStatus.REQ_ACK <= '1';

            ReadTransaction(transaction);
            SendTransaction(transaction, CLK, MI32_DWR, MI32_ADDR, MI32_BE, MI32_WR, MI32_RD, MI32_DRD, MI32_DRDY, MI32_ARDY);
            WriteTransaction(transaction);
            commandStatus.REQ_ACK <= '0';
            commandStatus.BUSY <= '0';
         end loop;
      end process;

end architecture;
