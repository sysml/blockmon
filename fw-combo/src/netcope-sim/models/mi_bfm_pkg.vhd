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

-- fl_bfm_pkg.vhd: Support package for bfm_sim
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
-- $Id: mi_bfm_pkg.vhd 12021 2011-04-15 08:23:45Z kastovsky $
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
--                        MI SIM Package
-- ----------------------------------------------------------------------------
package mi_bfm_pkg is
   type TTransactionDirection is (READ, WRITE);

   type TTransaction is record
      DATA : std_logic_vector(31 downto 0);
      ADDR : std_logic_vector(31 downto 0);
      BE   : std_logic_vector(3 downto 0);
      DIRECTION : TTransactionDirection;
   end record;

   type TCommandStatus is record
      BUSY : std_logic;
      REQ_ACK : std_logic;
      REQ  : std_logic;
   end record;

   signal status : TCommandStatus := ('0', '0', '0');

   -- internaly used to synchronize model
   procedure WriteTransaction(variable trans : in TTransaction);
   procedure ReadTransaction(variable trans : out TTransaction);

   -- write data on address addr with byte enables be. status_cnt have to be status(x) and mi_sim_id have to be x
   procedure MI32Write(constant addr : in std_logic_vector(31 downto 0);
                       constant data : in std_logic_vector(31 downto 0);
                       constant be : in std_logic_vector(3 downto 0);
                       signal status : inout TCommandStatus);

   -- read data from address addr with byte enables be. status_cnt have to be status(x) and mi_sim_id have to be x
   procedure MI32Read(constant addr : in std_logic_vector(31 downto 0);
                      variable data : inout std_logic_vector(31 downto 0);
                      constant be : in std_logic_vector(3 downto 0);
                      signal status : inout TCommandStatus);
end mi_bfm_pkg;


-- ----------------------------------------------------------------------------
--                      MI SIM PKG BODY
-- ----------------------------------------------------------------------------
package body mi_bfm_pkg is

   shared variable transaction : TTransaction;

   procedure ReadTransaction(variable trans : out TTransaction) is
   begin
      trans := transaction;
   end procedure;

   procedure WriteTransaction(variable trans : in TTransaction) is
   begin
      transaction := trans;
   end procedure;

   procedure MI32Write(constant addr : in std_logic_vector(31 downto 0);
                       constant data : in std_logic_vector(31 downto 0);
                       constant be : in std_logic_vector(3 downto 0);
                       signal status : inout TCommandStatus) is
   begin
      transaction.ADDR := addr;
      transaction.DATA := data;
      transaction.BE := be;
      transaction.DIRECTION := WRITE;

      status.REQ <= '1';
      wait on status.REQ_ACK;
      status.REQ <= '0';
      wait until status.BUSY = '0';
   end procedure;


   procedure MI32Read(constant addr : in std_logic_vector(31 downto 0);
                      variable data : inout std_logic_vector(31 downto 0);
                      constant be   : in std_logic_vector(3 downto 0);
                      signal status : inout TCommandStatus) is
   begin
      transaction.ADDR := addr;
      transaction.BE := be;
      transaction.DIRECTION := READ;
      status.REQ <= '1';
      wait on status.REQ_ACK;
      status.REQ <= '0';
      wait until status.BUSY = '0';
      data := transaction.data;
   end procedure;

end mi_bfm_pkg;
