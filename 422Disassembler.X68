*-----------------------------------------------------------
* Title      : Convert ASCII to hex
* Written by : Kaley & Cole & Abby
* Date       : 11/11/14
* Description: Small piece of disassembler project
*-----------------------------------------------------------

*--------------------- HEX FOR OUTPUT ---------------------*
                OPT         CRE
CR              EQU         $0D
LF              EQU         $0A
STACK           EQU         $8000
                ORG         $1000
                
NMASK           EQU         %00001111
            
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
                JSR         clearTempVars       ; clear the temporary variables for the output string
                JSR         clearOutputStr      ; clear the output string
                CLR.L       D0
                CLR.L       D1
                CLR.L       D2
                CLR.L       D3
                CLR.L       D4
                CLR.L       D5
                CLR.L       D6
                CLR.L       D7                  ; clear all of the registers
                MOVE.L      #$00000000,A0
                MOVE.L      #$00000000,A1
                MOVE.L      #$00000000,A2
                MOVE.L      #$00000000,A3
                MOVE.L      #$00000000,A4
                MOVE.L      #$00000000,A5
                MOVE.L      #$00000000,A6
                MOVE.L      #$00000000,A7       ; clear all address registers
                * For testing  
                MOVE.L      #$000200EC, $6060    ORI.B  #$EC,D2
                MOVE.L      #$00450123, $6050    ORI.W  #$0123,D5
                MOVE.W      #$0085, $6070        ORI.L  #$xxxxxxxx, D5
                MOVE.L      #$12345678, $6072             12345678    
                MOVE.L      #$43F87000, $6000    LEA $7000,A1
                
                MOVE.W      #$4E71, $7000       NOP 
                MOVE.W      #$1200, $7010       MOVE.B D0,D1
                MOVE.W      #$1607, $7020       MOVE.B D7,D3
                MOVE.W      #$6000, $7030       BRA 16bit
                MOVE.W      #$5555, $7032       ; 55 following
                MOVE.W      #$60FF, $7040       BRA 32bit
                MOVE.L      #$55555555, $7042   ; 5555 following
            
                MOVE.W      #$4BD1, $7050       LEA (A1) with A5
                
                MOVE.W      #$4E80, $7070       JSR
                MOVE.W      #$8A41, $7080       OR.W D5,D1 (into Dn)
                MOVE.W      #$8A01, $7090       OR.B D5,D1 (into Dn)
                MOVE.W      #$8B01, $8000       OR.B D5,D1 (into ea)
                MOVE.W      #$8B41, $8010       OR.W D5,D1 (into ea)
                MOVE.W      #$8A81, $8020       OR.L D5,D1 (into Dn)
                MOVE.W      #$8B81, $8030       OR.L D5,D1 (into ea)
                MOVE.W      #$0005, $8040       ORI.B #$xx,D5
                MOVE.W      #$0045, $8050       ORI.W #$xxxx,D5
                MOVE.W      #$0085, $8060       ORI.L #$xxxxxxxx,D5
                  *********************NEG TESTING************************
                MOVE.W      #$4401, $8070       NEG.B D1
                MOVE.W      #$4441, $8080       NEG.W D1
                MOVE.W      #$4481, $8090       NEG.L D1
                
                MOVE.W      #$4409, $8076       DATA (mode 1)
                MOVE.W      #$4449, $8086       DATA (mode 1)
                MOVE.W      #$4489, $8096       DATA (mode 1)
                
                MOVE.W      #$4411, $9300       NEG.B (A1)
                MOVE.W      #$4451, $9304       NEG.W (A1)
                MOVE.W      #$4491, $9308       NEG.L (A1)
                
                MOVE.W      #$4419, $9412       NEG.B (A1)+
                MOVE.W      #$4459, $9416       NEG.W (A1)+
                MOVE.W      #$4499, $9420       NEG.L (A1)+
                
                MOVE.W      #$4421, $9424       NEG.B -(A1)
                MOVE.W      #$4461, $9428       NEG.W -(A1)
                MOVE.W      #$44A1, $9432       NEG.L -(A1)
                

                MOVE.W      #$4438, $9460       NEG.B $AAAA 
                MOVE.W      #$AAAA, $9462
                MOVE.W      #$4478, $9468       NEG.W $AAAA
                MOVE.W      #$AAAA, $946A
                MOVE.W      #$44B8, $9476       NEG.L $AAAA
                MOVE.W      #$AAAA, $9478
                
                MOVE.W      #$4439, $9484       NEG.B $AAAAAAAA
                MOVE.L      #$AAAAAAAA, $9486
                MOVE.W      #$4479, $9496       NEG.W $AAAAAAAA
                MOVE.L      #$AAAAAAAA, $9498
                MOVE.W      #$44B9, $9508       NEG.L $AAAAAAAA
                MOVE.L      #$AAAAAAAA, $950A
                ********************************************************

                MOVE.W      #$4E75, $9000       RTS
                MOVE.W      #$0B91, $9010       BCLR D5,A1 
                MOVE.W      #$3246, $9020       MOVE.W D6,A1
                MOVE.W      #$E70D, $9030       LSL.B #3,D5
                MOVE.W      #$E70D, $9040       LSL.W #3,D5
                MOVE.W      #$E78D, $9050       LSL.L #3,D5
            
                MOVE.W      #$E72D, $9060       LSL.B D3,D5
                MOVE.W      #$E76D, $9070       LSL.W D3,D5
                MOVE.W      #$E7AD, $9080       LSL.L D3,D5
            
                MOVE.W      #$E60D, $9090       LSR.B #3,D5
                MOVE.W      #$E64D, $9100       LSR.W #3,D5
                MOVE.W      #$E68D, $9110       LSR.L #3,D5
            
                MOVE.W      #$E62D, $9120       LSR.B D3,D5
                MOVE.W      #$E66D, $9130       LSR.W D3,D5
                MOVE.W      #$E6AD, $9140       LSR.L D3,D5
                
                MOVE.W      #$0C01, $9200       CMPI.B #$ xx,D1
                MOVE.W      #$0C51, $9210       CMPI.W #$ xxxx,(A1)
                MOVE.W      #$0C99, $9220       CMPI.L #$ xxxxxxxx,(A1)+
            
            
                LEA         STACK,SP            Load the stack
            
                MOVE.B      #14,D0
                LEA         prompt_start,A1
                TRAP #15                        ; prompt for starting address
            
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP #15                        ; store user input
            
                JSR         asciiToHexS         ; convert user input from start address to hex
                *MOVE.B      #14,D0
                *LEA         prompt_end,A1
                *TRAP        #15                 ; prompt for ending address
                *MOVE.B      #2,D0
                *LEA         input,A1
                *TRAP        #15                 ; store user input
                *JSR         asciiToHexE         ; convert user input for end address to hex
            
                MOVE.L      D3,A1               ; move the start address into A1
                MOVE.L      D3,A2               ; also move it into A2
                MOVE.L      D4,A3               ; move the ending address into A3
                CLR.L       D0
                CLR.L       D1
                CLR.L       D2
                CLR.L       D3
                CLR.L       D4
                CLR.L       D5
                CLR.L       D6
                CLR.L       D7                  ; clear all of the registers
            
                LEA         $5000,A5            ; move the starting address of the output string to A1
                LEA         $4000,A4
                MOVE.W      A5,A6               ; move the ending address of the output string here too (empty string)
    
                MOVE.W      (A1),D0             ; MOVEs INSTRUCTION in A1 to D0
                JSR         print_add           ; print the address
                JSR         opcode              ; decode the opcode
            
                JSR         exit
                
******************************* CLEAR REGISTERS **************************
* clearTempVars  - clears all of the temporary variables starting at $4000
* clearOutputStr - clears all of the values starting at $5000
clearTempVars   MOVE.L      #$4000,A0           ; move the first address to A0
                BRA         CTV_loop            ; begin the loop
               
CTV_loop        CMP.L       #$FFFFFFFF,(A0)     ; check if the values at address A0 are all Fs
                BEQ         CTV_exit            ; if they are, exit
                MOVE.L      #$FFFFFFFF,(A0)+    ; otherwise, set them all to Fs and increment A0
                BRA         CTV_loop            ; loop again
                
CTV_exit        RTS                             ; return to where clearTempVars was called

clearOutputStr  MOVE.L      #$5000,A0           ; move the first address to A0
                BRA         COS_loop            ; begin the loop
                
COS_loop        CMP.L       #$FFFFFFFF,(A0)     ; check if the values at address A0 are all Fs
                BEQ         COS_exit            ; if they are, exit
                MOVE.L      #$FFFFFFFF,(A0)+    ; otherwise, set them all to Fs and increment A0
                BRA         COS_loop            ; loop again
                
COS_exit        RTS                             ; return to where clearOutputStr was called
                

******************************* ASCII TO HEX *****************************
* Convert starting address from ASCII to Hex, stores in D3
* D0 = temp value, D1 = length of string, D2 = counter, D3 = ret val
* A1 = memory location of beginning of the string
asciiToHexS     CMP.B       #8,D1               ; check that length is <= 8
                BGT         invalidAdd
                CMP.B       #0,D1               ; check that length is > 0
                BLE         invalidAdd
                CLR.L       D3                  ; clear return value
                SUBQ.B      #1,D1               ; subtract 1 from the counter
            
ATHS_loop       ROL.L       #4,D3               ; shift bits left by 4
                MOVE.B      (A1)+,D0            ; copy next byte from memory to convert
                CMP.B       #$39,D0             ; if the value is < 39 its a number
                BGT         ATHS_letter         ; its its not a number process it as a letter
                CMP.B       #$30,D0             ; if the value is < 30 its invalid
                BLT         invalidAdd
                SUBI.B      #$30,D0             ; its a valid number, subtract 30
                BRA         ATHS_done
            
ATHS_letter     CMP.B       #$66,D0             ; if the value is > 66 its invalid
                BGT         invalidAdd
                CMP.B       #$61,D0             ; if the value is >= 61 its lowercase
                BGE         ATHS_lower          ; process it as a lowercase letter
                CMP.B       #$46,D0             ; if the value is less than 46 its invalid
                BGT         invalidAdd
                CMP.B       #$41,D0             ; if the value is less than 41 its invalid
                BLT         invalidAdd
                SUBI.B      #$37,D0             ; valid letter, subtract 37
                BRA         ATHS_done
            
ATHS_lower      SUBI.B      #$57,D0             ; convert lowercase letter to hex
                BRA         ATHS_done
            
ATHS_done       OR.L        D0,D3               ; OR the result to the retVal
                DBF         D1,ATHS_loop        ; decrement counter and loop while they're > 0
                CLR.L D1                        ; done
                RTS
            
* Convert ending address from ASCII to Hex, stores in D4
* D0 = temp value, D1 = length of string, D2 = counter, D4 = ret val
* A1 = memory location of beginning of the string
asciiToHexE     CMP.B       #8,D1               ; check that length is <= 8
                BGT         invalidAdd
                CMP.B       #0,D1               ; check that length is > 0
                BLE         invalidAdd
                CLR.L       D4                  ; clear return value
                SUBQ.B      #1,D1               ; subtract 1 from the counter
            
ATHE_loop       ROL.L       #4,D4               ; shift bits left by 4
                MOVE.B      (A1)+,D0            ; copy next byte from memory to convert
                CMP.B       #$39,D0             ; if the value is < 39 its a number
                BGT         ATHE_letter         ; its its not a number process it as a letter
                CMP.B       #$30,D0             ; if the value is < 30 its invalid
                BLT         invalidAdd
                SUBI.B      #$30,D0             ; its a valid number, subtract 30
                BRA         ATHE_done
            
ATHE_letter     CMP.B       #$66,D0             ; if the value is > 66 its invalid
                BGT         invalidAdd
                CMP.B       #$61,D0             ; if the value is >= 61 its lowercase
                BGE         ATHE_lower          ; process it as a lowercase letter
                CMP.B       #$46,D0             ; if the value is less than 46 its invalid
                BGT         invalidAdd
                CMP.B       #$41,D0             ; if the value is less than 41 its invalid
                BLT         invalidAdd
                SUBI.B      #$37,D0             ; valid letter, subtract 37
                BRA         ATHE_done
            
ATHE_lower      SUBI.B      #$57,D0             ; convert lowercase letter to hex
                BRA         ATHE_done
            
ATHE_done       OR.L        D0,D4               ; OR the result to the retVal
                DBF         D1,ATHE_loop        ; decrement counter and loop while they're > 0
                CLR.L       D1                  ; done
                RTS
******************************* HEX TO ASCII *****************************
* Convert starting address from Hex to Ascii, stores in A0
* D0 = value to convert, D1 = number of bytes to process, A0 = retval

HEXTOASCII      ANDI.L      #$000000FF,D1       ; get the byte
                CMP.B       #4,D1
                BGT         HTA_error           ; error if > 4 bytes
                CMP.B       #0,D1
                BLE         HTA_error           ; error if <= 0 bytes
                MOVEM.L     D0/D2-D3,-(A7)
                ROL.L       #1,D1
                SUBQ.L      #1,D1
                MOVE.L      D1,D3
                
HTA_loop        MOVE.L      D0,D2
                ANDI.B      #%00001111,D2
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





******************************** OPCODE **********************************
opcode          LEA         JUMPTABLE,A0        ; load the jump table into A0
                JSR         OC_decode           ; decode the opcode
                CLR.L       D1                  ; clear D1
                MOVE.L      D0,D1               ; move instruction into D1
                MOVE.B      #12,D2              ; load the value 12 into D2
            
                       
                LSR.W       D2,D7               ; shift the original operation right by 12 bits
                MULU        #6,D7               ; multiply the new value in D7 by 6
                JSR         00(A0,D7)           ; find the corresponding code in the jump table
            
OC_decode       MOVE.W      D0,D1               ; move the original operation into D1
                MOVE.W      D0,D7               ; also move it into D7               Effective Addressing BITS
                ANDI.W      #$003F,D1
                MOVE.B      D1,D5               ; move the last 6 bits into D5
            
                ROR.W       #6,D0               ; rotate the operation to the right by 6 bits
                MOVE.W      D0,D1               ; move the new op value into D1      OPMODE BITS
                ANDI.W      #$0007,D1
                MOVE.B      D1,D4               ; move these bits into D4
            
                ROR.W       #3,D0               ; rotate the operation to the right by 3 bits
                MOVE.W      D0,D1               ; move the new op value into D1      Register bits
                ANDI.W      #$0007,D1
                MOVE.B      D1,D3               ; move these bits into D3
                
                RTS

JUMPTABLE       JMP         op0000              ORI, BCLR
                JMP         op0001              MOVE.B
                JMP         op0010
                JMP         op0011
                JMP         op0100              NEG, NOP, LEA, JSR, RTS
                JMP         op0101
                JMP         op0110              BRA
                JMP         op0111
                JMP         op1000              OR.X
                JMP         op1001
                JMP         op1010
                JMP         op1011
                JMP         op1100
                JMP         op1101
                JMP         op1110
                JMP         op1111

*-------------------------------------------------------------------------*
* Inclusive Or, Test a Bit and Clear, Compare Immediate
*-------------------------------------------------------------------------* 
op0000          *ORI
                MOVE.W      (A2),D1             ; copy instruction into D1
                ANDI        #%1111111100000000,D1
                CMP.W       #%0000000000000000,D1
                BEQ         op_ORI              ; check bits 8-15 for ORI
            
                *BCLR
                MOVE.W      (A2),D1             ; copy instruction into D1
                ANDI        #%0000000111000000,D1
                CMP.W       #%0000000110000000,D1
                BEQ         op_BCLR             ; check bits 9-11 for BCLR
            
                *CMPI
                MOVE.W      (A2),D1
                ANDI        #%1111111100000000,D1
                CMP.W       #%0000110000000000,D1
                BEQ         op_CMPI             ; check bits 8-15 for CMPI
            
                BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Byte
*-------------------------------------------------------------------------*
op0001          *MOVEM.L     D1,-(SP)            Save what we have here in D1 just in case
                MOVE.W      (A2)+,D7            Get instruction, advance pointer
            
                MOVE.B      #14,D0              Place MOVE.B string
                LEA         MOVEB_STR,A1
                TRAP        #15
            
            
                MOVE.B      #14,D0              Space with a tab
                LEA         TAB,A1
                TRAP        #15
            
                *MOVEM.L     (SP)+,D1            Restore it
            
                JSR         FIND_EAMODE         Get its mode
            
                MOVE.B      #14,D0              Place the comma
                LEA         COMMA,A1
                TRAP        #15
            
                        
                JSR         FIND_OPMODE             Find destination mode
            
                *MOVE.B      #14,D0
                *LEA         DATA_STR,A1
                *TRAP        #15                 ; OP code DNE
           
                RTS
            
*-------------------------------------------------------------------------*
* Move Long
*-------------------------------------------------------------------------*            
op0010          BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Word
*-------------------------------------------------------------------------*             
op0011          BRA         op_DATA

*-------------------------------------------------------------------------*
* Negate, No Operation, Load Effective Address, Jump to Subroutine, 
* Return from Subroutine, Move Multiple Registers
*-------------------------------------------------------------------------*             
op0100          *NEG
                MOVE.W      (A2),D1             ; move operation into D1
	            ANDI.W	    #%1111111100000000,D1
    	        CMP.W	    #%0100010000000000,D1
	            BEQ         op_NEG	            ; Check for NEG
	        
                *NOP
                CLR.L       D0                  ; clear D0
                MOVE.W      #%0100111001110001,D0
                CLR.L       D1                  ; clear D1
                MOVE.W      (A2),D1             ; move the original operation into D1
                CMP.W       D0,D1               ; compare D0 and D1
                BEQ         op_NOP              ; if they're equal, the operation is NOP
            
                *LEA
                ANDI.W      #%1111000111000000,D1
                CMP.W       #%0100000111000000,D1
                BEQ         op_LEA

                *JSR
                MOVE.W      (A2),D1             ; move the original operation into D1 
                ANDI.W      #%1111111111000000,D1
                CMP.W       #%0100111010000000,D1
                BEQ         op_JSR              ; check bits 6-15 to compare for JSR
            
                *RTS
                MOVE.W      (A2),D1             ; move the original operation into D1
                CMP.W       #%0100111001110101,D1
                BEQ         op_RTS              ; check for RTS

            
                BRA         op_DATA             ; invalid

          
op0101          BRA         op_DATA

*-------------------------------------------------------------------------*
* Branch Subroutine, Branch Always, Branch Conditionally
*-------------------------------------------------------------------------*             
op0110          *BRA
                CLR.L       D0
                MOVE.W      (A2),D0
                ANDI.W      #%1111111100000000,D0
                LSR.L       #8,D0               ; separate the first 6 bits (bits 8-15)
                CLR.L       D1
                MOVE.W      (A2),D1
                ANDI.W      #%0000000011111111,D1
                CMP.W       #%01100000,D0       ; standard first 8 bits of a BRA op
                BEQ         op_BRA              ; if they're equal, OP code is BRA

                BRA         op_DATA
            
op0111          BRA         op_DATA

*-------------------------------------------------------------------------*
* Inclusive Or, Signed Divide
*-------------------------------------------------------------------------*             
op1000          * OR
                JSR         op_OR
                JSR         OR_opmode
                RTS

                BRA         op_DATA

*-------------------------------------------------------------------------*
* Subtract
*-------------------------------------------------------------------------*             
op1001          BRA         op_DATA
            
op1010          BRA         op_DATA

*-------------------------------------------------------------------------*
* Exclusive Or, Compare
*-------------------------------------------------------------------------*             
op1011          BRA         op_DATA

*-------------------------------------------------------------------------*
* Signed Multiply
*-------------------------------------------------------------------------*            
op1100          BRA         op_DATA
                
*-------------------------------------------------------------------------*
* Add Address, Add
*-------------------------------------------------------------------------*            
op1101          BRA         op_DATA

*-------------------------------------------------------------------------*
* Arithmetic Shift Left, Arithmetic Shift Right, Logical Shift Left, 
* Logical Shift Right, Rotate Left, Rotate Right
*-------------------------------------------------------------------------*            
op1110          *LSL/LSR
                MOVE.W      (A2),D1
                ANDI.W      #%1111111111000000,D1
                CMP.W       #%1110001111000000,D1
                BEQ         LSL_ea
                CMP.W       #%1110001011000000,D1
                BEQ         LSR_ea
                MOVE.W      (A2),D1
            
                JSR         LS_no_ea

                MOVE.W      (A2),D1
                ANDI.W      #%1111000000111000,D1
                CMP.W       #%1110000000001000,D1
                BEQ         LS_count
                CMP.W       #%1110000000101000,D1
                BEQ         LS_reg
            
                BRA         op_DATA
            
op1111          BRA         op_DATA

LSL_ea          JSR         op_LSL_ea
                *** NEEDS TO BE FINISHED
                RTS
            
LSR_ea          JSR         op_LSR_ea
                *** NEEDS TO BE FINITO
                RTS
            
LS_no_ea        MOVE.L      D1,D0
                ANDI.W      #%0000000100000000,D0
                CMP.W       #%0000000100000000,D0
                BEQ         op_LSL
                CMP.W       #%0000000000000000,D0
                BEQ         op_LSR
                RTS

                LEA         OR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         OR_opmode           ; find the size and add it to the string
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string

LS_count        LEA         POUND,A5
                MOVE.L      A5,(A6)+            ; add # to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #%0000111000000000,D1
                LSR.L       #8,D1
                LSR.L       #1,D1               ; shift to get the register
                ADD.W       #$30,D1             ; convert ascii number to hex
            
                MOVE.B      D1,$4000            ; move the register to address $4000
                MOVE.B      #$00,$4001          ; add the string terminating character
                MOVE.L      #$00004000,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                LEA         COMMA,A5            ; add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #%0000000000000111,D1
                ADD.W       #$30,D1             ; convert the register to hex

                MOVE.B      D1,$4002            ; move the register to address $4002
                MOVE.B      #$00,$4003          ; add the string terminating character
                MOVE.L      #$00004002,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                BRA         PRINT_init          ; print the string
            
                RTS

LS_reg          LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add 'D'y to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #%0000111000000000,D1
                LSR.L       #8,D1
                LSR.L       #1,D1               ; shift to get the register
                ADD.W       #$30,D1             ; convert ascii number to hex
            
                MOVE.B      D1,$4000            ; move the register to address $4000
                MOVE.B      #$00,$4001          ; add the string terminating character
                MOVE.L      #$00004000,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                LEA         COMMA,A5            ; add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #%0000000000000111,D1
                ADD.W       #$30,D1             ; convert the register to hex

                MOVE.B      D1,$4002            ; move the register to address $4002
                MOVE.B      #$00,$4003          ; add the string terminating character
                MOVE.L      #$00004002,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                BRA         PRINT_init          ; print the string
            
                RTS

OR_opmode       CMP.W       #%0000,D4
                BEQ         print_B_str
                CMP.W       #%0100,D4
                BEQ         print_B_str
                CMP.W       #%0001,D4
                BEQ         print_W_str
                CMP.W       #%0101,D4
                BEQ         print_W_str
                CMP.W       #%0010,D4
                BEQ         print_L_str
                CMP.W       #%0110,D4
                BEQ         print_L_str
                CMP.W       #%0111,D4
                BEQ         op_DATA

print_add       MOVEM.L     D0-D7,-(SP)         ; Save the state
                MOVE.L      A2,D1               ; Move the current address to D1
                MOVE.L      #15,D0              ; Move the I/O code to D0 to print the number in D1
                MOVE.L      #16,D2              ; Print the number in base 16
                TRAP        #15                 ; print
                MOVEM.L     (SP)+,D0-D7         ; restore the state
                RTS
            
op_NOP          LEA         NOP_STR,A5
                MOVE.L      A5,(A6)+            ; add the operation to the string
                BRA         PRINT_init          ; print the string
                RTS
            
op_DATA         MOVE.L      #14,D0
                LEA         DATA_STR,A1
                TRAP        #15                 ; OP code DNE
                JSR         START
            
op_BRA          MOVE.L      #%11111111,D2       ; $FF into D2
                MOVE.L      #%00000000,D3       ; $00 into D3
            
                CMP.B       D1,D3               ; check the value of the last 8 bits against $00
                BEQ         op_BRA16            ; if equal, it's a 16 bit displacement
            
                CMP.B       D1,D2               ; check the value of the last 8 bits against $FF
                BEQ         op_BRA32            ; if equal, it's a 32 bit displacement
            
                BRA         op_BRA8
                
                RTS

op_BRA8         LEA         BRA8_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
            
op_BRA16        LEA         BRA16_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
            
                **** FINDING/ADDING EA TO STRING HERE
                
                JSR         PRINT_init          ; print the string
                RTS

op_BRA32        LEA         BRA32_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS


*--------------------------------------------------------------*
* OP-Section for L_oad E_ffective A_ddress
* D5 - has the EA bits (6 bits)
* D4 - has the REGISTER NUMBER (A-N)
*         
op_LEA          MOVEM.L     D0/A1,-(SP)         Save A1 & D0 to stack
            
                LEA         LEA_STR,A5
                MOVE.L      A5,(A6)+
            
                JSR         PRINT_TAB           Print the tab
            
            
                MOVEM.L     (SP)+,D0/A1         restore from stack
            
                * Since we know that in this case, LEA always moves
                * something to an address register An we can pass
                * our mode as 010 in D4 for Address Reg Direct
            
                CMP.W       (A2)+,A1            MOVE TO JUST AHEAD OF THE INSTRUCTION (this is important for correct EA mode 7)
            
                *---NEED TO INSERT INCORRECT EA-MODE CHECKS HERE---*
                JSR         FIND_EAMODE         We have our EA-bits in D5

                JSR         PRINT_COMMA         Print the comma

                MOVEM.L     D4,-(SP)            save contents of D4 on stack
                MOVE.B      #1,D4               Move our An mode to D4
                JSR         FIND_OPMODE             Now move to our mode
            
                JSR         PRINT_init          Print the output string
            
                MOVEM.L     (SP)+,D4            restore D4 before we go back
            
                BRA         exit
            
*--------------------------------------------------------------*

op_JSR          LEA         JSR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
         
op_OR           LEA         OR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         OR_opmode           ; find the size and add it to the string
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
            
op_ORI          LEA         ORI_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         opcode_size_str     ; find the size and add it to the string
                LSR.L       #6,D1               ; shift the size bits to get the flag 
                MOVE.L      D1,D6               ; move size bit to D6 to set flag
                **** CHECK FOR INVALID
                CMP.W       #%00111100,D5       ; Mode 7, Register 4 is invalid
                BEQ         op_DATA
                
                CLR.L       D0
                MOVE.W      D5,D0               ; Move the EA into D0
                ANDI.W      #%00111000,D0       ; Separate the EA Mode into D0
                CMP.W       #%00001000,D0       ; Compare the An Addressing mode
                BEQ         op_DATA             ; invalid
                
                MOVE.W      #%111,D4            ; set mode to 7 for mode 7
                MOVE.W      #%100,D3            ; set register to 4 for Immediate Data
                ADD.L       #$00000002,A2       ; move the current address forward by a word
                
                JSR         FIND_OPMODE         ; create the left side of the operation
                JSR         PRINT_COMMA         ; find the comma
                
                MOVE.W      (A1),D5             ; Move the original operation into D5
                ANDI.L      #$003F,D5           ; mask the last 6 bits
                JSR         FIND_EAMODE         ; create the right side of the operation

                
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
            
op_BCLR         LEA         BCLR_STR,A5         ; add the op to the string
                MOVE.L      A5,(A6)+
            
                **** FINDING/ADDING EA TO STRING HERE
                JSR         PRINT_init
                RTS
            
***************************************************************************       
opcode_size_str MOVE.W      (A2),D1
                ANDI.W      #$00C0,D1
                CMP.W       #$0000,D1
                BEQ         print_B_str         ; its a byte
                CMP.W       #$0040,D1
                BEQ         print_W_str         ; its a word
                CMP.W       #$0080,D1
                BEQ         print_L_str         ; its a long
                RTS
            
print_B_str     LEA         B_STR,A5            ; Add the address of .B to the string
                MOVE.L      A5,(A6)+
                RTS

print_W_str     LEA         W_STR,A5            ; Add the address of .W to the string
                MOVE.L      A5,(A6)+
                RTS

print_L_str     LEA         L_STR,A5            ; Add the address of .L to the string
                MOVE.L      A5,(A6)+
                RTS
            
PRINT_init      LEA         $5000,A5            ; load the beginning of the string
                BRA         PRINT_loop          ; enter the print loop
                RTS
            
PRINT_loop      CMP.L       #$FFFFFFFF,(A5)     ; if the value at A5 is all F's, you've reached the end
                BEQ         PRINT_exit          ; exit
                MOVE.L      #14,D0
                MOVE.L      (A5),A1             ; load the address pointed at by A5 to A1
                TRAP        #15                 ; print what the address points to
                ADDA.L      #$00000004,A5       ; increment A5 by a long
                BRA         PRINT_loop          ; loop
                
                RTS

PRINT_exit      RTS
***************************************************************************
op_NEG          LEA         NEG_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         opcode_size_str     ; find the size and add it to the string            
            
                **** ADD TESTING
                MOVEM.L     D5,-(SP)            ; save the state of D5
                ANDI.B      #%00111000,D5       ; separate the EA mode
                CMP.B       #%00001000,D5       ; check if it's mode 1
                BEQ         op_DATA             ; if is, it's invalid
                MOVEM.L     (SP)+,D5            ; restore D5 if it isn't
                
                ADD.W       #$02,A2
                
                JSR         FIND_EAMODE
            
                JSR         PRINT_init          ; print the string
                RTS
            
op_RTS          LEA         NEG_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string            
                JSR         PRINT_init          ; print the string
                RTS
            
op_LSL          LEA         LSL_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         opcode_size_str     ; find the size and add it to the string            
                RTS
          
op_LSR          LEA         LSR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         opcode_size_str     ; find the size and add it to the string            
                RTS
            
op_LSL_ea       **** FINDING/ADDING EA TO STRING HERE
                
                JSR         PRINT_init          ; print the string
                RTS
            
op_LSR_ea       **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
            
op_CMPI         LEA         CMPI_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         opcode_size_str     ; find the size and add it to the string            
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
            
   
*----------------------------------------*
* Prints a comma
*         
PRINT_COMMA     MOVEM.L     A1/D0,-(SP)         save what we change (ALWAYS!)

                LEA         COMMA,A5
                MOVE.L      A5,(A6)+            ; add the comma to the output string
                
                MOVEM.L     (SP)+,A1/D0         restore it
                
                RTS

*----------------------------------------*
* Prints a tab
*
PRINT_TAB       MOVEM.L     A1/D0,-(SP)         save what we change (ALWAYS!)
                
                LEA         TAB,A5  
                MOVE.L      A5,(A6)+            ; add the tab to the output string
                
                MOVEM.L     (SP)+,A1/D0         restore it
                
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
                ANDI.B      #EA_REG,D2          Get the EA register    
                ANDI.B      #EA_MODE,D5         Get the EA Mode
                LSR.B       #3,D5
                JSR         MODE_SELECT
                RTS    

*------------------------------------------------------------------------*
* This Subroutine performs the same way as EA, only we get the 
* Desination reg and mode (mainly for testing simpler commands where
* we know the what register and mode are, 
* D4 - is expected to carry an the op-mode
* D3 - has the appropriate register
*             
FIND_OPMODE     MOVEM.L     D2/D5,-(SP)         Save the state of Registers D2 & D5
                MOVE.B      D4,D5               Get OPMODE (this is for destination mode, reg testing)
                MOVE.B      D3,D2               Get reg number then go to appropriate mode
                JSR         MODE_SELECT
                MOVEM.L     (SP)+,D2/D5         Restore before we jump back
                RTS

*-----------------------------------------------------------------------
* This goes to the appropriate mode whether we start with FIND_EAMODE
* or FIND_OPMODE
* D5 - is the mode
* D2 - is expected to have the reg number
*


MODE_SELECT     CMP.B       #0,D5               MODE ZERO Goes to DATA REG DIRECT
                BEQ         M_ZERO
                CMP.B       #1,D5
                BEQ         M_ONE               Address Reg Direct
                CMP.B       #2,D5
                BEQ         M_TWO               Address Reg Indirect
                CMP.B       #3,D5
                BEQ         M_THREE             Address Reg Indirect Post Inc
                CMP.B       #4,D5
                BEQ         M_FOUR              Address Reg Indirect Pre Dec
                CMP.B       #5,D5
                BEQ         M_FIVE
                CMP.B       #6,D5
                BEQ         M_SIX
                CMP.B       #7,D5
                BEQ         M_SEVEN             Auxillary EA modes (ABS Short,Long,Immed...)

*-------------------------------------
* Mode zero is data register direct mode
* D2 - has the Register
* 
M_ZERO          MOVEM.L     D0-D7/A0-A3,-(SP)   Save our stuff real quick
                
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            Add the 'D' to the output string
                
                *CLR         D1                  Get EA Register
                *MOVE.B      D2,D1
                ADD.W       #$30,D2             ; convert ascii number to hex
                MOVE.B      D2,(A4)+            Move the register to A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
                
                *MOVE.B      #3,D0               EA REG in D1
                *TRAP        #15                 Display it

                MOVEM.L     (SP)+,D0-D7/A0-A3   Restore registers
         
                RTS                             Leave this place 

*------------------------------------------- 
* Mode One is Address Register Direct
* D2 has the register
*
M_ONE           MOVEM.L     D0-D7/A0-A3,-(SP)   Save our stuff real quick
                
                LEA         ADDR_REG,A5         
                MOVE.L      A5,(A6)+            Add the 'A' to the output string
                
                
                
                ADD.W       #$30,D2             ; convert ascii number to hex
                MOVE.B      D2,(A4)+            Move the register to A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3   Restore registers
         
                RTS                             Leave this place 


*---------------------------------------------
* Mode Two is Address Register Indirect
* (A2)
*
M_TWO           MOVEM.L     D0-D7/A0-A3,-(SP)   Save our stuff real quick
                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+            Add the '(' to the output string
            
                LEA         ADDR_REG,A5
                MOVE.L      A5,(A6)+            Add the 'A' to the output string

                ADD.W       #$30,D2             ; convert ascii number to hex
                MOVE.B      D2,(A4)+            Move the register to A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
            
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+            Add the ')' to the output string
            
                MOVEM.L     (SP)+,D0-D7/A0-A3   Restore registers
         
                RTS                             Leave this place 


*--------------------------------------------------------*
* Mode is Register Indirect Post Increment Mode
*
*
*    
M_THREE         MOVEM.L     D0-D7/A0-A3,-(SP)   Save our stuff real quick

                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+            Add the '(' to the output string
            
                LEA         ADDR_REG,A5        
                MOVE.L      A5,(A6)+            Add the 'A' to the output string

                ADD.W       #$30,D2             ; convert ascii number to hex
                MOVE.B      D2,(A4)+            Move the register to A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
           
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+            Add the ')' to the output string

                LEA         INCREMENT,A5
                MOVE.L      A5,(A6)+            Add the '+' to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3   Restore registers
         
                RTS                             Leave this place 


*--------------------------------------------------------------
* Mode is Register Indirect Pre-Decrement Mode
*
*            

M_FOUR          MOVEM.L     D0-D7/A0-A3,-(SP)   Save our stuff real quick
            
                LEA         DECREMENT,A5
                MOVE.L      A5,(A6)+            Add the '-' to the output string
    
                LEA         L_PAREN,A5
                MOVE.L      A5,(A6)+            Add the '(' to the output string
            
                LEA         ADDR_REG,A1         
                MOVE.L      A5,(A6)+            Add the 'A' to the output string

                ADD.W       #$30,D2             ; convert ascii number to hex
                MOVE.B      D2,(A4)+            Move the register to A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
            
                LEA         R_PAREN,A5
                MOVE.L      A5,(A6)+            Add the ')' to the output string

                MOVEM.L     (SP)+,D0-D7/A0-A3   Restore registers
         
                RTS                             Leave this place 



M_FIVE          BRA         exit

M_SIX           BRA         exit



*--------------------------------------------*
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
                BEQ         ABS_SHORTADDR
                CMP.B       #1,D2
                BEQ         ABS_LONGADDR
                CMP.B       #2,D2
                BEQ         exit                NOT DONE
                CMP.B       #3,D2
                BEQ         exit                NOT DONE
                CMP.B       #4,D2       
                BEQ         IMMED_DATA

            

*--------------------------------------------*
*  Absolute Short Addressing Mode
*  Grabs the word address from memory
*  and shows it like $XXXX,
*  Assumptions - 1) needed value is just after instruction
*

ABS_SHORTADDR   MOVEM.L     A1/D0-D1,-(SP)      Save our state
  
                *CMP.W       (A2)+,A1            MOVE just after the instruction in memory
    
                LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+            Add '$' to the output string
    
                MOVE.W      (A2)+,D2
                *** NEED TO CONVERT D2 TO ASCII
                
                MOVEM.L     D0-D7,-(SP)         Save state
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.W      D2,D0
                MOVE.L      #$00000002,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7         Restore state
                
                ***
                ADD.L       #$04,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$05,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
   
    
                MOVEM.L     (SP)+,A1/D0-D1      Restore the state!


                RTS                             Leave this foreboding place

*--------------------------------------------*
    
    
*--------------------------------------------*
* Absolute Long Addressing
* Gets the long-word address from memory
* for EA
*
*    
    
ABS_LONGADDR    MOVEM.L     A1/D0-D1,-(SP)      Save our state
  
                *CMP.W       (A2)+,A1            MOVE just after instruction in memory
    
                LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+            Add '$' to the output string
                
                MOVE.L      (A2)+,D2
                **** NEED TO CONVERT D2 to ASCII
                MOVEM.L     D0-D7,-(SP)         Save state
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.L      D2,D0
                MOVE.L      #$00000004,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7         Restore state

                ***
                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
   
    
                MOVEM.L     (SP)+,A1/D0-D1      Restore the state!


                RTS                             Leave this foreboding place

*---------------------------------------------------------*
* Immediate Data
* Gets the immediate data value from memory
* D6 - is the flag that determines whether to grab
*      a word or long amount of data from memory.
*      (0: for byte & Words, 1: long
*
*

IMMED_DATA      MOVEM.L     A1/D0-D1,-(SP)      Save our state
                
                *Find size to determine the data amount to be processed
                CMP.B       #%00,D6
                BEQ         GET_BYTE            
                CMP.B       #%01,D6
                BEQ         GET_WORD
                CMP.B       #%10,D6
                BEQ         GET_LONG 
                
                           

         
GET_BYTE        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+            Add '#$' to the output string
                *** NEED TO CONVERT D2 TO ASCII
                MOVE.W      (A2)+,D2            Read the word (only looking at byte amount)
                
                MOVEM.L     D0-D7,-(SP)         Save state
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.W      D2,D0               Move the word to D0 for HEXTOASCII
                MOVE.L      #1,D1               1 byte for a byte
                JSR         HEXTOASCII
                
                ADD.L       #$02,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$03,D0             Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7         Restore state
                BRA         IM_EXIT             Exit this mode

                
GET_WORD        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+            Add '#$' to the output string
                *** NEED TO CONVERT D2 TO ASCII
                MOVE.W      (A2)+,D2            Read the word
                
                MOVEM.L     D0-D7,-(SP)         Save state
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.W      D2,D0               Move the word to D0 for HEXTOASCII
                MOVE.L      #2,D1               2 bytes for a word
                JSR         HEXTOASCII
                
                ADD.L       #$04,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$05,D0             Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7         Restore state
                BRA         IM_EXIT             Exit this mode
    
GET_LONG        LEA         IMMED_PREFIX,A5
                MOVE.L      A5,(A6)+            Add '#$' to the output string
                *** NEED TO CONVERT D2 TO ASCII
                MOVE.L      (A2)+,D2            Read the long
                
                MOVEM.L     D0-D7,-(SP)         Save state
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.L      D2,D0               Move the long to D0 for HEXTOASCII
                MOVE.L      #4,D1               4 bytes for a long
                JSR         HEXTOASCII
                
                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0             Number of hex characters to display (zero based)
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string

                
                MOVEM.L     (SP)+,D0-D7         Restore state
                BRA         IM_EXIT             Exit this mode
        
IM_EXIT         MOVEM.L     (SP)+,A1/D0-D1      Restore the state!
                RTS                             Leave this place

*-------------------------------------------*
* For replacing the current Register with 
* the SP register. EX (SP),D1...
*   
*   
STACK_REG       MOVEM.L     D0/A1,-(SP)

                LEA         SP_REG,A5
                MOVE.L      A5,(A6)+
                
                MOVEM.L     (SP)+,D0/A1 
                
*-------------------------------------------*


            
exit            MOVE.L      #13,D0
                LEA         TAB,A1
                TRAP        #15                 ; print a new line before repeating prompt
                JSR         START
                SIMHALT                         ; halt simulator

* Put variables and constants here
prompt_start    DC.B        'What is the starting address?',CR,LF,0
prompt_end      DC.B        'What is the ending address?',CR,LF,0
input           DCB.B       256,0
invalidAdd      DC.B        'ERROR',0
COMMA           DC.B        ',',0
TAB             DC.B        '    ',0
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
*------------------------------------------------------------------*
DATA_STR        DC.B        '      DATA',CR,LF,0
NOP_STR         DC.B        '      NOP',CR,LF,0
MOVEB_STR       DC.B        '      MOVE.B',0
BRA8_STR        DC.B        '      BRA - 8-bit displacement  **FINISHHHHH',0
BRA16_STR       DC.B        '      BRA - 16-bit displacement **FINISH HIM',0
BRA32_STR       DC.B        '      BRA - 32-bit displacement **FINISH HIM',0
LEA_STR         DC.B        '      LEA',0
JSR_STR         DC.B        '      JSR',0
OR_STR          DC.B        '      OR',0
ORI_STR         DC.B        '      ORI',0
NEG_STR         DC.B        '      NEG',0
RTS_STR         DC.B        '      RTS',0
BCLR_STR        DC.B        '      BCLR',0
LSL_STR         DC.B        '      LSL',0
LSR_STR         DC.B        '      LSR',0
CMPI_STR        DC.B        '      CMPI',0

*------------------------------------------------------------------*
* EA REGISTERS
*------------------------------------------------------------------*
* DATA Register

DATA_REG        DC.B        'D',0
ADDR_REG        DC.B        'A',0
SP_REG          DC.B        'SP',0

*------------------------------------------------------------------*
INST_LINE       DCB.B       256,0                   String for one line of instruction

                END         START                   ; last line of source



































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
