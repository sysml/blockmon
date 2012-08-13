--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: O.40d
--  \   \         Application: netgen
--  /   /         Filename: tsu_async.vhd
-- /___/   /\     Timestamp: Wed Mar 30 10:05:04 2011
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -ofmt vhdl -w ngc/tsu_async.ngc sim/synth_models/tsu_async.vhd 
-- Device	: xc5vlx155t-2-ff1136
-- Input file	: ngc/tsu_async.ngc
-- Output file	: sim/synth_models/tsu_async.vhd
-- # of Entities	: 1
-- Design Name	: tsu_async
-- Xilinx	: /usr/local/fpga/xilinx131/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity tsu_async is
  port (
    IN_TS_DV : in STD_LOGIC := 'X'; 
    IN_CLK : in STD_LOGIC := 'X'; 
    RESET : in STD_LOGIC := 'X'; 
    OUT_TS_DV : out STD_LOGIC; 
    OUT_CLK : in STD_LOGIC := 'X'; 
    OUT_TS : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    IN_TS : in STD_LOGIC_VECTOR ( 63 downto 0 ) 
  );
end tsu_async;

architecture STRUCTURE of tsu_async is
  signal N0 : STD_LOGIC; 
  signal NlwRenamedSig_OI_OUT_TS_DV : STD_LOGIC; 
  signal ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000 : STD_LOGIC; 
  signal ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000 : STD_LOGIC; 
  signal ts_data_asfifo_full_allow : STD_LOGIC; 
  signal ts_data_asfifo_read_nextgray_0_xor0000 : STD_LOGIC; 
  signal ts_data_asfifo_regasync_empty_166 : STD_LOGIC; 
  signal ts_data_asfifo_regasync_full_167 : STD_LOGIC; 
  signal ts_data_asfifo_write_nextgray_0_xor0000 : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory64_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory63_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory62_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory61_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory60_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory59_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory58_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory57_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory56_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory55_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory54_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory53_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory52_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory51_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory49_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory48_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory50_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory47_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory46_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory45_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory44_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory43_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory42_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory40_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory39_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory41_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory38_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory37_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory36_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory35_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory34_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory33_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory31_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory30_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory32_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory29_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory28_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory27_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory26_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory25_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory24_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory22_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory21_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory23_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory20_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory19_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory18_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory17_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory16_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory15_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory13_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory12_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory14_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory11_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory10_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory9_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory8_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory7_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory6_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory4_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory3_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory5_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory2_SPO_UNCONNECTED : STD_LOGIC; 
  signal NLW_ts_data_asfifo_MEM_U_Mram_memory1_SPO_UNCONNECTED : STD_LOGIC; 
  signal ts_data_asfifo_cnt_read_addr_up_cin : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal ts_data_asfifo_cnt_read_addr_up_reg_cnt : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_cnt_read_addr_up_s : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_cnt_read_addr_up_xo : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_cnt_write_addr_u_cin : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal ts_data_asfifo_cnt_write_addr_u_reg_cnt : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_cnt_write_addr_u_s : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_cnt_write_addr_u_xo : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_ecomp : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_emuxcyo : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal ts_data_asfifo_fcomp : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_fmuxcyo : STD_LOGIC_VECTOR ( 2 downto 1 ); 
  signal ts_data_asfifo_read_addrgray : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_read_lastgray : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_read_nextgray : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_write_addrgray : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal ts_data_asfifo_write_nextgray : STD_LOGIC_VECTOR ( 1 downto 0 ); 
begin
  OUT_TS_DV <= NlwRenamedSig_OI_OUT_TS_DV;
  XST_GND : GND
    port map (
      G => N0
    );
  XST_VCC : VCC
    port map (
      P => NlwRenamedSig_OI_OUT_TS_DV
    );
  ts_data_asfifo_cnt_read_addr_up_reg_cnt_0 : FDCE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_cnt_read_addr_up_xo(0),
      Q => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0)
    );
  ts_data_asfifo_cnt_read_addr_up_reg_cnt_1 : FDCE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_cnt_read_addr_up_xo(1),
      Q => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1)
    );
  ts_data_asfifo_cnt_read_addr_up_gen_width_gt1_gen_muxcy_l_0_MUXCY_L_U : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      DI => N0,
      S => ts_data_asfifo_cnt_read_addr_up_s(0),
      LO => ts_data_asfifo_cnt_read_addr_up_cin(1)
    );
  ts_data_asfifo_cnt_read_addr_up_gen_width_gt1_gen_lut1_l_0_gen_init_const_up_LUT1_L_U : LUT1_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      LO => ts_data_asfifo_cnt_read_addr_up_s(0)
    );
  ts_data_asfifo_cnt_read_addr_up_gen_width_gt1_gen_lut1_l_1_gen_init_const_up_LUT1_L_U : LUT1_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      LO => ts_data_asfifo_cnt_read_addr_up_s(1)
    );
  ts_data_asfifo_cnt_read_addr_up_gen_width_gt1_gen_xorcy_0_XORCY_U : XORCY
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      LI => ts_data_asfifo_cnt_read_addr_up_s(0),
      O => ts_data_asfifo_cnt_read_addr_up_xo(0)
    );
  ts_data_asfifo_cnt_read_addr_up_gen_width_gt1_gen_xorcy_1_XORCY_U : XORCY
    port map (
      CI => ts_data_asfifo_cnt_read_addr_up_cin(1),
      LI => ts_data_asfifo_cnt_read_addr_up_s(1),
      O => ts_data_asfifo_cnt_read_addr_up_xo(1)
    );
  ts_data_asfifo_cnt_write_addr_u_reg_cnt_0 : FDCE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_cnt_write_addr_u_xo(0),
      Q => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0)
    );
  ts_data_asfifo_cnt_write_addr_u_reg_cnt_1 : FDCE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_cnt_write_addr_u_xo(1),
      Q => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1)
    );
  ts_data_asfifo_cnt_write_addr_u_gen_width_gt1_gen_muxcy_l_0_MUXCY_L_U : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      DI => N0,
      S => ts_data_asfifo_cnt_write_addr_u_s(0),
      LO => ts_data_asfifo_cnt_write_addr_u_cin(1)
    );
  ts_data_asfifo_cnt_write_addr_u_gen_width_gt1_gen_lut1_l_0_gen_init_const_up_LUT1_L_U : LUT1_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      LO => ts_data_asfifo_cnt_write_addr_u_s(0)
    );
  ts_data_asfifo_cnt_write_addr_u_gen_width_gt1_gen_lut1_l_1_gen_init_const_up_LUT1_L_U : LUT1_L
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      LO => ts_data_asfifo_cnt_write_addr_u_s(1)
    );
  ts_data_asfifo_cnt_write_addr_u_gen_width_gt1_gen_xorcy_0_XORCY_U : XORCY
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      LI => ts_data_asfifo_cnt_write_addr_u_s(0),
      O => ts_data_asfifo_cnt_write_addr_u_xo(0)
    );
  ts_data_asfifo_cnt_write_addr_u_gen_width_gt1_gen_xorcy_1_XORCY_U : XORCY
    port map (
      CI => ts_data_asfifo_cnt_write_addr_u_cin(1),
      LI => ts_data_asfifo_cnt_write_addr_u_s(1),
      O => ts_data_asfifo_cnt_write_addr_u_xo(1)
    );
  ts_data_asfifo_FMUXCY_GEN_1_fmuxcyX : MUXCY_L
    port map (
      CI => ts_data_asfifo_fmuxcyo(1),
      DI => N0,
      S => ts_data_asfifo_fcomp(1),
      LO => ts_data_asfifo_fmuxcyo(2)
    );
  ts_data_asfifo_FMUXCY_GEN_0_fmuxcyX : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      DI => N0,
      S => ts_data_asfifo_fcomp(0),
      LO => ts_data_asfifo_fmuxcyo(1)
    );
  ts_data_asfifo_EMUXCY_GEN_1_emuxcyX : MUXCY_L
    port map (
      CI => ts_data_asfifo_emuxcyo(1),
      DI => N0,
      S => ts_data_asfifo_ecomp(1),
      LO => ts_data_asfifo_emuxcyo(2)
    );
  ts_data_asfifo_EMUXCY_GEN_0_emuxcyX : MUXCY_L
    port map (
      CI => NlwRenamedSig_OI_OUT_TS_DV,
      DI => N0,
      S => ts_data_asfifo_ecomp(0),
      LO => ts_data_asfifo_emuxcyo(1)
    );
  ts_data_asfifo_MEM_U_Mram_memory64 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(63),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory64_SPO_UNCONNECTED,
      DPO => OUT_TS(63)
    );
  ts_data_asfifo_MEM_U_Mram_memory63 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(62),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory63_SPO_UNCONNECTED,
      DPO => OUT_TS(62)
    );
  ts_data_asfifo_MEM_U_Mram_memory62 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(61),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory62_SPO_UNCONNECTED,
      DPO => OUT_TS(61)
    );
  ts_data_asfifo_MEM_U_Mram_memory61 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(60),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory61_SPO_UNCONNECTED,
      DPO => OUT_TS(60)
    );
  ts_data_asfifo_MEM_U_Mram_memory60 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(59),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory60_SPO_UNCONNECTED,
      DPO => OUT_TS(59)
    );
  ts_data_asfifo_MEM_U_Mram_memory59 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(58),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory59_SPO_UNCONNECTED,
      DPO => OUT_TS(58)
    );
  ts_data_asfifo_MEM_U_Mram_memory58 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(57),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory58_SPO_UNCONNECTED,
      DPO => OUT_TS(57)
    );
  ts_data_asfifo_MEM_U_Mram_memory57 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(56),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory57_SPO_UNCONNECTED,
      DPO => OUT_TS(56)
    );
  ts_data_asfifo_MEM_U_Mram_memory56 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(55),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory56_SPO_UNCONNECTED,
      DPO => OUT_TS(55)
    );
  ts_data_asfifo_MEM_U_Mram_memory55 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(54),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory55_SPO_UNCONNECTED,
      DPO => OUT_TS(54)
    );
  ts_data_asfifo_MEM_U_Mram_memory54 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(53),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory54_SPO_UNCONNECTED,
      DPO => OUT_TS(53)
    );
  ts_data_asfifo_MEM_U_Mram_memory53 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(52),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory53_SPO_UNCONNECTED,
      DPO => OUT_TS(52)
    );
  ts_data_asfifo_MEM_U_Mram_memory52 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(51),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory52_SPO_UNCONNECTED,
      DPO => OUT_TS(51)
    );
  ts_data_asfifo_MEM_U_Mram_memory51 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(50),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory51_SPO_UNCONNECTED,
      DPO => OUT_TS(50)
    );
  ts_data_asfifo_MEM_U_Mram_memory49 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(48),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory49_SPO_UNCONNECTED,
      DPO => OUT_TS(48)
    );
  ts_data_asfifo_MEM_U_Mram_memory48 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(47),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory48_SPO_UNCONNECTED,
      DPO => OUT_TS(47)
    );
  ts_data_asfifo_MEM_U_Mram_memory50 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(49),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory50_SPO_UNCONNECTED,
      DPO => OUT_TS(49)
    );
  ts_data_asfifo_MEM_U_Mram_memory47 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(46),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory47_SPO_UNCONNECTED,
      DPO => OUT_TS(46)
    );
  ts_data_asfifo_MEM_U_Mram_memory46 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(45),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory46_SPO_UNCONNECTED,
      DPO => OUT_TS(45)
    );
  ts_data_asfifo_MEM_U_Mram_memory45 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(44),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory45_SPO_UNCONNECTED,
      DPO => OUT_TS(44)
    );
  ts_data_asfifo_MEM_U_Mram_memory44 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(43),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory44_SPO_UNCONNECTED,
      DPO => OUT_TS(43)
    );
  ts_data_asfifo_MEM_U_Mram_memory43 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(42),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory43_SPO_UNCONNECTED,
      DPO => OUT_TS(42)
    );
  ts_data_asfifo_MEM_U_Mram_memory42 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(41),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory42_SPO_UNCONNECTED,
      DPO => OUT_TS(41)
    );
  ts_data_asfifo_MEM_U_Mram_memory40 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(39),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory40_SPO_UNCONNECTED,
      DPO => OUT_TS(39)
    );
  ts_data_asfifo_MEM_U_Mram_memory39 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(38),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory39_SPO_UNCONNECTED,
      DPO => OUT_TS(38)
    );
  ts_data_asfifo_MEM_U_Mram_memory41 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(40),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory41_SPO_UNCONNECTED,
      DPO => OUT_TS(40)
    );
  ts_data_asfifo_MEM_U_Mram_memory38 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(37),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory38_SPO_UNCONNECTED,
      DPO => OUT_TS(37)
    );
  ts_data_asfifo_MEM_U_Mram_memory37 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(36),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory37_SPO_UNCONNECTED,
      DPO => OUT_TS(36)
    );
  ts_data_asfifo_MEM_U_Mram_memory36 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(35),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory36_SPO_UNCONNECTED,
      DPO => OUT_TS(35)
    );
  ts_data_asfifo_MEM_U_Mram_memory35 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(34),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory35_SPO_UNCONNECTED,
      DPO => OUT_TS(34)
    );
  ts_data_asfifo_MEM_U_Mram_memory34 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(33),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory34_SPO_UNCONNECTED,
      DPO => OUT_TS(33)
    );
  ts_data_asfifo_MEM_U_Mram_memory33 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(32),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory33_SPO_UNCONNECTED,
      DPO => OUT_TS(32)
    );
  ts_data_asfifo_MEM_U_Mram_memory31 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(30),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory31_SPO_UNCONNECTED,
      DPO => OUT_TS(30)
    );
  ts_data_asfifo_MEM_U_Mram_memory30 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(29),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory30_SPO_UNCONNECTED,
      DPO => OUT_TS(29)
    );
  ts_data_asfifo_MEM_U_Mram_memory32 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(31),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory32_SPO_UNCONNECTED,
      DPO => OUT_TS(31)
    );
  ts_data_asfifo_MEM_U_Mram_memory29 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(28),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory29_SPO_UNCONNECTED,
      DPO => OUT_TS(28)
    );
  ts_data_asfifo_MEM_U_Mram_memory28 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(27),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory28_SPO_UNCONNECTED,
      DPO => OUT_TS(27)
    );
  ts_data_asfifo_MEM_U_Mram_memory27 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(26),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory27_SPO_UNCONNECTED,
      DPO => OUT_TS(26)
    );
  ts_data_asfifo_MEM_U_Mram_memory26 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(25),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory26_SPO_UNCONNECTED,
      DPO => OUT_TS(25)
    );
  ts_data_asfifo_MEM_U_Mram_memory25 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(24),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory25_SPO_UNCONNECTED,
      DPO => OUT_TS(24)
    );
  ts_data_asfifo_MEM_U_Mram_memory24 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(23),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory24_SPO_UNCONNECTED,
      DPO => OUT_TS(23)
    );
  ts_data_asfifo_MEM_U_Mram_memory22 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(21),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory22_SPO_UNCONNECTED,
      DPO => OUT_TS(21)
    );
  ts_data_asfifo_MEM_U_Mram_memory21 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(20),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory21_SPO_UNCONNECTED,
      DPO => OUT_TS(20)
    );
  ts_data_asfifo_MEM_U_Mram_memory23 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(22),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory23_SPO_UNCONNECTED,
      DPO => OUT_TS(22)
    );
  ts_data_asfifo_MEM_U_Mram_memory20 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(19),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory20_SPO_UNCONNECTED,
      DPO => OUT_TS(19)
    );
  ts_data_asfifo_MEM_U_Mram_memory19 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(18),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory19_SPO_UNCONNECTED,
      DPO => OUT_TS(18)
    );
  ts_data_asfifo_MEM_U_Mram_memory18 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(17),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory18_SPO_UNCONNECTED,
      DPO => OUT_TS(17)
    );
  ts_data_asfifo_MEM_U_Mram_memory17 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(16),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory17_SPO_UNCONNECTED,
      DPO => OUT_TS(16)
    );
  ts_data_asfifo_MEM_U_Mram_memory16 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(15),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory16_SPO_UNCONNECTED,
      DPO => OUT_TS(15)
    );
  ts_data_asfifo_MEM_U_Mram_memory15 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(14),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory15_SPO_UNCONNECTED,
      DPO => OUT_TS(14)
    );
  ts_data_asfifo_MEM_U_Mram_memory13 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(12),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory13_SPO_UNCONNECTED,
      DPO => OUT_TS(12)
    );
  ts_data_asfifo_MEM_U_Mram_memory12 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(11),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory12_SPO_UNCONNECTED,
      DPO => OUT_TS(11)
    );
  ts_data_asfifo_MEM_U_Mram_memory14 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(13),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory14_SPO_UNCONNECTED,
      DPO => OUT_TS(13)
    );
  ts_data_asfifo_MEM_U_Mram_memory11 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(10),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory11_SPO_UNCONNECTED,
      DPO => OUT_TS(10)
    );
  ts_data_asfifo_MEM_U_Mram_memory10 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(9),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory10_SPO_UNCONNECTED,
      DPO => OUT_TS(9)
    );
  ts_data_asfifo_MEM_U_Mram_memory9 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(8),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory9_SPO_UNCONNECTED,
      DPO => OUT_TS(8)
    );
  ts_data_asfifo_MEM_U_Mram_memory8 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(7),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory8_SPO_UNCONNECTED,
      DPO => OUT_TS(7)
    );
  ts_data_asfifo_MEM_U_Mram_memory7 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(6),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory7_SPO_UNCONNECTED,
      DPO => OUT_TS(6)
    );
  ts_data_asfifo_MEM_U_Mram_memory6 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(5),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory6_SPO_UNCONNECTED,
      DPO => OUT_TS(5)
    );
  ts_data_asfifo_MEM_U_Mram_memory4 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(3),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory4_SPO_UNCONNECTED,
      DPO => OUT_TS(3)
    );
  ts_data_asfifo_MEM_U_Mram_memory3 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(2),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory3_SPO_UNCONNECTED,
      DPO => OUT_TS(2)
    );
  ts_data_asfifo_MEM_U_Mram_memory5 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(4),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory5_SPO_UNCONNECTED,
      DPO => OUT_TS(4)
    );
  ts_data_asfifo_MEM_U_Mram_memory2 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(1),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory2_SPO_UNCONNECTED,
      DPO => OUT_TS(1)
    );
  ts_data_asfifo_MEM_U_Mram_memory1 : RAM32X1D
    port map (
      A0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      A1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      A2 => N0,
      A3 => N0,
      A4 => N0,
      D => IN_TS(0),
      DPRA0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      DPRA1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      DPRA2 => N0,
      DPRA3 => N0,
      DPRA4 => N0,
      WCLK => IN_CLK,
      WE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      SPO => NLW_ts_data_asfifo_MEM_U_Mram_memory1_SPO_UNCONNECTED,
      DPO => OUT_TS(0)
    );
  ts_data_asfifo_read_lastgray_0 : FDPE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      D => ts_data_asfifo_read_addrgray(0),
      PRE => RESET,
      Q => ts_data_asfifo_read_lastgray(0)
    );
  ts_data_asfifo_read_lastgray_1 : FDCE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_read_addrgray(1),
      Q => ts_data_asfifo_read_lastgray(1)
    );
  ts_data_asfifo_write_addrgray_1 : FDPE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      D => ts_data_asfifo_write_nextgray(1),
      PRE => RESET,
      Q => ts_data_asfifo_write_addrgray(1)
    );
  ts_data_asfifo_write_addrgray_0 : FDPE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      D => ts_data_asfifo_write_nextgray(0),
      PRE => RESET,
      Q => ts_data_asfifo_write_addrgray(0)
    );
  ts_data_asfifo_read_addrgray_1 : FDPE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      D => ts_data_asfifo_read_nextgray(1),
      PRE => RESET,
      Q => ts_data_asfifo_read_addrgray(1)
    );
  ts_data_asfifo_read_addrgray_0 : FDPE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      D => ts_data_asfifo_read_nextgray(0),
      PRE => RESET,
      Q => ts_data_asfifo_read_addrgray(0)
    );
  ts_data_asfifo_regasync_empty : FDP
    port map (
      C => OUT_CLK,
      D => ts_data_asfifo_emuxcyo(2),
      PRE => RESET,
      Q => ts_data_asfifo_regasync_empty_166
    );
  ts_data_asfifo_write_nextgray_0 : FDCE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_write_nextgray_0_xor0000,
      Q => ts_data_asfifo_write_nextgray(0)
    );
  ts_data_asfifo_regasync_full : FDPE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_full_allow,
      D => ts_data_asfifo_fmuxcyo(2),
      PRE => RESET,
      Q => ts_data_asfifo_regasync_full_167
    );
  ts_data_asfifo_read_nextgray_0 : FDCE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      CLR => RESET,
      D => ts_data_asfifo_read_nextgray_0_xor0000,
      Q => ts_data_asfifo_read_nextgray(0)
    );
  ts_data_asfifo_write_nextgray_1 : FDPE
    port map (
      C => IN_CLK,
      CE => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000,
      D => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      PRE => RESET,
      Q => ts_data_asfifo_write_nextgray(1)
    );
  ts_data_asfifo_read_nextgray_1 : FDPE
    port map (
      C => OUT_CLK,
      CE => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000,
      D => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      PRE => RESET,
      Q => ts_data_asfifo_read_nextgray(1)
    );
  ts_data_asfifo_Mxor_write_nextgray_0_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(0),
      I1 => ts_data_asfifo_cnt_write_addr_u_reg_cnt(1),
      O => ts_data_asfifo_write_nextgray_0_xor0000
    );
  ts_data_asfifo_Mxor_read_nextgray_0_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(0),
      I1 => ts_data_asfifo_cnt_read_addr_up_reg_cnt(1),
      O => ts_data_asfifo_read_nextgray_0_xor0000
    );
  ts_data_asfifo_fcomp_1_or00001 : LUT4
    generic map(
      INIT => X"E14B"
    )
    port map (
      I0 => ts_data_asfifo_regasync_full_167,
      I1 => ts_data_asfifo_write_nextgray(1),
      I2 => ts_data_asfifo_read_lastgray(1),
      I3 => ts_data_asfifo_write_addrgray(1),
      O => ts_data_asfifo_fcomp(1)
    );
  ts_data_asfifo_ecomp_1_or00001 : LUT4
    generic map(
      INIT => X"E14B"
    )
    port map (
      I0 => ts_data_asfifo_regasync_empty_166,
      I1 => ts_data_asfifo_read_nextgray(1),
      I2 => ts_data_asfifo_write_addrgray(1),
      I3 => ts_data_asfifo_read_addrgray(1),
      O => ts_data_asfifo_ecomp(1)
    );
  ts_data_asfifo_fcomp_0_or00001 : LUT4
    generic map(
      INIT => X"E14B"
    )
    port map (
      I0 => ts_data_asfifo_regasync_full_167,
      I1 => ts_data_asfifo_write_nextgray(0),
      I2 => ts_data_asfifo_read_lastgray(0),
      I3 => ts_data_asfifo_write_addrgray(0),
      O => ts_data_asfifo_fcomp(0)
    );
  ts_data_asfifo_ecomp_0_or00001 : LUT4
    generic map(
      INIT => X"E14B"
    )
    port map (
      I0 => ts_data_asfifo_regasync_empty_166,
      I1 => ts_data_asfifo_read_nextgray(0),
      I2 => ts_data_asfifo_write_addrgray(0),
      I3 => ts_data_asfifo_read_addrgray(0),
      O => ts_data_asfifo_ecomp(0)
    );
  ts_data_asfifo_write_allow1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IN_TS_DV,
      I1 => ts_data_asfifo_regasync_full_167,
      O => ts_data_asfifo_cnt_write_addr_u_reg_cnt_or0000
    );
  ts_data_asfifo_full_allow1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => ts_data_asfifo_regasync_full_167,
      I1 => IN_TS_DV,
      O => ts_data_asfifo_full_allow
    );
  ts_data_asfifo_read_allow1_INV_0 : INV
    port map (
      I => ts_data_asfifo_regasync_empty_166,
      O => ts_data_asfifo_cnt_read_addr_up_reg_cnt_or0000
    );

end STRUCTURE;

