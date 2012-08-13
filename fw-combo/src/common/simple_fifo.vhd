-- -----------------------------------------------------------------
-- Simple synchronous FIFO
-- -----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity SIMPLE_FIFO is
    generic (
        DATA_WIDTH : integer := 64;
        DEPTH      : integer := 512
        );
    port (
        -- global FPGA clock
        CLK : in std_logic;

        -- global synchronous reset
        RESET : in std_logic;

        -- Write interface
        DATA_IN  : in std_logic_vector(DATA_WIDTH-1 downto 0);
        WRITE_EN : in std_logic;

        -- Read interface
        DATA_OUT : out std_logic_vector(DATA_WIDTH-1 downto 0);
        READ_EN  : in  std_logic;

        -- Control
        STATE_FULL  : out std_logic;
        STATE_EMPTY : out std_logic
        );
end entity SIMPLE_FIFO;

architecture behavioral of SIMPLE_FIFO is

    -- -----------------------------------------------------------------
    -- Signals
    -- -----------------------------------------------------------------
    type   ram_type is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal fifo      : ram_type;
    signal read_ptr  : integer range 0 to DEPTH-1;
    signal write_ptr : integer range 0 to DEPTH-1;
    signal depth_cur : integer range 0 to DEPTH;

begin

    -- -----------------------------------------------------------------
    -- Logic
    -- -----------------------------------------------------------------

    -- FIFO read and write
    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RESET = '1') then
                write_ptr <= 0;
                read_ptr  <= 0;
                DATA_OUT  <= (others => '0');
            else
                -- Read in the FIFO
                if (read_en = '1') then
                    data_out <= fifo(read_ptr);
                    -- Increment the pointer
                    if (read_ptr < DEPTH - 1) then
                        read_ptr <= read_ptr + 1;
                    else
                        read_ptr <= 0;
                    end if;
                end if;
                -- Write in the FIFO
                if (write_en = '1') then
                    fifo(write_ptr) <= data_in;
                    -- Increment the pointer
                    if (write_ptr < DEPTH - 1) then
                        write_ptr <= write_ptr + 1;
                    else
                        write_ptr <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- FIFO depth management
    process(CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RESET = '1') then
                depth_cur <= 0;
            else
                if (write_en = '1' and read_en = '0') then
                    depth_cur <= depth_cur + 1;
                elsif (write_en = '0' and read_en = '1') then
                    depth_cur <= depth_cur - 1;
                end if;
            end if;
        end if;
    end process;

    -- FIFO full/empty
    STATE_FULL  <= '1' when (depth_cur >= DEPTH) else '0';
    STATE_EMPTY <= '1' when (depth_cur <= 0)     else '0';
end;
