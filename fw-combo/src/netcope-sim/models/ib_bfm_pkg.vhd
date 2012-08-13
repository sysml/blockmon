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

-- storage_init_pkg.vhd: Storage Init PKG
-- Copyright (C) 2006 CESNET
-- Author(s): Petr Kobiersky <xkobie00@stud.fit.vutbr.cz>
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
-- $Id: ib_bfm_pkg.vhd 12021 2011-04-15 08:23:45Z kastovsky $
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
--                        Internal Bus BFM Package
-- ----------------------------------------------------------------------------
PACKAGE ib_bfm_pkg IS

  CONSTANT MAX_TRANS_LENGTH : integer := 4095;
  CONSTANT MAX_WRITE_LENGTH : integer := 4096;
  CONSTANT MAX_INIT_DATA    : integer := 4096;


  -----------------------------------------------------------------------------
  -- DATA TYPES
  -----------------------------------------------------------------------------
  -- Internal Bus Operation Type
  TYPE IbOpType IS (LocalRead, LocalWrite, Completition, G2LR, L2GW, FileLogging, TranscriptLogging,
                    InitMemory, InitMemoryFromAddr, ShowMemory);

  -- File Name Type
  TYPE FileNameType IS RECORD
    Len   : integer;
    Arr   : string(1 to 256);
  END RECORD;

  TYPE DataType IS ARRAY (0 TO MAX_INIT_DATA/8) of std_logic_vector(63 downto 0);

  -- Operation parameters
  TYPE DiCmdType IS RECORD
    SrcAddr        : std_logic_vector(31 downto 0); -- Source Address
    DstAddr        : std_logic_vector(31 downto 0); -- Destination Address
    LocalAddr      : std_logic_vector(31 downto 0); -- Local Address (for GlobalTransactions)
    GlobalAddr     : std_logic_vector(63 downto 0); -- Global Address (for GlobalTransactions) 
    Length         : integer;                       -- Length
    Tag            : integer;                       -- Tag
    Data           : DataType;                      -- Data
    LastFlag       : std_logic;                     -- Completition Last Flag
    Enable         : boolean;
    FileName       : FileNameType;
    MemAddr        : integer;
  END RECORD;

  -- Command record
  TYPE IbCmdVType IS
    RECORD
      CmdOp     : IbOpType;  -- Operation
      Di        : DiCmdType; -- Operation input parameters
    END RECORD;

  -- Command REQ/ACK record
  TYPE IbCmdType IS
    RECORD
      Req      : std_logic;
      ReqAck   : std_logic;
      Ack      : std_logic;
    END RECORD;

  ----------------------------------------------------------------------------
  -- SIGNAL FOR SETTINGS BFM REQUESTS
  ----------------------------------------------------------------------------
  SIGNAL IbCmd : IbCmdType := ('0', 'Z', 'Z');


  ----------------------------------------------------------------------------
  -- BFM FUNCTIONS
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Functions is called by IB BFM model to obtain command parameters
  PROCEDURE ReadIbCmdV (VARIABLE LclIbCmdV : OUT IbCmdVType);

  ----------------------------------------------------------------------------
  -- Functions is called by IB BFM model to return results
  PROCEDURE WriteIbCmdV (VARIABLE LclIbCmdV  : IN IbCmdVType);

  -----------------------------------------------------------------------------
  -- Converts string type into the FileNameType
  FUNCTION ConvFileName(FileName : string) RETURN FileNameType;

  -----------------------------------------------------------------------------
  -- Converts FileNameType into the string
  FUNCTION ConvFileName(FileName : FileNameType) return string;


  ----------------------------------------------------------------------------
  -- USER FUNCTIONS
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  -- Local Read Transaction
  PROCEDURE IBLocalRead (
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- Address from where are data readed
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination address of completition transaction
    CONSTANT Length   : IN integer;                       -- Number of bytes to be readed
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Local Write Transaction
  PROCEDURE IBLocalWrite (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Local Write Transaction with Data from File
  PROCEDURE IBLocalWriteFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Local Write Transaction
  PROCEDURE IBLocalWrite32 (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(31 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Local Write Transaction with Data from File
  PROCEDURE IBLocalWriteFile32 (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (32 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Completition Transaction
  PROCEDURE IBCompletition (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Completition Transaction with Data from File
  PROCEDURE IBCompletitionFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );
  
  -----------------------------------------------------------------------
  -- Not Last Completition Transaction (op_done is not generated)
  PROCEDURE IBNotLastCompletition (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Not Last Completition Transaction with Data from File (op_done is not generated)
  PROCEDURE IBNotLastCompletitionFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Enable Transcript Logging
  PROCEDURE SetTranscriptLogging (
    CONSTANT Enable   : IN boolean;                       -- Enable/Disable
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Enable File Logging
  PROCEDURE SetFileLogging (
    CONSTANT Enable   : IN boolean;                       -- Enable/Disable
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

  -----------------------------------------------------------------------
  -- Init HostPC Memory
  PROCEDURE InitMemory (
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );
  -----------------------------------------------------------------------
  -- Init HostPC Memory Starting From Given Address
  PROCEDURE InitMemoryFromAddr (
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Address  : IN integer;                       -- Where to write data
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );
  -----------------------------------------------------------------------
  -- Show content of Memory
  PROCEDURE ShowMemory (
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    );

END ib_bfm_pkg;



-- ----------------------------------------------------------------------------
--                      Internal Bus BFM Package BODY
-- ----------------------------------------------------------------------------
PACKAGE BODY ib_bfm_pkg IS
  
  -----------------------------------------------------------------------------
  -- Command shared variable
  SHARED  VARIABLE IbCmdV : IbCmdVType;

  -----------------------------------------------------------------------------
  -- Functions is called by IB BFM model to obtain command parameters
  PROCEDURE ReadIbCmdV (VARIABLE LclIbCmdV : OUT IbCmdVType) IS
  BEGIN
    LclIbCmdV := IbCmdV;
  END;

  -----------------------------------------------------------------------------
  -- Functions is called by IB BFM model to return results
  PROCEDURE WriteIbCmdV (VARIABLE LclIbCmdV  : IN IbCmdVType) IS
  BEGIN
    IbCmdV := LclIbCmdV;
  END;

  -----------------------------------------------------------------------------
  -- Converts string type into the FileNameType
  FUNCTION ConvFileName(FileName : string) RETURN FileNameType IS
  VARIABLE result : FileNameType;
  BEGIN
    result.Len := FileName'length;
    result.Arr(1 to result.len) := FileName;
    RETURN result;
  END;

  -----------------------------------------------------------------------------
  -- Converts FileNameType into the string
  FUNCTION ConvFileName(FileName : FileNameType) return string is
  BEGIN
    RETURN FileName.arr(1 to FileName.len);
  END;

  -- ----------------------------------------------------------------
  -- Count Number of lines in file
  FUNCTION FileLineCount(FileName : IN string) RETURN integer IS
   FILE     in_file      : text;
   VARIABLE in_line      : line;
   VARIABLE readFlag     : boolean;
   VARIABLE data         : std_logic_vector(63 downto 0);
   VARIABLE i            : integer;
   BEGIN
     i:=0;
     file_open(in_file, FileName, READ_MODE);
     while not (endfile(in_file)) loop
      readline(in_file, in_line);
      i:=i+1;
     end loop;
     file_close(in_file);
     RETURN i;
   END;

  -----------------------------------------------------------------------------
  -- Local Read Transaction
  PROCEDURE IBLocalRead (
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- Address from where are data readed
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination address of completition transaction
    CONSTANT Length   : IN integer;                       -- Number of bytes to be readed
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    assert (length <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp      := LocalRead;
    IbCmdV.Di.SrcAddr := SrcAddr;
    IbCmdV.Di.DstAddr := DstAddr;
    IbCmdV.Di.Length  := Length;
    IbCmdV.Di.Tag     := Tag;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------------
  -- Local Write Transaction
  PROCEDURE IBLocalWrite (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    assert (length <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp      := LocalWrite;
    IbCmdV.Di.SrcAddr := SrcAddr;
    IbCmdV.Di.DstAddr := DstAddr;
    IbCmdV.Di.Length  := Length;
    IbCmdV.Di.Tag     := Tag;
    IbCmdV.Di.Data(0) := Data;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------------
  -- Local Write File Transaction
  PROCEDURE IBLocalWriteFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  
    file     in_file      : text;
    variable in_line      : line;
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
    variable j            : integer;
    variable split_cnt    : integer;
    variable split_len    : integer;
  BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*8;
    else
      len := Length;
    end if;

    if (len <= MAX_WRITE_LENGTH) then
      IbCmdV.CmdOp       := LocalWrite;
      IbCmdV.Di.SrcAddr  := SrcAddr;
      IbCmdV.Di.DstAddr  := DstAddr;
      IbCmdV.Di.Length   := len;
      IbCmdV.Di.Tag      := Tag;
         
      file_open(in_file, FileName, READ_MODE);
      i:=0;
      while (i < len) loop
        readline(in_file, in_line);
        hread(in_line, IbCmdV.Di.Data(i/8), readFlag);
        assert readFlag report "IBLocalWriteFile read error" severity ERROR;
        i:=i+8;
      end loop;
      file_close(in_file);
      -- Req toggles each time we want the BFM to do a new check.
      IbCmd.Req <= '1';
      WAIT ON IbCmd.ReqAck;
      IbCmd.Req <= '0';
      WAIT ON IbCmd.Ack;
    
    else -- Split transactions
      file_open(in_file, FileName, READ_MODE);
      split_cnt := (len / MAX_WRITE_LENGTH);
      if (len > (MAX_WRITE_LENGTH*split_cnt)) then
        split_cnt := split_cnt+1;
      end if;
  
      i:=0;
      WHILE (split_cnt > 0) loop
        if (len > MAX_WRITE_LENGTH) then
          split_len := MAX_WRITE_LENGTH;
        else
          split_len := len;
        end if;
        IbCmdV.CmdOp       := LocalWrite;
        IbCmdV.Di.SrcAddr  := SrcAddr;
        IbCmdV.Di.DstAddr  := DstAddr+(i*MAX_WRITE_LENGTH);
        IbCmdV.Di.Length   := split_len;
        IbCmdV.Di.Tag      := Tag;
        
        j:=0;
        while (j < split_len) loop
          readline(in_file, in_line);
          hread(in_line, IbCmdV.Di.Data(j/8), readFlag);
          assert readFlag report "IBLocalWriteFile read error" severity ERROR;
          j:=j+8;
        end loop;


        i:=i+1;
        split_cnt:=split_cnt-1;
        len:=len-MAX_WRITE_LENGTH;
        -- Req toggles each time we want the BFM to do a new check.
        IbCmd.Req <= '1';
        WAIT ON IbCmd.ReqAck;
        IbCmd.Req <= '0';
        WAIT ON IbCmd.Ack;
      END LOOP;
      file_close(in_file);
    END IF;
  END;

  -----------------------------------------------------------------------------
  -- Local Write Transaction
  PROCEDURE IBLocalWrite32 (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(31 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    assert (length <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp      := LocalWrite;
    IbCmdV.Di.SrcAddr := SrcAddr;
    IbCmdV.Di.DstAddr := DstAddr;
    IbCmdV.Di.Length  := Length;
    IbCmdV.Di.Tag     := Tag;
    IbCmdV.Di.Data(0) := X"00000000" & Data;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------------
  -- Local Write File Transaction
  PROCEDURE IBLocalWriteFile32 (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (32 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  
    file     in_file      : text;
    variable in_line      : line;
    variable data32a      : std_logic_vector(31 downto 0);
    variable data32b      : std_logic_vector(31 downto 0);
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
    variable j            : integer;
    variable split_cnt    : integer;
    variable split_len    : integer;

  BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*4;
    else
      len := Length;
    end if;
    if (len <= MAX_WRITE_LENGTH) then
    IbCmdV.CmdOp       := LocalWrite;
    IbCmdV.Di.SrcAddr  := SrcAddr;
    IbCmdV.Di.DstAddr  := DstAddr;
    IbCmdV.Di.Length   := Len;
    IbCmdV.Di.Tag      := Tag;
         
    file_open(in_file, FileName, READ_MODE);
    i:=0;
    while (i < len) loop
      readline(in_file, in_line);
      hread(in_line, data32a, readFlag);
      assert readFlag report "IBLocalWriteFile32 read error" severity ERROR;
      if ((i + 4) < len) then
        readline(in_file, in_line);
        hread(in_line, data32b, readFlag);
        assert readFlag report "IBLocalWriteFile32 read error" severity ERROR;
      else
        data32b:=X"00000000";
      end if;
      IbCmdV.Di.Data(i/8):= data32b&data32a;
      i:=i+8;
    end loop;
    file_close(in_file);

    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
   else
      file_open(in_file, FileName, READ_MODE);
      split_cnt := (len / MAX_WRITE_LENGTH);
      if (len > (MAX_WRITE_LENGTH*split_cnt)) then
        split_cnt := split_cnt+1;
      end if;
  
      i:=0;
      WHILE (split_cnt > 0) loop
        if (len > MAX_WRITE_LENGTH) then
          split_len := MAX_WRITE_LENGTH;
        else
          split_len := len;
        end if;
        IbCmdV.CmdOp       := LocalWrite;
        IbCmdV.Di.SrcAddr  := SrcAddr;
        IbCmdV.Di.DstAddr  := DstAddr+(i*MAX_WRITE_LENGTH);
        IbCmdV.Di.Length   := split_len;
        IbCmdV.Di.Tag      := Tag;
        
        j := 0;
	while (j < split_len) loop
        readline(in_file, in_line);
        hread(in_line, data32a, readFlag);
        assert readFlag report "IBLocalWriteFile32 read error" severity ERROR;
        if ((j + 4) < len) then
          readline(in_file, in_line);
          hread(in_line, data32b, readFlag);
        assert readFlag report "IBLocalWriteFile32 read error" severity ERROR;
        else
          data32b:=X"00000000";
        end if;
        IbCmdV.Di.Data(j/8):= data32b&data32a;
        j:=j+8;
       end loop;


        i:=i+1;
        split_cnt:=split_cnt-1;
        len:=len-MAX_WRITE_LENGTH;
        -- Req toggles each time we want the BFM to do a new check.
        IbCmd.Req <= '1';
        WAIT ON IbCmd.ReqAck;
        IbCmd.Req <= '0';
        WAIT ON IbCmd.Ack;
      END LOOP;
      file_close(in_file);
	   
    end if;
  END;

  -----------------------------------------------------------------------
  -- Completition Transaction
  PROCEDURE IBCompletition (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    assert (length <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp       := Completition;
    IbCmdV.Di.SrcAddr  := SrcAddr;
    IbCmdV.Di.DstAddr  := DstAddr;
    IbCmdV.Di.Length   := Length;
    IbCmdV.Di.Tag      := Tag;
    IbCmdV.Di.Data(0)  := Data;
    IbCmdV.Di.LastFlag := '1';
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;


  -----------------------------------------------------------------------
  -- Completition Transaction with Data from File
  PROCEDURE IBCompletitionFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
    file     in_file      : text;
    variable in_line      : line;
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
 BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*8;
    else
      len := Length;
    end if;
    assert (len <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp       := Completition;
    IbCmdV.Di.SrcAddr  := SrcAddr;
    IbCmdV.Di.DstAddr  := DstAddr;
    IbCmdV.Di.Length   := len;
    IbCmdV.Di.Tag      := Tag;
    IbCmdV.Di.LastFlag := '1';     
    file_open(in_file, FileName, READ_MODE);
    i:=0;
    while (i < len) loop
      readline(in_file, in_line);
      hread(in_line, IbCmdV.Di.Data(i/8), readFlag);
      assert readFlag report "IBCompletitionFile read error" severity ERROR;
      i:=i+8;
    end loop;
    file_close(in_file);

    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;
  
  -----------------------------------------------------------------------
  -- Not Last Completition Transaction (op_done is not generated)
  PROCEDURE IBNotLastCompletition (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT Data     : IN std_logic_vector(63 downto 0); -- Data to be writen
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    assert (length <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp       := Completition;
    IbCmdV.Di.SrcAddr  := SrcAddr;
    IbCmdV.Di.DstAddr  := DstAddr;
    IbCmdV.Di.Length   := Length;
    IbCmdV.Di.Tag      := Tag;
    IbCmdV.Di.Data(0)  := Data;
    IbCmdV.Di.LastFlag := '0';
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Not Last Completition Transaction with Data from File (op_done is not generated)
  PROCEDURE IBNotLastCompletitionFile (
    CONSTANT DstAddr  : IN std_logic_vector(31 downto 0); -- Destination addres of write transaction
    CONSTANT SrcAddr  : IN std_logic_vector(31 downto 0); -- From where are write transaction generated
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Tag      : IN integer;                       -- Transaction Tag
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  
    file     in_file      : text;
    variable in_line      : line;
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
  BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*8;
    else
      len := Length;
    end if;
    assert (len <= MAX_TRANS_LENGTH) report "Transaction length exceed 4095 bytes IB limit" severity ERROR;
    IbCmdV.CmdOp       := Completition;
    IbCmdV.Di.SrcAddr  := SrcAddr;
    IbCmdV.Di.DstAddr  := DstAddr;
    IbCmdV.Di.Length   := len;
    IbCmdV.Di.Tag      := Tag;
    IbCmdV.Di.LastFlag := '0';     
    file_open(in_file, FileName, READ_MODE);
    i:=0;
    while (i < len) loop
      readline(in_file, in_line);
      hread(in_line, IbCmdV.Di.Data(i/8), readFlag);
      assert readFlag report "IBNotLastCompletitionFile read error" severity ERROR;
      i:=i+8;
    end loop;
    file_close(in_file);

    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Enable Transcript Logging
  PROCEDURE SetTranscriptLogging (
    CONSTANT Enable   : IN boolean;                       -- Enable/Disable
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    IbCmdV.CmdOp       := TranscriptLogging;
    IbCmdV.Di.Enable   := Enable;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Enable File Logging
  PROCEDURE SetFileLogging (
    CONSTANT Enable   : IN boolean;                       -- Enable/Disable
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
  BEGIN
    IbCmdV.CmdOp       := FileLogging;
    IbCmdV.Di.Enable   := Enable;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Init HostPC Memory
  PROCEDURE InitMemory (
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
    file     in_file      : text;
    variable in_line      : line;
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
  BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*8;
    else
      len := Length;
    end if;
    assert (len <= MAX_INIT_DATA) report "Transaction length exceed 4096 bytes memory init limit" severity ERROR;
    IbCmdV.CmdOp      := InitMemory;
    IbCmdV.Di.Length  := Length;
    IbCmdV.Di.MemAddr := 0;

    file_open(in_file, FileName, READ_MODE);
    i:=0;
    while (i < len) loop
      readline(in_file, in_line);
      hread(in_line, IbCmdV.Di.Data(i/8), readFlag);
      assert readFlag report "InitMemory read error" severity ERROR;
      i:=i+8;
    end loop;
    file_close(in_file);

    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Init HostPC Memory Starting From Given Address
  PROCEDURE InitMemoryFromAddr (
    CONSTANT Length   : IN integer;                       -- Length of writen data
    CONSTANT Address  : IN integer;                       -- Where to write data
    CONSTANT FileName : IN string;                        -- Filename from where are data writen (64 bit hexa values)
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
    ) IS
    file     in_file      : text;
    variable in_line      : line;
    variable readFlag     : boolean;
    variable len          : integer;
    variable i            : integer;
  BEGIN
    if (Length = 0) then
      len := FileLineCount(FileName)*8;
    else
      len := Length;
    end if;
    assert (len <= MAX_INIT_DATA) report "Transaction length exceed 4096 bytes memory init limit" severity ERROR;
    IbCmdV.CmdOp      := InitMemoryFromAddr;
    IbCmdV.Di.Length  := Length;
    IbCmdV.Di.MemAddr := Address;

    file_open(in_file, FileName, READ_MODE);
    i:=0;
    while (i < len) loop
      readline(in_file, in_line);
      hread(in_line, IbCmdV.Di.Data((i)/8), readFlag);
      assert readFlag report "InitMemoryFromAddr read error" severity ERROR;
      i:=i+8;
    end loop;
    file_close(in_file);

    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;

  -----------------------------------------------------------------------
  -- Show content of Memory
  PROCEDURE ShowMemory (
    SIGNAL   IbCmd    : INOUT IbCmdType                   -- Command record
  ) IS
  BEGIN
    IbCmdV.CmdOp := ShowMemory;
    -- Req toggles each time we want the BFM to do a new check.
    IbCmd.Req <= '1';
    WAIT ON IbCmd.ReqAck;
    IbCmd.Req <= '0';
    WAIT ON IbCmd.Ack;
  END;
END ib_bfm_pkg;

