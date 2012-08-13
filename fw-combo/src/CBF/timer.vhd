library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;



entity timer is
	  port ( clock : in std_logic;
	         reset : in std_logic;
		 TIMEDEC: in std_logic_vector(31 downto 0);
		 decrement: out std_logic
		);
end timer;

architecture Behavioral of timer is

signal timestampL: STD_LOGIC_VECTOR (7 downto 0);
signal timestampH: STD_LOGIC_VECTOR (31 downto 0);

begin
timestamp : process (clock, reset)
	  begin
	   if reset = '1' then
	      timestampL <= (others =>'0');
	      timestampH <= (others =>'0');
	      decrement <='0';
	   elsif clock'event and clock = '1' then
	        timestampL <= timestampL +'1';
	        if       timestampL=x"7D" then   --ogni 125 colpi di clock
	        timestampL<=x"00";
	        timestampH<=timestampH+1;       --quindi timestampH conta i micro-secondi
	        end if;
	        if (timestampL=x"7D") and (timestampH = TIMEDEC) then
	                        timestampH<=(others =>'0');
	        end if;
                if (timestampL=x"7D") and (timestampH = TIMEDEC) and (TIMEDEC/=x"00000000") then
	                        decrement<='1';
	                         else
	                        decrement<='0';
	        end if;  -- decremento ogni 1024*1024 micro secondi
	    end if;
	  end process;
	end Behavioral;
