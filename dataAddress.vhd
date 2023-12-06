library ieee;
use ieee.std_logic_1164.all; 
use ieee.math_real.all;
--arch
use ieee.numeric_std.all;

entity dataAddress is
	generic(	
	    addressWidth: positive;
		dataWidth: positive := 8;   -- in bits ; dataNumBytes = dataWidth/8 
		isVector: boolean := false; -- vector is a column matrix; vector[column] = matrix[0,column]
		isMatrix: boolean := true; -- matrix[row,column]
		numRowElements: positive := 1;  
		numColumnElements: positive := 1
	);
	port(
	    baseaddress: in std_logic_vector(addresswidth-1 downto 0);
	    row: in std_logic_vector(integer(ceil(log2(real(numRowElements))))-1 downto 0);        -- used only of data is in a matrix (0-based)
	    column: in std_logic_vector(integer(ceil(log2(real(numColumnElements))))-1 downto 0);  -- used only if data is in vector or matrix (0-based)
	    byteToAccess: in std_logic_vector(integer(ceil(log2(real(dataWidth)/8.0)))-1 downto 0);    -- if dataWidt>8 (1 byte) this the number of the byte to access (0<= byeToAccess <= dataNumBytes)
		address: out std_logic_vector(addressWidth-1 downto 0) 
	);
	begin
	    assert not (isVector and isMatrix) report "Data can not be a vector and a matrix at the same time" severity error;
end entity;

architecture BEHAVIOURAL of dataAddress is
	constant dataNumBytes: positive := integer(ceil(real(dataWidth)/8.0));
	signal output: std_logic_vector(addressWidth-1 downto 0);
	--signal add1, add2, add3: std_logic_vector(addressWidth-1 downto 0);
    
    -- COMPLETE	
begin
	-- general formula for all:  baseaddress + dataNumBytes * (row * numColumnElements + column) + byteToAccess

	-- Same formula simplified for variables with dataNumBytes = 1:  baseaddress
	var1byte: if not isVector and not isMatrix and dataNumBytes = 1  generate
	    output <= baseaddress;
	end generate;
	
	-- Same formula simplified for variables with dataNumBytes > 1:  baseaddress + byteToAccess
    varP1byte: if not isVector and not isMatrix and dataNumBytes > 1 generate
        output <= std_logic_vector(unsigned(baseaddress) + unsigned(byteToAccess));
    end generate;
    
	-- Same formula simplified for vectors with dataNumBytes = 1:  baseaddress + column
	vector1byte: if isVector and not isMatrix and dataNumBytes = 1 generate
	    output <= std_logic_vector(unsigned(baseaddress) + unsigned(column));
	end generate;
	
	-- Same formula simplified for vectors with dataNumBytes > 1:  baseaddress + dataNumBytes*column + byteToAccess
    vectorP1byte: if isVector and not isMatrix and dataNumBytes > 1 generate
    	signal add1, add2, add3: std_logic_vector(addressWidth-1 downto 0);
        begin
            add1 <= std_logic_vector(unsigned(baseaddress) + unsigned(byteToAccess));
            add2 <= std_logic_vector((to_unsigned(dataNumBytes, column'length)*unsigned(column)));
            add3 <= std_logic_vector(unsigned(add1) + unsigned(add2));
            output <= add3;
    end generate;
    
	-- Same formula simplified for matrixes with dataNumBytes = 1:  baseaddress + row*numColumnElements + column
	matrix1byte: if isMatrix and not isVector and dataNumBytes = 1 generate
	    signal add1, add2: std_logic_vector(addressWidth-1 downto 0);
        begin
            add1 <= std_logic_vector(unsigned(baseaddress) + unsigned(column));
            add2 <= std_logic_vector((to_unsigned(numColumnElements, row'length)*unsigned(row)) + unsigned(add1));
	        output <= add2;
	 end generate;
	
	-- Same formula simplified for matrixes with dataNumBytes > 1:  baseaddress + dataNumBytes*row*numColumnElements + dataNumBytes*column + byteToAccess
	
	matrix1Pbyte: if isMatrix and not isVector and dataNumBytes > 1 generate
    	signal add1, add2, add3: std_logic_vector(addressWidth-1 downto 0);
        begin
            add1 <= std_logic_vector(unsigned(baseaddress) + unsigned(byteToAccess));
            add2 <= std_logic_vector((to_unsigned(dataNumBytes, column'length)*unsigned(column) + unsigned(add1)));
            add3 <= std_logic_vector((to_unsigned(dataNumBytes, row'length)*to_unsigned(numColumnElements, row'length)*unsigned(row) + unsigned(add2)));
	        output <= add3;
	 end generate;
	
	-- vector is the same as matrix[0, column]
	-- variable is the same as matrix[0, 0]	

    address <= output;
end architecture;
