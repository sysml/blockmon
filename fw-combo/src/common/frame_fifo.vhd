-- -----------------------------------------------------------------
-- FIFO with a FrameLink interface
-- -----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.math_pack.all;

entity FRAME_FIFO is
    generic (
        DATA_WIDTH : integer := 64;
        DEPTH      : integer := 512
        );
    port (
        -- global FPGA clock
        CLK : in std_logic;

        -- global synchronous reset
        RESET : in std_logic;

        -- RX FrameLink interface
        RX_DATA      : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        RX_REM       : in  std_logic_vector(log2(DATA_WIDTH/8) - 1 downto 0);
        RX_SOF_N     : in  std_logic;
        RX_EOF_N     : in  std_logic;
        RX_SOP_N     : in  std_logic;
        RX_EOP_N     : in  std_logic;
        RX_SRC_RDY_N : in  std_logic;
        RX_DST_RDY_N : out std_logic;

        -- TX FrameLink interface
        TX_DATA      : out std_logic_vector(DATA_WIDTH-1 downto 0);
        TX_REM       : out std_logic_vector(log2(DATA_WIDTH/8) - 1 downto 0);
        TX_SOF_N     : out std_logic;
        TX_EOF_N     : out std_logic;
        TX_SOP_N     : out std_logic;
        TX_EOP_N     : out std_logic;
        TX_SRC_RDY_N : out std_logic;
        TX_DST_RDY_N : in  std_logic
        );
end entity FRAME_FIFO;

architecture behavioral of FRAME_FIFO is

    -- FIFO width: with control signals
    constant FIFO_DATA_WIDTH : integer := DATA_WIDTH + log2(DATA_WIDTH/8) + 4;

    -- -----------------------------------------------------------------
    -- Signals
    -- -----------------------------------------------------------------
    -- FIFO connection
    signal fifo_data_in  : std_logic_vector(FIFO_DATA_WIDTH-1 downto 0);
    signal fifo_data_out : std_logic_vector(FIFO_DATA_WIDTH-1 downto 0);
    signal fifo_full     : std_logic;
    signal fifo_empty    : std_logic;
    signal fifo_write_en : std_logic;
    signal fifo_read_en  : std_logic;

    -- Keep data control
    signal data_long_stored   : std_logic;
    signal data_just_stored   : std_logic;
    signal data_just_unstored : std_logic;
    signal data_stored        : std_logic;
    signal data_from_fifo     : std_logic;

    -- Keep data
    signal tx_data_read  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal tx_rem_read   : std_logic_vector(log2(DATA_WIDTH/8) - 1 downto 0);
    signal tx_sof_n_read : std_logic;
    signal tx_eof_n_read : std_logic;
    signal tx_sop_n_read : std_logic;
    signal tx_eop_n_read : std_logic;

    signal tx_data_keep  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal tx_rem_keep   : std_logic_vector(log2(DATA_WIDTH/8) - 1 downto 0);
    signal tx_sof_n_keep : std_logic;
    signal tx_eof_n_keep : std_logic;
    signal tx_sop_n_keep : std_logic;
    signal tx_eop_n_keep : std_logic;

begin

    -- -----------------------------------------------------------------
    -- Simple FIFO instance
    -- -----------------------------------------------------------------
    
    SIMPLE_FIFO_inst : entity work.SIMPLE_FIFO
        generic map (
            DATA_WIDTH => FIFO_DATA_WIDTH,
            DEPTH      => DEPTH
            )
        port map (
            CLK => CLK,

            RESET => RESET,

            DATA_IN  => fifo_data_in,
            WRITE_EN => fifo_write_en,

            DATA_OUT => fifo_data_out,
            READ_EN  => fifo_read_en,

            STATE_FULL  => fifo_full,
            STATE_EMPTY => fifo_empty
            );

    -- -----------------------------------------------------------------
    -- Logic
    -- -----------------------------------------------------------------

    -- FIFO data connection
    fifo_data_in  <= RX_DATA & RX_REM & RX_SOF_N & RX_EOF_N & RX_SOP_N & RX_EOP_N;
    tx_data_read  <= fifo_data_out(FIFO_DATA_WIDTH-1 downto FIFO_DATA_WIDTH-DATA_WIDTH);
    tx_rem_read   <= fifo_data_out(FIFO_DATA_WIDTH-DATA_WIDTH-1 downto 4);
    tx_sof_n_read <= fifo_data_out(3);
    tx_eof_n_read <= fifo_data_out(2);
    tx_sop_n_read <= fifo_data_out(1);
    tx_eop_n_read <= fifo_data_out(0);

    -- FrameLink write connections
    RX_DST_RDY_N  <= fifo_full;
    fifo_write_en <= (not RX_SRC_RDY_N) and (not fifo_full);

    -- FrameLink read connections: keep data if dst not ready
    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RESET = '1') then
                data_long_stored <= '0';
            else
                if (TX_DST_RDY_N = '0') then
                    data_long_stored <= '0';
                elsif (data_just_stored = '1') then
                    data_long_stored <= '1';
                end if;
                data_from_fifo <= fifo_read_en;
            end if;
        end if;
    end process;
    data_just_stored   <= data_from_fifo and TX_DST_RDY_N;
    data_just_unstored <= (not data_from_fifo) and (not TX_DST_RDY_N);
    data_stored        <= (data_just_stored or data_long_stored) and not data_just_unstored;
    fifo_read_en       <= (not data_stored) and (not fifo_empty);
    TX_SRC_RDY_N       <= (not data_from_fifo) and (not data_long_stored);

    -- Keep the read values if destination is not ready
    TX_DATA  <= tx_data_read  when (data_from_fifo = '1') else tx_data_keep;
    TX_REM   <= tx_rem_read   when (data_from_fifo = '1') else tx_rem_keep;
    TX_SOF_N <= tx_sof_n_read when (data_from_fifo = '1') else tx_sof_n_keep;
    TX_EOF_N <= tx_eof_n_read when (data_from_fifo = '1') else tx_eof_n_keep;
    TX_SOP_N <= tx_sop_n_read when (data_from_fifo = '1') else tx_sop_n_keep;
    TX_EOP_N <= tx_eop_n_read when (data_from_fifo = '1') else tx_eop_n_keep;
    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RESET = '1') then
                tx_data_keep  <= (others => '0');
                tx_rem_keep   <= (others => '0');
                tx_sof_n_keep <= '0';
                tx_eof_n_keep <= '0';
                tx_sop_n_keep <= '0';
                tx_eop_n_keep <= '0';
            elsif (data_from_fifo = '1') then
                tx_data_keep  <= tx_data_read;
                tx_rem_keep   <= tx_rem_read;
                tx_sof_n_keep <= tx_sof_n_read;
                tx_eof_n_keep <= tx_eof_n_read;
                tx_sop_n_keep <= tx_sop_n_read;
                tx_eop_n_keep <= tx_eop_n_read;
            end if;
        end if;
    end process;
end;
