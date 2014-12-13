*-----------------------------------------------------------
* Title      : M68k Disassembler
* Written by : Kaley & Cole & Abby
* Date       : 11/11/14
* Description: This program will examine assembly 
*              instructions at a given address range and
*              will disassemble the binary and output the
*              M68k instruction.
*-----------------------------------------------------------
                INCLUDE     'tests.x68'                 
*--------------------- HEX FOR OUTPUT ---------------------*
                OPT         CRE
CR              EQU         $0D
LF              EQU         $0A
STACK           EQU         $8000
                ORG         $1000
minaddress	    EQU	        $00000000 	
maxaddress	    EQU	        $00FFFFFF 	                
            
*----------------------------------------------------------*
*Mode Masks
* SRC 
EA_MODE         EQU         %00111000  
EA_REG          EQU         %00000111    
    
* DST
DEST_MODE       EQU         %00111000
DEST_REG        EQU         %00000111

*----------------------------------------------------------*
START:          
                LEA         STACK,SP                * load the stack
                JSR         PRINT_INTRO             * print the program intro
GET_START       MOVE.B      #14,D0        
                LEA         prompt_start,A1
                TRAP #15                            * prompt for starting address
            
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP #15                            * store user input
            
                JSR         asciiToHexS             * convert user input from start address to hex
	            
	            CMP.L 	    #0, D1		            * check to see if asciiToHexS reported an error
	            BNE 	    INPUT_ERROR	            * find wthe error message is. print it and loop to GET_START
                MOVE.L	    D3, A0		            * get the hex address

                MOVE.L	    A0,D3		            * put the start address in a data register
	            ANDI.L	    #$FFFFFFFE,D3	        * convert the address to an even number if it already isn't
	            MOVEA.L	    D0,A0		            * move the even address back to A0

	            MOVE.B	    #$03, D1	            * set the error code
	            CMP.L	    #minaddress, A0	        * check to see if start address is in bounds 
	            BLT	        INPUT_ERROR	            * find error

GET_END	            
                MOVE.B      #14,D0
                LEA         prompt_end,A1
                TRAP        #15                     * prompt for ending address
                CLR         D0
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP        #15                     * store user input
                JSR         asciiToHexE             * convert user input for end address to hex
                
	            CMP.L 	    #0, D1		            * check to see if asciiToHexE reported an error 
	            BNE	        INPUT_ERROR	            * error found. print it and loop to GET_START
                MOVE.L	    D4, A3		            * move end address to A3
                
	            MOVE.B	    #$04, D1	            * set the error code
	            CMP.L	    #maxaddress, A3	        * check if end address is in bounds
	            BGT	        INPUT_ERROR	            * find error
      
	            SUBQ.L	    #2, A3		            * take away 2 bytes to test distance
	            MOVE.B	    #$02, D1	            * set the error code
	            CMP.L	    A3, D3		            * check to see if end address is greater than start address
	            BGT	        INPUT_ERROR	            * find error
	            ADDQ.L	    #2, A3		            * return A3 back to normal
                
                MOVE.L	    A3,D4		            * put the end address in a data register
	            ANDI.L	    #$FFFFFFFE,D4	        * convert the address to an even number if it already isn't
            
                MOVE.L      D3,A1                   * move the start address into A1
                MOVE.L      D3,A2                   * also move it into A2
                MOVE.L      D4,A3                   * move the ending address into A3
                CLR.L       D0
                CLR.L       D1
                CLR.L       D2
                CLR.L       D3
                CLR.L       D4
                CLR.L       D5
                CLR.L       D6
                CLR.L       D7                      * clear all of the registers
                
                MOVE.W      #$0000,$00009000        * set counter to 0
                LEA         $000090A0,A5            * move the starting address of the output string to A1
                LEA         $00009010,A4
                MOVE.L      A5,A6                   * move the ending address of the output string here too (empty string)
                BRA         loop_start              * start the loop
                
loop_start
                CMP.W       $AAAA,A5
                CMP.W       #$AAAA,A5
                CMP.L       A3,A2                   * check to see if end is reached
                BGT         exit                    * nothing left, exit program
                       
                MOVE.L      #$00009000, A0          * Move address of count into A0
                ADD.W       #$01,(A0)               * increment count by one
                CMP.W       #$0020,(A0)             * check to see if count is 30
                BEQ         next_page               * if over 30, go to next page
                
                MOVE.W      (A2),D0                 * MOVEs INSTRUCTION in A1 to D0
                JSR         print_add               * print the address
                JSR         opcode                  * decode the opcode
            
                BRA         loop_exit
                
******************************* CLEAR REGISTERS **************************
* clearTempVars  - clears all of the temporary variables starting at $00009010
* clearOutputStr - clears all of the values starting at $000090A0


clearTempVars   MOVE.L      #$00009010,A0           * move the first address to A0
                BRA         CTV_loop                * begin the loop
               
CTV_loop        CMP.L       #$FFFFFFFF,(A0)         * check if the values at address A0 are all Fs
                BEQ         CTV_exit                * if they are, exit
                MOVE.L      #$FFFFFFFF,(A0)+        * otherwise, set them all to Fs and increment A0
                BRA         CTV_loop                * loop again
                
CTV_exit        RTS                                 * return to where clearTempVars was called

clearOutputStr  MOVE.L      #$000090A0,A0           * move the first address to A0
                BRA         COS_loop                * begin the loop
                
COS_loop        CMP.L       #$FFFFFFFF,(A0)         * check if the values at address A0 are all Fs
                BEQ         COS_exit                * if they are, exit
                MOVE.L      #$FFFFFFFF,(A0)+        * otherwise, set them all to Fs and increment A0
                BRA         COS_loop                * loop again
                
COS_exit        RTS                                 * return to where clearOutputStr was called
                

******************************* ASCII TO HEX *****************************
* Convert starting address from ASCII to Hex, stores in D3
* D0 = temp value, D1 = length of string, D2 = counter, D3 = ret val
* A1 = memory location of beginning of the string
asciiToHexS     CMP.B       #8,D1                   * check that length is <= 8
                BGT         INVALID_ADD
                CMP.B       #0,D1                   * check that length is > 0
                BLE         INVALID_ADD
                CLR.L       D3                      * clear return value
                SUBQ.B      #1,D1                   * subtract 1 from the counter
            
ATHS_loop       ROL.L       #4,D3                   * shift bits left by 4
                MOVE.B      (A1)+,D0                * copy next byte from memory to convert
                CMP.B       #$39,D0                 * if the value is < 39 its a number
                BGT         ATHS_letter             * its its not a number process it as a letter
                CMP.B       #$30,D0                 * if the value is < 30 its invalid
                BLT         INVALID_ADD
                SUBI.B      #$30,D0                 * its a valid number, subtract 30
                BRA         ATHS_done
            
ATHS_letter     CMP.B       #$66,D0                 * if the value is > 66 its invalid
                BGT         INVALID_ADD
                CMP.B       #$61,D0                 * if the value is >= 61 its lowercase
                BGE         ATHS_lower              * process it as a lowercase letter
                CMP.B       #$46,D0                 * if the value is less than 46 its invalid
                BGT         invalidAdd
                CMP.B       #$41,D0                 * if the value is less than 41 its invalid
                BLT         INVALID_ADD
                SUBI.B      #$37,D0                 * valid letter, subtract 37
                BRA         ATHS_done
            
ATHS_lower      SUBI.B      #$57,D0                 * convert lowercase letter to hex
                BRA         ATHS_done
            
ATHS_done       OR.L        D0,D3                   * OR the result to the retVal
                DBF         D1,ATHS_loop            * decrement counter and loop while they're > 0
                CLR.L D1                            * done
                RTS
            
* Convert ending address from ASCII to Hex, stores in D4
* D0 = temp value, D1 = length of string, D2 = counter, D4 = ret val
* A1 = memory location of beginning of the string
asciiToHexE     CMP.B       #8,D1                   * check that length is <= 8
                BGT         INVALID_ADD
                CMP.B       #0,D1                   * check that length is > 0
                BLE         INVALID_ADD
                CLR.L       D4                      * clear return value
                SUBQ.B      #1,D1                   * subtract 1 from the counter
            
ATHE_loop       ROL.L       #4,D4                   * shift bits left by 4
                MOVE.B      (A1)+,D0                * copy next byte from memory to convert
                CMP.B       #$39,D0                 * if the value is < 39 its a number
                BGT         ATHE_letter             * its its not a number process it as a letter
                CMP.B       #$30,D0                 * if the value is < 30 its invalid
                BLT         INVALID_ADD
                SUBI.B      #$30,D0                 * its a valid number, subtract 30
                BRA         ATHE_done
            
ATHE_letter     CMP.B       #$66,D0                 * if the value is > 66 its invalid
                BGT         INVALID_ADD
                CMP.B       #$61,D0                 * if the value is >= 61 its lowercase
                BGE         ATHE_lower              * process it as a lowercase letter
                CMP.B       #$46,D0                 * if the value is less than 46 its invalid
                BGT         INVALID_ADD
                CMP.B       #$41,D0                 * if the value is less than 41 its invalid
                BLT         INVALID_ADD
                SUBI.B      #$37,D0                 * valid letter, subtract 37
                BRA         ATHE_done
            
ATHE_lower      SUBI.B      #$57,D0                 * convert lowercase letter to hex
                BRA         ATHE_done
            
ATHE_done       OR.L        D0,D4                   * OR the result to the retVal
                DBF         D1,ATHE_loop            * decrement counter and loop while they're > 0
                CLR.L       D1                      * done
                RTS
                
INVALID_ADD
	            MOVE.B	    #$01,D1		            * Return error in D1 (0 = success) 
                RTS               
*******************************************************************************************
* INPUT_ERROR 
* Determines what error message to print based on what D1 is before jumping here	   
* D1 = Error code
*

* compare error codes to see what type of error was caught
INPUT_ERROR
	            CMP.B	    #$01,D1	 
	            BEQ	E1	                            * got to type 1 error

	            CMP.B	    #$02,D1	
	            BEQ	        E2	                    * go to type 2 error
	
	            CMP.B	    #$03,D1
	            BEQ	E3	                            * go to type 3 error    

	            CMP.W	    #$04,D1
	            BEQ	E4	                            * go to type 4 error

	            LEA	        ERROR_STR, A1	        * get error message
	            BRA	        PRINT_ERROR             * print default error and go to GET_START

* Address entered was not valid	
E1	
	            LEA	        ERROR_INVALID_ADD_STR, A1	* load error string
	            BRA	        PRINT_ERROR	                * print invalid address message

* Start and end address are less than 2 bits apart, or start address is greater than end address	
E2	
	            LEA	        ERROR_SGREATER_STR, A1	    * load error string
	            CMP         D4,D3                       * check to see if start address is greater than end address
                BGT         PRINT_ERROR                 * print start is greater than end message
                LEA	        ERROR_2BYTE_STR, A1	        * load error string
	            BRA	        PRINT_ERROR	                * print less than 2 bits apart message

* the start address is less than the minimum address bound	
E3	    
	            LEA	        ERROR_SBOUND_STR, A1	    * load error string 
	            BRA	        PRINT_ERROR	                * display the error message

* the end address is greater than the maximum bound	
E4	    
	            LEA	        ERROR_EBOUND_STR, A1	    * load error string
	            BRA	        PRINT_ERROR	                * print the error message

* print out the error message that was loaded in on of the error types	
PRINT_ERROR
	            MOVE.B	    #13, D0                     * print the error message	                
	            TRAP	    #15		                
	            BRA 	    GET_START                   * go to GET_START
******************************* HEX TO ASCII *****************************
* Convert starting address from Hex to Ascii, stores in A0
* D0 = value to convert, D1 = number of bytes to process, A0 = retval

HEXTOASCII      ANDI.L      #$000000FF,D1           * get the byte
                CMP.B       #4,D1
                BGT         HTA_error               * error if > 4 bytes
                CMP.B       #0,D1
                BLE         HTA_error               * error if <= 0 bytes
                MOVEM.L     D0/D2-D3,-(A7)
                ROL.L       #1,D1
                SUBQ.L      #1,D1
                MOVE.L      D1,D3
                
HTA_loop        MOVE.L      D0,D2
                ANDI.B      #$0F,D2
                CMP.B       #9,D2
                BGT         HTA_letter
                ADDI        #48,D2
                BRA         HTA_next
                
HTA_letter      ADDI        #55,D2

HTA_next        MOVE.B      D2,-(A7)
                ROR.L       #4,D0
                DBF         D1,HTA_loop
                
HTA_string      MOVE.B      (A7)+,(A0)+
                DBF         D3,HTA_string
                
                MOVEM.L     (A7)+,D0/D2-D3
                
                RTS
                
HTA_error       BRA         op_DATA




*-------------------------------OPCODE-----------------------------------*
* OPCODE section; this section separates the opcode and the
* necessary instruction bits for each operation, before moving to
* the specific operation
*
opcode          LEA         JUMPTABLE,A0            * load the jump table into A0
                JSR         OC_decode               * decode the opcode
                CLR.L       D1                      * clear D1
                MOVE.L      D0,D1                   * move instruction into D1
                MOVE.B      #12,D2                  * load the value 12 into D2
            
                       
                LSR.W       D2,D7                   * shift the original operation right by 12 bits
                MULU        #6,D7                   * multiply the new value in D7 by 6
                JSR         00(A0,D7)               * find the corresponding code in the jump table
            
OC_decode       MOVE.W      D0,D1                   * move the original operation into D1
                MOVE.W      D0,D7                   * also move it into D7          (Effective Addressing BITS)
                ANDI.W      #$003F,D1
                MOVE.B      D1,D5                   * move the last 6 bits into D5
            
                ROR.W       #6,D0                   * rotate the operation to the right by 6 bits
                MOVE.W      D0,D1                   * move the new op value into D1      (OPMODE BITS)
                ANDI.W      #$0007,D1
                MOVE.B      D1,D4                   * move these bits into D4
            
                ROR.W       #3,D0                   * rotate the operation to the right by 3 bits
                MOVE.W      D0,D1                   * move the new op value into D1      (Register bits)
                ANDI.W      #$0007,D1
                MOVE.B      D1,D3                   * move these bits into D3
                
                RTS
                
*-------------------------------------------------------------------------*
* Jump-table jumps to the correct operation according the 
* first 4 digits of the operation.
*
JUMPTABLE       JMP         op0000                  * ORI, BCLR
                JMP         op0001                  * MOVE.B
                JMP         op0010                  * MOVE.L
                JMP         op0011                  * MOVE.W
                JMP         op0100                  * NEG, NOP, LEA, JSR, RTS
                JMP         op0101                  * SUBQ
                JMP         op0110                  * BRA
                JMP         op0111
                JMP         op1000                  * OR.X
                JMP         op1001                  * SUB, SUBA
                JMP         op1010              
                JMP         op1011
                JMP         op1100
                JMP         op1101                  * ADD, ADDA
                JMP         op1110
                JMP         op1111

*-------------------------------------------------------------------------*
* Inclusive Or, Test a Bit and Clear, Compare Immediate
*-------------------------------------------------------------------------* 
op0000          *ORI
                MOVE.W      (A2),D1                 * copy instruction into D1
                ANDI        #$FF00,D1
                CMP.W       #$0000,D1
                BEQ         op_ORI                  * check bits 8-15 for ORI
            
                *BCLR STATIC
                MOVE.W      (A2),D1
                ANDI        #$FFC0,D1
                CMP.W       #$0880,D1
                BEQ         op_BCLR_STAT
                
                *BCLR DYNAMIC
                MOVE.W      (A2),D1                 * copy instruction into D1
                ANDI        #$01C0,D1
                CMP.W       #$0180,D1
                BEQ         op_BCLR_DYN             * check bits 9-11 for BCLR
            
                *CMPI
                MOVE.W      (A2),D1
                ANDI        #$FF00,D1               * mask for the first 8 bits
                CMP.W       #$0C00,D1
                BEQ         op_CMPI                 * check bits 8-15 for CMPI
            
                BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Byte Opmode
*-------------------------------------------------------------------------*
op0001          LEA        MOVEB_STR,A5             * Load the MOVE.B string
                MOVE.B     #$00,D6                  * Set the IM-DATA size code
                BRA        op_MOVE                  * Branch to general move op
                
                BRA        op_DATA

            
*-------------------------------------------------------------------------*
* Move Long  : MOVEA DOESN'T NEED EXTRA SPACING, ONLY TAB
*            : MOVE NEEDS ONE EXTRA SPACE
*-------------------------------------------------------------------------*            
op0010          
                *MOVEA.L
                LEA         MOVEAL_STR,A5
                MOVE.W      (A2),D0                 * move operation for compare
                MOVE.W      (A2),D1                 * move operation for flagging
	            ANDI.W	    #$01C0,D0
    	        CMP.W	    #$0040,D0
	            BEQ         op_MOVEA 	            * Check for MOVEA.L               
                
                
                
                LEA         MOVEL_STR,A5        * Load the MOVE.L string
                MOVE.B      #$02,D6             * Set IM-DATA size code
                BRA         op_MOVE             * Branch to general move op
                
                BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Word  : MOVEA DOESN'T NEED EXTRA SPACING, ONLY TAB
*            : MOVE NEEDS ONE EXTRA SPACE
*-------------------------------------------------------------------------*             
op0011          
                *MOVEA.W
                LEA         MOVEAW_STR,A5
                MOVE.W      (A2),D0                 * move operation for compare
                MOVE.W      (A2),D1                 * move operation for flagging
	            ANDI.W	    #$01C0,D0
    	        CMP.W	    #$0040,D0
	            BEQ         op_MOVEA	            * Check for MOVEA.W  
	            
	            

                LEA         MOVEW_STR,A5            * Load the MOVE.L string
                MOVE.B      #$02,D6                 * Set IM-DATA size code
                BRA         op_MOVE                 * Branch to general move op

                BRA         op_DATA

*-------------------------------------------------------------------------*
* Negate, No Operation, Load Effective Address, Jump to Subroutine, 
* Return from Subroutine, Move Multiple Registers
*-------------------------------------------------------------------------*             
op0100          *NEG
                MOVE.W      (A2),D1                 * move operation into D1
	            ANDI.W	    #$FF00,D1
    	        CMP.W	    #$4400,D1
	            BEQ         op_NEG	                * Check for NEG
	        
                *NOP
                MOVE.W      (A2),D1                 * move the original operation into D1
                CMP.W       #$4E71,D1               * compare D0 and D1
                BEQ         op_NOP                  * if they're equal, the operation is NOP
            
                *LEA
                MOVE.W      (A2),D1
                ANDI.W      #$F1C0,D1
                CMP.W       #$41C0,D1
                BEQ         op_LEA

                *JSR
                MOVE.W      (A2),D1                 * move the original operation into D1 
                ANDI.W      #$FFC0,D1
                CMP.W       #$4E80,D1
                BEQ         op_JSR                  * check bits 6-15 to compare for JSR
            
                *RTS
                MOVE.W      (A2),D1                 * move the original operation into D1
                CMP.W       #$4E75,D1
                BEQ         op_RTS                  * check for RTS
                
                *MOVEM
                MOVE.W      (A2),D1                 * move the original operation into D1
                MOVE.W      (A2),D2                 * move operation into D2 for masking
                ANDI.W      #$0B80,D1               * mask MOVEM defining bits
                CMP.W       #$0880,D1               * compare masked bits to MOVEM bits
                BEQ         op_MOVEM                * go to MOVEM decode
                
            
                BRA         op_DATA                 * invalid
*-------------------------------------------------------------------------*
* SUBI - Subtracts the immediate data (1-8) from the destination
* operand. Only Word and Long operations can be used with Adress Registers
* (An).      
*-------------------------------------------------------------------------*
          
op0101          BRA         op_SUBQ

*-------------------------------------------------------------------------*
* Branch Subroutine, Branch Always, Branch Conditionally
*-------------------------------------------------------------------------*             
op0110          
                CLR.L       D0
                MOVE.W      (A2),D0
                ANDI.W      #$FF00,D0
                LSR.L       #8,D0                   * separate the first 8 bits (bits 8-15)
                CLR.L       D1
                MOVE.W      (A2),D1
                ANDI.W      #$00FF,D1
                CMP.W       #$60,D0                 * standard first 8 bits of a BRA op
                BEQ         op_BRA                  * if they're equal, OP code is BRA
                                            
                CMP.W       #$65,D0                 * Check for BCS
                BEQ         op_BCS
                
                CMP.W       #$6C,D0                 * Check for BGE
                BEQ         op_BGE

                CMP.W       #$6D,D0                 * Check for BLT
                BEQ         op_BLT
                
                CMP.W       #$68,D0                 * Check for BVC
                BEQ         op_BVC

                BRA         op_DATA                 * Otherwise branch to data

*-------------------------------------------------------------------------*
* Undeclared Jumptable Location
*-------------------------------------------------------------------------*
            
op0111          BRA         op_DATA

*-------------------------------------------------------------------------*
* Inclusive Or, Signed Divide
*-------------------------------------------------------------------------*
op1000          * DIVS
                CMP.W       #$07,D4                 * check the opmode field
                BEQ         op_DIVS                 * if it is 7, the operation is DIVS

                * OR
                JSR         op_OR                   * otherwise the operation is OR

                BRA         op_DATA

*-------------------------------------------------------------------------*
* Subtract
*-------------------------------------------------------------------------*             
op1001          MOVE.W      (A2),D1                 * Move operation into D1 
                ANDI.W      #$F000,D1               * MASK for SUB operation
                CMP.W       #$9000,D1
                BEQ         op_SUB                  

                
                BRA         op_DATA



*-------------------------------------------------------------------------*
* Undeclared Jumptable Location
*-------------------------------------------------------------------------*
            
op1010          BRA         op_DATA

*-------------------------------------------------------------------------*
* Exclusive Or, Compare
*-------------------------------------------------------------------------*             
op1011          
                *EOR
	            MOVE.W	    (A2),D0                 * copy op for compare
	            ANDI.W	    #$F100,D0               * grab identifier bits
	            CMP.W	    #$B100,D0               * check to see if EOR
                BEQ         op_EOR
                
                *CMP
                MOVE.W      (A2),D0                 * copy op for compare
                MOVE.W      (A2),D1                 * copy op for testing
                ANDI.W	    #$F100,D0               * grab identifier bits
                CMP.W       #$B000,D0               * check to see if CMP
                BEQ         op_CMP              

                BRA         op_DATA

*-------------------------------------------------------------------------*
* Signed Multiply
*-------------------------------------------------------------------------*            
op1100          CMP.B       #$07,D4                 * check for Signed Multiply Word
                BEQ         op_MULS
                
                BRA         op_DATA
                
*-------------------------------------------------------------------------*
* Add
*-------------------------------------------------------------------------*            
op1101          BRA         op_ADD  Jump to Add operation

*-------------------------------------------------------------------------*
* Arithmetic Shift Left, Arithmetic Shift Right, Logical Shift Left, 
* Logical Shift Right, Rotate Left, Rotate Right
*-------------------------------------------------------------------------*            
op1110          MOVE.W      (A2),D0                 * move original op into D0
                ANDI.W      #$00C0,D0               * mask to find if it's an EA shift
                CMP.W       #$00C0,D0               * check for EA shifts
                BEQ         SHIFT_ea

                BRA         SHIFT_no_ea
                
*-------------------------------------------------------------------------*      
*Undeclared Jumptable Location   
*-------------------------------------------------------------------------*
                         
op1111          BRA         op_DATA




*-------------------------INDIVIDUAL-OPERATIONS---------------------------*



*-----------------------------------------------------------------*
* Signed Divide
* Divides the signed destination operand by the signed 
* source operand.
*
op_DIVS         LEA         DIVSW_STR,A5
                MOVE.L      A5,(A6)+                * add the operation to the output
                BRA         op_SIGN_MD

*-----------------------------------------------------------------*
* Signed Multiply
* Multiplies two signed operands yielding a signed result.
*
*                
op_MULS         LEA         MULSW_STR,A5            * add the operation to the output
                MOVE.L      A5,(A6)+
                BRA         op_SIGN_MD
                
op_SIGN_MD
                JSR         PRINT_ALI_1
                MOVE.W      D5,D0                   * copy the EA bits into D0
                ANDI.W      #$38,D0                 * Separate the mode
                CMP.W       #$08,D0                 * check if its mode 1
                BEQ         op_DATA                 * if it is, it's invalid
                
                MOVE.L      #$00000001,D6           * set the flag bit
                ADD.W       #$02,A2                 * increment the current operation address
                JSR         FIND_EAMODE             * create the left side of the operation
                
                JSR         PRINT_COMMA
                
                MOVE.L      #$00000000,D4           * Move our Dn mode to D4
                JSR         FIND_OPMODE             * Now move to our mode
                
                JSR         PRINT_init              * print the output string
                
                BRA         loop_exit               * address has been processed


SHIFT_ea        MOVE.W      (A2),D0                 * move original op into D0
                MOVE.W      (A2),D2                 * move the original op into D2

                ANDI.W      #$0E00,D0               * mask to find out which shift it is
                *LSL/LSR
                CMP.W       #$0200,D0               * check for LSL/LSR
                BEQ         op_LS
                
                *ASL/ASR
                CMP.W       #$0000,D0               * check for ASL/ASR
                BEQ         op_AS
                
                *ROL/ROR
                CMP.W       #$0600,D0               * check for ROL/ROR
                BEQ         op_RO
                
                BRA         op_DATA
                
SHIFT_no_ea     MOVE.W      (A2),D0                 * move the original op into D0
                MOVE.W      (A2),D1                 * move the original op into D1
                MOVE.W      (A2),D2                 * move the original op into D2
                MOVE.W      (A2),D3                 * move the original op into D3
                MOVE.W      (A2),D4                 * move the original op into D4
                MOVE.W      (A2),D5                 * move the original op into D5
                MOVE.W      (A2),D6
                AND.L       #$0E00,D1               * move the count/register into D1
                AND.L       #$0018,D2               * move the type of shift to D2
                AND.L       #$0020,D4               * move the i/r field into D4
                AND.L       #$0007,D5               * move the register into D5
                AND.L       #$00C0,D3               * move the size into D3
                
                CMP.W       #$0000,D2               * check for Arithmetic shift
                BEQ         AS_NO_EA
                
                CMP.W       #$0018,D2               * check for Rotate
                BEQ         RO_NO_EA
                
                CMP.W       #$0008,D2               * check for Logical shift
                BEQ         LS_NO_EA
                
                BRA         op_DATA
                
AS_NO_EA        JSR         AS_FIND_DIR
                MOVEM.L     D0-D7,-(SP)
                JSR         SHIFT_IR
                MOVEM.L     (SP)+,D0-D7
                RTS
                
AS_FIND_DIR     AND.L       #$0100,D6               * move the direction into D2
                CMP.L       #$0100,D6               * check for left rotate
                BEQ         op_ASL_STR
                CMP.L       #$0000,D6               * check for right rotate
                BEQ         op_ASR_STR

op_ASL_STR      LEA         ASL_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS
                
op_ASR_STR      LEA         ASR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS

RO_NO_EA        JSR         RO_FIND_DIR
                MOVEM.L     D0-D7,-(SP)
                JSR         SHIFT_IR
                MOVEM.L     (SP)+,D0-D7
                RTS
                
RO_FIND_DIR     AND.L       #$0100,D6               * move the direction into D3
                CMP.L       #$0100,D6               * check for left rotate
                BEQ         op_ROL_STR
                CMP.L       #$0000,D6               * check for right rotate
                BEQ         op_ROR_STR

op_ROL_STR      LEA         ROL_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS
                
op_ROR_STR      LEA         ROR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS

LS_NO_EA        JSR         LS_FIND_DIR
                MOVEM.L     D0-D7,-(SP)
                JSR         SHIFT_IR
                MOVEM.L     (SP)+,D0-D7
                RTS

LS_FIND_DIR     ANDI.W      #$0100,D6
                CMP.W       #$0100,D6
                BEQ         op_LSL_STR
                CMP.W       #$0000,D6
                BEQ         op_LSR_STR
                
op_LSL_STR      LEA         LSL_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS
                
op_LSR_STR      LEA         LSR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                RTS
*-----------------------------------------------------------------*
* Rotate Operations
*                
op_RO           MOVE.W      (A2),D0                 * move the original op into D0
                MOVE.W      (A2),D1                 * move the original op into D1
                MOVE.W      (A2),D2                 * move the original op into D2
                MOVE.W      (A2),D3                 * move the original op into D3
                MOVE.W      (A2),D4                 * move the original op into D4
                MOVE.W      (A2),D5                 * move the original op into D5
                MOVE.W      (A2),D6                 * move the original op into D6
                JSR         RO_FIND_DIR             * find the direction of the operation

                JSR         op_SHIFT_EA
                
                RTS
*-----------------------------------------------------------------*
* Arithmetic Shift Operations
*               
op_AS           MOVE.W      (A2),D0                 * move the original op into D0
                MOVE.W      (A2),D1                 * move the original op into D1
                MOVE.W      (A2),D2                 * move the original op into D2
                MOVE.W      (A2),D3                 * move the original op into D3
                MOVE.W      (A2),D4                 * move the original op into D4
                MOVE.W      (A2),D5                 * move the original op into D5
                JSR         AS_FIND_DIR             * find the direction of the operation
               
                JSR         op_SHIFT_EA
                
                RTS

*-----------------------------------------------------------------*
* Logical Shift Operations
*                
op_LS           MOVE.W      (A2),D0                 * move the original op into D0
                MOVE.W      (A2),D1                 * move the original op into D1
                MOVE.W      (A2),D2                 * move the original op into D2
                MOVE.W      (A2),D3                 * move the original op into D3
                MOVE.W      (A2),D4                 * move the original op into D4
                MOVE.W      (A2),D5                 * move the original op into D5
                MOVE.W      (A2),D6
                JSR         LS_FIND_DIR             * find the direction of the operation
               
                JSR         op_SHIFT_EA
                
                RTS
            
                
SHIFT_IR        JSR         opcode_size_str         * add the size to the string
                CMP.W       #$0000,D4               * check for count shift
                BEQ         SHIFT_count
                CMP.W       #$0020,D4               * check for register shift
                BEQ         SHIFT_reg
                
op_SHIFT_EA     JSR         PRINT_ALI_4
                
                ANDI.W      #$3F,D5
                
                CMP.W       #$3C,D5                 * mode 7, reg 4 invalid
                BEQ         op_DATA
                
                MOVEM.L     D0/D5,-(SP)             * store D0 on the stack
                MOVE.L      D5,D0                   * move D5 to D0 to change it
                ANDI.L      #$38,D0                 * separate the mode
                CMP.W       #$00,D0                 * check if its mode 0
                BEQ         op_DATA                 * if it is, it's invalid
                CMP.W       #$08,D0                 * check if its mode 1
                BEQ         op_DATA                 * if it is, it's invalid
                MOVEM.L     (SP)+,D0/D5
                
                ANDI.W      #$003F,D5               * mask D5 for the op mode
                ADD.W       #$02,A2                 * move to the next instruction
                JSR         FIND_EAMODE
                
                JSR         PRINT_init
                BRA         loop_exit

SHIFT_count     JSR         PRINT_ALI_1

                LEA         POUND,A5
                MOVE.L      A5,(A6)+                * add # to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #$0E00,D1
                LSR.L       #8,D1
                LSR.L       #1,D1               * shift to get the register
                
                CMP.B       #0,D1               * check for zero
                BEQ         SC_EIGHT

                
SC_RESUME       ADD.W       #$30,D1             * convert ascii number to hex
            
                MOVE.B      D1,(A4)+                * move the register to A4
                MOVE.B      #$00,(A4)+              * add the string terminating character
                MOVE.L      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * add the register to the string
            
                LEA         COMMA,A5                * add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+                * add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #$0007,D1
                ADD.W       #$30,D1                 * convert the register to hex

                MOVE.B      D1,(A4)+                * move the register to A4
                MOVE.B      #$00,(A4)+              * add the string terminating character
                MOVE.L      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * add the register to the string
            
                JSR         PRINT_init              * print the string
                ADD.W       #$02,A2
                BRA         loop_exit

SHIFT_reg       JSR         PRINT_ALI_1

                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+                * add 'D' to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #$0E00,D1
                LSR.L       #8,D1
                LSR.L       #1,D1                   * shift to get the register
                ADD.W       #$30,D1                 * convert ascii number to hex
            
                MOVE.B      D1,(A4)+                * move the register to A4
                MOVE.B      #$00,(A4)+              * add the string terminating character
                MOVE.L      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * add the register to the string
            
                LEA         COMMA,A5                * add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+                * add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #$0007,D1
                ADD.W       #$30,D1                 * convert the register to hex

                MOVE.B      D1,(A4)+                * move the register to A4
                MOVE.B      #$00,(A4)+              * add the string terminating character
                MOVE.L      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * add the register to the string
            
                JSR         PRINT_init              * print the string
                ADD.W       #$02,A2
                BRA         loop_exit
                
                
SC_EIGHT        MOVE.B      #8,D1               * for shift #8
                BRA         SC_RESUME    
            
*-----------------------------------------------------------------*
* Helper method for EOR to set the operation size
*
*
EOR_opmode      CMP.W       #$04,D4                 * check if byte
                BEQ         print_B_str             * go add .B to string
                CMP.W       #$05,D4                 * check if word
                BEQ         print_W_str             * go add .W to string
                CMP.W       #$06,D4                 * check if long
                BEQ         print_L_str             * go add .L to string
                BRA         op_DATA

*-----------------------------------------------------------------*
* Helper method for CMP to set the operation size
*
*
CMP_opmode      CMP.W       #$0000,D4               * check if byte
                BEQ         print_B_str             * go add .B to string
                CMP.W       #$0001,D4               * check if word
                BEQ         print_W_str             * go add .W to string
                CMP.W       #$0002,D4               * check if long 
                BEQ         print_L_str             * go add .L to string
                BRA         op_DATA
                
*-----------------------------------------------------------------*
* Helper method for OR to set the size op the operation                
*                
*
OR_opmode       MOVE.B      #$00,D6                 * set D6 for a byte operation
                CMP.W       #$0000,D4               * check for byte operation EA source
                BEQ         print_B_str
                CMP.W       #$0004,D4               * check for byte operation EA destination
                BEQ         print_B_str
                
                MOVE.B      #$01,D6                 * set D6 for a word operation
                CMP.W       #$01,D4                 * check for word operation EA source
                BEQ         print_W_str
                CMP.W       #$05,D4                 * check for word operation EA destination
                BEQ         print_W_str
                
                MOVE.B      #$02,D6                 * set D6 for a long operation
                CMP.W       #$02,D4                 * check for a long operation EA source
                BEQ         print_L_str
                CMP.W       #$06,D4                 * check for a long operation EA destination
                BEQ         print_L_str
                
                CMP.W       #$07,D4                 * check for an invalid opmode
                BEQ         op_DATA

*-----------------------------------------------------------------*
* Print Address
* Prints the address of the instruction
*

print_add       MOVEM.L     D0-D7,-(SP)             * Save the state
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.L      A2,D0
                MOVE.L      #$00000004,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                                
                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
                
                MOVEM.L     (SP)+,D0-D7             * restore the state
                RTS

*-----------------------------------------------------------------*
* NOP
* Performs no operation.
*            
op_NOP          LEA         NOP_STR,A5
                MOVE.L      A5,(A6)+                * add the operation to the string
                JSR         PRINT_init              * print the string
                BRA         loop_exit
                
*-----------------------------------------------------------------*
* DATA
* Prints out data on an incorrect instruction, in addition
* to the incorrect instruction.
*            
op_DATA         JSR         clearTempVars
                JSR         clearOutputStr
                MOVE.L      #$00009010,A4
                MOVE.L      #$000090A0,A6
                JSR         print_add

                LEA         DATA_STR,A5
                MOVE.L      A5,(A6)+                * add DATA to string

                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.W      (A2),D0
                MOVE.L      #$00000002,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore state
                
                ADD.L       #$04,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$05,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
                
                JSR         PRINT_init
                
                ADD.W       #$02,A2
                
                BRA         loop_exit


*-----------------------------------------------------------------*
* BRANCH ALWAYS
* Branches to PC counter plus displacement
*           
op_BRA          LEA         BRA_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4
                JSR         FIND_DISP
                BRA         loop_exit

*-----------------------------------------------------------------*
* FIND_DISP
* Helper method for branch functions calculates the needed
* displacement accordint to the current address and the 
* displacement.
*
             
FIND_DISP       LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+
                
                CMP.B       #$00,D1                 * check the value of the last 8 bits against $00
                BEQ         op_DISP16               * if equal, it's a 16 bit displacement
            
                CMP.B       #$FF,D1                 * check the value of the last 8 bits against $FF
                BEQ         op_DISP32               * if equal, it's a 32 bit displacement
            
                BRA         op_DISP8                * otherwise, it's an 8 bit displacement
                
                RTS
*-----------------------------------------------------------------*
* 8-bit Displacement
*
op_DISP8        MOVEM.L     D0-D7,-(SP)             * Save the state

                MOVE.L      A2,D0                   * Move current address in
                ADD.L       D1,D0                   * Add our displacement to current address
                
                MOVE.L      A4,A0                   * Move temp value pointer to A0
                MOVE.L      #$00000004,D1           * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore previous state
                ADD.L       #$08,A4                 * Prep temp variables
                MOVE.B      #$00,(A4)+              * Add terminating character
                MOVE.L      A4,D0                   * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                ADD.L       #$02,A2
                BRA         loop_exit
                
*-----------------------------------------------------------------*
* 16-bit Displacement
*            
op_DISP16       MOVEM.L     D0-D7,-(SP)             * Save the state

                MOVE.L      A2,D0                   * Move current address in
                ADD.W       #$02,A2                 * Advance the pointer
                MOVE.W      (A2)+,D1                * Advance pointer beyond data
                ADD.L       D1,D0                   * Add our displacement to current address
                
                MOVE.L      A4,A0                   * Move temp value pointer to A0
                MOVE.L      #$00000004,D1           * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore previous state
                ADD.L       #$08,A4                 * Prep temp variables
                MOVE.B      #$00,(A4)+              * Add terminating character
                MOVE.L      A4,D0                   * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                BRA         loop_exit

*-----------------------------------------------------------------*
* 32-bit Displacement
*
op_DISP32       MOVEM.L     D0-D7,-(SP)             * Save the state

                MOVE.L      A2,D0                   * Move current address in
                ADD.W       #$02,A2                 * Advance the pointer
                MOVE.L      (A2)+,D1                * Advance pointer beyond data
                ADD.L       D1,D0                   * Add our displacement to current address
                
                MOVE.L      A4,A0                   * Move temp value pointer to A0
                MOVE.L      #$00000004,D1           * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore previous state
                ADD.L       #$08,A4                 * Prep temp variables
                MOVE.B      #$00,(A4)+              * Add terminating character
                MOVE.L      A4,D0                   * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                BRA         loop_exit
                
*-----------------------------------------------------------------*
* BRANCH if CARRY SET
* Branches if the carry bit is set
*
op_BCS          LEA         BCS_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4
                JSR         FIND_DISP
                BRA         loop_exit               * eventually should jump to a repeat loop

*-----------------------------------------------------------------*
* BRANCH if GREATER THAN
* Branches if the result is greater than  or equal to 
* the compared operand.
*
                
op_BGE          LEA         BGE_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4
                JSR         FIND_DISP
                BRA         loop_exit               * eventually should jump to a repeat loop
                
*-----------------------------------------------------------------*
* BRANCH if LESS THAN
* Branches if the result is less than the compared operand
*
*
op_BLT          LEA         BLT_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4
                JSR         FIND_DISP
                BRA         loop_exit               * eventually should jump to a repeat loop

*-----------------------------------------------------------------*
* BRANCH if OVERFLOW SET
* Branches is the overflow bit is set in the CCR
*
op_BVC          LEA         BVC_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4
                JSR         FIND_DISP
                BRA         loop_exit               * eventually should jump to a repeat loop
                
*-----------------------------------------------------------------*
* COMPARE
* Subtracts the source operand from the destination register
* and sets the condition codes according to the results
*
op_CMP          LEA         CMP_STR,A5              * load op string
                MOVE.L      A5,(A6)+                * Add op string to output string
                JSR         CMP_opmode              * find the size and add it to the string
                JSR         PRINT_ALI_1             * align the columns

                ****Test for .B of An,Dn (invalid)
                ANDI.L      #$01F8,D1               * mask size and mode bits  
                CMP.L       #$0008,D1               * compare to invalid
                BEQ         op_DATA                 * invalid op, print DATA
                
                ANDI.L      #$01C0,D1               * mask the size bits
                LSR.B       #6,D1                   * rotate the bits to get size 
                MOVE.L      D1,D6                   * move size bits into flag             
                MOVE.L      D5,D0                   * load the op              
                ANDI.W      #$0038,D0               * mask the mode
                ADD.W       #$0002,A2               * increment the current address
                JSR         FIND_EAMODE             * create the left side of the operation
                JSR         PRINT_COMMA             * print a comma
                MOVE.L      #$00000000,D4           * set mode to 0 for Dn
                JSR         FIND_OPMODE             * create left side of operation

                JSR         PRINT_init              * print the output string
                BRA         loop_exit               * enter loop exit

*------------------------------------------------------------------*
* OP-Section for L_oad E_ffective A_ddress
* D5 - has the EA bits (6 bits)
* D4 - has the REGISTER NUMBER (A-N)
*         
op_LEA          MOVEM.L     D0/A1,-(SP)             * Save A1 & D0 to stack
            
                LEA         LEA_STR,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_ALI_4             * Print the tab
                MOVEM.L     (SP)+,D0/A1             * restore from stack
            
                * Since we know that in this case, LEA always moves
                * something to an address register An we can pass
                * our mode as 010 in D4 for Address Reg Direct
                CMP.W       #$3C,D5                 * Check for illegal #(data) mode
                BEQ         op_DATA         
                
                MOVEM.L     D0,-(SP)                * Just in case store whatever is in D)
                CLR         D0
                MOVE.W      D5,D0                   * Move D5 to D0
                ANDI.W      #$38,D0                 * Mask EA mode-bits
                CMP.W       #$0000,D0               * Check for illegal Dn mode
                BEQ         op_DATA
                CMP.W       #$08,D0                 * Check for illegal An mode
                BEQ         op_DATA 
                CMP.W       #$18,D0                 * Check for illegal (An)+ mode
                BEQ         op_DATA 
                CMP.W       #$20,D0                 * Check for illegal -(An) mode
                BEQ         op_DATA 
                
                MOVEM.L     (SP)+,D0                * Pop off the stack

                ADD.W       #$02,A2                 * MOVE TO JUST AHEAD OF THE INSTRUCTION                
                JSR         FIND_EAMODE             * We have our EA-bits in D5

                JSR         PRINT_COMMA             * Print the comma

                MOVEM.L     D4,-(SP)                * save contents of D4 on stack
                CLR         D4
                MOVE.B      #1,D4                   * Move our An mode to D4
                JSR         FIND_OPMODE             * Now move to our mode
            
                JSR         PRINT_init              * Print the output string
            
                MOVEM.L     (SP)+,D4                * Restore D4 before we go back
            
                BRA         loop_exit
            
*--------------------------------------------------------------*
* Jump to Subroutine 
* 
*

op_JSR          LEA         JSR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                
                CMP.W       #$3C,D5                 * Check for illegal #(data) mode
                BEQ         op_DATA         
                    
                MOVEM.L     D0,-(SP)                * Just in case store whatever is in D)
                CLR         D0
                MOVE.W      D5,D0                   * Move D5 to D0
                ANDI.W      #$0038,D0               * Mask EA mode-bits
                CMP.W       #$0000,D0               * Check for illegal Dn mode
                BEQ         op_DATA
                CMP.W       #$0008,D0               * Check for illegal An mode
                BEQ         op_DATA
                CMP.W       #$18,D0                 * Check for illegal (An)+ mode
                BEQ         op_DATA 
                CMP.W       #$20,D0                 * Check for illegal -(An) mode
                BEQ         op_DATA 
                
                MOVEM.L     (SP)+,D0                * Pop off the stack
                
                ADD.W       #$02,A2                 * Advance pointer beyond instruction
                JSR         PRINT_ALI_4
                JSR         FIND_EAMODE             * Find EA mode
                
                JSR         PRINT_init              * print the string
                BRA         loop_exit

*---------------------------------------------------------------*
* Exclusive OR
* Performs an exclusive OR on the source and destination
* operand.
*
op_EOR          LEA         EOR_STR,A5
                MOVE.L      A5,(A6)+
                JSR         EOR_opmode              * find the size and add it to the string
                
                JSR         PRINT_ALI_1
                
                MOVE.L      D5,D0
                ANDI.W      #$0038,D0               * mask the mode
                ** CHECK IF MODE IS INVALID **
                CMPI.W      #$0008,D0               * check for invalid mode 1   
                BEQ         op_DATA                 * mode 1, An, is invalid
                CMPI.W      #$003C,D0               * check for invalid mode 7 reg 4
                BEQ         op_DATA                 * mode 7 reg 4, #<data>, is invalid
                
                MOVE.L      #$00000000,D4           * set mode to 0
                JSR         FIND_OPMODE
                JSR         PRINT_COMMA

                ADD.W       #$0002,A2               * increment the current address
                JSR         FIND_EAMODE             * create the right side of the operation
                JSR         PRINT_init
                BRA         loop_exit
                
*-----------------------------------------------------------------*
* OR 
* Performs an inclusive OR on the source operand and the
* destination operand
*
op_OR           LEA         OR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                JSR         OR_opmode               * find the size and add it to the string
                JSR         PRINT_ALI_2
            
                ** CHECK IF EA IS THE DESTINATION **
                CMPI.W      #$0000,D4
                BEQ         op_OR_SRC
                CMPI.W      #$0001,D4
                BEQ         op_OR_SRC
                CMPI.W      #$0002,D4
                BEQ         op_OR_SRC
                
                ** CHECK IF EA IS THE SOURCE **
                CMPI.W      #$0004,D4
                BEQ         op_OR_DEST
                CMPI.W      #$0005,D4
                BEQ         op_OR_DEST
                CMPI.W      #$0006,D4
                BEQ         op_OR_DEST
            
                JSR         PRINT_init              * print the string
                BRA         loop_exit
                
op_OR_DEST      CMPI.W      #$003C,D5               * mode 7, register 4 is invalid
                BEQ         op_DATA 
                MOVE.L      D5,D0
                ANDI.W      #$0038,D0               * mask the mode
                CMPI.W      #$0000,D0               * mode 0 is invalid
                BEQ         op_DATA
                CMPI.W      #$0008,D0               * mode 1 is invalid
                BEQ         op_DATA
                
                MOVE.L      #$00000000,D4           * set mode to 0
                JSR         FIND_OPMODE             * create the LEFT side of the operation
                
                JSR         PRINT_COMMA

                ADD.W       #$0002,A2               * increment the current address
                JSR         FIND_EAMODE             * create the RIGHT side of the operation
                
                JSR         PRINT_init
                
                BRA         loop_exit

op_OR_SRC       MOVE.L      D5,D0
                ANDI.W      #$0038,D0               * mask the mode
                CMPI.W      #$0008,D0               * mode 1 is invalid
                BEQ         op_DATA
                
                ADD.W       #$0002,A2               * increment the current address
                JSR         FIND_EAMODE             * create the left side of the operation

                JSR         PRINT_COMMA
                
                MOVE.L      #$00000000,D4           * set mode to 0                
                JSR         FIND_OPMODE             * create the right side of the operation    
                JSR         PRINT_init
                
                BRA         loop_exit

*-----------------------------------------------------------------*
* OR INCLUSIVE
* Performs an inclusive-or in the immediate data and the 
* destination operand.
*
op_ORI          LEA         ORI_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3               * move the size into D3  
                JSR         opcode_size_str         * find the size and add it to the string
                
                JSR         PRINT_ALI_1

                MOVE.W      (A2),D1
                LSR.L       #6,D1                   * shift the size bits to get the flag 
                MOVE.L      D1,D6                   * move size bit to D6 to set flag
                **** CHECK FOR INVALID
                CMP.W       #$3C,D5                 * Mode 7, Register 4 is invalid
                BEQ         op_DATA
                
                CLR.L       D0
                MOVE.W      D5,D0                   * Move the EA into D0
                ANDI.W      #$38,D0                 * Separate the EA Mode into D0
                CMP.W       #$08,D0                 * Compare the An Addressing mode
                BEQ         op_DATA                 * invalid
                CMP.W       #$28,D0                 * check for mode 5
                BEQ         op_DATA
                CMP.W       #$30,D0                 * check for mode 6
                BEQ         op_DATA
                
                MOVE.L      #$00000007,D4           * set mode to 7 for mode 7
                MOVE.L      #$00000004,D3           * set register to 4 for Immediate Data
                
                ADD.L       #$00000002,A2           * move the current address forward by a word

                JSR         FIND_OPMODE             * create the left side of the operation
                JSR         PRINT_COMMA             * find the comma

                JSR         FIND_EAMODE             * create the right side of the operation

                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init              * print the string
                BRA         loop_exit
            
op_BCLR_STAT    LEA         BCLR_STR,A5             * add the op to the string
                MOVE.L      A5,(A6)+
                
                CMP.W       #$3C,D5                 * check for mode 7 register 4
                BEQ         op_DATA                 * invalid EA mode
                
                MOVE.W      D5,D0
                ANDI.W      #$38,D0                 * mask for EA mode
                CMP.W       #$08,D0                 * check for mode 2
                BEQ         op_DATA                 * invalid EA mode
                
                MOVE.W      (A2)+,D6                * store the original op in D6 and move to the next half of it
                MOVE.W      (A2),D0                 * move the second half to D0
                MOVE.W      (A2),D1                 * and D1
                ANDI.W      #$FF00,D0               * mask for the first byte in D0
                ANDI.W      #$00FF,D1               * and the second byte in D1
                
                CMP.W       #$0000,D0               * check for the valid bits in D0
                BNE         REWIND_add              * if they're invalid, rewind the current address and branch to op_DATA
                
                JSR         PRINT_ALI_3
                
                LEA         POUND,A5                * add the pound to the output
                MOVE.L      A5,(A6)+
                
                MOVE.L      A4,A0
                MOVE.W      D1,D0
                MOVE.L      #$00000001,D1           * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                ADD.L       #$02,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$03,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the number to the output string
                
                JSR         PRINT_COMMA
                
                CMP.W       #$38,D5
                BEQ         op_BCLR_STAT_ADD
                
                CMP.W       #$39,D5
                BEQ         op_BCLR_STAT_ADD
                
                JSR         FIND_EAMODE
                
                ADD.W       #$02,A2                 * Increment the current address
                
                JSR         PRINT_init
                BRA         loop_exit
                
op_BCLR_STAT_ADD
                ADD.W       #$02,A2
                JSR         FIND_EAMODE
                                
                JSR         PRINT_init
                BRA         loop_exit
                
REWIND_add      SUB.W       #$02,A2
                BRA         op_DATA
                
op_BCLR_DYN     LEA         BCLR_STR,A5             * add the op to the string
                MOVE.L      A5,(A6)+
            
                CMP.W       #$3C,D5                 * check for mode 7 register 4
                BEQ         op_DATA                 * invalid EA mode
                
                MOVE.W      D5,D0
                ANDI.W      #$38,D0                 * mask for EA mode
                CMP.W       #$08,D0                 * check for mode 2
                BEQ         op_DATA                 * invalid EA mode
                
                JSR         PRINT_ALI_3             * align last column
                
                LEA         DATA_REG,A5             * add the D to the output
                MOVE.L      A5,(A6)+
                
                MOVE.L      D3,D0
                ADD.W       #$30,D0
                MOVE.B      D0,(A4)+
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
                
                JSR         PRINT_COMMA             * print the comma
                    
                ADD.W       #$02,A2                 * increment the current address pointer
                
                JSR         FIND_EAMODE             * print the right side of the output
                
                
                JSR         PRINT_init
                BRA         loop_exit
                
*-----------------------------------------------------------------*
* MOVE ADDRESS 
* Moves the contents of the source to the destination address
*               
op_MOVEA        
                LSR.L       #6,D1                   * shift the size bits to get the flag 
                LSR.L       #6,D1                   * shift the size bits to get the flag
                MOVE.L      A5,(A6)+
                JSR         PRINT_TAB               * print space for alignment
               
                MOVE.L      D1,D6                   * move size bit to D6 to set flag
                CMP.B       #$03,D1                 * Check for size .W
                BEQ         SET_MOVEA_W

MOVEA_CONT      ADD.W       #$02,A2                 * increment the current address
                JSR         FIND_EAMODE             * add the left side of operation to output string
                JSR         PRINT_COMMA             * add a comma to output string
                MOVE.W      #$0001,D4               * set mode to 1 for An
                JSR         FIND_OPMODE             * add right operand to output string
                JSR         PRINT_init              * print the output string
                BRA         loop_exit               * exit the loop    
            
SET_MOVEA_W     MOVE.B      #1,D6
                BRA         MOVEA_CONT            

*------------------------------------------------------------------*    
* op_MOVE: Generic move method for all moves .B,.W,.L 
*
*

op_MOVE         MOVE.L      A5,(A6)+                * Move our op-sufix to str
                
                JSR         PRINT_ALI_1             * Spacer
                
                ADD.W       #$02,A2                 * advance pointer
                JSR         FIND_EAMODE             * Get the source operand
                
                CMP.B       #7,D4                   * If mode is 7 check reg 
                BEQ         CHECK_MOVEREG


MOVE_DONE       JSR         PRINT_COMMA             * Print comma
                JSR         FIND_OPMODE             * Get Destination Operand
                JSR         PRINT_init
                BRA         loop_exit

 
CHECK_MOVEREG   CMP.B       #4,D3                   * Prevent IM-DATA destination
                BEQ         op_DATA                 * error
                CMP.B       #3,D3                   * Prevent PC-Counter Disp
                BEQ         op_DATA                 * error
                CMP.B       #2,D3                   * Prevent PC Counter Ind.
                BEQ         op_data                 * error
                BRA         MOVE_DONE               * otherwise continue

*-----------------------------------------------------------------*
* OPCODE_SIZE_STR Helper method for attaching the operation
* size suffix for various operations.
*
*   
opcode_size_str CMP.W       #$0000,D3
                BEQ         print_B_str             * its a byte
                CMP.W       #$0040,D3
                BEQ         print_W_str             * its a word
                CMP.W       #$0080,D3
                BEQ         print_L_str             * its a long
                RTS
            
print_B_str     LEA         B_STR,A5                * Add the address of .B to the string
                MOVE.L      A5,(A6)+
                RTS

print_W_str     LEA         W_STR,A5                * Add the address of .W to the string
                MOVE.L      A5,(A6)+
                RTS

print_L_str     LEA         L_STR,A5                * Add the address of .L to the string
                MOVE.L      A5,(A6)+
                RTS
            
PRINT_init      LEA         $000090A0,A5            * load the beginning of the string
                BRA         PRINT_loop              * enter the print loop

            
PRINT_loop      CMP.L       #$FFFFFFFF,(A5)         * if the value at A5 is all F's, you've reached the end
                BEQ         PRINT_exit              * exit
                MOVE.L      #14,D0  
                MOVE.L      (A5),A1                 * load the address pointed at by A5 to A1
                TRAP        #15                     * print what the address points to
                ADDA.L      #$00000004,A5           * increment A5 by a long
                BRA         PRINT_loop              * loop
                RTS

PRINT_exit      MOVE.B      #14,D0
                LEA         new_line,A1
                TRAP        #15
                RTS
*-----------------------------------------------------------------*

*-----------------------------------------------------------------*
* Negate
* Subtracts the destination operand from zero and stores the result
* 
op_NEG          LEA         NEG_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3               * move the size into D3  
                JSR         opcode_size_str         * find the size and add it to the string            
                JSR         PRINT_ALI_1
                **** ADD TESTING
                MOVEM.L     D5,-(SP)                * save the state of D5
                ANDI.B      #$38,D5                 * separate the EA mode
                CMP.B       #$08,D5                 * check if it's mode 1
                BEQ         op_DATA                 * if is, it's invalid
                MOVEM.L     (SP)+,D5                * restore D5 if it isn't
                
                ADD.W       #$02,A2                 * Advance just ahead of instruction
                JSR         FIND_EAMODE
            
                JSR         PRINT_init              * print the string
                BRA         loop_exit
                
*------------------------------------------------------------------*
* RTS: Return From Subroutine
* 
*
op_RTS          LEA         RTS_STR,A5   
                MOVE.L      A5,(A6)+                * add the op to the string            
                JSR         PRINT_init              * print the string
                ADD.W       #02,A2                  * Advance pointer just after instruction
                BRA         loop_exit

*------------------------------------------------------------------*
* Logical Shift Right
* Shifts the bits in the operand in the direction specified
*
*

op_LSL          LEA         LSL_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3               * move the size into D3         
                JSR         opcode_size_str         * find the size and add it to the string            
                RTS
*------------------------------------------------------------------*
* Logical Shift Left
* Shifts the bits in the operand in the direction specified
*
*
          
op_LSR          LEA         LSR_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3               * move the size into D3  
                JSR         opcode_size_str         * find the size and add it to the string            
                RTS
*------------------------------------------------------------------*
* Compare Immediate
* Subtracts the immediate data from the destination
* operand and sets the condition code according to the result
*            
            
op_CMPI         LEA         CMPI_STR,A5
                MOVE.L      A5,(A6)+                * add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3               * move the size into D3  
                JSR         opcode_size_str         * find the size and add it to the string   
               
                JSR         PRINT_TAB

                MOVE.W      (A2),D1
                LSR.L       #6,D1                   * shift the size bits to get the flag 
                MOVE.L      D1,D6                   * move size bit to D6 to set flag
                **** CHECK FOR INVALID
                CMP.W       #$3C,D5                 * Mode 7, Register 4 is invalid
                BEQ         op_DATA
                
                CLR.L       D0
                MOVE.W      D5,D0                   * Move the EA into D0
                ANDI.W      #$38,D0                 * Separate the EA Mode into D0
                CMP.W       #$08,D0                 * Compare the An Addressing mode
                BEQ         op_DATA                 * invalid
                
                CLR.L       D0
                MOVE.W      D5,D0                   * Move the EA into D0
                ANDI.W      #$38,D0                 * Separate the EA Mode into D0
                CMP.W       #$08,D0                 * Compare the An Addressing mode
                BEQ         op_DATA                 * invalid
                CMP.W       #$28,D0                 * check for mode 5
                BEQ         op_DATA
                CMP.W       #$30,D0                 * check for mode 6
                BEQ         op_DATA
                
                MOVE.W      D3,D6
                LSR.L       #6,D6
                MOVE.L      #$00000007,D4           * set mode to 7 for mode 7
                MOVE.L      #$00000004,D3           * set register to 4 for Immediate Data
                
                ADD.L       #$00000002,A2           * move the current address forward by a word

                JSR         FIND_OPMODE             * create the left side of the operation
                JSR         PRINT_COMMA             * find the comma

                JSR         FIND_EAMODE             * create the right side of the operation

                **** FINDING/ADDING EA TO STRING HERE
                
                JSR         PRINT_init              * print the string
                BRA         loop_exit

                
            
                JSR         PRINT_init              * print the string
                RTS
*------------------------------------------------------------------*
* MOVEM Move Multiple registers
* Assumptions: Output will follow the following
* styling conventions: A7/A6/A7....D0/D1/... This was due
* to ambiguity of inputs such as A0-A5, etc.
*
*                
op_MOVEM        LEA         MOVEM_STR,A5
                MOVE.L      A5,(A6)+
                ANDI.L      #$0040,D2               * mask for size bit
                JSR         MOVEM_SIZE              * get size of instruction
                LEA         SMALL_TAB,A5
                MOVE.L      A5,(A6)+                * align the third column
                MOVE.W      (A2),D2                 * load instruction
                ANDI.L      #$0400,D2               * mask for direction
                CMP.W       #$0000,D2               * check for reg to mem
                BEQ         REG_TO_MEM              * branch to reg_to_mem
                CMP.W       #$0400,D2               * check for mem to reg
                BEQ         MEM_TO_REG              * branch to mem_to_reg

MOVEM_SIZE      CMP.W       #$00,D2                 * check if size is 0
                BEQ         PRINT_W_STR             * add .W to string
                CMP.W       #$40,D2                 * check if size is 1
                BEQ         PRINT_L_STR             * add .L to string
                RTS

REG_TO_MEM      CMP.W       #$3C,D5                 ***test for mode 7 reg 4 INVALID
                BEQ         op_DATA
                
                MOVE.W      D5,D0                   * move instruction to D0
                ANDI.W      #$38,D0                 * mask for the mode
                CMP.W       #$00,D0                 * check for mode 0 (INVALID)
                BEQ         op_DATA
                CMP.W       #$08,D0                 * check for mode 1 (INVALID)
                BEQ         op_DATA
                CMP.W       #$18,D0                 * check for mode 3 (INVALID)
                BEQ         op_DATA
                CMP.W       #$20,D0                 * check for predec
                BEQ         RTM_PREDEC
                CMP.W       #$28,D0                 * compare to mode 5
                BEQ         op_DATA
                CMP.W       #$30,D0                 * compare to mode 6
                BEQ         op_DATA
                
                LEA         MOVEM_POST_STR,A1       * load address of REG string into A1
                ADD.W       #$02,A2                 * move the current pointer to the next half of the op
                MOVE.W      (A2),D2                 * move the second half of the op to D2
                JSR         PARSE_STR               * set up the registers
                
                JSR         PRINT_COMMA             * add the comma
                
                ADD.W       #$02,A2                 * move the current address pointer forward a word
                JSR         FIND_EAMODE             * set up the second half
                JSR         PRINT_init              * print the output
                BRA         loop_exit


RTM_PREDEC      LEA         MOVEM_PRE_STR,A1        * load address of REG string into A1
                ADD.W       #$02,A2                 * move the current pointer to the next half of the op
                MOVE.W      (A2),D2                 * move the second half of the op to D2
                JSR         PARSE_STR               * set up the registers
                
                JSR         PRINT_COMMA             * add the comma
                
                ADD.W       #$02,A2                 * move the current address pointer forward a word
                JSR         FIND_EAMODE             * set up the second half
                JSR         PRINT_init              * print the output
                BRA         loop_exit

MEM_TO_REG      CMP.W       #$3C,D5                 ***test for mode 7 reg 4 INVALID
                BEQ         op_DATA
                
                MOVE.W      D5,D0
                ANDI.W      #$38,D0                 * mask for the mode
                CMP.W       #$00,D0                 * compare to mode 0
                BEQ         op_DATA
                CMP.W       #$08,D0                 * compare to mode 1
                BEQ         op_DATA
                CMP.W       #$20,D0                 * compare to mode 4
                BEQ         op_DATA             
                CMP.W       #$28,D0                 * compare to mode 5
                BEQ         op_DATA
                CMP.W       #$30,D0                 * compare to mode 6
                BEQ         op_DATA
               
                ADD.W       #$02,A2                 * move the current address pointer forward a word
                MOVE.W      (A2),D6                 * store the second word of the op in D6
                ADD.W       #$02,A2                 * move to the third word of the op
                JSR         FIND_EAMODE             * set up the second half

                JSR         PRINT_COMMA             * add the comma
                
                LEA         MOVEM_POST_STR,A1       * load address of REG string into A1
                MOVE.W      D6,D2                   * move the second word of the op to D2
                JSR         PARSE_STR               * set up the registers
                
                JSR         PRINT_init              * print the output
                BRA         loop_exit


*****Assumes second half of op is in D2, and assumes A1 has the address of the string

PARSE_STR       MOVEM.L     D0-D7,-(SP)             * save all data registers
                MOVE.L      #$00000000,D6           * clear D6 - the counter
             
                JSR         PS_loop                 * jump to PS_loop
                JSR         PS_exit_loop            * jump to PS_exit_loop
                MOVEM.L     (SP)+,D0-D7             * restore the data registers
                RTS                                 * return to the calling sub routine
                
PS_loop         MOVE.B      (A1)+,D1                * load the first word of the string into D1
                LSL.W       #8,D1
                MOVE.B      (A1)+,D1
                MOVE.W      D2,D0                   * copy the second half of the op into D0
                ANDI.W      #$8000,D0               * mask for the first bit of the word
                CMP.W       #$8000,D0               * check if the first bit is a 1
                BEQ         PS_valid_add            * add it to the output if it is
                BRA         PS_inc_count            * increment the counter
                
PS_valid_add    MOVE.L      A4,A0                   * copy the current pointer of the temp string into A0
                MOVE.B      D1,(A4)+
                LSR.W       #8,D1
                MOVE.B      D1,(A4)+                * copy the current pointer to the register string into A4
                MOVE.B      #$2F,(A4)+
                MOVE.B      #$00,(A4)+              * add '/' and the terminating character to the temp string
                MOVE.L      A0,(A6)+                * add the starting address to the output list
                BRA         PS_inc_count            * increment the counter
                
PS_inc_count    LSL.L       #1,D2                   * shift the second half of the op by 1 bit
                ADD.B       #$01,D6                 * add 1 bit to the counter
                CMP.W       #$10,D6                 * check if the counter has reached 16
                BNE         PS_loop
                RTS                                 * return to PARSE_STR if the loop is complete
                
PS_exit_loop    MOVE.L      A4,A0                   * copy A4 into A0
                SUB.W       #$02,A0                 * move A0 back by 2
                MOVE.B      #$00,(A0)+
                MOVE.B      #$FF,(A0)+              * overwrite the current data in A0 with 00FF
                MOVE.L      A0,A4                   * copy A0 back into A4
                RTS
        
*------------------------------------------------------------------*
* SUB & SUBA
* Subtract & Subtract from Address
*
op_SUB          LEA         SUB_STR,A5              * Go to SUB mode
                MOVE.L      A5,(A6)+                * Load SUB String


                CMP.B       #3,D4                   * ADDA.W
                BEQ         OP_ADDRESS              * Go to SUBA.W Mode
                                
                CMP.B       #7,D4                   * ADDA.L
                BEQ         OP_ADDRESS              * Go to SUBA.L Mode

                CMP.B       #0,D4                   * FIND OUT THE MODE for SUB
                BEQ         ARITH_MODE_1            * <EA> -> Dn Byte
                CMP.B       #1,D4
                BEQ         ARITH_MODE_1            * <EA> -> Dn Word 
                CMP.B       #2,D4
                BEQ         ARITH_MODE_1            * <EA> -> Dn Long
               

                CMP.B       #4,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Byte
                CMP.B       #5,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Word
                CMP.B       #6,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Long
            
*------------------------------------------------------------------*
* ADD & ADDA
* Addition and Add to Address
*
op_ADD          LEA         ADD_STR,A5              * Go to ADD mode
                MOVE.L      A5,(A6)+                * Load ADD String

 
                CMP.B       #3,D4                   * ADDA.W
                BEQ         OP_ADDRESS              * Go to ADDA.W Mode
                                 
                CMP.B       #7,D4                   * ADDA.L
                BEQ         OP_ADDRESS              * Go to ADDA.L Mode
  

                CMP.B       #0,D4                   * FIND OUT THE MODE for ADD
                BEQ         ARITH_MODE_1            * <EA> -> Dn Byte
                CMP.B       #1,D4
                BEQ         ARITH_MODE_1            * <EA> -> Dn Word 
                CMP.B       #2,D4
                BEQ         ARITH_MODE_1            * <EA> -> Dn Long
               

                CMP.B       #4,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Byte
                CMP.B       #5,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Word
                CMP.B       #6,D4
                BEQ         ARITH_MODE_2            * Dn -> <EA> Long
 

*------------------------------------------------------------------*
* OP_ADDRESS is Specifically for methods like SUBA or ADDA
* that have the 'A' Suffix and similar addressing behavior
*                             
OP_ADDRESS      LEA         ADDR_A,A5               * Load the ADDA String
                MOVE.L      A5,(A6)+     
               
                CMP.B       #3,D4                   * Is this a long operation?
                BNE         LONG_ADD

WORD_ADD        JSR         print_W_str             * Then it's a word operation
                MOVE.L      D6,-(SP)                * Save D6, just in case
                CLR         D6
                MOVE.B      #1,D6                   * Set Word flag (in case immediate data is used)
                BRA         OP_ADDR_CONT            * Continue operation

LONG_ADD        JSR         print_L_str
                MOVE.L      D6,-(SP)                * Save D6, just in case
                CLR         D6
                MOVE.B      #2,D6                   * Set Long flag (in case immediate data is used)


OP_ADDR_CONT    JSR         PRINT_TAB

                ADD.W       #$02,A2                 * Advance the pointer past the instruction
                JSR         FIND_EAMODE             * Get EA MODE
               
                JSR         PRINT_COMMA             * Comma
               
                MOVE.L      D4,-(SP)                * Save D4 for a minute
                CLR         D4              
                MOVE.L      #1,D4
               
                JSR         FIND_OPMODE
            
                MOVEM.L     (SP)+,D6/D4             * Restore D6 & D4

                JSR         PRINT_init              * Print the string
                
                BRA         loop_exit               * Done
               
               
               
               
*------------------------------------------------------------------*
* Arithmetic Mode 1 is for <EA> -> Dn Effective Addressing              
* This modal behavior is used by Add, and Sub alike
* D3: Should have the Dn register number.
* D4: Should contain the OPMode bits to determine the 
* D5: Should contain the EA-Bits (6 total)
* D6: Is the expected flag value for immediate data usage
* Operation size. (000)Byte, (001) Word, (010) Long
*

ARITH_MODE_1    MOVE.L      D6,-(SP)                * Save D6, just in case
                CLR         D6                      * Clear it out

                CMP.B       #1,D4                   * FIND OUT THE SIZE
                BEQ         ARITH1_WORD             * <EA> -> Dn Word
                CMP.B       #2,D4
                BEQ         ARITH1_LONG             * <EA> -> Dn Long 
               
ARITH1_BYTE     JSR         print_B_str             * Set the '.B' Suffix
                JSR         PRINT_ALI_1
                MOVE.B      #0,D6                   * Set the byte flag (for immediate data useage)
                BRA         ARITH_ONE_CONT          * Continue

ARITH1_WORD     JSR         print_W_str             * Set the '.W' Suffix
                JSR         PRINT_ALI_1
                MOVE.B      #1,D6                   * Set the word flag (for immediate data useage)
                BRA         ARITH_ONE_CONT          * Continue

ARITH1_LONG     JSR         print_L_str             * Set the '.L' Suffix
                JSR         PRINT_ALI_1
                MOVE.B      #2,D6                   * Set the Long flag (for immediate data useage)


ARITH_ONE_CONT  ADD.W       #$02,A2                 * Advance the pointer past the instruction
               
                JSR         FIND_EAMODE             * Get EA MODE 
                JSR         PRINT_COMMA             * Comma
               
                MOVE.L      D4,-(SP)                * Save D4 for a minute
                CLR         D4              
                MOVE.L      #0,D4                   * Manually set Dn for Destination
               
                JSR         FIND_OPMODE
            
                MOVEM.L     (SP)+,D4                * Restore  D4  

                JSR         PRINT_init              * Print the string
                BRA         loop_exit


*------------------------------------------------------------------*
* Arithmetic Mode 2 is for Dn -> <EA> Effective Addressing              
* This modal behavior is used by Add, and Sub alike
* D3: Should have the Dn register number.
* D4: Should contain the OPMode bits to determine the 
* D5: Should contain the EA-Bits (6 total)
* D6: Is the expected flag value for immediate data usage 
* (not used here)
* Operation size. (100)Byte, (101) Word, (110) Long
*
ARITH_MODE_2    CMP.B       #5,D4                   * FIND OUT THE SIZE
                BEQ         ARITH2_WORD             * Dn -> <EA> Word
                CMP.B       #6,D4
                BEQ         ARITH2_LONG             * Dn -> <EA> Long 
               
ARITH2_BYTE     JSR         print_B_str             * Set the '.B' Suffix
                JSR         PRINT_ALI_1
                BRA         ARITH_TWO_CONT          * Continue

ARITH2_WORD     JSR         print_W_str             * Set the '.W' Suffix
                JSR         PRINT_ALI_1
                BRA         ARITH_TWO_CONT          * Continue

ARITH2_LONG     JSR         print_L_str             * Set the '.L' Suffix
                JSR         PRINT_ALI_1


ARITH_TWO_CONT  MOVEM.L     D0/D1,-(SP)             * Save the D0,D1 Register

                MOVE.B      D5,D0
                MOVE.B      D5,D1
                ANDI.B      #EA_REG,D1              * Get the EA Reg        
                ANDI.B      #EA_MODE,D0             * Get the EA Mode
                LSR.B       #3,D0           

                CMP.B       #0,D0                   * Check for illegal Dn mode
                BEQ         op_DATA
                CMP.B       #1,D0                   * Check for illegal An mode
                BEQ         op_DATA
    
                CMP.B       #7,D0                   * Check for mode 7 Reg 4
                BEQ         CHECK_REG


ARITH2_RESUME   MOVEM.L     (SP)+,D0/D1             * Release D0,D1 from stack

                MOVE.L      D4,-(SP)                * Save D4 for a minute
                CLR         D4              
                MOVE.L      #0,D4                   * Manually set Dn for Source
                   
                JSR         FIND_OPMODE             * Get Dn register
                JSR         PRINT_COMMA             * Get Comma
        
                ADD.W       #$02,A2                 * Advance the pointer past the instruction
                JSR         FIND_EAMODE             * Get <EA> operand  

                MOVEM.L     (SP)+,D4                * Restore  D4

                JSR         PRINT_init              * Print the string
                BRA         loop_exit 


CHECK_REG       CMP.B       #2,D1                   * Check for illegal reg (d16,PC)
                BEQ         op_DATA
                CMP.B       #3,D1                   * Check for illegal reg (d8,PC,Xn)
                BEQ         op_DATA
                CMP.B       #4,D1                   * Check for illegal reg #(data) immediate data
                BEQ         op_DATA
                BRA         ARITH2_RESUME           * Otherwise continue.

*---------------------------------------------------------------------*                 
* SUBQ OPCODE Subtracts Immediate data (1-8) from dest operand.
*
*
op_SUBQ         JSR         NA_ADDR_CHECK           * Check for illegal submodes of mode 7 


                LEA         SUBQ_STR,A5             * Load the SUBQ Str
                MOVE.L      A5,(A6)+   
               
                MOVEM.L     D0/D1/D3,-(SP)          * Save state of D0/D1/D3  
                CLR         D0                      * Clear out D0
                MOVE.W      (A2),D0                 * Move the size bits into d0
                ANDI.W      #$00C0,D0               * Isolate Size bits
                
                CMP.B       #$00000000,D0           * Check for byte size
                BEQ         CHECK_SA_MODE           * Check for illegal EA mode
                
                
SUBQ_CONT       CLR         D3
                MOVE.W      D0,D3            
                JSR         opcode_size_str         * Get the size suffix
                
                JSR         PRINT_TAB
                
                CLR         D1
                MOVE.W      (A2),D1                 * Get the data bits
                ANDI.W      #$0E00,D1               * Isolate data number
                LSR.W       #3,D1                   * Shift the bits over
                LSR.W       #6,D1
                
                LEA         POUND,A5                * Load the '#' symbol
                MOVE.L      A5,(A6)+  

                CMP.B       #0,D1                   * Check for zero
                BNE         SKIP_8                  * Skip if not number 8 (i.e. 0)
    
                LEA         NO_EIGHT,A5             * Place the number 8 in the string
                MOVE.L      A5,(A6)+    
                BRA         SUBQ_DONE
                
SKIP_8          ADD.W       #$30,D1                 * Convert ascii number to hex
                MOVE.B      D1,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                CLR         D3
                MOVE.L      A4,D3
                SUB.L       #$02,D3
                MOVE.L      D3,A5
                MOVE.L      A5,(A6)+                * Move the number to the string
              
SUBQ_DONE       JSR         PRINT_COMMA             * Print the Comma
                ADD.W       #$02,A2                 * Advance pointer past instruction
                JSR         FIND_EAMODE             * Get EA
                JSR         PRINT_init              * Display the string
                
                MOVEM.L     (SP)+,D3/D1/D0          * Restore the stack
                
                BRA         loop_exit               * EXIT
        
CHECK_SA_MODE   CLR         D1                      * Check SUBQ Address mode
                MOVE.L      D5,D1
                ANDI.B      #$38,D1                 * Isolate EA MODE BITS
                CMP.B       #$08,D1                 * Compare for An mode
                BEQ         op_DATA                 * ILLEGAL EA MODE FOR SIZE BYTE
                BRA         SUBQ_CONT               * Otherwise continue
                
*------------------------------------------------------------------*   

*------------------------------------------------------------------*  
* Non-Alterable Address Check
* This ancillary method checks for non-alteralble addressing
* modes such as immediated data, etc that cannot be used
* addressing modes.
* D5: Expected to contain operation EA bits.   
*
NA_ADDR_CHECK   MOVE.L      D0,-(SP)                * Save the state of D0
                CLR         D0
                MOVE.W      D5,D0                   * Move in EA bits
                    
                CMP.B       #$38,D0                 * Look for Mode 7                
                BEQ         NON_MEM_REG
  
NAAC_CONT       MOVE.L      (SP)+,D0                * Restore D0 from stack
                RTS                                 * Return


NON_MEM_REG     CLR         D0                      * Clear D0    
                MOVE.W      D5,D0                   * Move in EA bits
                CMP.B       #$02,D0                 * Check for REG 2
                BEQ         op_DATA                 * Illegal Mode Displacement PC
                CMP.B       #$03,D0                 * Check for REG 3
                BEQ         op_DATA                 * Illegal Mode Displacement PC bit Xtended
                CMP.B       #$04,D0                 * Check for REG 4
                BEQ         op_DATA                 * Illegal Mode Immediate Data
                BRA         NAAC_CONT               * Continue to exit
*---------------------------------------------------------------------*  
*---------------------------------------------------------------------*
* Prints the intro
*  
PRINT_INTRO     MOVE.B      #14,D0
                LEA         INTRO_STR1,A1
                TRAP #15                             
                LEA         INTRO_STR2,A1
                TRAP #15    
                LEA         INTRO_STR3,A1
                TRAP #15 
                LEA         INTRO_STR4,A1
                TRAP #15 
                LEA         INTRO_STR5,A1
                TRAP #15 
                LEA         INTRO_STR6,A1
                TRAP #15 
                LEA         INTRO_STR7,A1
                TRAP #15
                LEA         INTRO_STR8,A1
                TRAP #15                             
                LEA         INTRO_STR9,A1
                TRAP #15 
                LEA         INTRO_STR10,A1
                TRAP #15 
                LEA         INTRO_STR11,A1
                TRAP #15 
                LEA         INTRO_STR12,A1
                TRAP #15 
                LEA         INTRO_STR13,A1
                TRAP #15 
                LEA         INTRO_STR14,A1
                TRAP #15
                LEA         INTRO_STR15,A1
                TRAP #15
                LEA         new_line,A1
                TRAP #15
                LEA         INTRO_STR16,A1
                TRAP #15
                LEA         INTRO_STR17,A1
                TRAP #15
                LEA         new_line,A1
                TRAP #15
                RTS
   
*------------------------------------------------------------------*
* Prints a comma
*         
PRINT_COMMA     MOVEM.L     A1/D0,-(SP)             * save what we change (ALWAYS!)

                LEA         COMMA,A5
                MOVE.L      A5,(A6)+                * add the comma to the output string
                
                MOVEM.L     (SP)+,A1/D0             * restore it
                
                RTS

*------------------------------------------------------------------*
* Prints a tab
*
PRINT_TAB       MOVEM.L     A1/D0,-(SP)             * save what we change (ALWAYS!)
                
                LEA         TAB,A5  
                MOVE.L      A5,(A6)+                * add the tab to the output string
                
                MOVEM.L     (SP)+,A1/D0             * restore it
                
                RTS     

*------------------------------------------------------------------*
* Prints a space
*               
PRINT_ALI_1     LEA         ONE_SPACE,A5            * Load one space
                MOVE.L      A5,(A6)+                * Add one space to string
                RTS
*------------------------------------------------------------------*
* Prints two spaces
*               
PRINT_ALI_2     LEA         TWO_SPACE,A5            * Load two spaces
                MOVE.L      A5,(A6)+                * Add spaces to string
                RTS

*------------------------------------------------------------------*
* Prints three spaces
*               
PRINT_ALI_3     LEA         THREE_SPACE,A5          * Load three spaces
                MOVE.L      A5,(A6)+                * Add spaces to string
                RTS
*------------------------------------------------------------------*
* Prints four spaces
*               
PRINT_ALI_4     LEA         FOUR_SPACE,A5           * Load four spaces
                MOVE.L      A5,(A6)+                * Add spaces to string
                RTS
                

*------------------------------------------------------------------*
* Determine EA MODE 
* This will deterine what effective addressing mode to do
*
* 
* D5 - Contains the EA bits
* 
* D7 Contains the instruction
* 
* FIND_MODE(D5:EA Bits, D7:Current instruction)
* D2 - Contains the Register

FIND_EAMODE     MOVE.L      D5,D2
                ANDI.B      #EA_REG,D2              * Get the EA register    
                ANDI.B      #EA_MODE,D5             * Get the EA Mode
                LSR.B       #3,D5
                JSR         MODE_SELECT
                RTS    

*------------------------------------------------------------------*
* This Subroutine performs the same way as EA, only we get the 
* Desination reg and mode (mainly for testing simpler commands where
* we know the what register and mode are, 
* D4 - is expected to carry an the op-mode
* D3 - has the appropriate register
*             
FIND_OPMODE     MOVEM.L     D2/D5,-(SP)             * Save the state of Registers D2 & D5
                MOVE.B      D4,D5                   * Get OPMODE (this is for destination mode, reg testing)
                MOVE.B      D3,D2                   * Get reg number then go to appropriate mode
                JSR         MODE_SELECT
                MOVEM.L     (SP)+,D2/D5             * Restore before we jump back
                RTS

*------------------------------------------------------------------*
* This goes to the appropriate mode whether we start with FIND_EAMODE
* or FIND_OPMODE
* D5 - is the mode
* D2 - is expected to have the reg number
*
MODE_SELECT     CMP.B       #0,D5                   * MODE ZERO Goes to DATA REG DIRECT
                BEQ         M_ZERO
                CMP.B       #1,D5
                BEQ         M_ONE                   * Address Reg Direct
                CMP.B       #2,D5
                BEQ         M_TWO                   * Address Reg Indirect
                CMP.B       #3,D5
                BEQ         M_THREE                 * Address Reg Indirect Post Inc
                CMP.B       #4,D5
                BEQ         M_FOUR                  * Address Reg Indirect Pre Dec
                CMP.B       #5,D5
                BEQ         M_INV                   * (stub for Displacement)
                CMP.B       #6,D5           
                BEQ         M_INV                   * (stub for memory indirect)
                CMP.B       #7,D5
                BEQ         M_SEVEN                 * Auxillary EA modes (ABS Short,Long,Immed...)

*------------------------------------------------------------------*
* Mode invalid 
* Handler for invalid EA modes
* 
M_INV           SUB.W       #$02,A2                 * roll back the address pointer
                BRA         op_DATA

*------------------------------------------------------------------* 
* Mode zero is data register direct mode
* D2 - has the Register
* 
M_ZERO          MOVEM.L     D0-D7/A0-A3,-(SP)       * Save our stuff real quick
                
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+                * Add the 'D' to the output string
                                
                ADD.W       #$30,D2                 * convert ascii number to hex
                MOVE.B      D2,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
                
                MOVEM.L     (SP)+,D0-D7/A0-A3       * Restore registers
         
                RTS                                 * Leave this place 

*------------------------------------------------------------------* 
* Mode One is Address Register Direct
* D2 has the register
*
M_ONE           MOVEM.L     D0-D7/A0-A3,-(SP)       * Save our stuff real quick
                
                LEA         ADDR_REG,A5         
                MOVE.L      A5,(A6)+                * Add the 'A' to the output string
                
                ADD.W       #$30,D2                 * convert ascii number to hex
                MOVE.B      D2,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3       * Restore registers
         
                RTS                                 * Leave this place 


*------------------------------------------------------------------*
* Mode Two is Address Register Indirect
* (A2)
*
M_TWO           MOVEM.L     D0-D7/A0-A3,-(SP)       * Save our stuff real quick
                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the '(' to the output string
            
                LEA         ADDR_REG,A5
                MOVE.L      A5,(A6)+                * Add the 'A' to the output string

                ADD.W       #$30,D2                 * convert ascii number to hex
                MOVE.B      D2,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
            
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the ')' to the output string
            
                MOVEM.L     (SP)+,D0-D7/A0-A3       * Restore registers
         
                RTS                                 * Leave this place 


*------------------------------------------------------------------*
* Mode is Register Indirect Post Increment Mode
*
* 
M_THREE         MOVEM.L     D0-D7/A0-A3,-(SP)       * Save our stuff real quick

                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the '(' to the output string
            
                LEA         ADDR_REG,A5        
                MOVE.L      A5,(A6)+                * Add the 'A' to the output string

                ADD.W       #$30,D2                 * convert ascii number to hex
                MOVE.B      D2,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
           
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the ')' to the output string

                LEA         INCREMENT,A5
                MOVE.L      A5,(A6)+                * Add the '+' to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3       * Restore registers
         
                RTS                                 * Leave this place 


*------------------------------------------------------------------*
* Mode is Register Indirect Pre-Decrement Mode
*
*            

M_FOUR          MOVEM.L     D0-D7/A0-A3,-(SP)       * Save our stuff real quick
            
                LEA         DECREMENT,A5
                MOVE.L      A5,(A6)+                * Add the '-' to the output string
    
                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the '(' to the output string
            
                LEA         ADDR_REG,A5         
                MOVE.L      A5,(A6)+                * Add the 'A' to the output string

                ADD.W       #$30,D2                 * convert ascii number to hex
                MOVE.B      D2,(A4)+                * Move the register to A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
            
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+                * Add the ')' to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3       * Restore registers
         
                RTS                                 * Leave this place 





*--------------------------------------------------------------------*
* Mode seven is special, it does stuff
* like absolute addressing and immediate 
* data.
* D2 - is the register data
* D5 - the mode data
* D6 - value to determine size of operation for 
*      Immediate data operation: For instance,
*      if the immediate data is a byte or a word,
*      then we are going to grab a word's-worth of
*      displacement from memory, otherwise we 
*      grab a longword's-worth
*
* NOTE!!! Assuming now, that the current location
* that we are at in memory is in A2, so we will be
* advancing from this point in memory. A2 should 
* be left at the next instruction by the time we
* are DONE!
*
*
M_SEVEN         CMP.B       #0,D2
                BEQ         ABS_SHORTADDR           * Absolute Short Addressing (xxx).W
                CMP.B       #1,D2
                BEQ         ABS_LONGADDR            * Absolute Long Addressing (xxx).L
                CMP.B       #2,D2
                BEQ         M_INV                   * (stub for PC Indirect)
                CMP.B       #3,D2
                BEQ         M_INV                   * (stub for PC Indirect w/ offset)
                CMP.B       #4,D2       
                BEQ         IMMED_DATA              * Immediate Data

*------------------------------------------------------------------*
*  Absolute Short Addressing Mode
*  Grabs the word address from memory
*  and shows it like $XXXX,
*  Assumptions - 1) needed value is just after instruction
*

ABS_SHORTADDR   MOVEM.L     A1/D0-D1,-(SP)          * Save our state
  
    
                LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+                * Add '$' to the output string
    
                MOVE.W      (A2)+,D2
               
                
                MOVEM.L     D0-D7,-(SP)             * Save state
                
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.W      D2,D0
                MOVE.L      #$00000002,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore state
                
                
                ADD.L       #$04,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$05,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
   
    
                MOVEM.L     (SP)+,A1/D0-D1          * Restore the state!


                RTS                                 * Leave this foreboding place

*------------------------------------------------------------------*
    
    
*------------------------------------------------------------------*
* EA- Absolute Long Addressing $XXXXXXXX
* Gets the long-word address from memory
* Assumes the address is just after
* the instruction code.
*    
    
ABS_LONGADDR    MOVEM.L     A1/D0-D1,-(SP)          * Save our state
    
                LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+                * Add '$' to the output string
                
                MOVE.L      (A2)+,D2
                
                MOVEM.L     D0-D7,-(SP)             * Save state
                
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.L      D2,D0
                MOVE.L      #$00000004,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7             * Restore state

                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string
   
    
                MOVEM.L     (SP)+,A1/D0-D1          * Restore the state!


                RTS                                 * Leave this foreboding place

*------------------------------------------------------------------*
* Immediate Data
* Gets the immediate data value from memory
* D6 - is the flag that determines whether to grab
*      a word or long amount of data from memory.
*      (0: for byte & Words, 1: long
*
*

IMMED_DATA      MOVEM.L     A1/D0-D1,-(SP)          * Save our state
                
                *Find size to determine the data amount to be processed
                CMP.B       #$00,D6
                BEQ         GET_BYTE            
                CMP.B       #$01,D6
                BEQ         GET_WORD
                CMP.B       #$02,D6
                BEQ         GET_LONG 
                         
GET_BYTE        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+                * Add '#$' to the output string
                MOVE.W      (A2)+,D2                * Read the word (only looking at byte amount)
                
                MOVEM.L     D0-D7,-(SP)             * Save state
                
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.W      D2,D0                   * Move the word to D0 for HEXTOASCII
                MOVE.L      #1,D1                   * 1 byte for a byte
                JSR         HEXTOASCII
                
                ADD.L       #$02,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$03,D0                 * Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7             * Restore state
                BRA         IM_EXIT                 * Exit this mode

                
GET_WORD        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+                * Add '#$' to the output string
                MOVE.W      (A2)+,D2                * Read the word
                
                MOVEM.L     D0-D7,-(SP)             * Save state
                
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.W      D2,D0                   * Move the word to D0 for HEXTOASCII
                MOVE.L      #2,D1                   * 2 bytes for a word
                JSR         HEXTOASCII
                
                ADD.L       #$04,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$05,D0                 * Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7             * Restore state
                BRA         IM_EXIT                 * Exit this mode
    
GET_LONG        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+                * Add '#$' to the output string
                MOVE.L      (A2)+,D2                * Read the long
                
                MOVEM.L     D0-D7,-(SP)             * Save state
                
                MOVE.L      A4,A0                   * Clear the output address location
                MOVE.L      D2,D0                   * Move the long to D0 for HEXTOASCII
                MOVE.L      #4,D1                   * 4 bytes for a long
                JSR         HEXTOASCII
                
                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+              * Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0                 * Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+                * Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7             * Restore state
                BRA         IM_EXIT                 * Exit this mode
        
IM_EXIT         MOVEM.L     (SP)+,A1/D0-D1          * Restore the state!
                RTS                                 * Leave this place

*------------------------------------------------------------------*
* For replacing the current Register with 
* the SP register. EX (SP),D1...
*   
*   
STACK_REG       MOVEM.L     D0/A1,-(SP)

                LEA         SP_REG,A5
                MOVE.L      A5,(A6)+
                
                MOVEM.L     (SP)+,D0/A1
                

*------------------------------------------------------------------*

next_page       CMP.L       A3,A2                   * check if end address has been reached
                BEQ         exit                    * exit the program
                
                MOVE.B      #14,D0
                LEA         prompt_new,A1
                TRAP #15                            * prompt user to press enter
                
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP #15                            * input used to wait for enter
                
                MOVE.L      #$0000,$00009000        * set counter to 0
                BRA         loop_start              * go back to start of the loop
                
*------------------------------------------------------------------*
loop_exit       MOVE.L      #$000000,A1
                CMP.L       A3,A2                   * check to see if end address has been reached
                BGT         exit                    * if reached, end the program
                
                JSR         clearTempVars           * clear the temporary variables for the output string
                JSR         clearOutputStr          * clear the output string
                MOVE.L      #$00009010,A4           * reset the temp string address
                MOVE.L      #$000090A0,A5           * reset the output list of addresses
                MOVE.L      #$000090A0,A6           * reset the current output address
                CLR.L       D0
                CLR.L       D1
                CLR.L       D2
                CLR.L       D3
                CLR.L       D4
                CLR.L       D5
                CLR.L       D6
                CLR.L       D7                      * clear all of the registers
                BRA         loop_start              * go back to the start of the loop
                
PAGE_FILL       MOVE.L      #$0000001F,D1           * move the max number of lines to D1
                MOVE.L      #$00009000,A1           * move the address of the counter to A1
                SUB.W       (A1),D1                 * subtract the counter from D1
                BRA         PF_LOOP                 * start the loop
                
PF_LOOP         CMP.L       #$00000000,D1           * check if the count down has reached 0
                BEQ         PF_EXIT                 * exit if it's zero
                MOVE.B      #14,D0
                LEA         new_line,A1
                TRAP        #15                     * print 1 blank line
                SUB.B       #$01,D1                 * subtract 1 from the countdown
                BRA         PF_LOOP                 * restart the loop
                
PF_EXIT         RTS                                 * return to the exit loop
    
exit            JSR         PAGE_FILL               * jump to the page fill loop

                MOVE.B      #14,D0
                LEA         FINISHED_STR,A1
                TRAP        #15                     * print the finished statement
                
                MOVE.B      #2,D0                   * get user input to determine if retrying
                LEA         input,A1
                TRAP #15
                CMP.L       #0,D1                   * check to see if user typed in 0 or enter
                BEQ         START                   * go to beginning if user typed in enter or 0
                SIMHALT                             * halt simulator

* strings for intro message
INTRO_STR1      DC.B        '_____________________________            _-----_',CR,LF,0
INTRO_STR2      DC.B        '\_=====================__=__/  ____.----*-------`----.____',CR,LF,0
INTRO_STR3      DC.B        '                  \_   \       \----._______________.----/ ',CR,LF,0
INTRO_STR4      DC.B        '                    \   \      /  /     `--___--*',CR,LF,0
INTRO_STR5      DC.B        '               __,---`   `----*  *-_                _______    _______',CR,LF,0
INTRO_STR6      DC.B        '              /____                ||              / _____/|  / ___  /|  _',CR,LF,0
INTRO_STR7      DC.B        '                   `--._________,--*              / /____ |/ / /__/ / / / /',CR,LF,0
INTRO_STR8      DC.B        '                                                 / ___  /|  / ___  / / / /,-.',CR,LF,0
INTRO_STR9      DC.B        '                                                / /__/ / / / /__/ / / /   ,*',CR,LF,0
INTRO_STR10     DC.B        '                                               /______/ / /______/ / /_/\_\',CR,LF,0
INTRO_STR11     DC.B        '                                               |______|/  |______|/ |_| |_|',CR,LF,0
INTRO_STR12     DC.B        '                                              =============================',CR,LF,0
INTRO_STR13     DC.B        '                                               ENTERPRISE      DECOMPILER',CR,LF,0
INTRO_STR14     DC.B        '                                              =============================',CR,LF,0
INTRO_STR15     DC.B        '                                               By Kaley, Cole, & Abby 2014',CR,LF,0               
INTRO_STR16     DC.B        'Welcome to the Enterprise Decompiler! Please load a range of addresses to',CR,LF,0 
INTRO_STR17     DC.B        'disassemble from and to by typing in their hex values followed by enter. ',CR,LF,0                

* IO error messages
ERROR_STR	            DC.B	'An error occured. Please try again.',0
ERROR_INVALID_ADD_STR	DC.B	'Invalid address. Please try again.',0
ERROR_2BYTE_STR	        DC.B	'The start and end address need to be atleast 2 bytes apart. Please try again.',0
ERROR_SBOUND_STR	    DC.B	'The start address is less than the minimum address. Please try again.',0
ERROR_EBOUND_STR	    DC.B	'The end address is greater than the maximum address. Please try again.',0
ERROR_SGREATER_STR	    DC.B	'The start address is greater than the end address. Please try again.',0

* variables and constants
prompt_start    DC.B        'What is the starting address? $',0
prompt_end      DC.B        '  What is the ending address? $',0
prompt_new      DC.B        'Press enter to continue',0
FINISHED_STR    DC.B        'Disassembly complete. Press enter to try again, or anything else to stop.',0
input           DCB.B       256,0
invalidAdd      DC.B        'ERROR',0
new_line        DC.B        '',CR,LF,0
COMMA           DC.B        ',',0
B_STR           DC.B        '.B ',0
W_STR           DC.B        '.W ',0
L_STR           DC.B        '.L ',0
L_PAREN         DC.B        '(',0
R_PAREN         DC.B        ')',0
INCREMENT       DC.B        '+',0
DECREMENT       DC.B        '-',0
POUND           DC.B        '#',0
DOLLAH          DC.B        '$',0
IMMED_PREFIX    DC.B        '#$',0
SMALL_TAB       DC.B        '     ',0
TAB             DC.B        '      ',0
ONE_SPACE       DC.B        '       ',0
TWO_SPACE       DC.B        '        ',0
THREE_SPACE     DC.B        '         ',0
FOUR_SPACE      DC.B        '          ',0
*------------------------------------------------------------------*
DATA_STR        DC.B        '      DATA         ',0
NOP_STR         DC.B        '      NOP',0
MOVEB_STR       DC.B        '      MOVE.B',0
MOVEW_STR       DC.B        '      MOVE.W',0
MOVEL_STR       DC.B        '      MOVE.L',0
BRA_STR         DC.B        '      BRA',0
LEA_STR         DC.B        '      LEA',0
JSR_STR         DC.B        '      JSR',0
EOR_STR         DC.B        '      EOR',0
OR_STR          DC.B        '      OR',0
ORI_STR         DC.B        '      ORI',0
NEG_STR         DC.B        '      NEG',0
RTS_STR         DC.B        '      RTS',0
BCLR_STR        DC.B        '      BCLR',0
LSL_STR         DC.B        '      LSL',0
LSR_STR         DC.B        '      LSR',0
CMPI_STR        DC.B        '      CMPI',0
BCS_STR         DC.B        '      BCS',0
BGE_STR         DC.B        '      BGE',0
BLT_STR         DC.B        '      BLT',0
BVC_STR         DC.B        '      BVC',0
ROL_STR         DC.B        '      ROL',0
ROR_STR         DC.B        '      ROR',0
ASL_STR         DC.B        '      ASL',0
ASR_STR         DC.B        '      ASR',0
ADDA_STR        DC.B        '      ADDA',0
ADD_STR         DC.B        '      ADD',0
SUBA_STR        DC.B        '      SUBA',0
SUB_STR         DC.B        '      SUB',0
SUBQ_STR        DC.B        '      SUBQ',0
MULSW_STR       DC.B        '      MULS.W',0
DIVSW_STR       DC.B        '      DIVS.W',0
CMP_STR         DC.B        '      CMP',0
MOVEAL_STR      DC.B        '      MOVEA.L',0
MOVEAW_STR      DC.B        '      MOVEA.W',0
MOVEM_STR       DC.B        '      MOVEM',0
MOVEM_POST_STR  DC.B        '7A','6A','5A','4A','3A','2A','1A','0A','7D','6D','5D','4D','3D','2D','1D','0D',0
MOVEM_PRE_STR   DC.B        '0D','1D','2D','3D','4D','5D','6D','7D','0A','1A','2A','3A','4A','5A','6A','7A',0
*------------------------------------------------------------------*
* EA REGISTERS
*------------------------------------------------------------------*
* DATA Register

NO_EIGHT        DC.B        '8',0
DATA_REG        DC.B        'D',0
ADDR_REG        DC.B        'A',0
ADDR_A          DC.B        'A',0
SP_REG          DC.B        'SP',0

*------------------------------------------------------------------*
INST_LINE       DCB.B       256,0                   * String for one line of instruction

                END         START                   * last line of source

*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
