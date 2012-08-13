library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

package utils is

FUNCTION or_reduce(arg : STD_LOGIC_VECTOR) RETURN STD_LOGIC; 
FUNCTION and_reduce(arg : STD_LOGIC_VECTOR) RETURN STD_LOGIC; 
function popcount6 (arg: std_logic_vector) return std_logic_vector; 
function popcount32 (arg: std_logic_vector) return std_logic_vector; 
function popcount64 (arg: std_logic_vector) return std_logic_vector; 
function myror (L: std_logic_vector; R: integer) return std_logic_vector; 
function to_string(sv: Std_Logic_Vector) return string; 
function hstr(slv: std_logic_vector) return string;
function h(slv: std_logic_vector) return string;

end utils;

package body utils is

function popcount6 (arg: std_logic_vector) return std_logic_vector is
    variable temp : std_logic_vector(5 downto 0) := "000000";
    variable result : std_logic_vector(2 downto 0) := "000";
  begin
       temp:=arg;
       case temp is
           when "000000" => 
                    result:= "000";
           when "000001" =>
                    result:= "001";
           when "000010" =>
                    result:= "001";
           when "000011" =>
                    result:= "010";
           when "000100" =>
                    result:= "001";
           when "000101" =>
                    result:= "010";
           when "000110" =>
                    result:= "010";
           when "000111" =>
                    result:= "011";
           when "001000" =>
                    result:= "001";
           when "001001" =>
                    result:= "010";
           when "001010" =>
                    result:= "010";
           when "001011" =>
                    result:= "011";
           when "001100" =>
                    result:= "010";
           when "001101" =>
                    result:= "011";
           when "001110" =>
                    result:= "011";
           when "001111" =>
                    result:= "100";
           when "010000" =>
                    result:= "001";
           when "010001" =>
                    result:= "010";
           when "010010" =>
                    result:= "010";
           when "010011" =>
                    result:= "011";
           when "010100" =>
                    result:= "010";
           when "010101" =>
                    result:= "011";
           when "010110" =>
                    result:= "011";
           when "010111" =>
                    result:= "100";
           when "011000" =>
                    result:= "010";
           when "011001" =>
                    result:= "011";
           when "011010" =>
                    result:= "011";
           when "011011" =>
                    result:= "100";
           when "011100" =>
                    result:= "011";
           when "011101" =>
                    result:= "100";
           when "011110" =>
                    result:= "100";
           when "011111" =>
                    result:= "101";
           when "100000" =>
                    result:= "001";
           when "100001" =>
                    result:= "010";
           when "100010" =>
                    result:= "010";
           when "100011" =>
                    result:= "011";
           when "100100" =>
                    result:= "010";
           when "100101" =>
                    result:= "011";
           when "100110" =>
                    result:= "011";
           when "100111" =>
                    result:= "100";
           when "101000" =>
                    result:= "010";
           when "101001" =>
                    result:= "011";
           when "101010" =>
                    result:= "011";
           when "101011" =>
                    result:= "100";
           when "101100" =>
                    result:= "011";
           when "101101" =>
                    result:= "100";
           when "101110" =>
                    result:= "100";
           when "101111" =>
                    result:= "101";
           when "110000" =>
                    result:= "010";
           when "110001" =>
                    result:= "011";
           when "110010" =>
                    result:= "011";
           when "110011" =>
                    result:= "100";
           when "110100" =>
                    result:= "011";
           when "110101" =>
                    result:= "100";
           when "110110" =>
                    result:= "100";
           when "110111" =>
                    result:= "101";
           when "111000" =>
                    result:= "011";
           when "111001" =>
                    result:= "100";
           when "111010" =>
                    result:= "100";
           when "111011" =>
                    result:= "101";
           when "111100" =>
                    result:= "100";
           when "111101" =>
                    result:= "101";
           when "111110" =>
                    result:= "101";
           when "111111" =>
                    result:= "110";
           when  others =>
                    result:= "000";
         end case;
    return result;
  end function popcount6;

function popcount32 (arg: std_logic_vector) return std_logic_vector is
    variable s1,s2,s3: std_logic_vector(2 downto 0) := "000";
    variable p1,p2,p3,p4,p5,p6 : std_logic_vector(2 downto 0) := "000";
    variable result : std_logic_vector(5 downto 0) := "000000";
  begin
   --first stage compression 6:3
   p1:= popcount6(arg(5 downto 0)); 
   p2:= popcount6(arg(11 downto 6)); 
   p3:= popcount6(arg(17 downto 12)); 
   p4:= popcount6(arg(23 downto 18)); 
   p5:= popcount6(arg(29 downto 24)); 
   p6:= popcount6(arg(31 downto 30)&"0000"); 
   
   --second stage compression 6:3
   s1:=popcount6(p1(0) & p2(0)& p3(0) & p4(0) & p5(0) & p6(0) );
   s2:=popcount6(p1(1) & p2(1)& p3(1) & p4(1) & p5(1) & p6(1) );
   s3:=popcount6(p1(2) & p2(2)& p3(2) & p4(2) & p5(2) & p6(2) );
   
   --third stage compression 6:3
   result(4 downto 0):="00"&s1+'0'&s2&'0'+s3&"00";
   result(5):=and_reduce(arg); 

   return result;
  end function popcount32;

function popcount64 (arg: std_logic_vector) return std_logic_vector is
    variable  carry_0, carry_2: std_logic := '0';
    variable u3,u4 : std_logic_vector(2 downto 0) := "000";
    variable t1,t2,t3,t4 : std_logic_vector(2 downto 0) := "000";
    variable s1,s2,s3,s4,s5,s6: std_logic_vector(2 downto 0) := "000";
    variable p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11 : std_logic_vector(2 downto 0) := "000";
    variable result : std_logic_vector(6 downto 0) := "0000000";
  begin
   --first stage compression 6:3
   p1:= popcount6(arg(5 downto 0)); 
   p2:= popcount6(arg(11 downto 6)); 
   p3:= popcount6(arg(17 downto 12)); 
   p4:= popcount6(arg(23 downto 18)); 
   p5:= popcount6(arg(29 downto 24)); 
   p6:= popcount6(arg(35 downto 30)); 
   p7:= popcount6(arg(41 downto 36)); 
   p8:= popcount6(arg(47 downto 42)); 
   p9:= popcount6(arg(53 downto 48)); 
   p10:= popcount6(arg(59 downto 54)); 
   p11:= popcount6("00"& arg(63 downto 60)); 
   
   --second stage compression 6:3
   s1:=popcount6(p1(0) & p2(0)& p3(0) & p4(0) & p5(0) & p6(0) );
   s2:=popcount6(p7(0) & p8(0)& p9(0) & p10(0) & p11(0) & '0' );
   s3:=popcount6(p1(1) & p2(1)& p3(1) & p4(1) & p5(1) & p6(1) );
   s4:=popcount6(p7(1) & p8(1)& p9(1) & p10(1) & p11(1) & '0' );
   s5:=popcount6(p1(2) & p2(2)& p3(2) & p4(2) & p5(2) & p6(2) );
   s6:=popcount6(p7(2) & p8(2)& p9(2) & p10(2) & p11(2) & '0' );
   
   --third stage compression 6:3
   result(0):=s1(0) xor s2(0);
   carry_0:=s1(0) and s2(0); 
   t1:=popcount6(s1(1) & s2(1)& s3(0) & s4(0) & carry_0 & '0' );
   t2:=popcount6(s1(2) & s2(2)& s3(1) & s4(1) & s5(0) & s6(0) );
   t3:=popcount6(s3(2) & s4(2)& s5(1) & s6(1) & "00" );
   t4(0):=s5(2) xor s6(2);
   t4(1):=s5(2) and s6(2);
  
   result(1):=t1(0);
   result(2):=t2(0) xor t1(1);
   carry_2:=t2(0) and t1(1);
   u3:=popcount6(t1(2) & t2(1) & t3(0) & carry_2 & "00");
   u4:=popcount6(t2(2) & t3(1) & t4(0) & "000");

  --use carry save
   result(3):=u3(0); 
   result(4):=u3(1) xor u4(0); 
   result(5):=u3(2) xor u4(1) xor t3(2) xor t4(1) xor (u3(1) and u4(0)); 
   result(6):=and_reduce(arg); 

   return result;

  end function popcount64;

function h(slv: std_logic_vector) return string is
       variable hexlen: integer;
       variable longslv : std_logic_vector(67 downto 0) := (others => '0');
       variable hex : string(1 to 16);
       variable fourbit : std_logic_vector(3 downto 0);
     begin
       hexlen := (slv'length+1)/4;
       if (slv'length+1) mod 4 /= 0 then
         hexlen := hexlen + 1;
       end if;
       longslv(slv'left downto slv'right) := slv;
       for i in (hexlen -1) downto 0 loop
         fourbit := longslv(((i*4)+3) downto (i*4));
         case fourbit is
           when "0000" => hex(hexlen -I) := '0';
           when "0001" => hex(hexlen -I) := '1';
           when "0010" => hex(hexlen -I) := '2';
           when "0011" => hex(hexlen -I) := '3';
           when "0100" => hex(hexlen -I) := '4';
           when "0101" => hex(hexlen -I) := '5';
           when "0110" => hex(hexlen -I) := '6';
           when "0111" => hex(hexlen -I) := '7';
           when "1000" => hex(hexlen -I) := '8';
           when "1001" => hex(hexlen -I) := '9';
           when "1010" => hex(hexlen -I) := 'A';
           when "1011" => hex(hexlen -I) := 'B';
           when "1100" => hex(hexlen -I) := 'C';
           when "1101" => hex(hexlen -I) := 'D';
           when "1110" => hex(hexlen -I) := 'E';
           when "1111" => hex(hexlen -I) := 'F';
           when "ZZZZ" => hex(hexlen -I) := 'z';
           when "UUUU" => hex(hexlen -I) := 'u';
           when "XXXX" => hex(hexlen -I) := 'x';
           when others => hex(hexlen -I) := '?';
         end case;
       end loop;
       return hex(1 to hexlen);
end function h;

function hstr(slv: std_logic_vector) return string is
       variable hexlen: integer;
       variable longslv : std_logic_vector(67 downto 0) := (others => '0');
       variable hex : string(1 to 16);
       variable fourbit : std_logic_vector(3 downto 0);
     begin
       hexlen := (slv'left+1)/4;
       if (slv'left+1) mod 4 /= 0 then
         hexlen := hexlen + 1;
       end if;
       longslv(slv'left downto 0) := slv;
       for i in (hexlen -1) downto 0 loop
         fourbit := longslv(((i*4)+3) downto (i*4));
         case fourbit is
           when "0000" => hex(hexlen -I) := '0';
           when "0001" => hex(hexlen -I) := '1';
           when "0010" => hex(hexlen -I) := '2';
           when "0011" => hex(hexlen -I) := '3';
           when "0100" => hex(hexlen -I) := '4';
           when "0101" => hex(hexlen -I) := '5';
           when "0110" => hex(hexlen -I) := '6';
           when "0111" => hex(hexlen -I) := '7';
           when "1000" => hex(hexlen -I) := '8';
           when "1001" => hex(hexlen -I) := '9';
           when "1010" => hex(hexlen -I) := 'A';
           when "1011" => hex(hexlen -I) := 'B';
           when "1100" => hex(hexlen -I) := 'C';
           when "1101" => hex(hexlen -I) := 'D';
           when "1110" => hex(hexlen -I) := 'E';
           when "1111" => hex(hexlen -I) := 'F';
           when "ZZZZ" => hex(hexlen -I) := 'z';
           when "UUUU" => hex(hexlen -I) := 'u';
           when "XXXX" => hex(hexlen -I) := 'x';
           when others => hex(hexlen -I) := '?';
         end case;
       end loop;
       return hex(1 to hexlen);
end function hstr;

function to_string(sv: Std_Logic_Vector) 
return string is
    use Std.TextIO.all;
    variable bv: bit_vector(sv'range) := to_bitvector(sv);
    variable lp: line;
  begin
    write(lp, bv);
    return lp.all;
end function to_string;

function myror (L: std_logic_vector; R: integer) return std_logic_vector is
 	begin
	return to_stdlogicvector(to_bitvector(L) ror R);
 end function myror;

function or_reduce (arg: std_logic_vector) return std_logic is
    variable result : std_logic := '0';
  begin
    for i in arg'reverse_range loop
      result := arg(i) or result;
    end loop;
    return result;
  end function or_reduce;

function and_reduce (arg: std_logic_vector) return std_logic is
    variable result : std_logic := '1';
  begin
    for i in arg'reverse_range loop
      result := arg(i) and result;
    end loop;
    return result;
  end function and_reduce;

end utils;
