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

-- testbench.vhd: Testbench for the Application entity
-- Copyright (C) 2009 CESNET
-- Author(s): Viktor Pus <pus@liberouter.cz>
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
-- $Id: testbench.vhd 12037 2011-04-15 13:17:09Z kastovsky $
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
use work.ib_pkg.all;
use work.ib_bfm_pkg.all;
use work.mi_bfm_pkg.all;
use work.fl_bfm_pkg.all;
use work.fl_bfm_rdy_pkg.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity testbench is
end entity testbench;
-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of testbench is

   constant MEMORY_BASE_ADDR  : std_logic_vector(63 downto 0) := X"0000000000000000";
   constant MEMORY_SIZE       : integer := 16#94000#;

   -- ----------------------------------------------------------------------
   -- CLOCKs and RESET
   -- ----------------------------------------------------------------------
   -- CLK:
   signal clk               : std_logic;
   -- reset
   signal reset             : std_logic;

   -- ----------------------------------------------------------------------
   -- Interconnection system
   -- ----------------------------------------------------------------------
   -- Internal Bus interface (Fast)
   signal ib_up_data        : std_logic_vector(63 downto 0);
   signal ib_up_sop_n       : std_logic;
   signal ib_up_eop_n       : std_logic;
   signal ib_up_src_rdy_n   : std_logic;
   signal ib_up_dst_rdy_n   : std_logic;
   signal ib_down_data      : std_logic_vector(63 downto 0);
   signal ib_down_sop_n     : std_logic;
   signal ib_down_eop_n     : std_logic;
   signal ib_down_src_rdy_n : std_logic;
   signal ib_down_dst_rdy_n : std_logic;

   -- MI32
   signal mi32_dwr         : std_logic_vector(31 downto 0);
   signal mi32_addr        : std_logic_vector(31 downto 0);
   signal mi32_rd          : std_logic;
   signal mi32_wr          : std_logic;
   signal mi32_be          : std_logic_vector(3 downto 0);
   signal mi32_drd         : std_logic_vector(31 downto 0);
   signal mi32_ardy        : std_logic;
   signal mi32_drdy        : std_logic;

   -- Timestamp for pacodag
   signal ts               : std_logic_vector(63 downto 0);
   signal ts_dv            : std_logic;
   signal ts_clk           : std_logic;

   -- ----------------------------------------------------------------------
   -- Experiment FrameLink interface signals
   -- ----------------------------------------------------------------------
   -- NETWORK -> APPLICATION
   signal network_rx0_data       : std_logic_vector(63 downto 0);
   signal network_rx0_drem       : std_logic_vector(2 downto 0);
   signal network_rx0_sof_n      : std_logic;
   signal network_rx0_eof_n      : std_logic;
   signal network_rx0_sop_n      : std_logic;
   signal network_rx0_eop_n      : std_logic;
   signal network_rx0_src_rdy_n  : std_logic;
   signal network_rx0_dst_rdy_n  : std_logic;

   signal network_rx1_data       : std_logic_vector(63 downto 0);
   signal network_rx1_drem       : std_logic_vector(2 downto 0);
   signal network_rx1_sof_n      : std_logic;
   signal network_rx1_eof_n      : std_logic;
   signal network_rx1_sop_n      : std_logic;
   signal network_rx1_eop_n      : std_logic;
   signal network_rx1_src_rdy_n  : std_logic;
   signal network_rx1_dst_rdy_n  : std_logic;

   -- APPLICATION -> NETWORK
   signal network_tx0_data       : std_logic_vector(63 downto 0);
   signal network_tx0_drem       : std_logic_vector(2 downto 0);
   signal network_tx0_sof_n      : std_logic;
   signal network_tx0_eof_n      : std_logic;
   signal network_tx0_sop_n      : std_logic;
   signal network_tx0_eop_n      : std_logic;
   signal network_tx0_src_rdy_n  : std_logic;
   signal network_tx0_dst_rdy_n  : std_logic;

   signal network_tx1_data       : std_logic_vector(63 downto 0);
   signal network_tx1_drem       : std_logic_vector(2 downto 0);
   signal network_tx1_sof_n      : std_logic;
   signal network_tx1_eof_n      : std_logic;
   signal network_tx1_sop_n      : std_logic;
   signal network_tx1_eop_n      : std_logic;
   signal network_tx1_src_rdy_n  : std_logic;
   signal network_tx1_dst_rdy_n  : std_logic;

   -- DMA interface
   -- APPLICATION -> DMA 
   signal dma_rx0_data       : std_logic_vector(63 downto 0);
   signal dma_rx0_drem       : std_logic_vector(2 downto 0);
   signal dma_rx0_sof_n      : std_logic;
   signal dma_rx0_eof_n      : std_logic;
   signal dma_rx0_sop_n      : std_logic;
   signal dma_rx0_eop_n      : std_logic;
   signal dma_rx0_src_rdy_n  : std_logic;
   signal dma_rx0_dst_rdy_n  : std_logic;

   signal dma_rx1_data       : std_logic_vector(63 downto 0);
   signal dma_rx1_drem       : std_logic_vector(2 downto 0);
   signal dma_rx1_sof_n      : std_logic;
   signal dma_rx1_eof_n      : std_logic;
   signal dma_rx1_sop_n      : std_logic;
   signal dma_rx1_eop_n      : std_logic;
   signal dma_rx1_src_rdy_n  : std_logic;
   signal dma_rx1_dst_rdy_n  : std_logic;

   -- DMA -> APPLICATION
   signal dma_tx0_data       : std_logic_vector(63 downto 0);
   signal dma_tx0_drem       : std_logic_vector(2 downto 0);
   signal dma_tx0_sof_n      : std_logic;
   signal dma_tx0_eof_n      : std_logic;
   signal dma_tx0_sop_n      : std_logic;
   signal dma_tx0_eop_n      : std_logic;
   signal dma_tx0_src_rdy_n  : std_logic;
   signal dma_tx0_dst_rdy_n  : std_logic;

   signal dma_tx1_data       : std_logic_vector(63 downto 0);
   signal dma_tx1_drem       : std_logic_vector(2 downto 0);
   signal dma_tx1_sof_n      : std_logic;
   signal dma_tx1_eof_n      : std_logic;
   signal dma_tx1_sop_n      : std_logic;
   signal dma_tx1_eop_n      : std_logic;
   signal dma_tx1_src_rdy_n  : std_logic;
   signal dma_tx1_dst_rdy_n  : std_logic;

   -- ----------------------------------------------------------------------
   -- Time constants
   -- ----------------------------------------------------------------------
   constant clkper         : time := 8 ns;
   constant reset_time     : time := 10*clkper;

-- ----------------------------------------------------------------------------
--                      Architecture body
-- ----------------------------------------------------------------------------
begin

UUT : entity work.application
port map(
   CLK            => clk,
   RESET          => reset,

   -- network interface
   -- NETWORK -> APPLICATION
   IBUF0_TX_DATA       => network_rx0_data,
   IBUF0_TX_REM        => network_rx0_drem,
   IBUF0_TX_SOF_N      => network_rx0_sof_n,
   IBUF0_TX_EOF_N      => network_rx0_eof_n,
   IBUF0_TX_SOP_N      => network_rx0_sop_n,
   IBUF0_TX_EOP_N      => network_rx0_eop_n,
   IBUF0_TX_SRC_RDY_N  => network_rx0_src_rdy_n,
   IBUF0_TX_DST_RDY_N  => network_rx0_dst_rdy_n,
                                                  
   IBUF1_TX_DATA       => network_rx1_data,
   IBUF1_TX_REM        => network_rx1_drem,
   IBUF1_TX_SOF_N      => network_rx1_sof_n,
   IBUF1_TX_EOF_N      => network_rx1_eof_n,
   IBUF1_TX_SOP_N      => network_rx1_sop_n,
   IBUF1_TX_EOP_N      => network_rx1_eop_n,
   IBUF1_TX_SRC_RDY_N  => network_rx1_src_rdy_n,
   IBUF1_TX_DST_RDY_N  => network_rx1_dst_rdy_n,

   -- APPLICATION -> NETWORK
   OBUF0_RX_DATA       => network_tx0_data,
   OBUF0_RX_REM        => network_tx0_drem,
   OBUF0_RX_SOF_N      => network_tx0_sof_n,
   OBUF0_RX_EOF_N      => network_tx0_eof_n,
   OBUF0_RX_SOP_N      => network_tx0_sop_n,
   OBUF0_RX_EOP_N      => network_tx0_eop_n,
   OBUF0_RX_SRC_RDY_N  => network_tx0_src_rdy_n,
   OBUF0_RX_DST_RDY_N  => network_tx0_dst_rdy_n,
                                                  
   OBUF1_RX_DATA       => network_tx1_data,
   OBUF1_RX_REM        => network_tx1_drem,
   OBUF1_RX_SOF_N      => network_tx1_sof_n,
   OBUF1_RX_EOF_N      => network_tx1_eof_n,
   OBUF1_RX_SOP_N      => network_tx1_sop_n,
   OBUF1_RX_EOP_N      => network_tx1_eop_n,
   OBUF1_RX_SRC_RDY_N  => network_tx1_src_rdy_n,
   OBUF1_RX_DST_RDY_N  => network_tx1_dst_rdy_n,

   -- DMA interface
   -- APPLICATION -> DMA 
   RX0_DATA          => dma_tx0_data,
   RX0_DREM          => dma_tx0_drem,
   RX0_SOF_N         => dma_tx0_sof_n,
   RX0_EOF_N         => dma_tx0_eof_n,
   RX0_SOP_N         => dma_tx0_sop_n,
   RX0_EOP_N         => dma_tx0_eop_n,
   RX0_SRC_RDY_N     => dma_tx0_src_rdy_n,
   RX0_DST_RDY_N     => dma_tx0_dst_rdy_n,
                                      
   RX1_DATA          => dma_tx1_data,
   RX1_DREM          => dma_tx1_drem,
   RX1_SOF_N         => dma_tx1_sof_n,
   RX1_EOF_N         => dma_tx1_eof_n,
   RX1_SOP_N         => dma_tx1_sop_n,
   RX1_EOP_N         => dma_tx1_eop_n,
   RX1_SRC_RDY_N     => dma_tx1_src_rdy_n,
   RX1_DST_RDY_N     => dma_tx1_dst_rdy_n,

   -- DMA -> APPLICATION
   TX0_DATA          => dma_rx0_data,
   TX0_DREM          => dma_rx0_drem,
   TX0_SOF_N         => dma_rx0_sof_n,
   TX0_EOF_N         => dma_rx0_eof_n,
   TX0_SOP_N         => dma_rx0_sop_n,
   TX0_EOP_N         => dma_rx0_eop_n,
   TX0_SRC_RDY_N     => dma_rx0_src_rdy_n,
   TX0_DST_RDY_N     => dma_rx0_dst_rdy_n,
                                      
   TX1_DATA          => dma_rx1_data,
   TX1_DREM          => dma_rx1_drem,
   TX1_SOF_N         => dma_rx1_sof_n,
   TX1_EOF_N         => dma_rx1_eof_n,
   TX1_SOP_N         => dma_rx1_sop_n,
   TX1_EOP_N         => dma_rx1_eop_n,
   TX1_SRC_RDY_N     => dma_rx1_src_rdy_n,
   TX1_DST_RDY_N     => dma_rx1_dst_rdy_n,

   -- internal bus
   IB_DOWN_DATA      => ib_down_data,
   IB_DOWN_SOF_N     => ib_down_sop_n,
   IB_DOWN_EOF_N     => ib_down_eop_n,
   IB_DOWN_SRC_RDY_N => ib_down_src_rdy_n,
   IB_DOWN_DST_RDY_N => ib_down_dst_rdy_n,
   IB_UP_DATA        => ib_up_data,
   IB_UP_SOF_N       => ib_up_sop_n,
   IB_UP_EOF_N       => ib_up_eop_n,
   IB_UP_SRC_RDY_N   => ib_up_src_rdy_n,
   IB_UP_DST_RDY_N   => ib_up_dst_rdy_n,
   
   -- mi32 bus
   MI32_DWR          => mi32_dwr,
   MI32_ADDR         => mi32_addr,
   MI32_RD           => mi32_rd,
   MI32_WR           => mi32_wr,
   MI32_BE           => mi32_be,
   MI32_DRD          => mi32_drd,
   MI32_ARDY         => mi32_ardy,
   MI32_DRDY         => mi32_drdy,

   -- Timestamps for pacodag
   TS             => ts,
   TS_DV          => ts_dv,
   TS_CLK         => ts_clk,

   -- PACODAG interface (no simulation model available)
   IBUF0_CTRL_CLK          => clk,
   IBUF0_CTRL_DATA         => open,
   IBUF0_CTRL_REM          => open,
   IBUF0_CTRL_SRC_RDY_N    => open,
   IBUF0_CTRL_SOP_N        => open,
   IBUF0_CTRL_EOP_N        => open,
   IBUF0_CTRL_DST_RDY_N    => '0',
   IBUF0_CTRL_RDY          => open,

   IBUF1_CTRL_CLK          => clk,
   IBUF1_CTRL_DATA         => open,
   IBUF1_CTRL_REM          => open,
   IBUF1_CTRL_SRC_RDY_N    => open,
   IBUF1_CTRL_SOP_N        => open,
   IBUF1_CTRL_EOP_N        => open,
   IBUF1_CTRL_DST_RDY_N    => '0',
   IBUF1_CTRL_RDY          => open,

   -- IBUF status interface (no status information available)
   IBUF0_SOP               => '0',
   IBUF0_PAYLOAD_LEN       => X"0100",
   IBUF0_FRAME_ERROR       => '0',
   IBUF0_CRC_CHECK_FAILED  => '0',
   IBUF0_MAC_CHECK_FAILED  => '0',
   IBUF0_LEN_BELOW_MIN     => '0',
   IBUF0_LEN_OVER_MTU      => '0',
   IBUF0_STAT_DV           => '1',

   IBUF1_SOP               => '0',
   IBUF1_PAYLOAD_LEN       => X"0100",
   IBUF1_FRAME_ERROR       => '0',
   IBUF1_CRC_CHECK_FAILED  => '0',
   IBUF1_MAC_CHECK_FAILED  => '0',
   IBUF1_LEN_BELOW_MIN     => '0',
   IBUF1_LEN_OVER_MTU      => '0',
   IBUF1_STAT_DV           => '1'
);

-- CLK generator
clk_gen_p: process
begin
   clk  <= '1';
   wait for clkper/2;
   clk  <= '0';
   wait for clkper/2;
end process;

-- Internal Bus simulation component

IB_BFM_I : entity work.IB_BFM
generic map(
    MEMORY_BASE_ADDR    => MEMORY_BASE_ADDR,
    MEMORY_SIZE         => MEMORY_SIZE
)
port map(
   -- Common interface
   CLK               => clk,

   -- Internal Bus Interface
   IB_DOWN_DATA      => ib_down_data,
   IB_DOWN_SOF_N     => ib_down_sop_n,
   IB_DOWN_EOF_N     => ib_down_eop_n,
   IB_DOWN_SRC_RDY_N => ib_down_src_rdy_n,
   IB_DOWN_DST_RDY_N => ib_down_dst_rdy_n,
   IB_UP_DATA        => ib_up_data,
   IB_UP_SOF_N       => ib_up_sop_n,
   IB_UP_EOF_N       => ib_up_eop_n,
   IB_UP_SRC_RDY_N   => ib_up_src_rdy_n,
   IB_UP_DST_RDY_N   => ib_up_dst_rdy_n
);

-- MI32 Bus simulation component
MI_BFM_I : entity work.MI_BFM
port map (
   CLK => clk,
   RESET => reset,

   MI32_DWR => mi32_dwr,
   MI32_ADDR => mi32_addr,
   MI32_BE => mi32_be,
   MI32_RD => mi32_rd,
   MI32_WR => mi32_wr,
   MI32_ARDY => mi32_ardy,
   MI32_DRD => mi32_drd,
   MI32_DRDY => mi32_drdy
);

-- FrameLink simulation component
FL_BFM_NET_RX0 : entity work.FL_BFM
generic map (
   DATA_WIDTH  => 64,
   FL_BFM_ID   => 0)
port map (
   -- Common interface
   RESET       => reset,
   CLK         => clk,
   TX_DATA     => network_rx0_data,
   TX_REM      => network_rx0_drem,
   TX_SOF_N    => network_rx0_sof_n,
   TX_EOF_N    => network_rx0_eof_n,
   TX_SOP_N    => network_rx0_sop_n,
   TX_EOP_N    => network_rx0_eop_n,
   TX_SRC_RDY_N=> network_rx0_src_rdy_n,
   TX_DST_RDY_N=> network_rx0_dst_rdy_n);

-- FrameLink simulation component
FL_BFM_NET_RX1 : entity work.FL_BFM
generic map (
   DATA_WIDTH  => 64,
   FL_BFM_ID   => 1)
port map (
   -- Common interface
   RESET       => reset,
   CLK         => clk,
   TX_DATA     => network_rx1_data,
   TX_REM      => network_rx1_drem,
   TX_SOF_N    => network_rx1_sof_n,
   TX_EOF_N    => network_rx1_eof_n,
   TX_SOP_N    => network_rx1_sop_n,
   TX_EOP_N    => network_rx1_eop_n,
   TX_SRC_RDY_N=> network_rx1_src_rdy_n,
   TX_DST_RDY_N=> network_rx1_dst_rdy_n);

-- FrameLink simulation component
FL_BFM_DMA_TX0 : entity work.FL_BFM
generic map (
   DATA_WIDTH  => 64,
   FL_BFM_ID   => 2)
port map (
   -- Common interface
   RESET       => reset,
   CLK         => clk,
   TX_DATA     => dma_tx0_data,
   TX_REM      => dma_tx0_drem,
   TX_SOF_N    => dma_tx0_sof_n,
   TX_EOF_N    => dma_tx0_eof_n,
   TX_SOP_N    => dma_tx0_sop_n,
   TX_EOP_N    => dma_tx0_eop_n,
   TX_SRC_RDY_N=> dma_tx0_src_rdy_n,
   TX_DST_RDY_N=> dma_tx0_dst_rdy_n);

-- FrameLink simulation component
FL_BFM_DMA_TX1 : entity work.FL_BFM
generic map (
   DATA_WIDTH  => 64,
   FL_BFM_ID   => 3)
port map (
   -- Common interface
   RESET       => reset,
   CLK         => clk,
   TX_DATA     => dma_tx1_data,
   TX_REM      => dma_tx1_drem,
   TX_SOF_N    => dma_tx1_sof_n,
   TX_EOF_N    => dma_tx1_eof_n,
   TX_SOP_N    => dma_tx1_sop_n,
   TX_EOP_N    => dma_tx1_eop_n,
   TX_SRC_RDY_N=> dma_tx1_src_rdy_n,
   TX_DST_RDY_N=> dma_tx1_dst_rdy_n);

-----------------------------------------------------------------------------
-- Main testbench process
-----------------------------------------------------------------------------
tb : process

variable mi32_data : std_logic_vector(31 downto 0);

begin
   -- Set Destination Ready signals to active
   dma_rx0_dst_rdy_n <= '0';
   dma_rx1_dst_rdy_n <= '0';
   network_tx0_dst_rdy_n <= '0';
   network_tx1_dst_rdy_n <= '0';

   -- Reset the design
   reset <= '1';
   wait for reset_time;
   reset <= '0';

   wait for 5*clkper;

   IBLocalWrite(X"02300000", -- DST Addr
                X"FFFFFFF0", -- SRC Addr
                8,           -- Length (Bytes)
                220,         -- Tag
                X"FEDCBA9876543210", -- Data
                IbCmd);      -- Command record

   wait for 5*clkper;

   IBLocalWrite(X"02300008", -- DST Addr
                X"FFFFFFF0", -- SRC Addr
                8,           -- Length (Bytes)
                220,         -- Tag
                X"1111222233334444", -- Data
                IbCmd);      -- Command record

   wait for 5*clkper;

   IBLocalRead( X"02300000", -- SRC Addr
                X"FFFFFFF0", -- DST Addr
                16,           -- Length (Bytes)
                220,         -- Tag
                IbCmd);      -- Command record

   wait for 5*clkper;

   -- Recieve ICMP packet from network interface 0
   FLWriteFile("./packets/icmp_net0.txt", EVER, flCmd_0, 0);

   -- Recieve ICMP packet from network interface 1
   FLWriteFile("./packets/icmp_net1.txt", EVER, flCmd_1, 1);

   -- Dma module sending ICMP packet to interface 0, toggling SRC_RDY_N
   FLWriteFile("./packets/icmp_dma.txt", ONOFF, flCmd_2, 2);

   -- Dma module sending ICMP packet to interface 1, random SRC_RDY_N
   FLWriteFile("./packets/icmp_dma.txt", RND, flCmd_3, 3);


   -- Write 4 bytes through MI32 Bus
   MI32Write(X"00080000",  -- address
             X"01234567",  -- data
             "1111",       -- byte enables
             status);

   wait for 5*clkper;

   -- Read 4 bytes through MI32 Bus
   MI32Read(X"00080000",   -- address
            mi32_data,     -- output data
            "1111",        -- byte enables
            status);

   wait for 5*clkper;

   -- Read 4 bytes through MI32 Bus
   MI32Read(X"00080800",   -- address
            mi32_data,     -- output data
            "1111",        -- byte enables
            status);

   wait for 5*clkper;

   -- Read 4 bytes through MI32 Bus
   MI32Read(X"00080804",   -- address
            mi32_data,     -- output data
            "1111",        -- byte enables
            status);

   wait;
end process;

end architecture;
