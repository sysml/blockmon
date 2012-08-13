--ENTITY of filter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.utils.ALL;

entity CBFfilter is
	Port(
		clock			: in  STD_LOGIC;
		reset 			: in  STD_LOGIC;
		src_ip			: in  STD_LOGIC_VECTOR(31 downto 0);
		dst_ip			: in  STD_LOGIC_VECTOR(31 downto 0);
		src_port		: in  STD_LOGIC_VECTOR(15 downto 0);
		dst_port		: in  STD_LOGIC_VECTOR(15 downto 0);
		decrement		: in  STD_LOGIC;
		start			: in  STD_LOGIC;
		Address_CBF_dump	: in  STD_LOGIC_VECTOR (10 downto 0);
		dump	                : in  STD_LOGIC;
		Threshold		: in  STD_LOGIC_VECTOR (31 downto 0);
		Data_CBF_dump	        : out STD_LOGIC_VECTOR (31 downto 0);
		osip	 		: out STD_LOGIC_VECTOR(31 downto 0); -- SRC IP of the last flow over the threshold
		odip	 		: out STD_LOGIC_VECTOR(31 downto 0); -- DST IP of the last flow over the threshold
		oport	 		: out STD_LOGIC_VECTOR(31 downto 0); -- SRC & DST PORT of the last flow over the threshold
		counter_item 		: out STD_LOGIC_VECTOR(31 downto 0);
		max_sip	 		: out STD_LOGIC_VECTOR(31 downto 0); -- SRC IP of the biggest flow
		max_dip	 		: out STD_LOGIC_VECTOR(31 downto 0); -- DST IP of the biggest flow 
		max_port 		: out STD_LOGIC_VECTOR(31 downto 0); -- SRC & DST PORT of the biggest flow 
		max_count 		: out STD_LOGIC_VECTOR(31 downto 0);
		counter_overflow 	: out STD_LOGIC_VECTOR(31 downto 0)
	);
end CBFfilter;


--ARCHITECTURE of filter
architecture Behavioral of CBFfilter is
	type stato_filtro 	is (IDLE,CLEAN,ZERO_CLEAN,READ0,READ1,READ2,READ3,LAST_READ,WRITE0,WRITE1,DEC0,DEC1,DEC2,DUMP_STATE);	
	type HH 		is array(3 downto 0) 	of STD_LOGIC_VECTOR (10 downto 0); 		
	type ADDR 		is array(3 downto 0) 	of STD_LOGIC_VECTOR (10 downto 0);
	type CV 		is array(3 downto 0) 	of STD_LOGIC_VECTOR (15 downto 0);
	type CBF		is array(2047 downto 0) of STD_LOGIC_VECTOR (15 downto 0); 	--2048 count;
	
	signal max_val			: STD_LOGIC_VECTOR(15 downto 0);  -- the value of the bigger flow
	signal flow 			: STD_LOGIC_VECTOR(95 downto 0);  -- the flow currently examined
	signal int_counter_item 	: STD_LOGIC_VECTOR(31 downto 0);  -- counts the total number of stored item
	signal int_counter_overflow 	: STD_LOGIC_VECTOR(31 downto 0);  -- count the number of overflows
	signal H			: HH;				  -- vector of hash values
	signal addr_w			: ADDR;				  -- vector of address to be updated
	signal count_val		: STD_LOGIC_VECTOR (15 downto 0); -- value of the counter for the current flow 
	signal countBF			: CBF;				  -- memory of the CBF
	signal Htot_UNI			: STD_LOGIC_VECTOR (43 downto 0); -- total hash 
	signal stato			: stato_filtro;			  -- FSM curent state
	signal n_val			: STD_LOGIC_VECTOR (2 downto 0);  -- number of conter to be updated
	signal decrementing		: STD_LOGIC;			  -- the CBF is in decrementing 
	signal write_enable		: STD_LOGIC;			  -- write to the CBF RAM
	signal overflow		   	: STD_LOGIC;			  -- checks if the current flow is over the threshold
	signal HADDR			: STD_LOGIC_VECTOR (10 downto 0); -- address for the CBF memory 
	signal HCOUNT_VAL_TRF		: STD_LOGIC_VECTOR (15 downto 0); -- HCOUNT_VAL_ToReadFrom
	signal HCOUNT_VAL_TWI		: STD_LOGIC_VECTOR (15 downto 0); -- HCOUNT_VAL_ToWriteInto
	signal i 			: integer range 0 to 2047;
	signal j 			: integer range 0 to 2047;
	signal k 			: integer range 0 to 2047;
	signal w 			: integer range 0 to 3;
	signal input_hash		: STD_LOGIC_VECTOR(131 downto 0);
	
	begin

	counter_item<= int_counter_item;
	counter_overflow<= int_counter_overflow;
	input_hash<= x"f2a650193" & src_ip & dst_ip & src_port & dst_port;	
	
	
	
-------------------------------------------
--      computing hash using ror and xor
-------------------------------------------

	Htot_UNI <= (myror(input_hash(131 downto 88),11)) xor (myror(input_hash(87 downto 44), 7)) xor input_hash(43 downto 0);
	--Htot_UNI <= (input_hash(131 downto 88) ror 11) xor (input_hash(87 downto 44) ror 7) xor input_hash(43 downto 0);
	
	process (clock, reset) 
	begin
		if reset = '1' then
			flow<= (others =>'0');
		elsif clock' event and clock='1' then
			if start = '1' then
				flow<= src_ip & dst_ip & src_port & dst_port;	
			end if;	
		end if;	
	end process;
	
	process (clock, reset) 
	begin
		if reset = '1' then
			write_enable <= '0';
			HCOUNT_VAL_TRF <= (others => '0');
			addr_w(0) <= (others => '0');
			addr_w(1) <= (others => '0');
			addr_w(2) <= (others => '0');
			addr_w(3) <= (others => '0');
			count_val <= (others => '0');
			
			H(0) <= (others => '0');
			H(1) <= (others => '0');
			H(2) <= (others => '0');
			H(3) <= (others => '0');
			
			n_val <= (others => '0');
			
			stato <= ZERO_CLEAN; 
			decrementing <= '0';
			overflow <= '0';
			osip <= (others => '0');
			odip <= (others => '0');
			oport <= (others => '0');
			int_counter_overflow <= (others => '0');
			int_counter_item<= (others => '0');
			i <= 0;
			
		elsif clock' event and clock='1' then
			if decrement='1' and stato /= CLEAN then
					decrementing <= '1';
			end if;
			write_enable <= '0';
			if start = '1' and stato /= CLEAN then
				H(0) <= Htot_UNI(10 downto 0);
				H(1) <= Htot_UNI(21 downto 11);
				H(2) <= Htot_UNI(32 downto 22);
				H(3) <= Htot_UNI(43 downto 33);
				-- conta il numero di item inserite nel CBF
				int_counter_item<=  int_counter_item +1;
				stato <= READ0;
			end if;
			
			--------------------------------------
			-- Stati di reset dei contatori
			--- stati ZERO_CLEAN e CLEAN
			--------------------------------------
			
			if stato = ZERO_CLEAN then --"01111"
				i <= 0;
				write_enable <= '1';
				HCOUNT_VAL_TRF <= (others => '0');
				stato <= CLEAN;
			end if;

			if stato = CLEAN then --"11111"
				if i <= 2046 then
					i <= i + 1;
					HCOUNT_VAL_TRF <= (others => '0');
					write_enable <= '1';
				else
					stato <= IDLE; --"01110"
					write_enable <= '0';
					i <= 0;
				end if;
			end if;


			--------------------------------------
			-- Stati di lettura dei contatori
			--- stato >= 0 e <= 4 
			--------------------------------------
			if stato = READ0 then
				--HADDR <= H(0);
				stato <= READ1;
			end if; 
			
			if stato = READ1 then
				--HADDR <= H(1);
				stato <= READ2;
				count_val <= HCOUNT_VAL_TWI;
				addr_w(0) <= H(0);
				n_val <= "001";
				if(HCOUNT_VAL_TWI >= Threshold) then
					overflow <= '1';
				else
					overflow <= '0';
				end if;
			end if; 
			
			if stato = READ2 then
				stato <= READ3;
				--HADDR <= H(2);
				--count_val <= HCOUNT_VAL_TWI;
				if(HCOUNT_VAL_TWI < Threshold) then
					overflow <= '0';
				end if;
				--multiple counters with value = TWI
				if count_val = HCOUNT_VAL_TWI then
					addr_w(1) <= H(1);
					n_val <= "010";
				end if;
				--this counter has the minimum value
				if count_val > HCOUNT_VAL_TWI then
					count_val <= HCOUNT_VAL_TWI;
					addr_w(0) <= H(1);
					n_val <= "001";
				end if;
			end if;

			if stato = READ3 then
				stato <= LAST_READ;
				--HADDR <= H(3);
				if(HCOUNT_VAL_TWI < Threshold) then
					overflow <= '0';
				end if;
				--multiple counters with value = TWI
				if count_val = HCOUNT_VAL_TWI then
					if n_val = "001" then
						addr_w(1) <= H(2);
						n_val <= "010";
					end if;
					if n_val = "010" then
						addr_w(2) <= H(2);
						n_val <= "011";
					end if;
				end if;
				--this counter has the minimum value
				if count_val > HCOUNT_VAL_TWI then
					count_val <= HCOUNT_VAL_TWI;
					addr_w(0) <= H(2);
					n_val <= "001";
				end if;
			end if; 			
		
			--stop letture ed ultimo confronto
			if stato = LAST_READ then
				j <= 0;
				stato <= WRITE0;
				if(HCOUNT_VAL_TWI < Threshold) then
					overflow <= '0';
				end if;
				--multiple counters with value = TWI
				if count_val = HCOUNT_VAL_TWI then
					if n_val = "001" then
						addr_w(1) <= H(3);
						n_val <= "010";
					end if;
					if n_val = "010" then
						addr_w(2) <= H(3);
						n_val <= "011";
					end if;
					if n_val = "011" then
						addr_w(3) <= H(3);
						n_val <= "100";
					end if;
				end if;
					--this counter has the minimum value
				if count_val > HCOUNT_VAL_TWI then
					count_val <= HCOUNT_VAL_TWI;
					addr_w(0) <= H(3);
					n_val <= "001";
				end if;
			end if; 

			--------------------------------------
			-- Stati di scrittura dei contatori
			--- stato = 5,21
			--------------------------------------
			
			if stato = WRITE0 then
					stato <= WRITE1; --"10101";
					HCOUNT_VAL_TRF <= count_val + 1;
					j <= 0; --number of counters to be incremented
					write_enable <= '1';
					if (count_val+1)>max_val then
						max_val<=count_val+1;
						max_sip<=flow(95 downto 64); --src_ip
						max_dip<=flow(63 downto 32); --dst_ip;
						max_port<=flow(31 downto 0); --src_port & dst_port;
						max_count<=x"0000"&(count_val+1);
					end if;	
				if(overflow = '1') then
					--stato <= IDLE; -- go to IDLE only for saturate behaviour
					--conta il numero di overflow
					int_counter_overflow <= int_counter_overflow + 1;
					-- store the flow over the threshold
					osip<=flow(95 downto 64); --src_ip
					odip<=flow(63 downto 32); --dst_ip;
					oport<=flow(31 downto 0); --src_port & dst_port;
					report "overflow src ip:  " & integer'image(conv_integer(src_ip(31 downto 24))) & "." & 
					integer'image(conv_integer(src_ip(23 downto 16))) & "." & 
					integer'image(conv_integer(src_ip(15 downto 8))) & "." & 
					integer'image(conv_integer(src_ip(7 downto 0))) & LF ; 
					report "overflow dst ip:  " & integer'image(conv_integer(dst_ip(31 downto 24))) & "." & 
					integer'image(conv_integer(dst_ip(23 downto 16))) & "." & 
					integer'image(conv_integer(dst_ip(15 downto 8))) & "." & 
					integer'image(conv_integer(dst_ip(7 downto 0))) & LF ; 
					report "overflow src port " & integer'image(conv_integer(src_port)) & LF ;
					report "overflow dst port " & integer'image(conv_integer(dst_port)) & LF ;
				--elsif(overflow=0)
					-- here increment only if the value are below the Threshold, otherwise the counters saturate
					--stato <= WRITE1; --"10101";
					--HCOUNT_VAL_TRF <= count_val + 1;
					--j <= 0; --number of counters to be incremented
					--write_enable <= '1';
				end if;
			end if;
			
			if stato = WRITE1 then
					stato <= WRITE1;
					--loop for all the conunters(n_val) to be incremented
					if(j+1 < conv_integer(n_val)) then
							HCOUNT_VAL_TRF <= count_val + 1;
							j <= j + 1;
							write_enable <= '1';
					else
						stato <= IDLE; --"01110";
						j <= 0;
						write_enable <= '0';
					end if;
			end if;

			
			--IDLE STATE
			if stato = IDLE then --"01110"
				overflow <= '0';
				write_enable <= '0';
				if decrementing = '1' then
					if i <= 2046 then
						i <= i + 1;
						stato <= DEC0;
					else
						decrementing<= '0';
						stato <= IDLE; -- "01110";
						i <= 0;
					end if;
				elsif dump='1' then 
					stato <= DUMP_STATE;
				end if;
			end if;
			
			if stato = DUMP_STATE then
					if dump='0' then
						stato <= IDLE;
					end if;
			end if;
			
			--decrementing state
			if stato = DEC0 then
				stato <= DEC1;
				write_enable <= '0';
			end if;
			
			if stato = DEC1 then
				stato <= DEC2;
				if(conv_integer(HCOUNT_VAL_TWI) > 0) then
					write_enable <= '1';
					HCOUNT_VAL_TRF <= HCOUNT_VAL_TWI - 1;
				end if;
			end if;
			
			--needed to write decremented value on the CBF
			if stato = DEC2 then
				write_enable <= '0';
				stato <= IDLE; -- "01110";
			end if;
		end if;	
	end process;



HADDR <=H(0) when stato=READ0 else
	H(1) when stato=READ1 else
	H(2) when stato=READ2 else
	H(3) when stato=READ3 else
	addr_w(j)  when stato=LAST_READ else
	addr_w(j)  when stato=WRITE0 else
	addr_w(j)  when stato=WRITE1 else
	Address_CBF_dump when stato=DUMP_STATE else 
	Address_CBF_dump when stato=IDLE and dump='1' else -- hack:when dump=1 and IDLE risparmia un cilo ci clock
	conv_std_logic_vector(i,11); 

--with stato select
	--HADDR <=H(0) 			     when READ0,
		--H(1) 			     when READ1,
		--H(2) 			     when READ2,
		--H(3) 			     when READ3,
		--addr_w(j)		     when LAST_READ,
		--addr_w(j)		     when WRITE0,
		--addr_w(j)	 	     when WRITE1,
		--Address_CBF_dump            when DUMP_STATE, -- hack:when dump=1 and IDLE risparmia un cilo ci clock
		--conv_std_logic_vector(i,11) when others;


	process(clock)
	begin
		if clock'event and clock = '1' then
				HCOUNT_VAL_TWI <= countBF(conv_integer(HADDR));
			if (write_enable = '1') then
				countBF(conv_integer(HADDR)) <= HCOUNT_VAL_TRF;
				HCOUNT_VAL_TWI <= HCOUNT_VAL_TRF; -- needed to synth block RAM
			end if;
		end if;			
	end process;


------------------------------
-- forniamo il valore memorizzato dal CBF per l'operazione di DUMP
	Data_CBF_dump<= x"0000" & HCOUNT_VAL_TWI;


end Behavioral;
