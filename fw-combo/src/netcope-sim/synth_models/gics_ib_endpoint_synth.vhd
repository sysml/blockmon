--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: O.40d
--  \   \         Application: netgen
--  /   /         Filename: gics_ib_endpoint_synth.vhd
-- /___/   /\     Timestamp: Wed Mar 30 10:05:03 2011
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -ofmt vhdl -w ngc/gics_ib_endpoint_synth.ngc sim/synth_models/gics_ib_endpoint_synth.vhd 
-- Device	: xc5vlx110t-1-ff1136
-- Input file	: ngc/gics_ib_endpoint_synth.ngc
-- Output file	: sim/synth_models/gics_ib_endpoint_synth.vhd
-- # of Entities	: 1
-- Design Name	: gics_ib_endpoint_synth
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

entity gics_ib_endpoint_synth is
  port (
    CLK : in STD_LOGIC := 'X'; 
    WR_EOF : out STD_LOGIC; 
    BM_SRC_RDY_N : in STD_LOGIC := 'X'; 
    RESET : in STD_LOGIC := 'X'; 
    IB_UP_SRC_RDY_N : out STD_LOGIC; 
    IB_UP_EOF_N : out STD_LOGIC; 
    BM_SOF_N : in STD_LOGIC := 'X'; 
    RD_REQ : out STD_LOGIC; 
    IB_DOWN_EOF_N : in STD_LOGIC := 'X'; 
    BM_TAG_VLD : out STD_LOGIC; 
    RD_DST_RDY : out STD_LOGIC; 
    IB_DOWN_DST_RDY_N : out STD_LOGIC; 
    IB_UP_SOF_N : out STD_LOGIC; 
    WR_REQ : out STD_LOGIC; 
    WR_RDY : in STD_LOGIC := 'X'; 
    RD_SRC_RDY : in STD_LOGIC := 'X'; 
    RD_SOF : out STD_LOGIC; 
    IB_DOWN_SOF_N : in STD_LOGIC := 'X'; 
    RD_ARDY_ACCEPT : in STD_LOGIC := 'X'; 
    BM_DST_RDY_N : out STD_LOGIC; 
    RD_EOF : out STD_LOGIC; 
    IB_DOWN_SRC_RDY_N : in STD_LOGIC := 'X'; 
    IB_UP_DST_RDY_N : in STD_LOGIC := 'X'; 
    BM_EOF_N : in STD_LOGIC := 'X'; 
    WR_SOF : out STD_LOGIC; 
    IB_UP_DATA : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    WR_LENGTH : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
    WR_BE : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    RD_LENGTH : out STD_LOGIC_VECTOR ( 11 downto 0 ); 
    RD_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
    BM_TAG : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    WR_DATA : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    WR_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 ); 
    RD_BE : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    RD_DATA : in STD_LOGIC_VECTOR ( 63 downto 0 ); 
    IB_DOWN_DATA : in STD_LOGIC_VECTOR ( 63 downto 0 ); 
    BM_DATA : in STD_LOGIC_VECTOR ( 63 downto 0 ) 
  );
end gics_ib_endpoint_synth;

architecture STRUCTURE of gics_ib_endpoint_synth is
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N111 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N14 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241_SW0_FRB_87 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_eq : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB0_90 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_91 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_rstpot_92 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB2_93 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB3_94 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16224_98 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_99 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB0_101 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB1_102 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB3_103 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB4_104 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB5_105 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB6_106 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB7_107 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_not0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_110 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_not0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_rstpot_113 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_117 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_118 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_119 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_120 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_121 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB5_122 : STD_LOGIC;
 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1_126 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1_128 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1_130 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1_132 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1_134 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1_136 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1_138 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1_140 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1_142 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1_144 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0_145 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_1_146 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1_148 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1_150 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1_152 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1_154 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1_156 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1_158 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1_160 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1_162 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1_164 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1_166 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0_167 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_1_168 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1_170 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1_172 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_0_173 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_1_174 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_0_175 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_1_176 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_0_177 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_1_178 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_0_179 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_1_180 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_0_181 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_1_182 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_0_183 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_1_184 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_0_185 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_1_186 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_0_187 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_1_188 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0_189 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_1_190 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_0_191 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_1_192 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_0_193 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_1_194 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_0_195 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_1_196 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_0_197 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_1_198 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_0_199 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_1_200 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_0_201 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_1_202 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_0_203 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_1_204 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_0_205 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_1_206 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_0_207 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_1_208 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_0_209 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_1_210 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1_212 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_0_213 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_1_214 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_0_215 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_1_216 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_0_217 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_1_218 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_0_219 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_1_220 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_0_221 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_1_222 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_0_223 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_1_224 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_0_225 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_1_226 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_0_227 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_1_228 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_0_229 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_1_230 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_0_231 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_1_232 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1_234 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_0_235 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_1_236 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_0_237 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_1_238 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_0_239 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_1_240 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_0_241 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_1_242 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_0_243 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_1_244 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1_248 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1_250 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1_252 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1_254 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_last : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_start : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_not0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_269 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_rstpot_270 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_rstpot_271 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2_272 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_rstpot_274 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB4_275 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_rstpot_277 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB7_278 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB8_279 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB9_280 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB11_283 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_rstpot_285 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_rstpot_288 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addrpart_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_316 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_318 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB4_324 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB2_328 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB3_329 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB4_330 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB2_332 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB3_333 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB4_334 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB2_336 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB3_337 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB4_338 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB2_340 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB3_341 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB4_342 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB2_344 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB3_345 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB4_346 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB2_348 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB3_349 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB4_350 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB2_352 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB3_353 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB4_354 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB2_356 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB3_357 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB4_358 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB2_360 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB3_361 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB4_362 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB2_364 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB3_365 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB4_366 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_1_BRB2_367 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB2_370 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB3_371 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB4_372 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB2_374 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB3_375 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB4_376 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB2_378 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB3_379 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB4_380 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB2_382 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB3_383 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB4_384 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB2_386 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB3_387 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB4_388 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB2_390 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB3_391 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB4_392 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB2_394 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB3_395 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB4_396 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB2_398 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB3_399 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB4_400 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB2_402 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB3_403 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB4_404 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB2_406 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB3_407 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB4_408 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_2_BRB4_409 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB2_412 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB3_413 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB4_414 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB2_416 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB3_417 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB4_418 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_3_BRB4_427 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB2_440 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB3_441 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB4_442 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB2_454 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB3_455 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB4_456 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB2_462 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB3_463 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB4_464 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB2_466 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB3_467 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB4_468 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB2_470 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB3_471 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB4_472 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB2_474 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB3_475 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB4_476 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_rstpot_479 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_and0000_inv : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_in_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_in_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_out_dst_rdy_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_fsm_rd_src_rdy_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_addr : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB0_623 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB1_624 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB2_625 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB3_626 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4_627 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB5_628 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_1_700 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data1 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data3 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data4 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data5 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data6 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data7 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data8 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data9 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_and0000 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0_FRB_745 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_N01 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cmp_empty : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In_759 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB0_767 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB1_768 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB3_769 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB4_770 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_774 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_775 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_776 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_777 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_778 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_0_779 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_1_780 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_0_781 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_1_782 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_0_783 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_1_784 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_0_785 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_1_786 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_0_787 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_1_788 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_0_789 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_1_790 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_0_791 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_1_792 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_0_793 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_1_794 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_0_795 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_1_796 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_0_797 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_1_798 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_0_799 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_1_800 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_0_801 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_1_802 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_0_803 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_1_804 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_0_805 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_1_806 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_0_807 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_1_808 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_0_809 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_1_810 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_0_811 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_1_812 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_0_813 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_1_814 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_0_815 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_1_816 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_0_817 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_1_818 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_0_819 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_1_820 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_0_821 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_1_822 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_0_823 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_1_824 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_0_825 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_1_826 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_0_827 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_1_828 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_0_829 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_1_830 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_0_831 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_1_832 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_0_833 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_1_834 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_0_835 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_1_836 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_0_837 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_1_838 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_0_839 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_1_840 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_0_841 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_1_842 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_0_843 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_1_844 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_0_845 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_1_846 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_0_847 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_1_848 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_0_849 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_1_850 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_0_851 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_1_852 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_0_853 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_1_854 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_0_855 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_1_856 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_0_857 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_1_858 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_0_859 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_1_860 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_0_861 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_1_862 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_0_863 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_1_864 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_0_865 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_1_866 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_0_867 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_1_868 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_0_869 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_1_870 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_0_871 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_1_872 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_0_873 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_1_874 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_0_875 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_1_876 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_0_877 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_1_878 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_0_879 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_1_880 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_0_881 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_1_882 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_0_883 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_1_884 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_0_885 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_1_886 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_0_887 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_1_888 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_0_889 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_1_890 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_0_891 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_1_892 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_0_893 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_1_894 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_0_895 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_1_896 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_0_897 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_1_898 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_0_899 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_1_900 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_0_901 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_1_902 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_0_903 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_1_904 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_0_905 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_1_906 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_0_907 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_1_908 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_0_909 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_1_910 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1C : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1R : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_rt_922 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_rt_924 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_rt_928 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_rt_930 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_rt_932 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_rt_934 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_rt_936 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_rt_938 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_0_Q_939 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_2_Q_940 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_3_Q_941 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_rt_944 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_rt_946 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_rt_948 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_rt_950 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_rt_952 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_rt_954 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_rt_956 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_rt_958 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_rt_960 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_rt_962 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_rt_964 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_rt_966 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_rt_968 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_rt_970 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_rt_972 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_rt_974 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_rt_976 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_rt_978 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_rt_980 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_rt_982 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_rt_984 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_rt_986 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_rt_988 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_rt_990 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_rt_992 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_rt_994 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_rt_996 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count1 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count2 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count3 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count4 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count5 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count6 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count7 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count8 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count9 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000035_1038 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000071_1039 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB2_1042 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB3_1043 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB4_1044 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB2_1045 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB3_1046 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB4_1047 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB2_1048 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB3_1049 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB4_1050 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB2_1051 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB3_1052 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB4_1053 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB2_1054 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB3_1055 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB4_1056 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB2_1057 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB3_1058 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB4_1059 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB2_1060 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB3_1061 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB4_1062 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB2_1063 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB3_1064 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB4_1065 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB2_1066 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB3_1067 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB4_1068 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB2_1069 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB3_1070 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB4_1071 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB2_1073 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB3_1074 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB4_1075 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB2_1076 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB3_1077 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB4_1078 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB2_1079 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB3_1080 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB4_1081 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB2_1082 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB3_1083 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB4_1084 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB2_1085 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB3_1086 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB4_1087 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB2_1088 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB3_1089 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB4_1090 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB2_1091 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB3_1092 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB4_1093 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB2_1094 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB3_1095 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB4_1096 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB2_1097 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB3_1098 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB4_1099 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB2_1100 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB3_1101 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB4_1102 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB2_1103 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB3_1104 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB4_1105 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB2_1137 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB3_1138 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB4_1139 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_rstpot_1140 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB2_1141 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB3_1142 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB4_1143 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB2_1145 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB3_1146 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB4_1147 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB2_1148 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB3_1149 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB4_1150 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB2_1151 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB3_1152 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB4_1153 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB2_1154 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB3_1155 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB4_1156 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB2_1157 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB3_1158 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB4_1159 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB2_1160 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB3_1161 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB4_1162 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_and0000 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_reg_full_1196 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_addr_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_done_flag_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_hbuf_full : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_header_last : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_re : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB0_1278 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB1_1279 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB5_1283 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_rt_1286 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_rt_1288 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_rt_1290 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_rt_1292 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_rt_1294 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_rt_1296 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_rt_1298 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_rt_1300 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_rt_1302 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_rt_1304 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_rt_1306 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_rt_1308 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_rt_1310 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_rt_1312 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_rt_1314 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_rt_1316 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_rt_1318 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_rt_1320 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_rt_1322 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_rt_1324 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_rt_1326 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_rt_1328 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_rt_1330 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_rt_1332 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_rt_1334 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_rt_1336 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_rt_1338 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB2_1343 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB4_1344 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB5_1345 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB2_1346 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB5_1347 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB6_1348 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB2_1349 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB5_1350 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB6_1351 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB2_1352 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB5_1353 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB6_1354 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB2_1355 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB5_1356 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB6_1357 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB2_1358 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB5_1359 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB6_1360 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB2_1361 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB5_1362 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB6_1363 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB2_1364 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB5_1365 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB6_1366 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB1_1367 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB2_1368 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB5_1369 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB1_1370 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB2_1371 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB5_1372 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB1_1374 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB2_1375 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB5_1376 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB1_1377 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB2_1378 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB5_1379 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB1_1380 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB2_1381 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB5_1382 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB1_1383 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB2_1384 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB5_1385 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB1_1386 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB2_1387 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB5_1388 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB1_1389 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB2_1390 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB5_1391 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB1_1392 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB2_1393 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB5_1394 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB1_1395 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB2_1396 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB5_1397 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB1_1398 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB2_1399 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB5_1400 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB1_1401 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB2_1402 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB5_1405 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB1_1406 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB2_1407 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB5_1408 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB1_1438 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB2_1439 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB5_1440 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_rstpot_1441 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB2_1442 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB4_1443 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB5_1444 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB2_1445 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB4_1446 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB5_1447 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB2_1448 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB4_1449 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB5_1450 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB2_1451 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB4_1452 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB5_1453 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB2_1454 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB4_1455 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB5_1456 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB2_1457 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB4_1458 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB5_1459 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB2_1460 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB4_1461 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB5_1462 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_10_1463 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_11_1464 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_12_1465 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_13_1466 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_14_1467 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_15_1468 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5 : STD_LOGIC; 
  signal NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_6 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_7_1472 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_8_1473 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_9_1474 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477 : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_In : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_write_ctrl_addr_we : STD_LOGIC; 
  signal IB_ENDPOINT_I_cpl_pipe_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_cpl_pipe_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_downrd_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_downrd_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_rd_pipe_dst_rdy_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_rd_pipe_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_rd_pipe_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_wr_dst_rdy_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_wr_eof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_wr_sof_n : STD_LOGIC; 
  signal IB_ENDPOINT_I_wr_src_rdy_n : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal N101 : STD_LOGIC; 
  signal N103 : STD_LOGIC; 
  signal N11 : STD_LOGIC; 
  signal N115 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N13 : STD_LOGIC; 
  signal N138 : STD_LOGIC; 
  signal N139 : STD_LOGIC; 
  signal N140 : STD_LOGIC; 
  signal N142 : STD_LOGIC; 
  signal N143 : STD_LOGIC; 
  signal N148 : STD_LOGIC; 
  signal N150 : STD_LOGIC; 
  signal N156 : STD_LOGIC; 
  signal N163 : STD_LOGIC; 
  signal N173 : STD_LOGIC; 
  signal N19 : STD_LOGIC; 
  signal N195 : STD_LOGIC; 
  signal N207 : STD_LOGIC; 
  signal N209 : STD_LOGIC; 
  signal N21 : STD_LOGIC; 
  signal N211 : STD_LOGIC; 
  signal N212 : STD_LOGIC; 
  signal N214 : STD_LOGIC; 
  signal N215 : STD_LOGIC; 
  signal N217 : STD_LOGIC; 
  signal N218 : STD_LOGIC; 
  signal N220 : STD_LOGIC; 
  signal N23 : STD_LOGIC; 
  signal N25 : STD_LOGIC; 
  signal N27 : STD_LOGIC; 
  signal N36 : STD_LOGIC; 
  signal N38 : STD_LOGIC; 
  signal N395 : STD_LOGIC; 
  signal N40 : STD_LOGIC; 
  signal N42 : STD_LOGIC; 
  signal N46 : STD_LOGIC; 
  signal N48 : STD_LOGIC; 
  signal N5 : STD_LOGIC; 
  signal N506 : STD_LOGIC; 
  signal N57 : STD_LOGIC; 
  signal N59 : STD_LOGIC; 
  signal N61 : STD_LOGIC; 
  signal N610 : STD_LOGIC; 
  signal N618 : STD_LOGIC; 
  signal N626 : STD_LOGIC; 
  signal N634 : STD_LOGIC; 
  signal N642 : STD_LOGIC; 
  signal N645 : STD_LOGIC; 
  signal N65 : STD_LOGIC; 
  signal N66 : STD_LOGIC; 
  signal N7 : STD_LOGIC; 
  signal N73 : STD_LOGIC; 
  signal N77 : STD_LOGIC; 
  signal N789 : STD_LOGIC; 
  signal N79 : STD_LOGIC; 
  signal N790 : STD_LOGIC; 
  signal N791 : STD_LOGIC; 
  signal N792 : STD_LOGIC; 
  signal N793 : STD_LOGIC; 
  signal N794 : STD_LOGIC; 
  signal N795 : STD_LOGIC; 
  signal N797 : STD_LOGIC; 
  signal N799 : STD_LOGIC; 
  signal N8 : STD_LOGIC; 
  signal N801 : STD_LOGIC; 
  signal N803 : STD_LOGIC; 
  signal N804 : STD_LOGIC; 
  signal N81 : STD_LOGIC; 
  signal N83 : STD_LOGIC; 
  signal N87 : STD_LOGIC; 
  signal N9 : STD_LOGIC; 
  signal N95 : STD_LOGIC; 
  signal NlwRenamedSig_OI_RD_EOF : STD_LOGIC; 
  signal NlwRenamedSig_OI_RD_SOF : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_0_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_10_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_11_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_12_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_13_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_14_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_15_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_16_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_17_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_18_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_19_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_20_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_21_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_22_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_23_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_24_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_25_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_26_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_27_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_28_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_29_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_3_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_30_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_31_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_4_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_5_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_6_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_7_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_8_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_ADDR_9_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_0_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_10_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_11_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_12_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_13_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_14_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_15_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_32_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_33_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_34_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_35_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_36_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_37_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_38_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_39_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_4_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_40_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_41_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_42_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_43_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_44_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_45_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_46_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_47_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_48_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_49_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_5_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_50_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_51_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_52_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_53_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_54_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_55_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_56_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_57_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_58_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_59_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_6_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_60_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_61_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_62_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_63_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_7_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_8_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_DATA_9_Q : STD_LOGIC; 
  signal NlwRenamedSig_OI_WR_EOF : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_10_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_1_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_0_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_2_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_11_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_3_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_12_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_4_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_13_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_5_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_14_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_6_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_15_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_20_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_7_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_16_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_17_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_22_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_21_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_8_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_9_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_18_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_23_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_24_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_19_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_30_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_25_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_31_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_26_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_32_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_27_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_33_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_28_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_40_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_35_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_34_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_29_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_41_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_36_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_42_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_37_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_43_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_38_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_44_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_39_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_50_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_45_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_51_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_46_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_52_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_47_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_53_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_48_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_54_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_49_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_60_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_55_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_61_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_56_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_62_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_57_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_63_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_58_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_59_0_Q15_UNCONNECTED : STD_LOGIC; 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_type_lg_we_regsh_do : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr : STD_LOGIC_VECTOR ( 15 downto 4 ); 
  signal IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux : STD_LOGIC_VECTOR ( 65 downto 64 ); 
  signal IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal IB_ENDPOINT_I_U_down_buf_addr_dec_in_data : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_dout : STD_LOGIC_VECTOR ( 65 downto 0 ); 
  signal IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout : STD_LOGIC_VECTOR ( 65 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux : STD_LOGIC_VECTOR ( 6 downto 6 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_last_align : STD_LOGIC_VECTOR ( 2 downto 2 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy : STD_LOGIC_VECTOR ( 27 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1 : STD_LOGIC_VECTOR ( 12 downto 3 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64 : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000 : STD_LOGIC_VECTOR ( 28 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal IB_ENDPOINT_I_U_read_ctrl_align_in_data : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_out_data_aux : STD_LOGIC_VECTOR ( 65 downto 64 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align : STD_LOGIC_VECTOR ( 2 downto 2 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy : STD_LOGIC_VECTOR ( 27 downto 0 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32 : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000 : STD_LOGIC_VECTOR ( 28 downto 0 ); 
  signal IB_ENDPOINT_I_cpl_data : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal IB_ENDPOINT_I_downrd_data : STD_LOGIC_VECTOR ( 63 downto 32 ); 
  signal NlwRenamedSig_OI_RD_ADDR : STD_LOGIC_VECTOR ( 31 downto 3 ); 
begin
  WR_EOF <= NlwRenamedSig_OI_WR_EOF;
  RD_REQ <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2;
  BM_TAG_VLD <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  IB_DOWN_DST_RDY_N <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2;
  RD_SOF <= NlwRenamedSig_OI_RD_SOF;
  BM_DST_RDY_N <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  RD_EOF <= NlwRenamedSig_OI_RD_EOF;
  WR_LENGTH(11) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_15_1468;
  WR_LENGTH(10) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_14_1467;
  WR_LENGTH(9) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_13_1466;
  WR_LENGTH(8) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_12_1465;
  WR_LENGTH(7) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_11_1464;
  WR_LENGTH(6) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_10_1463;
  WR_LENGTH(5) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_9_1474;
  WR_LENGTH(4) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_8_1473;
  WR_LENGTH(3) <= IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_7_1472;
  WR_LENGTH(2) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_6;
  WR_LENGTH(1) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5;
  WR_LENGTH(0) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4;
  RD_LENGTH(11) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15;
  RD_LENGTH(10) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14;
  RD_LENGTH(9) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13;
  RD_LENGTH(8) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12;
  RD_LENGTH(7) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11;
  RD_LENGTH(6) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10;
  RD_LENGTH(5) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9;
  RD_LENGTH(4) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8;
  RD_LENGTH(3) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7;
  RD_LENGTH(2) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6;
  RD_LENGTH(1) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5;
  RD_LENGTH(0) <= NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4;
  RD_ADDR(31) <= NlwRenamedSig_OI_RD_ADDR(31);
  RD_ADDR(30) <= NlwRenamedSig_OI_RD_ADDR(30);
  RD_ADDR(29) <= NlwRenamedSig_OI_RD_ADDR(29);
  RD_ADDR(28) <= NlwRenamedSig_OI_RD_ADDR(28);
  RD_ADDR(27) <= NlwRenamedSig_OI_RD_ADDR(27);
  RD_ADDR(26) <= NlwRenamedSig_OI_RD_ADDR(26);
  RD_ADDR(25) <= NlwRenamedSig_OI_RD_ADDR(25);
  RD_ADDR(24) <= NlwRenamedSig_OI_RD_ADDR(24);
  RD_ADDR(23) <= NlwRenamedSig_OI_RD_ADDR(23);
  RD_ADDR(22) <= NlwRenamedSig_OI_RD_ADDR(22);
  RD_ADDR(21) <= NlwRenamedSig_OI_RD_ADDR(21);
  RD_ADDR(20) <= NlwRenamedSig_OI_RD_ADDR(20);
  RD_ADDR(19) <= NlwRenamedSig_OI_RD_ADDR(19);
  RD_ADDR(18) <= NlwRenamedSig_OI_RD_ADDR(18);
  RD_ADDR(17) <= NlwRenamedSig_OI_RD_ADDR(17);
  RD_ADDR(16) <= NlwRenamedSig_OI_RD_ADDR(16);
  RD_ADDR(15) <= NlwRenamedSig_OI_RD_ADDR(15);
  RD_ADDR(14) <= NlwRenamedSig_OI_RD_ADDR(14);
  RD_ADDR(13) <= NlwRenamedSig_OI_RD_ADDR(13);
  RD_ADDR(12) <= NlwRenamedSig_OI_RD_ADDR(12);
  RD_ADDR(11) <= NlwRenamedSig_OI_RD_ADDR(11);
  RD_ADDR(10) <= NlwRenamedSig_OI_RD_ADDR(10);
  RD_ADDR(9) <= NlwRenamedSig_OI_RD_ADDR(9);
  RD_ADDR(8) <= NlwRenamedSig_OI_RD_ADDR(8);
  RD_ADDR(7) <= NlwRenamedSig_OI_RD_ADDR(7);
  RD_ADDR(6) <= NlwRenamedSig_OI_RD_ADDR(6);
  RD_ADDR(5) <= NlwRenamedSig_OI_RD_ADDR(5);
  RD_ADDR(4) <= NlwRenamedSig_OI_RD_ADDR(4);
  RD_ADDR(3) <= NlwRenamedSig_OI_RD_ADDR(3);
  RD_ADDR(2) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  RD_ADDR(1) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  RD_ADDR(0) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(7) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(6) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(5) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(4) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(3) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(2) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(1) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  BM_TAG(0) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  WR_DATA(63) <= NlwRenamedSig_OI_WR_DATA_63_Q;
  WR_DATA(62) <= NlwRenamedSig_OI_WR_DATA_62_Q;
  WR_DATA(61) <= NlwRenamedSig_OI_WR_DATA_61_Q;
  WR_DATA(60) <= NlwRenamedSig_OI_WR_DATA_60_Q;
  WR_DATA(59) <= NlwRenamedSig_OI_WR_DATA_59_Q;
  WR_DATA(58) <= NlwRenamedSig_OI_WR_DATA_58_Q;
  WR_DATA(57) <= NlwRenamedSig_OI_WR_DATA_57_Q;
  WR_DATA(56) <= NlwRenamedSig_OI_WR_DATA_56_Q;
  WR_DATA(55) <= NlwRenamedSig_OI_WR_DATA_55_Q;
  WR_DATA(54) <= NlwRenamedSig_OI_WR_DATA_54_Q;
  WR_DATA(53) <= NlwRenamedSig_OI_WR_DATA_53_Q;
  WR_DATA(52) <= NlwRenamedSig_OI_WR_DATA_52_Q;
  WR_DATA(51) <= NlwRenamedSig_OI_WR_DATA_51_Q;
  WR_DATA(50) <= NlwRenamedSig_OI_WR_DATA_50_Q;
  WR_DATA(49) <= NlwRenamedSig_OI_WR_DATA_49_Q;
  WR_DATA(48) <= NlwRenamedSig_OI_WR_DATA_48_Q;
  WR_DATA(47) <= NlwRenamedSig_OI_WR_DATA_47_Q;
  WR_DATA(46) <= NlwRenamedSig_OI_WR_DATA_46_Q;
  WR_DATA(45) <= NlwRenamedSig_OI_WR_DATA_45_Q;
  WR_DATA(44) <= NlwRenamedSig_OI_WR_DATA_44_Q;
  WR_DATA(43) <= NlwRenamedSig_OI_WR_DATA_43_Q;
  WR_DATA(42) <= NlwRenamedSig_OI_WR_DATA_42_Q;
  WR_DATA(41) <= NlwRenamedSig_OI_WR_DATA_41_Q;
  WR_DATA(40) <= NlwRenamedSig_OI_WR_DATA_40_Q;
  WR_DATA(39) <= NlwRenamedSig_OI_WR_DATA_39_Q;
  WR_DATA(38) <= NlwRenamedSig_OI_WR_DATA_38_Q;
  WR_DATA(37) <= NlwRenamedSig_OI_WR_DATA_37_Q;
  WR_DATA(36) <= NlwRenamedSig_OI_WR_DATA_36_Q;
  WR_DATA(35) <= NlwRenamedSig_OI_WR_DATA_35_Q;
  WR_DATA(34) <= NlwRenamedSig_OI_WR_DATA_34_Q;
  WR_DATA(33) <= NlwRenamedSig_OI_WR_DATA_33_Q;
  WR_DATA(32) <= NlwRenamedSig_OI_WR_DATA_32_Q;
  WR_DATA(15) <= NlwRenamedSig_OI_WR_DATA_15_Q;
  WR_DATA(14) <= NlwRenamedSig_OI_WR_DATA_14_Q;
  WR_DATA(13) <= NlwRenamedSig_OI_WR_DATA_13_Q;
  WR_DATA(12) <= NlwRenamedSig_OI_WR_DATA_12_Q;
  WR_DATA(11) <= NlwRenamedSig_OI_WR_DATA_11_Q;
  WR_DATA(10) <= NlwRenamedSig_OI_WR_DATA_10_Q;
  WR_DATA(9) <= NlwRenamedSig_OI_WR_DATA_9_Q;
  WR_DATA(8) <= NlwRenamedSig_OI_WR_DATA_8_Q;
  WR_DATA(7) <= NlwRenamedSig_OI_WR_DATA_7_Q;
  WR_DATA(6) <= NlwRenamedSig_OI_WR_DATA_6_Q;
  WR_DATA(5) <= NlwRenamedSig_OI_WR_DATA_5_Q;
  WR_DATA(4) <= NlwRenamedSig_OI_WR_DATA_4_Q;
  WR_DATA(0) <= NlwRenamedSig_OI_WR_DATA_0_Q;
  WR_ADDR(31) <= NlwRenamedSig_OI_WR_ADDR_31_Q;
  WR_ADDR(30) <= NlwRenamedSig_OI_WR_ADDR_30_Q;
  WR_ADDR(29) <= NlwRenamedSig_OI_WR_ADDR_29_Q;
  WR_ADDR(28) <= NlwRenamedSig_OI_WR_ADDR_28_Q;
  WR_ADDR(27) <= NlwRenamedSig_OI_WR_ADDR_27_Q;
  WR_ADDR(26) <= NlwRenamedSig_OI_WR_ADDR_26_Q;
  WR_ADDR(25) <= NlwRenamedSig_OI_WR_ADDR_25_Q;
  WR_ADDR(24) <= NlwRenamedSig_OI_WR_ADDR_24_Q;
  WR_ADDR(23) <= NlwRenamedSig_OI_WR_ADDR_23_Q;
  WR_ADDR(22) <= NlwRenamedSig_OI_WR_ADDR_22_Q;
  WR_ADDR(21) <= NlwRenamedSig_OI_WR_ADDR_21_Q;
  WR_ADDR(20) <= NlwRenamedSig_OI_WR_ADDR_20_Q;
  WR_ADDR(19) <= NlwRenamedSig_OI_WR_ADDR_19_Q;
  WR_ADDR(18) <= NlwRenamedSig_OI_WR_ADDR_18_Q;
  WR_ADDR(17) <= NlwRenamedSig_OI_WR_ADDR_17_Q;
  WR_ADDR(16) <= NlwRenamedSig_OI_WR_ADDR_16_Q;
  WR_ADDR(15) <= NlwRenamedSig_OI_WR_ADDR_15_Q;
  WR_ADDR(14) <= NlwRenamedSig_OI_WR_ADDR_14_Q;
  WR_ADDR(13) <= NlwRenamedSig_OI_WR_ADDR_13_Q;
  WR_ADDR(12) <= NlwRenamedSig_OI_WR_ADDR_12_Q;
  WR_ADDR(11) <= NlwRenamedSig_OI_WR_ADDR_11_Q;
  WR_ADDR(10) <= NlwRenamedSig_OI_WR_ADDR_10_Q;
  WR_ADDR(9) <= NlwRenamedSig_OI_WR_ADDR_9_Q;
  WR_ADDR(8) <= NlwRenamedSig_OI_WR_ADDR_8_Q;
  WR_ADDR(7) <= NlwRenamedSig_OI_WR_ADDR_7_Q;
  WR_ADDR(6) <= NlwRenamedSig_OI_WR_ADDR_6_Q;
  WR_ADDR(5) <= NlwRenamedSig_OI_WR_ADDR_5_Q;
  WR_ADDR(4) <= NlwRenamedSig_OI_WR_ADDR_4_Q;
  WR_ADDR(3) <= NlwRenamedSig_OI_WR_ADDR_3_Q;
  WR_ADDR(2) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  WR_ADDR(1) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  WR_ADDR(0) <= NlwRenamedSig_OI_WR_ADDR_0_Q;
  XST_GND : GND
    port map (
      G => NlwRenamedSig_OI_WR_ADDR_0_Q
    );
  XST_VCC : VCC
    port map (
      P => N1
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_28_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(27),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_rstpot_1441,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(28)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_27_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(26),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_rt_1324,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(27)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(26),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_rt_1324,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(27)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_26_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(25),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_rt_1322,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(26)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(25),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_rt_1322,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(26)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_25_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(24),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_rt_1320,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(25)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(24),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_rt_1320,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(25)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_24_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(23),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_rt_1318,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(24)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(23),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_rt_1318,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(24)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_23_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(22),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_rt_1316,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(23)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(22),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_rt_1316,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(23)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_22_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(21),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_rt_1314,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(22)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(21),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_rt_1314,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(22)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_21_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(20),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_rt_1312,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(21)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(20),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_rt_1312,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(21)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_20_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(19),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_rt_1310,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(20)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(19),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_rt_1310,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(20)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_19_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(18),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_rt_1306,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(19)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(18),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_rt_1306,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(19)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_18_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(17),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_rt_1304,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(18)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(17),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_rt_1304,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(18)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_17_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(16),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_rt_1302,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(17)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(16),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_rt_1302,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(17)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_16_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(15),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_rt_1300,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(16)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(15),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_rt_1300,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(16)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_15_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(14),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_rt_1298,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(15)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(14),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_rt_1298,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(15)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_14_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(13),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_rt_1296,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(14)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(13),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_rt_1296,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(14)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_13_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(12),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_rt_1294,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(13)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(12),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_rt_1294,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(13)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_12_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(11),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_rt_1292,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(12)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(11),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_rt_1292,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(12)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_11_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(10),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_rt_1290,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(11)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(10),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_rt_1290,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(11)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_10_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(9),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_rt_1288,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(10)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(9),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_rt_1288,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(10)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_9_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(8),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_rt_1338,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(9)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(8),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_rt_1338,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(9)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_8_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(7),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_rt_1336,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(8)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(7),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_rt_1336,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(8)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_7_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(6),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_rt_1334,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(7)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(6),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_rt_1334,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(7)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_6_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(5),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_rt_1332,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(6)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(5),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_rt_1332,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(6)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_5_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(4),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_rt_1330,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(5)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(4),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_rt_1330,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(5)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_4_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(3),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_rt_1328,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(4)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(3),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_rt_1328,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(4)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_3_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(2),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_rt_1326,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(3)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(2),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_rt_1326,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(3)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_2_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(1),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_rt_1308,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(1),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_rt_1308,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_1_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(0),
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_rt_1286,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(1)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(0),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_rt_1286,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(1)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_xor_0_Q : XORCY
    port map (
      CI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      LI => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_lut(0),
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(0)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_0_Q : MUXCY
    port map (
      CI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      DI => N1,
      S => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_lut(0),
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy(0)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_15 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_15_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_15_1468
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_14 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_14_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_14_1467
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_13 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_13_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_13_1466
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_12 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_12_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_12_1465
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_11 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_11_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_11_1464
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_10 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_10_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_10_1463
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_9_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_9_1474
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_8_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_8_1473
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_7_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_7_1472
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_6_Q,
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_6
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_5_Q,
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_4_Q,
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_34_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_32_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_write_ctrl_addr_we,
      D => NlwRenamedSig_OI_WR_DATA_33_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2 : FDS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_In,
      S => RESET,
      Q => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_0_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(0),
      Q => IB_UP_DATA(0)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_1_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(1),
      Q => IB_UP_DATA(1)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_2_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(2),
      Q => IB_UP_DATA(2)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_3_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(3),
      Q => IB_UP_DATA(3)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_4_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(4),
      Q => IB_UP_DATA(4)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_5_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(5),
      Q => IB_UP_DATA(5)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_6_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(6),
      Q => IB_UP_DATA(6)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_7_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(7),
      Q => IB_UP_DATA(7)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_8_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(8),
      Q => IB_UP_DATA(8)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_9_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(9),
      Q => IB_UP_DATA(9)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_10_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(10),
      Q => IB_UP_DATA(10)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_11_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(11),
      Q => IB_UP_DATA(11)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_12_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(12),
      Q => IB_UP_DATA(12)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_13_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(13),
      Q => IB_UP_DATA(13)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_14_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(14),
      Q => IB_UP_DATA(14)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_15_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(15),
      Q => IB_UP_DATA(15)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_16_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(16),
      Q => IB_UP_DATA(16)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_17_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(17),
      Q => IB_UP_DATA(17)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_18_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(18),
      Q => IB_UP_DATA(18)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_19_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(19),
      Q => IB_UP_DATA(19)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_20_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(20),
      Q => IB_UP_DATA(20)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_21_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(21),
      Q => IB_UP_DATA(21)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_22_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(22),
      Q => IB_UP_DATA(22)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_23_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(23),
      Q => IB_UP_DATA(23)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_24_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(24),
      Q => IB_UP_DATA(24)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_25_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(25),
      Q => IB_UP_DATA(25)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_26_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(26),
      Q => IB_UP_DATA(26)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_27_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(27),
      Q => IB_UP_DATA(27)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_28_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(28),
      Q => IB_UP_DATA(28)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_29_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(29),
      Q => IB_UP_DATA(29)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_30_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(30),
      Q => IB_UP_DATA(30)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_31_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(31),
      Q => IB_UP_DATA(31)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_32_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(32),
      Q => IB_UP_DATA(32)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_33_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(33),
      Q => IB_UP_DATA(33)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_34_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(34),
      Q => IB_UP_DATA(34)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_35_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(35),
      Q => IB_UP_DATA(35)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_36_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(36),
      Q => IB_UP_DATA(36)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_37_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(37),
      Q => IB_UP_DATA(37)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_38_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(38),
      Q => IB_UP_DATA(38)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_39_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(39),
      Q => IB_UP_DATA(39)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_40_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(40),
      Q => IB_UP_DATA(40)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_41_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(41),
      Q => IB_UP_DATA(41)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_42_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(42),
      Q => IB_UP_DATA(42)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_43_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(43),
      Q => IB_UP_DATA(43)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_44_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(44),
      Q => IB_UP_DATA(44)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_45_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(45),
      Q => IB_UP_DATA(45)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_46_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(46),
      Q => IB_UP_DATA(46)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_47_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(47),
      Q => IB_UP_DATA(47)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_48_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(48),
      Q => IB_UP_DATA(48)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_49_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(49),
      Q => IB_UP_DATA(49)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_50_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(50),
      Q => IB_UP_DATA(50)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_51_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(51),
      Q => IB_UP_DATA(51)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_52_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(52),
      Q => IB_UP_DATA(52)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_53_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(53),
      Q => IB_UP_DATA(53)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_54_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(54),
      Q => IB_UP_DATA(54)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_55_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(55),
      Q => IB_UP_DATA(55)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_56_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(56),
      Q => IB_UP_DATA(56)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_57_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(57),
      Q => IB_UP_DATA(57)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_58_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(58),
      Q => IB_UP_DATA(58)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_59_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(59),
      Q => IB_UP_DATA(59)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_60_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(60),
      Q => IB_UP_DATA(60)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_61_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(61),
      Q => IB_UP_DATA(61)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_62_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(62),
      Q => IB_UP_DATA(62)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_63_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_data(63),
      Q => IB_UP_DATA(63)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_64_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_pipe_sof_n,
      Q => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_out_data_aux(64)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_65_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_cpl_pipe_eof_n,
      Q => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_out_data_aux(65)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2 : FDS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_In,
      S => RESET,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_0_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(0),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(0)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_1_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(1),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(1)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_2_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(2),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(2)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_3_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(3),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(3)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_4_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(4),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(4)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_5_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(5),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(5)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_6_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(6),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(6)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_7_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(7),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(7)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_8_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(8),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(8)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_9_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(9),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(9)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_10_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(10),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(10)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_11_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(11),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(11)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_12_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(12),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(12)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_13_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(13),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(13)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_14_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(14),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(14)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_15_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(15),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(15)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_16_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(16),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(16)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_17_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(17),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(17)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_18_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(18),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(18)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_19_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(19),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(19)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_20_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(20),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(20)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_21_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(21),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(21)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_22_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(22),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(22)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_23_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(23),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(23)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_24_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(24),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(24)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_25_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(25),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(25)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_26_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(26),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(26)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_27_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(27),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(27)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_28_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(28),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(28)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_29_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(29),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(29)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_30_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(30),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(30)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_31_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(31),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(31)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_32_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(32),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(32)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_33_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(33),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(33)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_34_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(34),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(34)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_35_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(35),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(35)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_36_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(36),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(36)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_37_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(37),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(37)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_38_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(38),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(38)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_39_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(39),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(39)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_40_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(40),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(40)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_41_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(41),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(41)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_42_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(42),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(42)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_43_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(43),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(43)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_44_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(44),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(44)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_45_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(45),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(45)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_46_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(46),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(46)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_47_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(47),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(47)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_48_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(48),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(48)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_49_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(49),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(49)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_50_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(50),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(50)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_51_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(51),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(51)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_52_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(52),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(52)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_53_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(53),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(53)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_54_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(54),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(54)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_55_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(55),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(55)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_56_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(56),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(56)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_57_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(57),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(57)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_58_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(58),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(58)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_59_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(59),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(59)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_60_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(60),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(60)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_61_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(61),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(61)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_62_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(62),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(62)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_63_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_data(63),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(63)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_64_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_sof_n,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(64)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_65_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_ENDPOINT_I_downrd_eof_n,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(65)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_65 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(65),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(65)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_64 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(64),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(64)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_63 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(63),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(63)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_62 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(62),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(62)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_61 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(61),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(61)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_60 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(60),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(60)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_59 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(59),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(59)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_58 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(58),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(58)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_57 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(57),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(57)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_56 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(56),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(56)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_55 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(55),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(55)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_54 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(54),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(54)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_53 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(53),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(53)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_52 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(52),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(52)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_51 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(51),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(51)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_50 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(50),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(50)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_49 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(49),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(49)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_48 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(48),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(48)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_47 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(47),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(47)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_46 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(46),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(46)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_45 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(45),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(45)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_44 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(44),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(44)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_43 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(43),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(43)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_42 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(42),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(42)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_41 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(41),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(41)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_40 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(40),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(40)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_39 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(39),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(39)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_38 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(38),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(38)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_37 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(37),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(37)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_36 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(36),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(36)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_35 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(35),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(35)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_34 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(34),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(34)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_33 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(33),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(33)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_32 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(32),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(32)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_31 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(31),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(31)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_30 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(30),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(30)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_29 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(29),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(29)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_28 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(28),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(28)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_27 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(27),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(27)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_26 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(26),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(26)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_25 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(25),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(25)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_24 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(24),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(24)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_23 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(23),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(23)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_22 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(22),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(22)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_21 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(21),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(21)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_20 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(20),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(20)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_19 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(19),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(19)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_18 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(18),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(18)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_17 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(17),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(17)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_16 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(16),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(16)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_15 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(15),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(15)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_14 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(14),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(14)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_13 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(13),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(13)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_12 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(12),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(12)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_11 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(11),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(11)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_10 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(10),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(10)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(9),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(9)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(8),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(8)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(7),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(7)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(6),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(6)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(5),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(5)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(4),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(4)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(3),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(3)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(2),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(2)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(1),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_dout(0),
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(0)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1,
      R => RESET,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_In,
      PRE => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In_759,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_0 : FDCE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_1 : FDCE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_2 : FDCE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_3 : FDCE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_10_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(10),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(10),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_10_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_1_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(1),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_1_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_0_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(0),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_0_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_2_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(2),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_2_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_11_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(11),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(11),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_11_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_3_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(3),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_3_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_12_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(12),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(12),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_12_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_4_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(4),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_4_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_13_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(13),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(13),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_13_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_5_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(5),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_5_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_14_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(14),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(14),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_14_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_6_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(6),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_6_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_15_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(15),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(15),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_15_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_20_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(20),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(20),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_20_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_7_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(7),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_7_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_16_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(16),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(16),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_16_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_17_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(17),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(17),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_17_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_22_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(22),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(22),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_22_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_21_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(21),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(21),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_21_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_8_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(8),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_8_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_9_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(9),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_9_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_18_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(18),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(18),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_18_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_23_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(23),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(23),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_23_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_24_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(24),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(24),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_24_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_19_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(19),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(19),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_19_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_30_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(30),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(30),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_30_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_25_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(25),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(25),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_25_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_31_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(31),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(31),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_31_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_26_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(26),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(26),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_26_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_32_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(32),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(32),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_32_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_27_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(27),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(27),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_27_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_33_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(33),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(33),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_33_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_28_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(28),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(28),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_28_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_40_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(40),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(40),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_40_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_35_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(35),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(35),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_35_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_34_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(34),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(34),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_34_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_29_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(29),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(29),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_29_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_41_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(41),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(41),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_41_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_36_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(36),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(36),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_36_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_42_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(42),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(42),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_42_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_37_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(37),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(37),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_37_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_43_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(43),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(43),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_43_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_38_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(38),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(38),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_38_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_44_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(44),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(44),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_44_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_39_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(39),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(39),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_39_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_50_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(50),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(50),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_50_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_45_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(45),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(45),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_45_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_51_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(51),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(51),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_51_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_46_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(46),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(46),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_46_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_52_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(52),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(52),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_52_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_47_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(47),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(47),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_47_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_53_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(53),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(53),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_53_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_48_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(48),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(48),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_48_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_54_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(54),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(54),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_54_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_49_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(49),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(49),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_49_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_60_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(60),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(60),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_60_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_55_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(55),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(55),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_55_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_61_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(61),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(61),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_61_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_56_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(56),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(56),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_56_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_62_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(62),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(62),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_62_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_57_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(57),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(57),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_57_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_63_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(63),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(63),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_63_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_58_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(58),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(58),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_58_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_59_0 : SRLC16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      A1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      A2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      A3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      CE => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce,
      CLK => CLK,
      D => RD_DATA(59),
      Q => IB_ENDPOINT_I_U_read_ctrl_align_in_data(59),
      Q15 => NLW_IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Mshreg_dout_int_59_0_Q15_UNCONNECTED
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_0_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_and0000,
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_0_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_and0000,
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_1_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(0),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(1),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_1_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(0),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(1),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data1
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_2_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(1),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(2),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_2_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(1),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(2),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data2
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_3_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(2),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(3),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_3_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(2),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(3),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data3
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_4_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(3),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(4),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_4_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(3),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(4),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data4
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_5_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(4),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(5),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_5_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(4),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(5),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data5
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_6_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(5),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(6),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_6_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(5),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(6),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data6
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_7_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(6),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(7),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_7_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(6),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(7),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data7
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy_8_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(7),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(8),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_8_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(7),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(8),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data8
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_xor_9_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_cy(8),
      LI => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(9),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data9
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_0 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_1 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data1,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_2 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data2,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_3 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data3,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_4 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data4,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_5 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data5,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_6 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data6,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_7 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data7,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_8 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data8,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_9 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data9,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_reg_full : FDRSE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_re,
      D => NlwRenamedSig_OI_WR_ADDR_0_Q,
      R => RESET,
      S => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_reg_full_1196
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2_In,
      R => RESET,
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_header_last,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_header_last,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_header_last,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(4),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(5),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(6),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(7),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(8),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(9),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(10),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(11),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(12),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(13),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(14),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_done_flag_we,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(15),
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_0_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_and0000,
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_0_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_and0000,
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_1_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(0),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(1),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_1_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(0),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(1),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count1
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_2_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(1),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(2),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_2_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(1),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(2),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count2
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_3_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(2),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(3),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_3_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(2),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(3),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count3
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_4_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(3),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(4),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_4_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(3),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(4),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count4
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_5_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(4),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(5),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_5_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(4),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(5),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count5
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_6_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(5),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(6),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_6_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(5),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(6),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count6
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_7_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(6),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(7),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_7_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(6),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(7),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count7
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy_8_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(7),
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(8),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_8_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(7),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(8),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count8
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_xor_9_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_cy(8),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(9),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count9
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count1,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count2,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count3,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count4,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count5,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count6,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count7,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count8,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count9,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_0_Q : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(0),
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_0_Q_939
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_0_Q : MUXCY
    port map (
      CI => N1,
      DI => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(0),
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_0_Q_939,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_1_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(0),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1R,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_2_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(1),
      DI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1C,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_2_Q_940,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_3_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(2),
      DI => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_3_Q_941,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_3_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(2),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_3_Q_941,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(3),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_rt_928,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_4_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(3),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_rt_928,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(4),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_rt_930,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_5_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(4),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_rt_930,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(5),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_rt_932,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_6_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(5),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_rt_932,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(6),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_rt_934,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_7_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(6),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_rt_934,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(7),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_rt_936,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_8_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(7),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_rt_936,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(8),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_rt_938,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_9_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(8),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_rt_938,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(9),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_rt_922,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_10_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(9),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_rt_922,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(10),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_rt_924,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_11_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(10),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_rt_924,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_xor_12_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy(11),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(12)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_0_Q : MUXCY
    port map (
      CI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      DI => N1,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_0_Q : XORCY
    port map (
      CI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_lut(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(0),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_rt_944,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_1_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(0),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_rt_944,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(1),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_rt_966,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_2_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(1),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_rt_966,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(2),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_rt_984,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_3_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(2),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_rt_984,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(3),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_rt_986,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_4_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(3),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_rt_986,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(4),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_rt_988,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_5_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(4),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_rt_988,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(5),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_rt_990,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_6_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(5),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_rt_990,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(6),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_rt_992,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_7_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(6),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_rt_992,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(7),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_rt_994,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_8_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(7),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_rt_994,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(8),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_rt_996,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_9_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(8),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_rt_996,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(9),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_rt_946,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_10_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(9),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_rt_946,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(10),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_rt_948,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_11_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(10),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_rt_948,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(11),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_rt_950,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(12)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_12_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(11),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_rt_950,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(12)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(12),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_rt_952,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(13)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_13_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(12),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_rt_952,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(13)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(13),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_rt_954,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(14)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_14_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(13),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_rt_954,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(14)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(14),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_rt_956,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(15)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_15_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(14),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_rt_956,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(15)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(15),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_rt_958,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(16)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_16_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(15),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_rt_958,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(16)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(16),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_rt_960,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(17)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_17_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(16),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_rt_960,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(17)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(17),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_rt_962,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(18)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_18_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(17),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_rt_962,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(18)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(18),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_rt_964,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(19)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_19_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(18),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_rt_964,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(19)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(19),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_rt_968,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(20)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_20_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(19),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_rt_968,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(20)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(20),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_rt_970,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(21)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_21_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(20),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_rt_970,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(21)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(21),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_rt_972,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(22)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_22_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(21),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_rt_972,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(22)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(22),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_rt_974,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(23)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_23_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(22),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_rt_974,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(23)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(23),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_rt_976,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(24)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_24_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(23),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_rt_976,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(24)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(24),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_rt_978,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(25)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_25_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(24),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_rt_978,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(25)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(25),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_rt_980,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(26)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_26_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(25),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_rt_980,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(26)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_Q : MUXCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(26),
      DI => NlwRenamedSig_OI_WR_ADDR_0_Q,
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_rt_982,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(27)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_27_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(26),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_rt_982,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(27)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_xor_28_Q : XORCY
    port map (
      CI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy(27),
      LI => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_rstpot_1140,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(28)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_In,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_0_901,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_1_902
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_rd_pipe_sof_n,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_0_901
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_0_887,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_1_888
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(59),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_0_887
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_0_899,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_1_900
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_rd_pipe_eof_n,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_0_899
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_0_885,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_1_886
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(58),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_0_885
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_0_897,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_1_898
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(63),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_0_897
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_0_883,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_1_884
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(57),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_0_883
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_0_895,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_1_896
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(62),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_0_895
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_0_881,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_1_882
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(56),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_0_881
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_0_893,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_1_894
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(61),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_0_893
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_0_879,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_1_880
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(55),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_0_879
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_0_891,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_1_892
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(60),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_0_891
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_0_865,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_1_866
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(49),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_0_865
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_0_877,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_1_878
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(54),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_0_877
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_0_863,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_1_864
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(48),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_0_863
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_0_861,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_1_862
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(47),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_0_861
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_0_875,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_1_876
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(53),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_0_875
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_0_873,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_1_874
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(52),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_0_873
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_0_859,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_1_860
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(46),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_0_859
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_0_871,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_1_872
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(51),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_0_871
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_0_857,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_1_858
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(45),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_0_857
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_0_869,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_1_870
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(50),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_0_869
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_0_843,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_1_844
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(39),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_0_843
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_0_855,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_1_856
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(44),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_0_855
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_0_841,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_1_842
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(38),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_0_841
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_0_853,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_1_854
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(43),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_0_853
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_0_839,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_1_840
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(37),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_0_839
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_0_851,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_1_852
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(42),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_0_851
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_0_837,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_1_838
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(36),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_0_837
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_0_849,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_1_850
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(41),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_0_849
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_0_835,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_1_836
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(35),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_0_835
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_0_821,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_1_822
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(29),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_0_821
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_0_833,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_1_834
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(34),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_0_833
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_0_847,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_1_848
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(40),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_0_847
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_0_819,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_1_820
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(28),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_0_819
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_0_831,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_1_832
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(33),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_0_831
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_0_817,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_1_818
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(27),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_0_817
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_0_829,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_1_830
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(32),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_0_829
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_0_815,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_1_816
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(26),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_0_815
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_0_827,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_1_828
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(31),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_0_827
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_0_813,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_1_814
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(25),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_0_813
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_0_825,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_1_826
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(30),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_0_825
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_0_799,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_1_800
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(19),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_0_799
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_0_811,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_1_812
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(24),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_0_811
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_0_809,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_1_810
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(23),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_0_809
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_0_797,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_1_798
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(18),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_0_797
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_0_909,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_1_910
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_0_909
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_0_807,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_1_808
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(22),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_0_807
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_0_907,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_1_908
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_0_907
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_0_805,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_1_806
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(21),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_0_805
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_0_795,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_1_796
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(17),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_0_795
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_0_793,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_1_794
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(16),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_0_793
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_0_905,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_1_906
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_0_905
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_0_803,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_1_804
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(20),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_0_803
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_0_791,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_1_792
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(15),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_0_791
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_0_903,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_1_904
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_0_903
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_0_789,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_1_790
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(14),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_0_789
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_0_889,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_1_890
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_0_889
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_0_787,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_1_788
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(13),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_0_787
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_0_867,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_1_868
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_0_867
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_0_785,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_1_786
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(12),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_0_785
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_0_845,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_1_846
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_0_845
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_0_783,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_1_784
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(11),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_0_783
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_0_823,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_1_824
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_0_823
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_0_781,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_1_782
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(10),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_0_781
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_0_779,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_1_780
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_0_779
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_0_801,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_1_802
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_0_801
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addrpart_we,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_not0000,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addrpart_we,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_not0000,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_110
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(1),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0_145
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0_145,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_1_146
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(0),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(10),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1_126
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(2),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0_167
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0_167,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_1_168
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(11),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1_128
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(3),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0_189
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0_189,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_1_190
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(12),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1_130
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(4),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1_212
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(13),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1_132
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(5),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1_234
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(14),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1_134
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(6),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1_248
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(15),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1_136
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(20),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1_148
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(7),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1_250
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(16),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1_138
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(17),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1_140
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(21),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1_150
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(8),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1_252
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(22),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1_152
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(9),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1_254
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(18),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1_142
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(23),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1_154
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(24),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1_156
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(19),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1_144
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(30),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1_170
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(25),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1_158
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(31),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1_172
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(26),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1_160
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(32),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_0_173
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_0_173,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_1_174
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(27),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1_162
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(33),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_0_175
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_0_175,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_1_176
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(28),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1_164
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(40),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_0_191
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_0_191,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_1_192
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(34),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_0_177
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_0_177,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_1_178
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(29),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1_166
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(35),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_0_179
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_0_179,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_1_180
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(41),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_0_193
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_0_193,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_1_194
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(36),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_0_181
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_0_181,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_1_182
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(42),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_0_195
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_0_195,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_1_196
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(37),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_0_183
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_0_183,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_1_184
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(43),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_0_197
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_0_197,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_1_198
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(38),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_0_185
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_0_185,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_1_186
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(44),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_0_199
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_0_199,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_1_200
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(39),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_0_187
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_0_187,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_1_188
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(50),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_0_213
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_0_213,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_1_214
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(45),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_0_201
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_0_201,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_1_202
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(51),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_0_215
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_0_215,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_1_216
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(46),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_0_203
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_0_203,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_1_204
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(52),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_0_217
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_0_217,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_1_218
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(53),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_0_219
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_0_219,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_1_220
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(47),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_0_205
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_0_205,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_1_206
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(48),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_0_207
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_0_207,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_1_208
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(54),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_0_221
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_0_221,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_1_222
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(49),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_0_209
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_0_209,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_1_210
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(60),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_0_235
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_0_235,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_1_236
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(55),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_0_223
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_0_223,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_1_224
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(61),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_0_237
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_0_237,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_1_238
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(56),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_0_225
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_0_225,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_1_226
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(62),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_0_239
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_0_239,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_1_240
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(57),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_0_227
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_0_227,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_1_228
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(63),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_0_241
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_0_241,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_1_242
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(58),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_0_229
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_0_229,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_1_230
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_eof_n,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_0_243
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_0_243,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_1_244
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(59),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_0_231
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_0_231,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_1_232
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_sof_n,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_15 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(63),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(15)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_14 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(62),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(14)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_13 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(61),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(13)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_12 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(60),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(12)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_11 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(59),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(11)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_10 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(58),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(10)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_9 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(57),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(9)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_8 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(56),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(8)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_7 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(55),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(7)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_6 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(54),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(6)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(53),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(5)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(52),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(4)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(51),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(3)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(50),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(2)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(49),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(1)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr_0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(48),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(0)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_type_lg_we_SH_REG_XU_0_SH_REG_U_U_SRL16E : 
SRL16E
    generic map(
      INIT => X"0001"
    )
    port map (
      A0 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_start,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_type_lg_we_regsh_do(0),
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_type_lg_we_regsh_do(0)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_addr_start_SH_REG_XU_0_SH_REG_U_U_SRL16E : 
SRL16E
    generic map(
      INIT => X"0001"
    )
    port map (
      A0 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_start,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_U_reg_cyc_addr_last_SH_REG_XU_0_SH_REG_U_U_SRL16E : 
SRL16E
    generic map(
      INIT => X"0001"
    )
    port map (
      A0 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_last,
      CLK => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addrpart_we,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_not0000,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_65_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_EOF_N,
      Q => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux(65)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_64_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_SOF_N,
      Q => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux(64)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_63_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(63),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(63)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_62_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(62),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(62)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_61_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(61),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(61)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_60_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(60),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(60)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_59_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(59),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(59)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_58_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(58),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(58)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_57_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(57),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(57)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_56_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(56),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(56)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_55_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(55),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(55)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_54_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(54),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(54)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_53_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(53),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(53)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_52_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(52),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(52)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_51_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(51),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(51)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_50_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(50),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(50)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_49_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(49),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(49)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_48_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(48),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(48)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_47_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(47),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(47)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_46_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(46),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(46)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_45_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(45),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(45)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_44_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(44),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(44)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_43_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(43),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(43)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_42_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(42),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(42)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_41_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(41),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(41)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_40_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(40),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(40)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_39_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(39),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(39)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_38_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(38),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(38)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_37_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(37),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(37)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_36_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(36),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(36)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_35_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(35),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(35)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_34_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(34),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(34)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_33_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(33),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(33)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_32_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(32),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(32)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_31_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(31),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(31)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_30_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(30),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(30)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_29_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(29),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(29)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_28_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(28),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(28)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_27_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(27),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(27)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_26_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(26),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(26)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_25_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(25),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(25)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_24_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(24),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(24)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_23_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(23),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(23)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_22_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(22),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(22)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_21_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(21),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(21)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_20_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(20),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(20)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_19_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(19),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(19)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_18_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(18),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(18)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_17_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(17),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(17)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_16_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(16),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(16)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_15_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(15),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(15)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_14_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(14),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(14)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_13_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(13),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(13)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_12_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(12),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(12)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_11_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(11),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(11)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_10_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(10),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(10)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_9_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(9),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(9)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_8_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(8),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(8)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_7_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(7),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(7)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_6_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(6),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(6)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_5_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(5),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(5)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_4_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(4),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(4)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_3_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(3),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(3)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_2_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(2),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(2)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_1_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(1),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(1)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_NOT_FAKE_SH_REG_DATA_WIDTH_0_SH_REG_DATA_U_SRL16E : SRL16E
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr,
      A1 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A2 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      A3 => NlwRenamedSig_OI_WR_ADDR_0_Q,
      CE => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce,
      CLK => CLK,
      D => IB_DOWN_DATA(0),
      Q => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(0)
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_In,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2 : FDS
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2_In,
      S => RESET,
      Q => NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_316,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_318,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg : FDSE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_and0000_inv,
      D => IB_ENDPOINT_I_downrd_sof_n,
      S => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_32 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_32_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(32)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_33 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_33_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(33)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_34 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_34_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(34)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_35 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_35_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(35)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_36 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_36_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(36)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_37 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_37_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(37)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_38 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_38_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(38)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_39 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_39_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(39)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_40 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_40_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(40)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_41 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_41_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(41)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_42 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_42_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(42)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_43 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_43_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(43)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_44 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_44_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(44)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_45 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_45_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(45)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_46 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_46_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(46)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_47 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_47_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(47)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_48 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_48_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(48)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_49 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_49_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(49)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_50 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_50_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(50)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_51 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_51_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(51)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_52 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_52_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(52)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_53 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_53_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(53)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_54 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_54_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(54)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_55 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_55_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(55)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_56 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_56_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(56)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_57 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_57_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(57)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_58 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_58_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(58)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_59 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_59_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(59)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_60 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_60_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(60)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_61 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_61_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(61)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_62 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_62_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(62)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_63 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_63_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(63)
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_Out21 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      O => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_addr
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_IN_DST_RDY1 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      I1 => RESET,
      O => RD_DST_RDY
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_Out21 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1,
      O => IB_ENDPOINT_I_U_rd_pipe_PIPE_addr
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_Out21 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      O => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_addr
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_34_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_1_178,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_34_0_177,
      O => NlwRenamedSig_OI_WR_DATA_34_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_33_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_1_176,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_33_0_175,
      O => NlwRenamedSig_OI_WR_DATA_33_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_32_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_1_174,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_32_0_173,
      O => NlwRenamedSig_OI_WR_DATA_32_Q
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce1 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => IB_DOWN_SRC_RDY_N,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2,
      O => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_ce
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_63_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_1_242,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_63_0_241,
      O => NlwRenamedSig_OI_WR_DATA_63_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_62_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_1_240,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_62_0_239,
      O => NlwRenamedSig_OI_WR_DATA_62_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_61_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_1_238,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_61_0_237,
      O => NlwRenamedSig_OI_WR_DATA_61_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_60_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_1_236,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_60_0_235,
      O => NlwRenamedSig_OI_WR_DATA_60_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_59_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_1_232,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_59_0_231,
      O => NlwRenamedSig_OI_WR_DATA_59_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_58_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_1_230,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_58_0_229,
      O => NlwRenamedSig_OI_WR_DATA_58_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_57_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_1_228,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_57_0_227,
      O => NlwRenamedSig_OI_WR_DATA_57_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_56_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_1_226,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_56_0_225,
      O => NlwRenamedSig_OI_WR_DATA_56_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_55_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_1_224,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_55_0_223,
      O => NlwRenamedSig_OI_WR_DATA_55_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_54_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_1_222,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_54_0_221,
      O => NlwRenamedSig_OI_WR_DATA_54_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_53_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_1_220,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_53_0_219,
      O => NlwRenamedSig_OI_WR_DATA_53_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_52_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_1_218,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_52_0_217,
      O => NlwRenamedSig_OI_WR_DATA_52_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_51_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_1_216,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_51_0_215,
      O => NlwRenamedSig_OI_WR_DATA_51_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_50_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_1_214,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_50_0_213,
      O => NlwRenamedSig_OI_WR_DATA_50_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_49_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_1_210,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_49_0_209,
      O => NlwRenamedSig_OI_WR_DATA_49_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_48_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_1_208,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_48_0_207,
      O => NlwRenamedSig_OI_WR_DATA_48_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_47_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_1_206,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_47_0_205,
      O => NlwRenamedSig_OI_WR_DATA_47_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_46_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_1_204,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_46_0_203,
      O => NlwRenamedSig_OI_WR_DATA_46_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_45_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_1_202,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_45_0_201,
      O => NlwRenamedSig_OI_WR_DATA_45_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_44_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_1_200,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_44_0_199,
      O => NlwRenamedSig_OI_WR_DATA_44_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_43_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_1_198,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_43_0_197,
      O => NlwRenamedSig_OI_WR_DATA_43_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_42_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_1_196,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_42_0_195,
      O => NlwRenamedSig_OI_WR_DATA_42_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_41_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_1_194,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_41_0_193,
      O => NlwRenamedSig_OI_WR_DATA_41_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_40_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_1_192,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_40_0_191,
      O => NlwRenamedSig_OI_WR_DATA_40_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_39_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_1_188,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_39_0_187,
      O => NlwRenamedSig_OI_WR_DATA_39_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_38_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_1_186,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_38_0_185,
      O => NlwRenamedSig_OI_WR_DATA_38_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_37_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_1_184,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_37_0_183,
      O => NlwRenamedSig_OI_WR_DATA_37_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_36_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_1_182,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_36_0_181,
      O => NlwRenamedSig_OI_WR_DATA_36_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_35_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_1_180,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_35_0_179,
      O => NlwRenamedSig_OI_WR_DATA_35_Q
    );
  IB_ENDPOINT_I_U_rd_pipe_OUT_SOF_N1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(64),
      O => IB_ENDPOINT_I_rd_pipe_sof_n
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not00011 : LUT3
    generic map(
      INIT => X"75"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cmp_empty_cmp_eq00001 : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cmp_empty
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_CNT_ADDR_CE11 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      O => IB_ENDPOINT_I_U_read_ctrl_N01
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_9_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1_254,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253,
      O => NlwRenamedSig_OI_WR_DATA_9_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_8_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1_252,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251,
      O => NlwRenamedSig_OI_WR_DATA_8_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_7_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1_250,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249,
      O => NlwRenamedSig_OI_WR_DATA_7_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_6_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1_248,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247,
      O => NlwRenamedSig_OI_WR_DATA_6_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_5_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1_234,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233,
      O => NlwRenamedSig_OI_WR_DATA_5_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_4_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1_212,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211,
      O => NlwRenamedSig_OI_WR_DATA_4_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_3_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_1_190,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0_189,
      O => WR_DATA(3)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_31_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1_172,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171,
      O => WR_DATA(31)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_30_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1_170,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169,
      O => WR_DATA(30)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_2_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_1_168,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0_167,
      O => WR_DATA(2)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_29_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1_166,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165,
      O => WR_DATA(29)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_28_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1_164,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163,
      O => WR_DATA(28)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_27_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1_162,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161,
      O => WR_DATA(27)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_26_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1_160,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159,
      O => WR_DATA(26)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_25_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1_158,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157,
      O => WR_DATA(25)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_24_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1_156,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155,
      O => WR_DATA(24)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_23_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1_154,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153,
      O => WR_DATA(23)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_22_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1_152,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151,
      O => WR_DATA(22)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_21_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1_150,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149,
      O => WR_DATA(21)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_20_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1_148,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147,
      O => WR_DATA(20)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_1_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_1_146,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0_145,
      O => WR_DATA(1)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_19_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1_144,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143,
      O => WR_DATA(19)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_18_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1_142,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141,
      O => WR_DATA(18)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_17_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1_140,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139,
      O => WR_DATA(17)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_16_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1_138,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137,
      O => WR_DATA(16)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_15_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1_136,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135,
      O => NlwRenamedSig_OI_WR_DATA_15_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_14_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1_134,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133,
      O => NlwRenamedSig_OI_WR_DATA_14_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_13_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1_132,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131,
      O => NlwRenamedSig_OI_WR_DATA_13_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_12_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1_130,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129,
      O => NlwRenamedSig_OI_WR_DATA_12_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_11_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1_128,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127,
      O => NlwRenamedSig_OI_WR_DATA_11_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_10_mux00001 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1_126,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125,
      O => NlwRenamedSig_OI_WR_DATA_10_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_Out21 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_In1 : LUT4
    generic map(
      INIT => X"3A2A"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I2 => RD_ARDY_ACCEPT,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      O => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_mux00001 : LUT4
    generic map(
      INIT => X"8CDC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744,
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_RD_SOF_N1 : LUT5
    generic map(
      INIT => X"FFFFBABB"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323,
      O => N220
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_In1 : LUT5
    generic map(
      INIT => X"F0F05350"
    )
    port map (
      I0 => WR_RDY,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0,
      I4 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_In1 : LUT5
    generic map(
      INIT => X"CC44EC44"
    )
    port map (
      I0 => WR_RDY,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I3 => IB_ENDPOINT_I_wr_eof_n,
      I4 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_WR_REQ1 : LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => IB_ENDPOINT_I_wr_src_rdy_n,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      O => WR_REQ
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_Out11 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      O => NlwRenamedSig_OI_RD_SOF
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000035 : LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11,
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000035_1038
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000071 : LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000071_1039
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000072 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000035_1038,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096_cmp_eq000071_1039,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_flag4096
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_and0000_inv1 : LUT3
    generic map(
      INIT => X"1F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I2 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_and0000_inv
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv1 : LUT4
    generic map(
      INIT => X"0015"
    )
    port map (
      I0 => RESET,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I3 => IB_ENDPOINT_I_U_down_buf_fsm_rd_src_rdy_n,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv
    );
  IB_ENDPOINT_I_U_down_buf_addr_dec_in_sof_n1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux(64),
      O => IB_ENDPOINT_I_U_down_buf_addr_dec_in_sof_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"1510101055505050"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_OUT_SOF_N1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_out_data_aux(64),
      O => IB_UP_SOF_N
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_OUT_EOF_N1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_out_data_aux(65),
      O => IB_UP_EOF_N
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_OUT_EOF_N1 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      I1 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_eof_n
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_WR_SOF1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I1 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => WR_SOF
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_WR_EOF1 : LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => IB_ENDPOINT_I_wr_eof_n,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      O => NlwRenamedSig_OI_WR_EOF
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer1 : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => RESET,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I2 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_SW0 : LUT5
    generic map(
      INIT => X"ABABABAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      O => N7
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_SW1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      O => N8
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In : LUT6
    generic map(
      INIT => X"FF880588FA880088"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n,
      I1 => N8,
      I2 => NlwRenamedSig_OI_WR_DATA_0_Q,
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n,
      I4 => N9,
      I5 => N7,
      O => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_318
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_SW1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      O => N12
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_SW2 : LUT5
    generic map(
      INIT => X"ABABABAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      O => N13
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In : LUT6
    generic map(
      INIT => X"FF885088AF880088"
    )
    port map (
      I0 => IB_ENDPOINT_I_wr_dst_rdy_n,
      I1 => N12,
      I2 => NlwRenamedSig_OI_WR_DATA_0_Q,
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n,
      I4 => N11,
      I5 => N13,
      O => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_316
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1R2 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1),
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1R
    );
  IB_ENDPOINT_I_U_down_buf_addr_dec_in_eof_n1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux(65),
      O => IB_ENDPOINT_I_U_down_buf_addr_dec_in_eof_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_65_mux00001 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      O => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_64_mux00001 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_1_244,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_64_0_243,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      O => IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n
    );
  IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_IB_DST_RDY_N1 : LUT3
    generic map(
      INIT => X"54"
    )
    port map (
      I0 => WR_RDY,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      O => IB_ENDPOINT_I_wr_dst_rdy_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"AAA2AAA2AAA2AAF3"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_117,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_118,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_119,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_120,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_121,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB5_122,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"AAAAAAAEAAAA0000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_dst_rdy_n,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut_1_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      O => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut_1_1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      O => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_RD_EOF1 : LUT4
    generic map(
      INIT => X"8880"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I1 => RD_ARDY_ACCEPT,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      O => NlwRenamedSig_OI_RD_EOF
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1C1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1),
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1C
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_1_Q : LUT6
    generic map(
      INIT => X"555F555F555F1113"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_SOF,
      I1 => NlwRenamedSig_OI_RD_EOF,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I4 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I5 => N36,
      O => RD_BE(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_2_Q : LUT6
    generic map(
      INIT => X"11FF33FF010F030F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I2 => NlwRenamedSig_OI_RD_EOF,
      I3 => NlwRenamedSig_OI_RD_SOF,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I5 => N42,
      O => RD_BE(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_4_Q : LUT6
    generic map(
      INIT => X"05FFFFFF01333333"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I1 => NlwRenamedSig_OI_RD_EOF,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I4 => NlwRenamedSig_OI_RD_SOF,
      I5 => N46,
      O => RD_BE(4)
    );
  IB_ENDPOINT_I_U_rd_pipe_OUT_EOF_N1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(65),
      O => IB_ENDPOINT_I_rd_pipe_eof_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_fsm_request_vector_we1 : LUT5
    generic map(
      INIT => X"C8408800"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_IN_DST_RDY_N1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      O => IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_dout_int_0_mux00001 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      O => NlwRenamedSig_OI_WR_DATA_0_Q
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"AAAAAAAF22222223"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_774,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_775,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_776,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_777,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_778,
      I5 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4_627,
      O => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"A0A0A0A0A0A0A0E0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I2 => IB_ENDPOINT_I_U_read_ctrl_N01,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I5 => IB_ENDPOINT_I_rd_pipe_dst_rdy_n,
      O => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_SHREG_CE1 : LUT4
    generic map(
      INIT => X"00C4"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I3 => IB_ENDPOINT_I_rd_pipe_dst_rdy_n,
      O => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_ce
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_10_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(10),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(42),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(10)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_5_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(5),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(37),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(5)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_4_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(4),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(36),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(4)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_15_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(15),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(47),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(15)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_13_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(13),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(45),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(13)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000251 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(11),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(12),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(13),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(14),
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(15),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N14
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state,
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_In,
      O => N789
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_SW0 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(2),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(6),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(1),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(9),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(5),
      O => N48
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000 : LUT6
    generic map(
      INIT => X"0000000000000004"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      I5 => N48,
      O => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_9_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(9),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(41),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(9)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_6_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(6),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(38),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(6)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_14_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(14),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(46),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(14)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_8_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(8),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(40),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(8)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_12_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(12),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(44),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(12)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_7_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(7),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(39),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(7)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_U_gen_mux_DATA_OUT_11_1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(11),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(43),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(11)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux000011 : LUT6
    generic map(
      INIT => X"727272FFFF72FFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB4_275,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB7_278,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB8_279,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB9_280,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_269,
      O => N87
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16224 : LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(11),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(7),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(12),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(14),
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(13),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16224_98
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_NEXT_TRANS1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      O => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_re
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_IB_DST_RDY_N1 : LUT5
    generic map(
      INIT => X"FFFF54FC"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_rd_pipe_dst_rdy_n
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data2,
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data6,
      I2 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data1,
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data9,
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data5,
      O => N790
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000 : LUT6
    generic map(
      INIT => X"0000000000000004"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(4),
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(0),
      I2 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(3),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(8),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(7),
      I5 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0_FRB_745,
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_30_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_27_rt_1324
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_29_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_26_rt_1322
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_28_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_25_rt_1320
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_27_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_24_rt_1318
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_26_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_23_rt_1316
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_25_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_22_rt_1314
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_24_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_21_rt_1312
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_23_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_20_rt_1310
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_22_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_19_rt_1306
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_21_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_18_rt_1304
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_20_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_17_rt_1302
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_19_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_16_rt_1300
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_18_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_15_rt_1298
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_17_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_14_rt_1296
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_16_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_13_rt_1294
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_15_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_12_rt_1292
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_14_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_11_rt_1290
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_13_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_10_rt_1288
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_12_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_9_rt_1338
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_11_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_8_rt_1336
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_10_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_7_rt_1334
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_9_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_6_rt_1332
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_8_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_5_rt_1330
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_7_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_4_rt_1328
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_6_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_3_rt_1326
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_5_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_2_rt_1308
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_WR_ADDR_4_Q,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_cy_1_rt_1286
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_8,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_4_rt_928
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_9,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_5_rt_930
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_10,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_6_rt_932
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_11,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_7_rt_934
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_12,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_8_rt_936
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_13,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_9_rt_938
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_14,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_10_rt_922
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_15,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_cy_11_rt_924
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(4),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_1_rt_944
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(5),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_2_rt_966
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(6),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_3_rt_984
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(7),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_4_rt_986
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(8),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_5_rt_988
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(9),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_6_rt_990
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(10),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_7_rt_992
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(11),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_8_rt_994
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(12),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_9_rt_996
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(13),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_10_rt_946
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(14),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_11_rt_948
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(15),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_12_rt_950
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(16),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_13_rt_952
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(17),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_14_rt_954
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(18),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_15_rt_956
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(19),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_16_rt_958
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(20),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_17_rt_960
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(21),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_18_rt_962
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(22),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_19_rt_964
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(23),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_20_rt_968
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(24),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_21_rt_970
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(25),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_22_rt_972
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(26),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_23_rt_974
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(27),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_24_rt_976
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(28),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_25_rt_978
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(29),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_26_rt_980
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_ADDR(30),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_cy_27_rt_982
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_9_Q : LUT4
    generic map(
      INIT => X"4755"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(9),
      I1 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(12),
      I3 => IB_ENDPOINT_I_U_read_ctrl_header_last,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_fetch_marker_HEADER_LAST1 : LUT6
    generic map(
      INIT => X"0000000000AB0003"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_header_last
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt00002_SW0_SW0 : LUT5
    generic map(
      INIT => X"00000001"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(7),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(6),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(9),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(5),
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(4),
      O => N57
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt00002 : LUT6
    generic map(
      INIT => X"FFFFFFFFCF8ECFCF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N111,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(10),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_110,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(8),
      I4 => N57,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N14,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt0000
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq161 : LUT6
    generic map(
      INIT => X"0001000000000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(15),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(5),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(9),
      I3 => N59,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16224_98,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_99,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_eq161 : LUT5
    generic map(
      INIT => X"01000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(15),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(10),
      I2 => N61,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16224_98,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_99,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_eq
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241_SW0 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(51),
      I1 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(50),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(49),
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(48),
      O => N81
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241 : LUT6
    generic map(
      INIT => X"DDDDDDDDDDDDDDD8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241_SW0_FRB_87,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(35),
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(34),
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(33),
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(32),
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N111
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_mux00001 : LUT6
    generic map(
      INIT => X"CCA0000000000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2_272,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I5 => N87,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt00002_SW2 : LUT6
    generic map(
      INIT => X"FFD5FF55FF55FF54"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(4),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(5),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(10),
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(9),
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N111,
      O => N65
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt00002 : LUT6
    generic map(
      INIT => X"FFFFFF01FFFFFE00"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(6),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(7),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr(8),
      I3 => N66,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_N14,
      I5 => N65,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux00002 : LUT5
    generic map(
      INIT => X"D1000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I4 => N83,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_rstpot_SW0 : LUT4
    generic map(
      INIT => X"B2A2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB4_104,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB5_105,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB6_106,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB7_107,
      O => N115
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_rstpot : LUT4
    generic map(
      INIT => X"8CDC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB0_101,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB1_102,
      I2 => N115,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB3_103,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_SW1 : LUT4
    generic map(
      INIT => X"FFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(3),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(1),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(0),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(8),
      O => N73
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt00002_SW3 : LUT6
    generic map(
      INIT => X"EFFFEFFFEFFFEF0F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(9),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(10),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(42),
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(41),
      O => N66
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_rstpot : LUT4
    generic map(
      INIT => X"AAE2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB0_90,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_91,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB2_93,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB3_94,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16274_SW0 : LUT6
    generic map(
      INIT => X"BEFFBE33BEFFBECC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(4),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_110,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(10),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(36),
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(42),
      O => N59
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16274_SW1_SW0 : LUT4
    generic map(
      INIT => X"8001"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(9),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(5),
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(4),
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108,
      O => N77
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16274_SW1 : LUT6
    generic map(
      INIT => X"1D3F3F3F3F3F3F2E"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I2 => N77,
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(37),
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(41),
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(36),
      O => N61
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_SW2 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(34),
      I1 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(33),
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(32),
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(40),
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(38),
      O => N79
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271 : LUT6
    generic map(
      INIT => X"0010001000100F1F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(6),
      I1 => N73,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_ADDR_SPLITTER_YES_U_addr_splitter_reg_addr(2),
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_in_data(35),
      I5 => N79,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq16271_99
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241_SW0_FRB : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we,
      D => N81,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000241_SW0_FRB_87
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2_272
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_0_Q : LUT6
    generic map(
      INIT => X"5555555555554755"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(3),
      I3 => N95,
      I4 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_1_Q : LUT6
    generic map(
      INIT => X"5555554755555555"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(1),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(4),
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => N95,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_2_Q : LUT6
    generic map(
      INIT => X"5555554755555555"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(2),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(5),
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => N95,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_3_Q : LUT6
    generic map(
      INIT => X"5555555555554575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N95,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(6),
      I4 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW1 : LUT5
    generic map(
      INIT => X"FFFFFEFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(7),
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(4),
      I2 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(3),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(0),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      O => N101
    );
  IB_ENDPOINT_I_U_read_ctrl_hbuf_full1 : LUT6
    generic map(
      INIT => X"EEEEEEEEEEEAEEEE"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_reg_full_1196,
      I2 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(8),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0_FRB_745,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I5 => N101,
      O => IB_ENDPOINT_I_U_read_ctrl_hbuf_full
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_4_Q : LUT6
    generic map(
      INIT => X"5555555555455575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(7),
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_5_Q : LUT6
    generic map(
      INIT => X"5555554555555575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(5),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(8),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_6_Q : LUT6
    generic map(
      INIT => X"5555554555555575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(6),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(9),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_7_Q : LUT6
    generic map(
      INIT => X"5555554555555575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(10),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut_8_Q : LUT6
    generic map(
      INIT => X"5555554555555575"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      I1 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I2 => N103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I4 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_count_aux1(11),
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Mcount_reg_count_lut(8)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB0 : FDS
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq,
      S => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB0_101
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB1 : FDR
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history,
      R => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB1_102
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB3_103
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB0 : FDS
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history,
      S => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB0_90
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB2_93
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_eq,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB3_94
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB4 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_eq,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB4_275
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB7 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_U_comparator_LT_GT_cmp_gt0000,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB7_278
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB8 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_eq,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB8_279
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB9 : FDSE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000,
      S => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB9_280
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB11 : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_U_comparator_LT_GT_cmp_gt0000,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB11_283
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_IB_DST_RDY_N : LUT6
    generic map(
      INIT => X"2727227727273333"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I1 => N138,
      I2 => N139,
      I3 => N140,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      O => IB_ENDPOINT_I_U_down_buf_addr_dec_out_dst_rdy_n
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_ce1 : LUT3
    generic map(
      INIT => X"15"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      I2 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_U_rd_pipe_PIPE_ce
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"C400CC0000000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I3 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      I5 => IB_ENDPOINT_I_rd_pipe_dst_rdy_n,
      O => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_not00011 : LUT5
    generic map(
      INIT => X"00FFE0FF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N395
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"FF15BF15BF15BF15"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB0_623,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB1_624,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB2_625,
      I3 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB3_626,
      I4 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4_627,
      I5 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB5_628,
      O => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB6_1366,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB5_1365,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N506
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB6_1363,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB5_1362,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N610
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB6_1360,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB5_1359,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N618
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB6_1357,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB5_1356,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N626
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB6_1354,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB5_1353,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N634
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB6_1351,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB5_1350,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N642
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_mux00001 : LUT6
    generic map(
      INIT => X"AAAAAAAACCCAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB6_1348,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB5_1347,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => N645
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux00002_SW0 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      O => N142
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux00002_SW1 : LUT6
    generic map(
      INIT => X"FFFFFFFF020F0E0F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I5 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      O => N143
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_RD_EOF_N1 : LUT6
    generic map(
      INIT => X"FFABFFA8FFAAFFAA"
    )
    port map (
      I0 => N142,
      I1 => NlwRenamedSig_OI_WR_DATA_0_Q,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n,
      I4 => N143,
      I5 => N83,
      O => IB_ENDPOINT_I_downrd_sof_n
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB2_1364,
      I1 => N506,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_17_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB2_1361,
      I1 => N610,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_16_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB2_1358,
      I1 => N618,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_15_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB2_1355,
      I1 => N626,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_14_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB2_1352,
      I1 => N634,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_13_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB2_1349,
      I1 => N642,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_12_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_rstpot : LUT3
    generic map(
      INIT => X"CA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB2_1346,
      I1 => N645,
      I2 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_11_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_rstpot_113,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_3_Q : LUT3
    generic map(
      INIT => X"36"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(2),
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_7,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_3_Q_941
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_2_Q : LUT4
    generic map(
      INIT => X"5A69"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(2),
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(1),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_count_aux1_Madd_lut_2_Q_940
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_SOF_N1_SW0 : LUT6
    generic map(
      INIT => X"A080AF8C0080008C"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124,
      O => N148
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_SOF_N1 : LUT6
    generic map(
      INIT => X"FFFFFFFFABBBBBBB"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I3 => N83,
      I4 => N148,
      I5 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      O => IB_ENDPOINT_I_wr_sof_n
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_SW1 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      O => N150
    );
  IB_ENDPOINT_I_U_read_ctrl_U_fetch_marker_HEADER_LAST1_SW1 : LUT6
    generic map(
      INIT => X"000F000F000F111F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I4 => N150,
      I5 => N48,
      O => N95
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_SW4 : LUT4
    generic map(
      INIT => X"FFEF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      O => N156
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_COUNT_CE1 : LUT6
    generic map(
      INIT => X"AAA0AAA0AAA08880"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I4 => N156,
      I5 => N48,
      O => IB_ENDPOINT_I_U_read_ctrl_addr_ce
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld : FDR
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_rstpot_479,
      R => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_IB_DST_RDY_N_SW4 : LUT6
    generic map(
      INIT => X"CCCC888CFFFF888C"
    )
    port map (
      I0 => WR_RDY,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I4 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I5 => IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n,
      O => N138
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_IB_DST_RDY_N_SW5 : LUT5
    generic map(
      INIT => X"AAFF7F7F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I3 => IB_ENDPOINT_I_wr_dst_rdy_n,
      I4 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      O => N139
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_IB_DST_RDY_N_SW6 : LUT6
    generic map(
      INIT => X"F700F7FFF707F7F7"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_wr_dst_rdy_n,
      I5 => NlwRenamedSig_OI_WR_DATA_0_Q,
      O => N140
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_rstpot : LUT6
    generic map(
      INIT => X"F0F0F0B4F0F00A4A"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I5 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_dst_rdy_n,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_rstpot_113
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_and00001 : LUT6
    generic map(
      INIT => X"0000000000AB0003"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_and0000
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_SW6 : LUT4
    generic map(
      INIT => X"FFDF"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(3),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(8),
      O => N163
    );
  IB_ENDPOINT_I_U_read_ctrl_U_fetch_marker_HEADER_LAST1_SW4 : LUT6
    generic map(
      INIT => X"000F000F000F111F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(7),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count(4),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I4 => N163,
      I5 => N48,
      O => N103
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_mux00001_SW0 : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => WR_RDY,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      O => N173
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_rstpot : LUT6
    generic map(
      INIT => X"EEE4EEEE44E44444"
    )
    port map (
      I0 => N395,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB1_1438,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB2_1439,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB5_1440,
      O => NlwRenamedSig_OI_WR_ADDR_31_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB5_1408,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB2_1407,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB1_1406,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_30_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB5_1405,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB2_1402,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB1_1401,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_29_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB5_1400,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB2_1399,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB1_1398,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_28_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB5_1397,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB2_1396,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB1_1395,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_27_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB5_1394,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB2_1393,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB1_1392,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_26_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB5_1391,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB2_1390,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB1_1389,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_25_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB5_1388,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB2_1387,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB1_1386,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_24_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB5_1385,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB2_1384,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB1_1383,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_23_Q
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_rstpot : LUT5
    generic map(
      INIT => X"A8FFA0FF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_478,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      I3 => IB_ENDPOINT_I_U_down_buf_fsm_rd_src_rdy_n,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_vld_rstpot_479
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_rstpot : LUT6
    generic map(
      INIT => X"DDDDCCCD9999CCC9"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB0_1278,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB1_1279,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB5_1283,
      O => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_1_1 : LUT6
    generic map(
      INIT => X"F0F0F0F0F0F04050"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_1_BRB2_367,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320,
      I5 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_fetch_marker_DONE_FLAG_WE1 : LUT6
    generic map(
      INIT => X"0000000000AB0003"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => IB_ENDPOINT_I_rd_pipe_sof_n,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_done_flag_we
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or00001 : LUT6
    generic map(
      INIT => X"FAEABAAAEAEAAAAA"
    )
    port map (
      I0 => RESET,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_last_aux,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_3_1 : LUT6
    generic map(
      INIT => X"FFFF0055FFFF0010"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_3_BRB4_427,
      I5 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(3)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_2_1 : LUT6
    generic map(
      INIT => X"FFFF0055FFFF0010"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_2_BRB4_409,
      I5 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(2)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_0_1 : LUT6
    generic map(
      INIT => X"FFFF0055FFFF0010"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB4_324,
      I5 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(0)
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we1 : LUT6
    generic map(
      INIT => X"33333333BBBF333F"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_rd_pipe_PIPE_outreg_we
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_rstpot_92,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_91
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB5_1382,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB2_1381,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB1_1380,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_22_Q
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_9_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB2_474,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB3_475,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB4_476,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(9)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_8_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB2_470,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB3_471,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB4_472,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(8)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_7_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB2_466,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB3_467,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB4_468,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(7)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_6_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB2_462,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB3_463,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB4_464,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(6)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_5_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB2_454,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB3_455,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB4_456,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(5)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_4_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB2_440,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB3_441,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB4_442,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(4)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_31_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB2_416,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB3_417,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB4_418,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(31)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_30_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB2_412,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB3_413,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB4_414,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(30)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_29_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB2_406,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB3_407,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB4_408,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(29)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_28_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB2_402,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB3_403,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB4_404,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(28)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_27_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB2_398,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB3_399,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB4_400,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(27)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_26_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB2_394,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB3_395,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB4_396,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(26)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_25_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB2_390,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB3_391,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB4_392,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(25)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_24_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB2_386,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB3_387,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB4_388,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(24)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_23_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB2_382,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB3_383,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB4_384,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(23)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_22_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB2_378,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB3_379,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB4_380,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(22)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_21_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB2_374,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB3_375,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB4_376,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(21)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_20_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB2_370,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB3_371,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB4_372,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(20)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_19_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB2_364,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB3_365,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB4_366,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(19)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_18_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB2_360,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB3_361,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB4_362,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(18)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_17_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB2_356,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB3_357,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB4_358,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(17)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_16_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB2_352,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB3_353,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB4_354,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(16)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_15_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB2_348,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB3_349,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB4_350,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(15)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_14_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB2_344,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB3_345,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB4_346,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(14)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_13_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB2_340,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB3_341,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB4_342,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(13)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_12_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB2_336,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB3_337,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB4_338,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(12)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_11_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB2_332,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB3_333,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB4_334,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(11)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_in_mx_10_1 : LUT5
    generic map(
      INIT => X"FBEA5140"
    )
    port map (
      I0 => N220,
      I1 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439,
      I2 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB2_328,
      I3 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB3_329,
      I4 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB4_330,
      O => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(10)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB5_1379,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB2_1378,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB1_1377,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_21_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB5_1376,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB2_1375,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB1_1374,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_20_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB5_1372,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB2_1371,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB1_1370,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_19_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_rstpot_285,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_rstpot_288,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_rstpot_271,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_rstpot_274,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_rstpot_277,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_rstpot_270,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_269
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_rstpot : LUT6
    generic map(
      INIT => X"AAAACCAAF0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB5_1369,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB2_1368,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB1_1367,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I5 => N395,
      O => NlwRenamedSig_OI_WR_ADDR_18_Q
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB2_1141,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB3_1142,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB4_1143,
      O => NlwRenamedSig_OI_RD_ADDR(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB4_1150,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB3_1149,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB2_1148,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB4_1147,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB3_1146,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB2_1145,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB4_1153,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB3_1152,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB2_1151,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB4_1156,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB3_1155,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB2_1154,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB4_1159,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB3_1158,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB2_1157,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB4_1162,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB3_1161,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB2_1160,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB4_1044,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB3_1043,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB2_1042,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB4_1050,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB3_1049,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB2_1048,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(12)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB4_1047,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB3_1046,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB2_1045,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_rstpot : LUT5
    generic map(
      INIT => X"AAF0CCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB4_1053,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB3_1052,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB2_1051,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      O => NlwRenamedSig_OI_RD_ADDR(13)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB2_1054,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB3_1055,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB4_1056,
      O => NlwRenamedSig_OI_RD_ADDR(14)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB2_1073,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB3_1074,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB4_1075,
      O => NlwRenamedSig_OI_RD_ADDR(20)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB2_1057,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB3_1058,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB4_1059,
      O => NlwRenamedSig_OI_RD_ADDR(15)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB2_1060,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB3_1061,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB4_1062,
      O => NlwRenamedSig_OI_RD_ADDR(16)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB2_1076,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB3_1077,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB4_1078,
      O => NlwRenamedSig_OI_RD_ADDR(21)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB2_1063,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB3_1064,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB4_1065,
      O => NlwRenamedSig_OI_RD_ADDR(17)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB2_1079,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB3_1080,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB4_1081,
      O => NlwRenamedSig_OI_RD_ADDR(22)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB2_1066,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB3_1067,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB4_1068,
      O => NlwRenamedSig_OI_RD_ADDR(18)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB2_1082,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB3_1083,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB4_1084,
      O => NlwRenamedSig_OI_RD_ADDR(23)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB2_1069,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB3_1070,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB4_1071,
      O => NlwRenamedSig_OI_RD_ADDR(19)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB2_1085,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB3_1086,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB4_1087,
      O => NlwRenamedSig_OI_RD_ADDR(24)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB2_1088,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB3_1089,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB4_1090,
      O => NlwRenamedSig_OI_RD_ADDR(25)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB2_1103,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB3_1104,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB4_1105,
      O => NlwRenamedSig_OI_RD_ADDR(30)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB2_1091,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB3_1092,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB4_1093,
      O => NlwRenamedSig_OI_RD_ADDR(26)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB2_1137,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB3_1138,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB4_1139,
      O => NlwRenamedSig_OI_RD_ADDR(31)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB2_1100,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB3_1101,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB4_1102,
      O => NlwRenamedSig_OI_RD_ADDR(29)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB2_1094,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB3_1095,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB4_1096,
      O => NlwRenamedSig_OI_RD_ADDR(27)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_rstpot : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB2_1097,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB3_1098,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB4_1099,
      O => NlwRenamedSig_OI_RD_ADDR(28)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_fetch_marker_HEADER_LAST1_SW9 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      O => N207
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_count_not00011 : LUT6
    generic map(
      INIT => X"FFFF0000FFFF0B03"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => N207,
      I2 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I4 => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      I5 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_rstpot : LUT6
    generic map(
      INIT => X"D1D1F0F0FF00FF00"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB3_103,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB0_101,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB1_102,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I4 => N115,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_rstpot_288
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_rstpot : LUT6
    generic map(
      INIT => X"AEA2AEA2FFFF0000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB0_90,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_91,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB3_94,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB2_93,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_269,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_rstpot_270
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_rstpot : LUT6
    generic map(
      INIT => X"BBA94446BBAA4444"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB0_767,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB1_768,
      I2 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4_627,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB3_769,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB4_770,
      I5 => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB5_628,
      O => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_rstpot : LUT6
    generic map(
      INIT => X"0500CCCC05000500"
    )
    port map (
      I0 => RESET,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I3 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I5 => N209,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_rstpot_277
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_rstpot : LUT6
    generic map(
      INIT => X"AFAFA3A0ACAFA0A0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I1 => N195,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      I4 => N211,
      I5 => N212,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_rstpot_285
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_rstpot : LUT6
    generic map(
      INIT => X"AFAFA3A0ACAFA0A0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I1 => N195,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      I4 => N214,
      I5 => N215,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_rstpot_271
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_rstpot : LUT6
    generic map(
      INIT => X"AFAFA3A0ACAFA0A0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I1 => N195,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      I4 => N217,
      I5 => N218,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_rstpot_274
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW0 : LUT6
    generic map(
      INIT => X"FEFEFFF0FEFEFFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => N195,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      O => N209
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB1_439
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1_212,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB2_440
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB3_441
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(36),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_4_BRB4_442
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1_234,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB2_454
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB3_455
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(37),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_5_BRB4_456
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1_248,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB2_462
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB3_463
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(38),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_6_BRB4_464
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1_250,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB2_466
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB3_467
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(39),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_7_BRB4_468
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1_252,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB2_470
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB3_471
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(40),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_8_BRB4_472
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1_254,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB2_474
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB3_475
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(41),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_9_BRB4_476
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1_126,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB2_328
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB3_329
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(42),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_10_BRB4_330
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1_128,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB2_332
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB3_333
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(43),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_11_BRB4_334
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1_130,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB2_336
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB3_337
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(44),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_12_BRB4_338
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1_132,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB2_340
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB3_341
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(45),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_13_BRB4_342
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1_134,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB2_344
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB3_345
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(46),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_14_BRB4_346
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1_136,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB2_348
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB3_349
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(47),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_15_BRB4_350
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1_138,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB2_352
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB3_353
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(48),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_16_BRB4_354
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1_140,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB2_356
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB3_357
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(49),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_17_BRB4_358
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1_142,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB2_360
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB3_361
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(50),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_18_BRB4_362
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1_144,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB2_364
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB3_365
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(51),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_19_BRB4_366
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1_148,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB2_370
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB3_371
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(52),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_20_BRB4_372
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1_150,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB2_374
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB3_375
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(53),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_21_BRB4_376
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1_152,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB2_378
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB3_379
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(54),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_22_BRB4_380
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1_154,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB2_382
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB3_383
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(55),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_23_BRB4_384
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1_156,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB2_386
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB3_387
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(56),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_24_BRB4_388
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1_158,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB2_390
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB3_391
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(57),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_25_BRB4_392
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1_160,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB2_394
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB3_395
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(58),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_26_BRB4_396
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1_162,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB2_398
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB3_399
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(59),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_27_BRB4_400
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1_164,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB2_402
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB3_403
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(60),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_28_BRB4_404
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1_166,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB2_406
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB3_407
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(61),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_29_BRB4_408
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1_170,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB2_412
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB3_413
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(62),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_30_BRB4_414
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1_172,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB2_416
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB3_417
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(63),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_31_BRB4_418
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_not0001,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_addr_ce,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(31),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB2_1137
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(31),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB3_1138
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(28),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB4_1139
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB0 : FDS
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd2_629,
      S => RESET,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB0_623
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB1 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_downrd_sof_n,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB1_624
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_eof_n_reg_480,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB2_625
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1,
      R => RESET,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB3_626
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_rd_pipe_dst_rdy_n,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB4_627
    );
  IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      Q => IB_ENDPOINT_I_U_rd_pipe_PIPE_present_state_FSM_FFd1_BRB5_628
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB0_320
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => NlwRenamedSig_OI_WR_DATA_0_Q,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB1_321
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB2_322
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB3_323
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(32),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB4_324
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_0_BRB5_325
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_1_BRB2 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(33),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_1_BRB2_367
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_2_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(34),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_2_BRB4_409
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_3_BRB4 : FDE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_or0000_inv,
      D => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(35),
      Q => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg_3_BRB4_427
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_29_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB1_1401
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(26),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB2_1402
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_wr_src_rdy_n,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4 : FD
    port map (
      C => CLK,
      D => N173,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_61_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB5_1405
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_28_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB1_1398
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(25),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB2_1399
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_60_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_28_BRB5_1400
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_26_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB1_1392
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(23),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB2_1393
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_58_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_26_BRB5_1394
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_27_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB1_1395
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(24),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB2_1396
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_59_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_27_BRB5_1397
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_31_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB1_1438
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(28),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB2_1439
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_63_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB5_1440
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_30_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB1_1406
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(27),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB2_1407
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_62_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_30_BRB5_1408
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB0 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_N01,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB0_767
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB1 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB1_768
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB3_769
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB4 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0_BRB4_770
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_25_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB1_1389
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(22),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB2_1390
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_57_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_25_BRB5_1391
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_24_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB1_1386
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(21),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB2_1387
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_56_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_24_BRB5_1388
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_23_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB1_1383
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(20),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB2_1384
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_55_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_23_BRB5_1385
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_22_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB1_1380
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(19),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB2_1381
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_54_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_22_BRB5_1382
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_21_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB1_1377
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(18),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB2_1378
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_53_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_21_BRB5_1379
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(30),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB2_1103
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(30),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB3_1104
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(27),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_30_BRB4_1105
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_20_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB1_1374
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(17),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB2_1375
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_52_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_20_BRB5_1376
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(29),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB2_1100
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(29),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB3_1101
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(26),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_29_BRB4_1102
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_19_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB1_1370
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(16),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB2_1371
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_51_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_19_BRB5_1372
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(28),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB2_1097
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(28),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB3_1098
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(25),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_28_BRB4_1099
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB1 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_18_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB1_1367
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(15),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB2_1368
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_50_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_18_BRB5_1369
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(27),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB2_1094
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(27),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB3_1095
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(24),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_27_BRB4_1096
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_17_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB2_1364
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(26),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB2_1091
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(26),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB3_1092
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(23),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_26_BRB4_1093
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(25),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB2_1088
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(25),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB3_1089
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(22),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_25_BRB4_1090
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(24),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB2_1085
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(24),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB3_1086
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(21),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_24_BRB4_1087
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(23),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB2_1082
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(23),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB3_1083
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(20),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_23_BRB4_1084
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(22),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB2_1079
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(22),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB3_1080
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(19),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_22_BRB4_1081
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(21),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB2_1076
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(21),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB3_1077
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(18),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_21_BRB4_1078
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      PRE => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_774
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout_rdy_697,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_775
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2 : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd1_771,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_776
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_777
    );
  IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_N01,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_778
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(20),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB2_1073
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(20),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB3_1074
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(17),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_20_BRB4_1075
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(19),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB2_1069
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(19),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB3_1070
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(16),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_19_BRB4_1071
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(18),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB2_1066
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(18),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB3_1067
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(15),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_18_BRB4_1068
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(17),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB2_1063
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(17),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB3_1064
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(14),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_17_BRB4_1065
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(16),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB2_1060
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(16),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB3_1061
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(13),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_16_BRB4_1062
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(15),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB2_1057
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(15),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB3_1058
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(12),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_15_BRB4_1059
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(14),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB2_1054
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(14),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB3_1055
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(11),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_14_BRB4_1056
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(13),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB2_1051
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(13),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB3_1052
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(10),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_13_BRB4_1053
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(12),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB2_1048
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(12),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB3_1049
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_12_BRB4_1050
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(11),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB2_1045
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(11),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB3_1046
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_11_BRB4_1047
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(10),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB2_1042
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(10),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB3_1043
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_10_BRB4_1044
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB2_1160
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(9),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB3_1161
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_9_BRB4_1162
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB2_1157
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(8),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB3_1158
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_8_BRB4_1159
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_16_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB2_1361
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB2_1154
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(7),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB3_1155
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_7_BRB4_1156
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_15_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB2_1358
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB2_1151
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(6),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB3_1152
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_6_BRB4_1153
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_14_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB2_1355
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB2_1148
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(5),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB3_1149
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(2),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_5_BRB4_1150
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_13_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB2_1352
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB2_1145
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(4),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB3_1146
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(1),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_4_BRB4_1147
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_12_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB2_1349
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_11_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB2_1346
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB5_1345,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB4_1344,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB2_1343,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_10_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB5_1462,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB4_1461,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB2_1460,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_9_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB5_1459,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB4_1458,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB2_1457,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_8_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB5_1456,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB4_1455,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB2_1454,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_7_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB5_1453,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB4_1452,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB2_1451,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_6_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB5_1450,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB4_1449,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB2_1448,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_5_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_rstpot : LUT6
    generic map(
      INIT => X"AAF0AAF0CCCCAAF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB5_1447,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB4_1446,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB2_1445,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      O => NlwRenamedSig_OI_WR_ADDR_4_Q
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_rstpot : LUT6
    generic map(
      INIT => X"FDFCA8FC75302030"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB2_1442,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB4_1443,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB5_1444,
      O => NlwRenamedSig_OI_WR_ADDR_3_Q
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB4_104
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB5_105
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB6 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB6_106
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB7 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_high_reg_history_BRB7_107
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_rd_pipe_PIPE_reg_dout(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB2_1141
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB3 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_RD_ADDR(3),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB3_1142
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_3_add0000(0),
      Q => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB4_1143
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2,
      PRE => RESET,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB0_117
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1 : FDC
    port map (
      C => CLK,
      CLR => RESET,
      D => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB1_118
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB2_119
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3 : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB3_120
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB4_121
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_down_buf_addr_dec_out_dst_rdy_n,
      Q => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_BRB5_122
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_RD_SRC_RDY_N1 : LUT6
    generic map(
      INIT => X"FFABFFA8FFAAFFAA"
    )
    port map (
      I0 => N142,
      I1 => NlwRenamedSig_OI_WR_DATA_0_Q,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I4 => N143,
      I5 => N83,
      O => IB_ENDPOINT_I_U_down_buf_fsm_rd_src_rdy_n
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB0 : FDS
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_wr_src_rdy_n,
      S => RESET,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB0_1278
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB1 : FDR
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0,
      R => RESET,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB1_1279
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB2_1280
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB3_1281
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4 : FD
    port map (
      C => CLK,
      D => WR_RDY,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB4_1282
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_wr_eof_n,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_transfer_cnt_0_0_BRB5_1283
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_wr_sof_n,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_42_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB2_1343
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(7),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB4_1344
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_10_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB5_1345
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_41_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB2_1460
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(6),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB4_1461
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_9_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_9_BRB5_1462
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_40_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB2_1457
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(5),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB4_1458
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_8_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_8_BRB5_1459
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_39_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB2_1454
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(4),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB4_1455
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_7_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_7_BRB5_1456
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_38_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB2_1451
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(3),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB4_1452
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_6_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_6_BRB5_1453
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_37_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB2_1448
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(2),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB4_1449
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_5_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_5_BRB5_1450
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_36_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB2_1445
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(1),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB4_1446
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_4_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_4_BRB5_1447
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(14),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB5_1365
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_49_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_17_BRB6_1366
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(13),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB5_1362
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_48_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_16_BRB6_1363
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(12),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB5_1359
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_47_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_15_BRB6_1360
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(11),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB5_1356
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_46_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_14_BRB6_1357
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(10),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB5_1353
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_45_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_13_BRB6_1354
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(9),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB5_1350
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_44_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_12_BRB6_1351
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB5 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(8),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB5_1347
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB6 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_43_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_11_BRB6_1348
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB2 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_DATA_35_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB2_1442
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB4 : FD
    port map (
      C => CLK,
      D => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_3_add0000(0),
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB4_1443
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB5 : FD
    port map (
      C => CLK,
      D => NlwRenamedSig_OI_WR_ADDR_3_Q,
      Q => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB5_1444
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_rstpot : LUT5
    generic map(
      INIT => X"0000B2A2"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_or0000,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_cmp_base_reg_history_BRB1_rstpot_92
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_and00001 : LUT4
    generic map(
      INIT => X"5455"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_and0000
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"DF8A8A8AFFAAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_out_data_aux(65),
      I2 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_transfer,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_lut_0_Q : LUT5
    generic map(
      INIT => X"082A5D7F"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB4_1143,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB2_1141,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_3_BRB3_1142,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_Madd_reg_addr64_31_3_add0000_lut(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"545454FFF4F4F4F7"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I3 => IB_ENDPOINT_I_U_read_ctrl_hbuf_full,
      I4 => IB_ENDPOINT_I_rd_pipe_eof_n,
      I5 => RD_ARDY_ACCEPT,
      O => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_lut_0_Q : LUT6
    generic map(
      INIT => X"0404BF0404BFBFBF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB4_1443,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_10_BRB1_1342,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB5_1444,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_3_BRB2_1442,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_Madd_reg_addr32_31_3_add0000_lut(0)
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_In_SW2 : LUT6
    generic map(
      INIT => X"F0F5F0F3F0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N9
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_In_SW0 : LUT6
    generic map(
      INIT => X"F0F5F0F3F0F0F0F0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N11
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_63_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(63),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_1_172,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_31_0_171,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(63)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_62_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(62),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_1_170,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_30_0_169,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(62)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_61_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(61),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_1_166,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_29_0_165,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(61)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_60_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(60),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_1_164,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_28_0_163,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(60)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_59_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(59),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_1_162,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_27_0_161,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(59)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_58_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(58),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_1_160,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_26_0_159,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(58)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_57_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(57),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_1_158,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_25_0_157,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(57)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_56_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(56),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_1_156,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_24_0_155,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(56)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_55_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(55),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_1_154,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_23_0_153,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(55)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_54_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(54),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_1_152,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_22_0_151,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(54)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_53_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(53),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_1_150,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_21_0_149,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(53)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_52_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(52),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_1_148,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_20_0_147,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(52)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_51_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(51),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_1_144,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_19_0_143,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(51)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_50_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(50),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_1_142,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_18_0_141,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(50)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_49_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(49),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_1_140,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_17_0_139,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(49)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_48_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(48),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_1_138,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_16_0_137,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(48)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_47_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(47),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_1_136,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_15_0_135,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(47)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_46_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(46),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_1_134,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_14_0_133,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(46)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_45_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(45),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_1_132,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_13_0_131,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(45)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_44_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(44),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_1_130,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_12_0_129,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(44)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_43_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(43),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_1_128,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_11_0_127,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(43)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_42_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(42),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_1_126,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_10_0_125,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(42)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_41_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(41),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_1_254,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_9_0_253,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(41)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_40_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(40),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_1_252,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_8_0_251,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(40)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_39_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(39),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_1_250,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_7_0_249,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(39)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_38_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(38),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_1_248,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_6_0_247,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(38)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_37_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(37),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_1_234,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_5_0_233,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(37)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_36_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(36),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_1_212,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_4_0_211,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(36)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_35_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(35),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_1_190,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_3_0_189,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(35)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_34_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(34),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_1_168,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_2_0_167,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(34)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_33_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(33),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_1_146,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_1_0_145,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(33)
    );
  IB_ENDPOINT_I_U_down_buf_U_swapper_out_mx_32_1 : LUT5
    generic map(
      INIT => X"AAAACCF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_swapper_data_reg(32),
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I4 => IB_ENDPOINT_I_downrd_sof_n,
      O => IB_ENDPOINT_I_downrd_data(32)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW1 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N211
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW3 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N214
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW5 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAAAAAA"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N217
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW2 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAACCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N212
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW4 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAACCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N215
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW6 : LUT6
    generic map(
      INIT => X"AAAAAAACAAAACCCC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => N218
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => CLK,
      D => N789,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0_FRB : FDRE
    port map (
      C => CLK,
      CE => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data_not0001,
      D => N790,
      R => RESET,
      Q => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_SW0_FRB_745
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux000011_SW0 : MUXF7
    port map (
      I0 => N791,
      I1 => N792,
      S => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB8_279,
      O => N83
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux000011_SW0_F : LUT5
    generic map(
      INIT => X"A2808080"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB11_283,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2_272,
      O => N791
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_mux000011_SW0_G : LUT5
    generic map(
      INIT => X"A2808080"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB10_269,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB1_268,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB5_276,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB3_273,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP_BRB2_272,
      O => N792
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW0_SW1 : MUXF7
    port map (
      I0 => N793,
      I1 => N794,
      S => IB_ENDPOINT_I_wr_dst_rdy_n,
      O => N195
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW0_SW1_F : LUT6
    generic map(
      INIT => X"FFF5FFF3FFF0FFF0"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I5 => IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n,
      O => N793
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_SW0_SW1_G : LUT6
    generic map(
      INIT => X"FFFFFFFFFFFAFFFC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_1_124,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_0_0_123,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I5 => IB_ENDPOINT_I_U_down_buf_fsm_rd_dst_rdy_n,
      O => N794
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_SRC_RDY_N1_SW0 : LUT5
    generic map(
      INIT => X"D1000000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I4 => NlwRenamedSig_OI_WR_DATA_0_Q,
      O => N795
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_SRC_RDY_N1 : LUT6
    generic map(
      INIT => X"FFDCFFDDFFDDFFDD"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I4 => N83,
      I5 => N795,
      O => IB_ENDPOINT_I_wr_src_rdy_n
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state_0_mux0000_SW1 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_1_900,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_64_0_899,
      O => N797
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state_0_mux0000 : LUT6
    generic map(
      INIT => X"AAA2AAA2AAA2AAF7"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I3 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I5 => N797,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_next_state
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_EOF_N1_SW0 : LUT5
    generic map(
      INIT => X"2EFFFFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB3_286,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB0_282,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB4_287,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I4 => NlwRenamedSig_OI_WR_DATA_0_Q,
      O => N799
    );
  IB_ENDPOINT_I_U_down_buf_U_down_fsm_WR_EOF_N1 : LUT6
    generic map(
      INIT => X"FBFBFBFBFBFAFBFB"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I1 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I2 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_eof_n,
      I3 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I4 => N83,
      I5 => N799,
      O => IB_ENDPOINT_I_wr_eof_n
    );
  IB_ENDPOINT_I_U_cpl_pipe_OUT_EOF_N1 : LUT3
    generic map(
      INIT => X"BF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I2 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_next_state_0_cmp_eq0000_744,
      O => IB_ENDPOINT_I_cpl_pipe_eof_n
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce1 : LUT4
    generic map(
      INIT => X"0207"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      O => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_ce
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_SHREG_CE1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => RD_SRC_RDY,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_shreg_ce
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"A8A8A8AFAFA8AFAF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      I1 => IB_UP_DST_RDY_N,
      I2 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      O => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_HBUF_WE1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => RD_ARDY_ACCEPT,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      O => IB_ENDPOINT_I_U_read_ctrl_unpck_hbuf_we
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"8888888800088088"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      I1 => IB_UP_DST_RDY_N,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I5 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      O => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"A0A0A080AAAAAA88"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I1 => RESET,
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I5 => IB_DOWN_SRC_RDY_N,
      O => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_In1 : LUT6
    generic map(
      INIT => X"AAAAAAA8AAAAFFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I2 => RESET,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_pause_transfer,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd2,
      I5 => IB_DOWN_SRC_RDY_N,
      O => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_In
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In_SW0 : LUT4
    generic map(
      INIT => X"FFBF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      I2 => RD_SRC_RDY,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      O => N5
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_SHREG_CE1 : LUT4
    generic map(
      INIT => X"4404"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_ce
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result_1_1 : LUT4
    generic map(
      INIT => X"693C"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(1)
    );
  IB_ENDPOINT_I_U_write_ctrl_U_fetch_marker_LENGTH_WE1 : LUT6
    generic map(
      INIT => X"0000555500004000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_addr_dec_out_sof_n,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_BRB2_284,
      I2 => N83,
      I3 => N148,
      I4 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I5 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      O => IB_ENDPOINT_I_U_write_ctrl_addr_we
    );
  IB_ENDPOINT_I_U_cpl_pipe_OUT_SOF_N1 : LUT5
    generic map(
      INIT => X"FFFDFFF8"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_1_902,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_fsm_u_present_state_FSM_FFd2,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_65_0_901,
      O => IB_ENDPOINT_I_cpl_pipe_sof_n
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result_2_1 : LUT5
    generic map(
      INIT => X"6C6CC96C"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(2)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_start1 : LUT5
    generic map(
      INIT => X"00000002"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I4 => RESET,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_start
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_0_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(0),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(0),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(0)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_1_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(1),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(1),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_2_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(2),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(2),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_3_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(3),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(3),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_4_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(4),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(4),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_5_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(5),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(5),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_6_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(6),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(6),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_7_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(7),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(7),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_8_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(8),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(8),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(8)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_last1 : LUT6
    generic map(
      INIT => X"202020202020A820"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      I3 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I5 => RESET,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_ce_addr_last
    );
  IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut_9_Q : LUT6
    generic map(
      INIT => X"00FF001000FFEFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_cnt_data(9),
      I4 => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_present_state(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpck_hbuf_data_out(9),
      O => IB_ENDPOINT_I_U_read_ctrl_DATA_REORDER_NO_U_align_unit_fake_Mcount_cnt_data_lut(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result_3_1 : LUT6
    generic map(
      INIT => X"6C6CCC6CCCCCC9CC"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(1),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_CNT_ADDR_CE1 : LUT5
    generic map(
      INIT => X"21202122"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      I3 => RD_SRC_RDY,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cmp_empty,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr_ce
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In : LUT6
    generic map(
      INIT => X"8C8C8C8C8D8C8C8C"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(3),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(2),
      I5 => N5,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_In_759
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_In1 : LUT5
    generic map(
      INIT => X"C5C4C4C4"
    )
    port map (
      I0 => RD_SRC_RDY,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_760,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_758,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cmp_empty,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_DATA_DST_RDY1_FRB_763,
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd2_In
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_9_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_0_909,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(9),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_9_1_910,
      O => IB_ENDPOINT_I_cpl_data(9)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_8_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_0_907,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(8),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_8_1_908,
      O => IB_ENDPOINT_I_cpl_data(8)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_7_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_0_905,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(7),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_7_1_906,
      O => IB_ENDPOINT_I_cpl_data(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_63_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_0_897,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(63),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_63_1_898,
      O => IB_ENDPOINT_I_cpl_data(63)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_62_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_0_895,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(62),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_62_1_896,
      O => IB_ENDPOINT_I_cpl_data(62)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_61_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_0_893,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(61),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_61_1_894,
      O => IB_ENDPOINT_I_cpl_data(61)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_60_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_0_891,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(60),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_60_1_892,
      O => IB_ENDPOINT_I_cpl_data(60)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_6_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_0_903,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(6),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_6_1_904,
      O => IB_ENDPOINT_I_cpl_data(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_59_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_0_887,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(59),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_59_1_888,
      O => IB_ENDPOINT_I_cpl_data(59)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_58_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_0_885,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(58),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_58_1_886,
      O => IB_ENDPOINT_I_cpl_data(58)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_57_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_0_883,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(57),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_57_1_884,
      O => IB_ENDPOINT_I_cpl_data(57)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_56_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_0_881,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(56),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_56_1_882,
      O => IB_ENDPOINT_I_cpl_data(56)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_55_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_0_879,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(55),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_55_1_880,
      O => IB_ENDPOINT_I_cpl_data(55)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_54_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_0_877,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(54),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_54_1_878,
      O => IB_ENDPOINT_I_cpl_data(54)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_53_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_0_875,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(53),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_53_1_876,
      O => IB_ENDPOINT_I_cpl_data(53)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_52_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_0_873,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(52),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_52_1_874,
      O => IB_ENDPOINT_I_cpl_data(52)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_51_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_0_871,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(51),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_51_1_872,
      O => IB_ENDPOINT_I_cpl_data(51)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_50_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_0_869,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(50),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_50_1_870,
      O => IB_ENDPOINT_I_cpl_data(50)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_5_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_0_889,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(5),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_5_1_890,
      O => IB_ENDPOINT_I_cpl_data(5)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_49_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_0_865,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(49),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_49_1_866,
      O => IB_ENDPOINT_I_cpl_data(49)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_48_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_0_863,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(48),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_48_1_864,
      O => IB_ENDPOINT_I_cpl_data(48)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_47_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_0_861,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(47),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_47_1_862,
      O => IB_ENDPOINT_I_cpl_data(47)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_46_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_0_859,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(46),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_46_1_860,
      O => IB_ENDPOINT_I_cpl_data(46)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_45_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_0_857,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(45),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_45_1_858,
      O => IB_ENDPOINT_I_cpl_data(45)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_44_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_0_855,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(44),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_44_1_856,
      O => IB_ENDPOINT_I_cpl_data(44)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_43_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_0_853,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(43),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_43_1_854,
      O => IB_ENDPOINT_I_cpl_data(43)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_42_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_0_851,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(42),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_42_1_852,
      O => IB_ENDPOINT_I_cpl_data(42)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_41_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_0_849,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(41),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_41_1_850,
      O => IB_ENDPOINT_I_cpl_data(41)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_40_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_0_847,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(40),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_40_1_848,
      O => IB_ENDPOINT_I_cpl_data(40)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_4_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_0_867,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(4),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_4_1_868,
      O => IB_ENDPOINT_I_cpl_data(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_39_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_0_843,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(39),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_39_1_844,
      O => IB_ENDPOINT_I_cpl_data(39)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_38_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_0_841,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(38),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_38_1_842,
      O => IB_ENDPOINT_I_cpl_data(38)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_37_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_0_839,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(37),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_37_1_840,
      O => IB_ENDPOINT_I_cpl_data(37)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_36_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_0_837,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(36),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_36_1_838,
      O => IB_ENDPOINT_I_cpl_data(36)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_35_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_0_835,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(35),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_35_1_836,
      O => IB_ENDPOINT_I_cpl_data(35)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_34_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_0_833,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(34),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_34_1_834,
      O => IB_ENDPOINT_I_cpl_data(34)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_33_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_0_831,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(33),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_33_1_832,
      O => IB_ENDPOINT_I_cpl_data(33)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_32_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_0_829,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(32),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_32_1_830,
      O => IB_ENDPOINT_I_cpl_data(32)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_31_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_0_827,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(31),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_31_1_828,
      O => IB_ENDPOINT_I_cpl_data(31)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_30_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_0_825,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(30),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_30_1_826,
      O => IB_ENDPOINT_I_cpl_data(30)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_3_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_0_845,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(3),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_3_1_846,
      O => IB_ENDPOINT_I_cpl_data(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_29_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_0_821,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(29),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_29_1_822,
      O => IB_ENDPOINT_I_cpl_data(29)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_28_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_0_819,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(28),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_28_1_820,
      O => IB_ENDPOINT_I_cpl_data(28)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_27_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_0_817,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(27),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_27_1_818,
      O => IB_ENDPOINT_I_cpl_data(27)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_26_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_0_815,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(26),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_26_1_816,
      O => IB_ENDPOINT_I_cpl_data(26)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_25_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_0_813,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(25),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_25_1_814,
      O => IB_ENDPOINT_I_cpl_data(25)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_24_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_0_811,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(24),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_24_1_812,
      O => IB_ENDPOINT_I_cpl_data(24)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_23_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_0_809,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(23),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_23_1_810,
      O => IB_ENDPOINT_I_cpl_data(23)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_22_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_0_807,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(22),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_22_1_808,
      O => IB_ENDPOINT_I_cpl_data(22)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_21_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_0_805,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(21),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_21_1_806,
      O => IB_ENDPOINT_I_cpl_data(21)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_20_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_0_803,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(20),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_20_1_804,
      O => IB_ENDPOINT_I_cpl_data(20)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_2_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_0_823,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(2),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_2_1_824,
      O => IB_ENDPOINT_I_cpl_data(2)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_19_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_0_799,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(19),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_19_1_800,
      O => IB_ENDPOINT_I_cpl_data(19)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_18_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_0_797,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(18),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_18_1_798,
      O => IB_ENDPOINT_I_cpl_data(18)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_17_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_0_795,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(17),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_17_1_796,
      O => IB_ENDPOINT_I_cpl_data(17)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_16_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_0_793,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(16),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_16_1_794,
      O => IB_ENDPOINT_I_cpl_data(16)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_15_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_0_791,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(15),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_15_1_792,
      O => IB_ENDPOINT_I_cpl_data(15)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_14_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_0_789,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(14),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_14_1_790,
      O => IB_ENDPOINT_I_cpl_data(14)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_13_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_0_787,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(13),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_13_1_788,
      O => IB_ENDPOINT_I_cpl_data(13)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_12_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_0_785,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(12),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_12_1_786,
      O => IB_ENDPOINT_I_cpl_data(12)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_11_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_0_783,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(11),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_11_1_784,
      O => IB_ENDPOINT_I_cpl_data(11)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_10_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_0_781,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(10),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_10_1_782,
      O => IB_ENDPOINT_I_cpl_data(10)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_1_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_0_801,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(1),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_1_1_802,
      O => IB_ENDPOINT_I_cpl_data(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_OUT_DATA_0_1 : LUT6
    generic map(
      INIT => X"FFFE1110EFEE0100"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_cpl_fsm_present_state(0),
      I1 => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd2_1271,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_cnt_addr_0_0,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_0_779,
      I4 => IB_ENDPOINT_I_U_read_ctrl_align_in_data(0),
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_pck_hbuf_U_ib_endpoint_pck_hbuf_sh_fifo_shreg_0_1_780,
      O => IB_ENDPOINT_I_cpl_data(0)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_fsm_addrpart_we1 : LUT6
    generic map(
      INIT => X"555D555D00040000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I1 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I3 => RESET,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addrpart_we
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_3_Q : LUT6
    generic map(
      INIT => X"5444444555555555"
    )
    port map (
      I0 => N19,
      I1 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I4 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(3)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_5_Q : LUT6
    generic map(
      INIT => X"0068008900FF00FF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I1 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I3 => N21,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(5)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_2_Q : LUT6
    generic map(
      INIT => X"5555444155555555"
    )
    port map (
      I0 => N23,
      I1 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I4 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_Q : LUT6
    generic map(
      INIT => X"000060810000FFFF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I2 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I3 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I4 => N25,
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(6)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_4_Q : LUT6
    generic map(
      INIT => X"006A00A900FF00FF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I3 => N27,
      I4 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(4)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_3_Q : LUT6
    generic map(
      INIT => X"00FFFFFF00818181"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I1 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_lut(1),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I3 => NlwRenamedSig_OI_RD_SOF,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I5 => N38,
      O => RD_BE(3)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_0_1 : LUT5
    generic map(
      INIT => X"DDDDDDDF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      O => RD_BE(0)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_0_1 : LUT5
    generic map(
      INIT => X"DDDDDDDF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I1 => IB_ENDPOINT_I_wr_src_rdy_n,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      O => WR_BE(0)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_3_SW0 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I2 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => N19
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_5_SW0 : LUT4
    generic map(
      INIT => X"2000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I1 => IB_ENDPOINT_I_wr_src_rdy_n,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      O => N21
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_2_SW0 : LUT5
    generic map(
      INIT => X"22202020"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I1 => IB_ENDPOINT_I_wr_src_rdy_n,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      O => N23
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_SW0 : LUT5
    generic map(
      INIT => X"00008000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I4 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => N25
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_4_SW0 : LUT5
    generic map(
      INIT => X"20202000"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I1 => IB_ENDPOINT_I_wr_src_rdy_n,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      O => N27
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_3_SW0 : LUT5
    generic map(
      INIT => X"FF57FFFF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_cmp_eq0000_916,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I3 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I4 => RD_ARDY_ACCEPT,
      O => N38
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_5_Q : LUT6
    generic map(
      INIT => X"AFAF23AFAFAFAFAF"
    )
    port map (
      I0 => N40,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I2 => NlwRenamedSig_OI_RD_EOF,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd1_912,
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_read_fsm_present_state_FSM_FFd2,
      O => RD_BE(5)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_fsm_addr_we1 : LUT6
    generic map(
      INIT => X"0001000000000000"
    )
    port map (
      I0 => RESET,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_fsm_u_present_state_FSM_FFd1_114,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd1_263,
      I3 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_present_state_FSM_FFd2_265,
      I4 => IB_ENDPOINT_I_U_down_buf_INPUT_BUFFER_GEN1_U_input_pipe_PIPE_present_state_FSM_FFd1_309,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_addr_start_aux,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_we
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_7_1 : LUT6
    generic map(
      INIT => X"01080801FFFFFFFF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I2 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I5 => NlwRenamedSig_OI_WR_EOF,
      O => WR_BE(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_7_1 : LUT6
    generic map(
      INIT => X"01080801FFFFFFFF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I2 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I5 => NlwRenamedSig_OI_RD_EOF,
      O => RD_BE(7)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_1_SW0 : LUT4
    generic map(
      INIT => X"9FF9"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      O => N36
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_xor_2_11 : LUT6
    generic map(
      INIT => X"9996969696666666"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      O => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_last_align(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_Madd_last_align_xor_2_11 : LUT6
    generic map(
      INIT => X"9996969696666666"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_6,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5,
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      O => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2)
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_1_Q : LUT6
    generic map(
      INIT => X"CCCCCCFF04CC04FF"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(2),
      I1 => N801,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd2_1477,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_write_fsm_present_state_FSM_FFd1_1475,
      I5 => IB_ENDPOINT_I_wr_src_rdy_n,
      O => WR_BE(1)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_5_SW0 : LUT6
    generic map(
      INIT => X"8778066006601EE1"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      O => N40
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_2_SW0 : LUT6
    generic map(
      INIT => X"FCE93F7F3F7FFCE9"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I1 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      O => N42
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_4_SW0 : LUT6
    generic map(
      INIT => X"C33C3C3C963C3C69"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I2 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I5 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      O => N46
    );
  IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_be_mux_1_SW1 : LUT6
    generic map(
      INIT => X"FFFFFFF6FFF6FFFF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_5,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(1),
      I2 => IB_ENDPOINT_I_U_write_ctrl_BE_GEN_YES_U_be_gen_last_align(2),
      I3 => IB_ENDPOINT_I_wr_eof_n,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32(0),
      I5 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_length_0_4,
      O => N801
    );
  IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_rstpot1 : LUT6
    generic map(
      INIT => X"EEE4EEEE44E44444"
    )
    port map (
      I0 => N395,
      I1 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB1_1438,
      I2 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB2_1439,
      I3 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB3_1403,
      I4 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_29_BRB4_1404,
      I5 => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_BRB5_1440,
      O => IB_ENDPOINT_I_U_write_ctrl_U_unpacker_reg_addr32_31_rstpot_1441
    );
  IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_rstpot1 : LUT5
    generic map(
      INIT => X"FDA87520"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB0_1135,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB1_1136,
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB2_1137,
      I3 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB3_1138,
      I4 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_BRB4_1139,
      O => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64_31_rstpot_1140
    );
  IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result_0_1_INV_0 : INV
    port map (
      I => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_cnt_addr(0),
      O => IB_ENDPOINT_I_U_read_ctrl_U_cpl_buf_U_buf_U_ib_buffer_sh_fifo_Result(0)
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_not00001_INV_0 : INV
    port map (
      I => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_261,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_fetch_marker_cnt_addrpart_we_0_0_not0000
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_not00001_INV_0 : INV
    port map (
      I => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_110,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_limit_cnt_sel_0_0_not0000
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_not00001_INV_0 : INV
    port map (
      I => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_108,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_addr_const_base_cnt_sel_0_0_not0000
    );
  IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_OUT_SRC_RDY_N1_INV_0 : INV
    port map (
      I => IB_ENDPOINT_I_U_up_buf_OUTPUT_BUFFER_GEN1_U_output_pipe_PIPE_present_state_FSM_FFd1_1269,
      O => IB_UP_SRC_RDY_N
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001 : MUXF7
    port map (
      I0 => N803,
      I1 => N804,
      S => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_DROP,
      O => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_289
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_F : LUT6
    generic map(
      INIT => X"FFFF0020FFFF0070"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246,
      I2 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ,
      I3 => N195,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      O => N803
    );
  IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_endpoint_addr_dec_req_buf_OUT_REQ_not0001_G : LUT6
    generic map(
      INIT => X"FFFF0002FFFF0007"
    )
    port map (
      I0 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_cnt_addr_0_0_112,
      I1 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_1_246,
      I2 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd2_317,
      I3 => IB_ENDPOINT_I_U_down_buf_U_down_fsm_present_state_FSM_FFd1_315,
      I4 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_addr_next,
      I5 => IB_ENDPOINT_I_U_down_buf_ADDRESS_DECODER_GEN_YES_U_addr_dec_U_ib_buffer_sh_U_ib_buffer_sh_fifo_shreg_65_0_245,
      O => N804
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_1 : LUT6
    generic map(
      INIT => X"171D3515575D75D5"
    )
    port map (
      I0 => NlwRenamedSig_OI_RD_EOF,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I5 => NlwRenamedSig_OI_RD_SOF,
      O => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux(6)
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_2 : LUT6
    generic map(
      INIT => X"06601881FFFFFFFF"
    )
    port map (
      I0 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_5,
      I1 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(1),
      I2 => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(2),
      I3 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_6,
      I4 => NlwRenamedSig_OI_IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_length_0_4,
      I5 => NlwRenamedSig_OI_RD_EOF,
      O => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_1_700
    );
  IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_f7 : MUXF7
    port map (
      I0 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux_6_1_700,
      I1 => IB_ENDPOINT_I_U_read_ctrl_BE_GEN_YES_U_be_gen_be_mux(6),
      S => IB_ENDPOINT_I_U_read_ctrl_U_unpacker_reg_addr64(0),
      O => RD_BE(6)
    );

end STRUCTURE;

