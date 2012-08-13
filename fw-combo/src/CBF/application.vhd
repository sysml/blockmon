-- ----------------------------------------------------------------------------
--                            modified by sal 
-- ----------------------------------------------------------------------------
-- application.vhd : Combov2 NetCOPE application module
-- Copyright (C) 2009 CESNET
-- Author(s): Jan Stourac <xstour03@stud.fit.vutbr.cz>
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
-- $Id$
--

-- ----------------------------------------------------------------------------
--                             Entity declaration
-- ----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 
use work.combov2_core_const.all;
use work.combov2_user_const.all;
use work.math_pack.all;
use work.ibuf_general_pkg.all;
use work.addr_space.all;
use work.network_mod_10g2_64_const.all;
use work.utils.all;
Library UNISIM;
use UNISIM.vcomponents.all;

architecture full of APPLICATION is

   component tsu_async is
   -- PORTS
   port (
      RESET          : in std_logic;

      -- Input interface
      IN_CLK         : in std_logic;

      IN_TS          : in std_logic_vector(63 downto 0);
      IN_TS_DV       : in std_logic;

      -- Output interface
      OUT_CLK        : in std_logic;

      OUT_TS         : out std_logic_vector(63 downto 0);
      OUT_TS_DV      : out std_logic
   );
   end component tsu_async;

component GICS_IB_ENDPOINT_SYNTH 
   port(
      -- Common interface -----------------------------------------------------
      CLK               : in std_logic;  
      RESET             : in std_logic;  

      -- IB Interface ---------------------------------------------------------
      IB_DOWN_DATA      : in  std_logic_vector(63 downto 0);
      IB_DOWN_SOF_N     : in  std_logic;
      IB_DOWN_EOF_N     : in  std_logic;
      IB_DOWN_SRC_RDY_N : in  std_logic;
      IB_DOWN_DST_RDY_N : out std_logic;

      IB_UP_DATA        : out std_logic_vector(63 downto 0);
      IB_UP_SOF_N       : out std_logic;
      IB_UP_EOF_N       : out std_logic;
      IB_UP_SRC_RDY_N   : out std_logic;
      IB_UP_DST_RDY_N   : in  std_logic;      

      -- Write Interface ------------------------------------------------------
      WR_REQ            : out std_logic;                           
      WR_RDY            : in  std_logic;                                 
      WR_DATA           : out std_logic_vector(63 downto 0);
      WR_ADDR           : out std_logic_vector(31 downto 0);       
      WR_BE             : out std_logic_vector(7 downto 0);        
      WR_LENGTH         : out std_logic_vector(11 downto 0);       
      WR_SOF            : out std_logic;                           
      WR_EOF            : out std_logic;

      -- Read Interface -------------------------------------------------------
      RD_REQ            : out std_logic;                           
      RD_ARDY_ACCEPT    : in  std_logic;                           
      RD_ADDR           : out std_logic_vector(31 downto 0);        
      RD_BE             : out std_logic_vector(7 downto 0);       
      RD_LENGTH         : out std_logic_vector(11 downto 0);       
      RD_SOF            : out std_logic;                           
      RD_EOF            : out std_logic;                    

      RD_DATA           : in  std_logic_vector(63 downto 0); 
      RD_SRC_RDY        : in  std_logic;                           
      RD_DST_RDY        : out std_logic;

      -- Bus Master Interface -------------------------------------------------
      BM_DATA           : in  std_logic_vector(63 downto 0);
      BM_SOF_N          : in  std_logic;
      BM_EOF_N          : in  std_logic;
      BM_SRC_RDY_N      : in  std_logic;
      BM_DST_RDY_N      : out std_logic;

      BM_TAG            : out std_logic_vector(7 downto 0);
      BM_TAG_VLD        : out std_logic
  );
end component;

-- ----------------------------------------------------------------------------
--                            Signal declaration
-- ----------------------------------------------------------------------------

   -- Signals Internal Bus Endpoint signals
   signal ibep_wr_req         : std_logic;
   signal ibep_rd_req         : std_logic;
   signal reg_ibep_rd_req     : std_logic;
   signal ibep_rd_dst_rdy     : std_logic;

   signal ibep_dwr            : std_logic_vector(63 downto 0);
   signal ibep_wr_be          : std_logic_vector(7 downto 0);
   signal ibep_wraddr         : std_logic_vector(31 downto 0);
   signal ibep_rdaddr         : std_logic_vector(31 downto 0);
   signal ibep_wr             : std_logic;
   signal ibep_rd             : std_logic;
   signal ibep_drd            : std_logic_vector(63 downto 0);
   signal ibep_ack            : std_logic;

   signal reg_ibep_drdy       : std_logic;
   -- -------------------------------------------------------------------------
   --                         Pacodag signals
   -- -------------------------------------------------------------------------
   signal ts0_sync               : std_logic_vector(63 downto 0);
   signal ts0_dv_sync            : std_logic;
   signal ts1_sync               : std_logic_vector(63 downto 0);
   signal ts1_dv_sync            : std_logic;


   -- -------------------------------------------------------------------------
   -- -------------------------------------------------------------------------
   -- -------------------------------------------------------------------------
   -- inizio codice sal
   -- -------------------------------------------------------------------------
   -- -------------------------------------------------------------------------
   -- -------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
--                            Signal declaration
-- ----------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------
	-- signals for FSM  FrameLink decoding 
	-- ----------------------------------------------------------------------------
	type fsm_states is (WAIT_FOR_FRAME, FRAME_HEADER, SRC_MAC_ADDRESS, DST_MAC_ADDRESS, IP1, IP2, IP3, DATA);
	signal curr_state, next_state : fsm_states;
	signal step: boolean;
	
	-- ----------------------------------------------------------------------------
	-- signals for packet classification 
	-- ----------------------------------------------------------------------------
	signal is_IP,is_UDP,is_TCP: boolean;
	signal src_mac,dst_mac: std_logic_vector(47 downto 0);
	signal exchange: std_logic_vector(63 downto 0);
	signal src_ip,dst_ip: std_logic_vector(31 downto 0);
	signal src_port,dst_port: std_logic_vector(15 downto 0);
	
	-- ----------------------------------------------------------------------------
	-- stats  
	-- ----------------------------------------------------------------------------
	signal ip_count,tcp_count,udp_count:std_logic_vector(31 downto 0);

	-- ----------------------------------------------------------------------------
	-- signals for CBF 
	-- ----------------------------------------------------------------------------
	
	signal	max_sip  : STD_LOGIC_VECTOR(31 downto 0); -- SRC IP of the last flow over the threshold
	signal	max_dip  : STD_LOGIC_VECTOR(31 downto 0); -- DST IP of the last flow over the threshold
	signal	max_port : STD_LOGIC_VECTOR(31 downto 0); -- SRC & DST PORT of the last flow over the threshold
	signal	max_count : STD_LOGIC_VECTOR(31 downto 0); -- SRC & DST PORT of the last flow over the threshold
	signal	osip  : STD_LOGIC_VECTOR(31 downto 0); -- SRC IP of the last flow over the threshold
	signal	odip  : STD_LOGIC_VECTOR(31 downto 0); -- DST IP of the last flow over the threshold
	signal	oport : STD_LOGIC_VECTOR(31 downto 0); -- SRC & DST PORT of the last flow over the threshold
	signal decrement,dump,start_CBF:std_logic;
	signal TIMEDEC,Threshold: std_logic_vector(31 downto 0);
	signal Data_CBF_dump: std_logic_vector(31 downto 0);
	signal counter_item: std_logic_vector(31 downto 0);
	signal counter_overflow: std_logic_vector(31 downto 0);
	
	
	-- ----------------------------------------------------------------------------
	-- signals for MI32 BUS 
	-- ----------------------------------------------------------------------------
	signal MI32_RD_d		: std_logic;
        signal int_mi32_addr            : std_logic_vector(31 downto 0);

-- ----------------------------------------------------------------------------
--                             Architecture body
-- ----------------------------------------------------------------------------
begin

   -- -------------------------------------------------------------------------
   --                             FrameLink
   -- -------------------------------------------------------------------------
   -- DMA -> NET
   OBUF0_RX_DATA     <= RX0_DATA;
   OBUF0_RX_REM      <= RX0_DREM;
   OBUF0_RX_SOF_N    <= RX0_SOF_N;
   OBUF0_RX_EOF_N    <= RX0_EOF_N;
   OBUF0_RX_SOP_N    <= RX0_SOP_N;
   OBUF0_RX_EOP_N    <= RX0_EOP_N;
   OBUF0_RX_SRC_RDY_N<= RX0_SRC_RDY_N;
   RX0_DST_RDY_N     <= OBUF0_RX_DST_RDY_N;

   OBUF1_RX_DATA     <= RX1_DATA;
   OBUF1_RX_REM      <= RX1_DREM;
   OBUF1_RX_SOF_N    <= RX1_SOF_N;
   OBUF1_RX_EOF_N    <= RX1_EOF_N;
   OBUF1_RX_SOP_N    <= RX1_SOP_N;
   OBUF1_RX_EOP_N    <= RX1_EOP_N;
   OBUF1_RX_SRC_RDY_N<= RX1_SRC_RDY_N;
   RX1_DST_RDY_N     <= OBUF1_RX_DST_RDY_N;

   -- NET -> DMA
   TX0_DATA          <= IBUF0_TX_DATA;
   TX0_DREM          <= IBUF0_TX_REM;
   TX0_SOF_N         <= IBUF0_TX_SOF_N;
   TX0_EOF_N         <= IBUF0_TX_EOF_N;
   TX0_SOP_N         <= IBUF0_TX_SOP_N;
   TX0_EOP_N         <= IBUF0_TX_EOP_N;
   TX0_SRC_RDY_N     <= IBUF0_TX_SRC_RDY_N;
   IBUF0_TX_DST_RDY_N<= TX0_DST_RDY_N;

   TX1_DATA          <= IBUF1_TX_DATA;
   TX1_DREM          <= IBUF1_TX_REM;
   TX1_SOF_N         <= IBUF1_TX_SOF_N;
   TX1_EOF_N         <= IBUF1_TX_EOF_N;
   TX1_SOP_N         <= IBUF1_TX_SOP_N;
   TX1_EOP_N         <= IBUF1_TX_EOP_N;
   TX1_SRC_RDY_N     <= IBUF1_TX_SRC_RDY_N;
   IBUF1_TX_DST_RDY_N<= TX1_DST_RDY_N;


   -- -------------------------------------------------------------------------
   --                            Internal Bus
   -- -------------------------------------------------------------------------
   IB_ENDPOINT_I : GICS_IB_ENDPOINT_SYNTH
   port map(
      -- Common Interface
      CLK        => CLK,
      RESET      => RESET,

      -- Internal Bus Interface
      IB_DOWN_DATA        => IB_DOWN_DATA,
      IB_DOWN_SOF_N       => IB_DOWN_SOF_N,
      IB_DOWN_EOF_N       => IB_DOWN_EOF_N,
      IB_DOWN_SRC_RDY_N   => IB_DOWN_SRC_RDY_N,
      IB_DOWN_DST_RDY_N   => IB_DOWN_DST_RDY_N,
      IB_UP_DATA          => IB_UP_DATA,
      IB_UP_SOF_N         => IB_UP_SOF_N,
      IB_UP_EOF_N         => IB_UP_EOF_N,
      IB_UP_SRC_RDY_N     => IB_UP_SRC_RDY_N,
      IB_UP_DST_RDY_N     => IB_UP_DST_RDY_N,

      -- Write Interface
      WR_REQ        => ibep_wr_req,
      WR_RDY        => ibep_wr_req,
      WR_DATA       => ibep_dwr,
      WR_ADDR       => ibep_wraddr,
      WR_BE         => ibep_wr_be,
      WR_LENGTH     => open,
      WR_SOF        => open,
      WR_EOF        => open,

      -- Read Interface
      RD_REQ           => ibep_rd_req,
      RD_ARDY_ACCEPT   => ibep_rd_dst_rdy,
      RD_ADDR          => ibep_rdaddr,
      RD_BE            => open,
      RD_LENGTH        => open,
      RD_SOF           => open,
      RD_EOF           => open,
      RD_DATA          => ibep_drd,
      RD_SRC_RDY       => reg_ibep_rd_req,
      RD_DST_RDY       => ibep_rd_dst_rdy,

      -- Bus Master Interface
      BM_DATA          => X"0000000000000000",
      BM_SOF_N         => '1',
      BM_EOF_N         => '1',
      BM_SRC_RDY_N     => '1',
      BM_DST_RDY_N     => open,
      BM_TAG           => open,
      BM_TAG_VLD       => open
   );

   RAMB18SDP_inst0 : RAMB18SDP
   generic map (
      DO_REG   => 0,            -- Optional output register (0 or 1)
      INIT     => X"000000000", --  Initial values on output port
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      SRVAL    => X"000000000"  --  Set/Reset value for port output
      )
   port map (
      DO       => ibep_drd(31 downto 0),  -- 32-bit Data Output
      DOP      => open,                   -- 4-bit  Parity Output
      RDCLK    => CLK,                    -- 1-bit read port clock
      RDEN     => ibep_rd_req,            -- 1-bit read port enable
      REGCE    => '1',                    -- 1-bit register enable input
      SSR      => '0',              -- 1-bit synchronous output set/reset input
      WRCLK    => CLK,                    -- 1-bit write port clock
      WREN     => ibep_wr_req,            -- 1-bit write port enable
      WRADDR   => ibep_wraddr(10 downto 2),-- 9-bit write port address input
      RDADDR   => ibep_rdaddr(10 downto 2),-- 9-bit read port address input
      DI       => ibep_dwr(31 downto 0),  -- 32-bit data input
      DIP      => "0000",                 -- 4-bit parity data input
      WE       => ibep_wr_be(3 downto 0)  -- 4-bit write enable input
   );

   RAMB18SDP_inst1 : RAMB18SDP
   generic map (
      DO_REG   => 0,             -- Optional output register (0 or 1)
      INIT     => X"000000000",  --  Initial values on output port
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      SRVAL    => X"000000000"   --  Set/Reset value for port output
      )
   port map (
      DO       => ibep_drd(63 downto 32), -- 32-bit Data Output
      DOP      => open,                   -- 4-bit  Parity Output
      RDCLK    => CLK,                    -- 1-bit read port clock
      RDEN     => ibep_rd_req,            -- 1-bit read port enable
      REGCE    => '1',                    -- 1-bit register enable input
      SSR      => '0',              -- 1-bit synchronous output set/reset input
      WRCLK    => CLK,                    -- 1-bit write port clock
      WREN     => ibep_wr_req,            -- 1-bit write port enable
      WRADDR   => ibep_wraddr(10 downto 2),-- 9-bit write port address input
      RDADDR   => ibep_rdaddr(10 downto 2),-- 9-bit read port address input
      DI       => ibep_dwr(63 downto 32), -- 32-bit data input
      DIP      => "0000",                 -- 4-bit parity data input
      WE       => ibep_wr_be(7 downto 4)  -- 4-bit write enable input
   );
   
   -- Delay read request and use it as acknowledge of read data
   reg_ibep_rd_req_p : process(CLK)
   begin
      if CLK'event and CLK = '1' then
         reg_ibep_rd_req <= ibep_rd_req;
      end if;
   end process;


   -- -------------------------------------------------------------------------
   --                              PACODAG
   -- -------------------------------------------------------------------------
   PACODAG_TOP_I: entity work.pacodag_tsu_top2_t64
   generic map(
      HEADER_EN => PACODAG_HEADER_EN,
      FOOTER_EN => PACODAG_FOOTER_EN
   )
   port map(
      -- Common interface
      RESET    => RESET,
      -- IBUF interface
      PCD0_CTRL_CLK              => IBUF0_CTRL_CLK,
      PCD0_CTRL_DATA             => IBUF0_CTRL_DATA,
      PCD0_CTRL_REM              => IBUF0_CTRL_REM,
      PCD0_CTRL_SRC_RDY_N        => IBUF0_CTRL_SRC_RDY_N,
      PCD0_CTRL_SOP_N            => IBUF0_CTRL_SOP_N,
      PCD0_CTRL_EOP_N            => IBUF0_CTRL_EOP_N,
      PCD0_CTRL_DST_RDY_N        => IBUF0_CTRL_DST_RDY_N,
      PCD0_CTRL_RDY              => IBUF0_CTRL_RDY,
      PCD0_SOP                   => IBUF0_SOP,
      PCD0_STAT_PAYLOAD_LEN      => IBUF0_PAYLOAD_LEN,
      PCD0_STAT_FRAME_ERROR      => IBUF0_FRAME_ERROR,
      PCD0_STAT_CRC_CHECK_FAILED => IBUF0_CRC_CHECK_FAILED,
      PCD0_STAT_MAC_CHECK_FAILED => IBUF0_MAC_CHECK_FAILED,
      PCD0_STAT_LEN_BELOW_MIN    => IBUF0_LEN_BELOW_MIN,
      PCD0_STAT_LEN_OVER_MTU     => IBUF0_LEN_OVER_MTU,
      PCD0_STAT_DV               => IBUF0_STAT_DV,

      PCD1_CTRL_CLK              => IBUF1_CTRL_CLK,
      PCD1_CTRL_DATA             => IBUF1_CTRL_DATA,
      PCD1_CTRL_REM              => IBUF1_CTRL_REM,
      PCD1_CTRL_SRC_RDY_N        => IBUF1_CTRL_SRC_RDY_N,
      PCD1_CTRL_SOP_N            => IBUF1_CTRL_SOP_N,
      PCD1_CTRL_EOP_N            => IBUF1_CTRL_EOP_N,
      PCD1_CTRL_DST_RDY_N        => IBUF1_CTRL_DST_RDY_N,
      PCD1_CTRL_RDY              => IBUF1_CTRL_RDY,
      PCD1_SOP                   => IBUF1_SOP,
      PCD1_STAT_PAYLOAD_LEN      => IBUF1_PAYLOAD_LEN,
      PCD1_STAT_FRAME_ERROR      => IBUF1_FRAME_ERROR,
      PCD1_STAT_CRC_CHECK_FAILED => IBUF1_CRC_CHECK_FAILED,
      PCD1_STAT_MAC_CHECK_FAILED => IBUF1_MAC_CHECK_FAILED,
      PCD1_STAT_LEN_BELOW_MIN    => IBUF1_LEN_BELOW_MIN,
      PCD1_STAT_LEN_OVER_MTU     => IBUF1_LEN_OVER_MTU,
      PCD1_STAT_DV               => IBUF1_STAT_DV,

      TS0       => ts0_sync,
      TS0_DV    => ts0_dv_sync,
      TS1       => ts1_sync,
      TS1_DV    => ts1_dv_sync
   );

   -- ---------------------------------------------------------------
   -- Generate tsu_async only if timestamp unit is also generated
   ts_true_async : if TIMESTAMP_UNIT = true generate
   tsu_async_i0 : tsu_async
      -- PORTS
      port map (
         RESET          => RESET,
         -- Input interface
         IN_CLK         => TS_CLK,
         IN_TS          => TS,
         IN_TS_DV       => TS_DV,
         -- Output interface
         OUT_CLK        => IBUF0_CTRL_CLK,
         OUT_TS         => ts0_sync,
         OUT_TS_DV      => ts0_dv_sync
      );
      tsu_async_i1 : tsu_async
      -- PORTS
      port map (
         RESET          => RESET,
         -- Input interface
         IN_CLK         => TS_CLK,
         IN_TS          => TS,
         IN_TS_DV       => TS_DV,
         -- Output interface
         OUT_CLK        => IBUF1_CTRL_CLK,
         OUT_TS         => ts1_sync,
         OUT_TS_DV      => ts1_dv_sync
      );
   end generate ts_true_async;

   -- Else map TS and TS_DV signals directly into pacodag
   ts_false_async : if TIMESTAMP_UNIT = false generate
      ts0_sync <= TS;
      ts0_dv_sync <= TS_DV;
      ts1_sync <= TS;
      ts1_dv_sync <= TS_DV;
   end generate ts_false_async;


-- -------------------------------------------------------------------------
-- inizio codice sal
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- exchange from network order to little endian 
-- -------------------------------------------------------------------------
exchange(31 downto 0)<=IBUF0_TX_DATA(39 downto 32) & IBUF0_TX_DATA(47 downto 40) & IBUF0_TX_DATA(55 downto 48) & IBUF0_TX_DATA(63 downto 56); 
exchange(63 downto 32)<=IBUF0_TX_DATA(7 downto 0) & IBUF0_TX_DATA(15 downto 8) & IBUF0_TX_DATA(23 downto 16) & IBUF0_TX_DATA(31 downto 24); 
-- -------------------------------------------------------------------------
--
-- process to detect if the next word is available
--
-- -------------------------------------------------------------------------

step_assign: step<= true when (IBUF0_TX_SRC_RDY_N = '0') and (TX0_DST_RDY_N = '0') else false;

-- -------------------------------------------------------------------------
--
-- process for FrameLink FSM
-- extract Header ETH-IP-TCP/UDP
--
-- -------------------------------------------------------------------------

process(CLK, RESET)
	begin
	   if (CLK'event and CLK = '1') then
		  if (RESET = '1') then
		     curr_state <= WAIT_FOR_FRAME;
		     dst_mac <= (others => '0');
		     src_mac <= (others => '0');
		     src_ip <= (others => '0');
		     dst_ip <= (others => '0');
		     src_port <= (others => '0');
		     dst_port <= (others => '0');
		     start_CBF <='0';
		     ip_count<= (others => '0');
		     tcp_count<= (others => '0');
		     udp_count<= (others => '0');
		     is_ip<=false; 
		     is_UDP<=false;
		     is_TCP<=false;
		  else
		     curr_state <= next_state;
		     case curr_state is
		  	when WAIT_FOR_FRAME =>
			     dst_mac <= (others => '0');
			     src_mac <= (others => '0');
			     src_ip <= (others => '0');
			     dst_ip <= (others => '0');
			     src_port <= (others => '0');
			     dst_port <= (others => '0');
			     start_CBF <='0';
			     is_ip<=false;
	   	  	     is_UDP<=false;
			     is_TCP<=false;
			  when DST_MAC_ADDRESS =>
			     if (step) then
				 report "tx_data DST_MAC_ADDRESS STATE: " & hstr(exchange) & LF ; 
				 dst_mac <= exchange(47 downto 0);
				 src_mac(47 downto 32) <= exchange(63 downto 48);
			     end if;
			  when SRC_MAC_ADDRESS =>
			     if (step) then
				 src_mac(31 downto 0) <= exchange(31 downto 0);
				 report "tx_data SRC_MAC_ADDRESS STATE: " & hstr(exchange) & LF ; 
				 --report "tx_data:  " & integer'image(conv_integer() & LF ; 
				 if (exchange(31 downto 16)=x"0800") then
				 	ip_count <= ip_count+1;
					is_ip<=true;
				 end if;  
			     end if;
			  when IP1 =>
			      if (step) then
				 report "tx_data IP1 STATE: " & hstr(exchange) & LF ; 
			      	  if exchange(7 downto 0)=x"11" and is_ip then --FIXME does not check eth header lenght
				 	report "UDP packet" ; 
				 	udp_count <= udp_count+1;
				  	is_UDP<=true;
				  elsif exchange(7 downto 0)=x"06" then 
				 	report "TCP packet" ; 
				 	tcp_count <= tcp_count+1;
				  	is_TCP<=true;
			  	  end if;
			      end if;
			  when IP2 =>
			      if (step) then
				 report "tx_data IP2 STATE: " & hstr(exchange) & LF ; 
				 src_ip <= exchange(47 downto 16);
				 dst_ip(31 downto 16) <= exchange(15 downto 0);
			      end if; 
			  when IP3 =>
			      if (step) then
				 report "tx_data IP3 STATE: " & hstr(exchange) & LF ; 
				 dst_ip(15 downto 0) <= exchange(63 downto 48);
				 if is_TCP or is_UDP then 
				 	src_port <= exchange(47 downto 32); 
				 	dst_port <= exchange(31 downto 16); 
				 end if;
				 if is_IP then 
				 	start_CBF <='1';
				end if;
			     end if;
			  when DATA =>
				 start_CBF <='0';
			  when others =>
			  	null;
		     end case;
		  end if;
	   end if;
end process;

process(curr_state, step, IBUF0_TX_SOF_N, IBUF0_TX_EOF_N, IBUF0_TX_SOP_N, IBUF0_TX_EOP_N)
	   begin
	   next_state <= curr_state;
	   case curr_state is
		  when WAIT_FOR_FRAME =>
		     if (IBUF0_TX_SOF_N = '0' and step ) then
		         next_state <= FRAME_HEADER;
		     end if;
		  when FRAME_HEADER =>
		     if (IBUF0_TX_EOP_N = '0' and step ) then
		         next_state <= DST_MAC_ADDRESS;
		     end if;
		  when DST_MAC_ADDRESS =>
		     if (step) then
		         next_state <= SRC_MAC_ADDRESS;
		     end if;
		  when SRC_MAC_ADDRESS =>
		     if (step) then
		         next_state <= IP1; 
		     end if;
		  when IP1 =>
		      if (step) then
		         next_state <= IP2; 
		     end if;
		  when IP2 =>
		      if (step) then
		         next_state <= IP3; 											
		      end if; 
		  when IP3 =>
		      if (step) then
		         next_state <= DATA; 											
		     end if;
		  when DATA =>
		     if (IBUF0_TX_EOF_N = '0' and step) then
			 report "src ip:  " & integer'image(conv_integer(src_ip(31 downto 24))) & "." & 
			 integer'image(conv_integer(src_ip(23 downto 16))) & "." & 
			 integer'image(conv_integer(src_ip(15 downto 8))) & "." & 
			 integer'image(conv_integer(src_ip(7 downto 0))) & LF ; 
			 report "dst ip:  " & integer'image(conv_integer(dst_ip(31 downto 24))) & "." & 
			 integer'image(conv_integer(dst_ip(23 downto 16))) & "." & 
			 integer'image(conv_integer(dst_ip(15 downto 8))) & "." & 
			 integer'image(conv_integer(dst_ip(7 downto 0))) & LF ; 
			 report "src port " & integer'image(conv_integer(src_port)) & LF ;
			 report "dst port " & integer'image(conv_integer(dst_port)) & LF ;
		         next_state <= WAIT_FOR_FRAME;
		     end if;
	   end case;
end process;

-- -------------------------------------------------------------------------
-- MI32 interface
-- -------------------------------------------------------------------------

   MI32_ARDY <= MI32_WR or MI32_RD;
   
-- Store the MI32_ADDR 
-- can be avoided if read latency =1 
process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if (RESET = '1') then
            int_mi32_addr <= (others => '0');
	 elsif  MI32_RD='1' then
            int_mi32_addr <= MI32_ADDR; 
         end if;
      end if;
   end process;

-- Create two cycle reading latency
--can be only one when address \= 0009 are used
process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if (RESET = '1') then
            MI32_DRDY <= '0';
            MI32_RD_d <= '0';
	 else 
            MI32_RD_d <= MI32_RD;
            MI32_DRDY <= MI32_RD_d;
         end if;
      end if;
   end process;


-- -------------------------------------------------------------------------
-- csbus: 0x00089000
-- MI32 ADDRESS:
-- 0x0008 A000 : Threshold 
-- 0x0008 A004 : TIMEDEC 
-- 0x0008 A008 : counter_overflow (RD_ONLY)
-- 0x0008 A00C : counter_item (RD_ONLY)
-- 0x0008 A010 : osip (RD_ONLY) last overthreshold flow
-- 0x0008 A014 : odip (RD_ONLY)
-- 0x0008 A018 : oport (RD_ONLY) 
-- 0x0008 A01C : N/A 
-- 0x0008 A020 : maxsip (RD_ONLY) biggest flow
-- 0x0008 A024 : maxdip (RD_ONLY)
-- 0x0008 A028 : maxport (RD_ONLY) 
-- 0x0008 A02C : maxcount value of the biggest flow 
-- 0x0008 A030 : ip_count (RD_ONLY)
-- 0x0008 A034 : udp_count (RD_ONLY)
-- 0x0008 A038 : tcp_count (RD_ONLY) 
-- 0x0008 A03C : N/A 

-- 0x0009 0000 - 0x0009 1FFF: CBF dump (RD_ONLY)
-- -------------------------------------------------------------------------



-- -------------------------------------------------------------------------
-- Threshold/TIMEDEC Registers
-- -------------------------------------------------------------------------

process(CLK)
   begin
      if (CLK'event and CLK = '1') then
         if (RESET = '1') then
            Threshold <= x"0000ffff";
            TIMEDEC   <= x"00000000";
         else
            if ( MI32_ADDR=x"0008A000" and MI32_WR = '1') then
               Threshold <= MI32_DWR;
            end if;
            if ( MI32_ADDR=x"0008A004" and MI32_WR = '1') then
               TIMEDEC <= MI32_DWR;
            end if;
         end if;
      end if;
   end process;

process(CLK)
   begin
      if (CLK'event and CLK = '1') then
            if MI32_RD_d='1' then 
	     if int_mi32_addr(31 downto 16)= x"0009" then --FIXME addr should be 31 downto 13
			MI32_DRD <= Data_CBF_dump;
	     elsif int_mi32_addr = x"0008A000" then
			MI32_DRD <= Threshold;
	     elsif int_mi32_addr = x"0008A004" then 
			MI32_DRD <= TIMEDEC;
	     elsif int_mi32_addr = x"0008A008" then
			MI32_DRD <= counter_overflow;
	     elsif int_mi32_addr = x"0008A00C" then
			MI32_DRD <= counter_item;
	     elsif int_mi32_addr = x"0008A010" then 
			MI32_DRD <= osip;
	     elsif int_mi32_addr = x"0008A014" then
			MI32_DRD <= odip;
	     elsif int_mi32_addr = x"0008A018" then
			MI32_DRD <= oport;
	     elsif int_mi32_addr = x"0008A020" then 
			MI32_DRD <= max_sip;
	     elsif int_mi32_addr = x"0008A024" then
			MI32_DRD <= max_dip;
	     elsif int_mi32_addr = x"0008A028" then
			MI32_DRD <= max_port;
	     elsif int_mi32_addr = x"0008A02C" then 
			MI32_DRD <= max_count;
	     elsif int_mi32_addr = x"0008A030" then 
			MI32_DRD <= ip_count;
	     elsif int_mi32_addr = x"0008A034" then
			MI32_DRD <= udp_count;
	     elsif int_mi32_addr = x"0008A038" then
			MI32_DRD <= tcp_count;
	     else
			MI32_DRD <= x"beefbeef";
	     end if;
	    end if;
      end if;
   end process;


--------------------------------------
-- Timer to activate the CBF decrement 
--------------------------------------
 
T: entity work.timer
		port map(
		clock => CLK,
	        reset => RESET,
		TIMEDEC => TIMEDEC,
		decrement => decrement
		);
									     

--------------------------------------
-- CBF instanziation 
--------------------------------------
 
dump<= MI32_RD when MI32_ADDR(31 downto 12)=x"00090" or MI32_ADDR(31 downto 12)=x"00091"
       else '0';

CBF: entity work.CBFfilter 
		port map(
			clock => CLK,
			reset => RESET,
			src_ip => src_ip,
			dst_ip => dst_ip,
			src_port => src_port, 
			dst_port => dst_port, 
			start => start_CBF,
			decrement => decrement,
			-- MI32 interface 
			Address_CBF_dump => MI32_ADDR(12 downto 2), --FIXME should be (12 downto 2)
                        dump	=> dump,
			Data_CBF_dump => Data_CBF_dump,
			osip => osip,
			odip => odip,
			oport => oport,
			max_sip => max_sip,
			max_dip => max_dip,
			max_port => max_port,
			max_count => max_count,
			Threshold => Threshold,
			counter_item => counter_item,
			counter_overflow => counter_overflow
		);

end architecture full;
