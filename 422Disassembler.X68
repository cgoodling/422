*-----------------------------------------------------------
* Title      : Convert ASCII to hex
* Written by : Kaley & Cole & Abby
* Date       : 11/11/14
* Description: Small piece of disassembler project
*-----------------------------------------------------------

*--------------------- HEX FOR OUTPUT ---------------------*
            OPT         CRE
CR          EQU         $0D
LF          EQU         $0A
STACK       EQU         $8000
            ORG         $1000
            
*----------------------------------------------------------*
*Mode Masks
* SRC 
EA_MODE    EQU    %00111000  
EA_REG     EQU    %00000111    
    
* DST
DEST_MODE   EQU    %00111000
DEST_REG    EQU    %00000111

*----------------------------------------------------------*
START:                              
            * For testing           
            MOVE.W      #%0100111001110001, $7000       NOP 
            MOVE.W      #%0001001000000000, $7010       MOVE.B D0,D1
            MOVE.W      #%0001011000000111, $7020       MOVE.B D7,D3
            MOVE.W      #%0110000000000000, $7030       BRA 16bit
            MOVE.W      #%0101010101010101, $7032       55 following
            MOVE.W      #%0110000011111111, $7040       BRA 32bit
            MOVE.L      #%01010101010101010101010101010101, $7042 ; 5555 following
            MOVE.W      #%0100101111010101, $7050       LEA A5 with D5
            MOVE.W      #%0100111010000000, $7070       JSR
            MOVE.W      #%1000101001000001, $7080       OR.W D5,D1 (into Dn)
            MOVE.W      #%1000101000000001, $7090       OR.B D5,D1 (into Dn)
            MOVE.W      #%1000101100000001, $8000       OR.B D5,D1 (into ea)
            MOVE.W      #%1000101101000001, $8010       OR.W D5,D1 (into ea)
            MOVE.W      #%1000101010000001, $8020       OR.L D5,D1 (into Dn)
            MOVE.W      #%1000101110000001, $8030       OR.L D5,D1 (into ea)
            MOVE.W      #%0000000000000101, $8040       ORI.B #%xx,D5
            MOVE.W      #%0000000001000101, $8050       ORI.W #%xxxx,D5
            MOVE.W      #%0000000010000101, $8060       ORI.L #%xxxxxxxx,D5
            MOVE.W      #%0100010000000001, $8070       NEG.B
            MOVE.W      #%0100010001000001, $8080       NEG.W
            MOVE.W      #%0100010010000001, $8090       NEG.L
            MOVE.W      #%0100111001110101, $9000       RTS
            MOVE.W      #%0000101110010001, $9010       BCLR D5,A1 
            MOVE.W      #%0011001001000110, $9020       MOVE.W D6,A1
            MOVE.W      #%1110011100001101, $9030       LSL.B #3,D5
            MOVE.W      #%1110011101001101, $9040       LSL.W #3,D5
            MOVE.W      #%1110011110001101, $9050       LSL.L #3,D5
            
            MOVE.W      #%1110011100101101, $9060       LSL.B D3,D5
            MOVE.W      #%1110011101101101, $9070       LSL.W D3,D5
            MOVE.W      #%1110011110101101, $9080       LSL.L D3,D5
            
            MOVE.W      #%1110011000001101, $9090       LSR.B #3,D5
            MOVE.W      #%1110011001001101, $9100       LSR.W #3,D5
            MOVE.W      #%1110011010001101, $9110       LSR.L #3,D5
            
            MOVE.W      #%1110011000101101, $9120       LSR.B D3,D5
            MOVE.W      #%1110011001101101, $9130       LSR.W D3,D5
            MOVE.W      #%1110011010101101, $9140       LSR.L D3,D5
            
            MOVE.W      #%0000110000000001, $9200       CMPI.B #%xx,D1
            MOVE.W      #%0000110001010001, $9210       CMPI.W #%xxxx,(A1)
            MOVE.W      #%0000110010011001, $9220       CMPI.L #%xxxxxxxx,(A1)+
            
            
            LEA         STACK,SP    Load the stack
            
            MOVE.B      #14,D0
            LEA         prompt_start,A1
            TRAP #15                ; prompt for starting address
            
            MOVE.B      #2,D0
            LEA         input,A1
            TRAP #15                ; store user input
            
            JSR         asciiToHexS ; convert user input from start address to hex
            *MOVE.B      #14,D0
            *LEA         prompt_end,A1
            *TRAP        #15         ; prompt for ending address
            *MOVE.B      #2,D0
            *LEA         input,A1
            *TRAP        #15         ; store user input
            *JSR         asciiToHexE ; convert user input for end address to hex
            
            MOVE.L      D3,A1       ; move the start address into A1
            MOVE.L      D3,A2       ; also move it into A2
            MOVE.L      D4,A3       ; move the ending address into A3
            CLR.L       D0
            CLR.L       D1
            CLR.L       D2
            CLR.L       D3
            CLR.L       D4
            CLR.L       D5
            CLR.L       D6
            CLR.L       D7          ; clear all of the registers

            MOVEA.L     A1,A3       ; move the current operation address to A3
            MOVE.W      (A1)+,D0    ; move the starting address to D0
            JSR         opcode      ; decode the opcode
            
            JSR         exit

******************************* ASCII TO HEX *****************************
* Convert starting address from ASCII to Hex, stores in D3
* D0 = temp value, D1 = length of string, D2 = counter, D3 = ret val
* A1 = memory location of beginning of the string
asciiToHexS CMP.B       #8,D1        ; check that length is <= 8
            BGT         invalidAdd
            CMP.B       #0,D1        ; check that length is > 0
            BLE         invalidAdd
            CLR.L       D3           ; clear return value
            SUBQ.B      #1,D1        ; subtract 1 from the counter
            
ATHS_loop   ROL.L       #4,D3        ; shift bits left by 4
            MOVE.B      (A1)+,D0     ; copy next byte from memory to convert
            CMP.B       #$39,D0      ; if the value is < 39 its a number
            BGT         ATHS_letter  ; its its not a number process it as a letter
            CMP.B       #$30,D0      ; if the value is < 30 its invalid
            BLT         invalidAdd
            SUBI.B      #$30,D0      ; its a valid number, subtract 30
            BRA         ATHS_done
            
ATHS_letter CMP.B       #$66,D0      ; if the value is > 66 its invalid
            BGT         invalidAdd
            CMP.B       #$61,D0      ; if the value is >= 61 its lowercase
            BGE         ATHS_lower   ; process it as a lowercase letter
            CMP.B       #$46,D0      ; if the value is less than 46 its invalid
            BGT         invalidAdd
            CMP.B       #$41,D0      ; if the value is less than 41 its invalid
            BLT         invalidAdd
            SUBI.B      #$37,D0      ; valid letter, subtract 37
            BRA         ATHS_done
            
ATHS_lower  SUBI.B      #$57,D0      ; convert lowercase letter to hex
            BRA         ATHS_done
            
ATHS_done   OR.L        D0,D3        ; OR the result to the retVal
            DBF         D1,ATHS_loop ; decrement counter and loop while they're > 0
            CLR.L D1                 ; done
            RTS
            
* Convert ending address from ASCII to Hex, stores in D4
* D0 = temp value, D1 = length of string, D2 = counter, D4 = ret val
* A1 = memory location of beginning of the string
asciiToHexE CMP.B       #8,D1        ; check that length is <= 8
            BGT         invalidAdd
            CMP.B       #0,D1        ; check that length is > 0
            BLE         invalidAdd
            CLR.L       D4           ; clear return value
            SUBQ.B      #1,D1        ; subtract 1 from the counter
            
ATHE_loop   ROL.L       #4,D4        ; shift bits left by 4
            MOVE.B      (A1)+,D0     ; copy next byte from memory to convert
            CMP.B       #$39,D0      ; if the value is < 39 its a number
            BGT         ATHE_letter  ; its its not a number process it as a letter
            CMP.B       #$30,D0      ; if the value is < 30 its invalid
            BLT         invalidAdd
            SUBI.B      #$30,D0      ; its a valid number, subtract 30
            BRA         ATHE_done
            
ATHE_letter CMP.B       #$66,D0      ; if the value is > 66 its invalid
            BGT         invalidAdd
            CMP.B       #$61,D0      ; if the value is >= 61 its lowercase
            BGE         ATHE_lower   ; process it as a lowercase letter
            CMP.B       #$46,D0      ; if the value is less than 46 its invalid
            BGT         invalidAdd
            CMP.B       #$41,D0      ; if the value is less than 41 its invalid
            BLT         invalidAdd
            SUBI.B      #$37,D0      ; valid letter, subtract 37
            BRA         ATHE_done
            
ATHE_lower  SUBI.B      #$57,D0      ; convert lowercase letter to hex
            BRA         ATHE_done
            
ATHE_done   OR.L        D0,D4        ; OR the result to the retVal
            DBF         D1,ATHE_loop ; decrement counter and loop while they're > 0
            CLR.L       D1           ; done
            RTS

******************************** OPCODE **********************************
opcode      CLR.L       D7                  ; Clear D7 (not sure if this is necessary..?)
            LEA         JUMPTABLE,A0        ; load the jump table into A0
            JSR         OC_decode           ; decode the opcode
            CLR.L       D1                  ; clear D1
            MOVE.L      D0,D1               ; move instruction into D1
            MOVE.B      #12,D2              ; load the value 12 into D2
            
                       
            LSR.W       D2,D7               ; shift the original operation right by 12 bits
            MULU        #6,D7               ; multiply the new value in D7 by 6
            JSR         00(A0,D7)           ; find the corresponding code in the jump table
            
OC_decode   MOVE.W      D0,D1                   ; move the original operation into D1
            MOVE.W      D0,D7                   ; also move it into D7                      Effective Addressing BITS
            ANDI.W      #%0000000000111111,D1   ; bitmask the last 6 bits (bits 0-5)
            MOVE.B      D1,D5                   ; move the last 6 bits into D5
            
            ROR.W       #6,D0                   ; rotate the operation to the right by 6 bits
            MOVE.W      D0,D1                   ; move the new op value into D1                OPMODE BITS
            ANDI.W      #%0000000000000111,D1   ; bitmask the last 3 bits (bits 6-8)
            MOVE.B      D1,D4                   ; move these bits into D4
            
            ROR.W       #3,D0                   ; rotate the operation to the right by 3 bits
            MOVE.W      D0,D1                   ; move the new op value into D1                 Register bits
            ANDI.W      #%0000000000000111,D1   ; bitmask the last 3 bits (bits 9-11)
            MOVE.B      D1,D3                   ; move these bits into D3
            
            RTS

JUMPTABLE   JMP         op0000        ORI, BCLR
            JMP         op0001        MOVE.B
            JMP         op0010
            JMP         op0011
            JMP         op0100        NEG, NOP, LEA, JSR, RTS
            JMP         op0101
            JMP         op0110        BRA
            JMP         op0111
            JMP         op1000        OR.X
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
op0000    
            *ORI
            MOVE.W      (A2),D1                ; copy instruction into D1
            ANDI        #%1111111100000000,D1  ; isolate bits 8-15
            CMP.W       #%0000000000000000,D1  ; check if this is ORI
            BEQ         op_ORI
            
            *BCLR
            MOVE.W      (A2),D1                ; copy instruction into D1
            ANDI        #%0000000111000000,D1  ; get bits 9-11
            CMP.W       #%0000000110000000,D1  ; check for BCLR
            BEQ         op_BCLR
            
            *CMPI
            MOVE.W      (A2),D1
            ANDI        #%1111111100000000,D1  ; get bits 8-15
            CMP.W       #%0000110000000000,D1  ; check for CMPI
            BEQ         op_CMPI
            
            BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Byte
*-------------------------------------------------------------------------*
op0001      *MOVEM.L     D1,-(SP)   Save what we have here in D1 just in case
            JSR         print_add
            MOVE.W      (A2)+,D7        Get instruction, advance pointer
            
            MOVE.B      #14,D0          Place MOVE.B string
            LEA         MOVEB_STR,A1
            TRAP        #15
            
            
            MOVE.B      #14,D0          Space with a tab
            LEA         TAB,A1
            TRAP        #15
            
            *MOVEM.L     (SP)+,D1        Restore it
            
            JSR         FIND_EAMODE       Get its mode
            
            MOVE.B      #14,D0          Place the comma
            LEA         COMMA,A1
            TRAP        #15
            
                        
            JSR         OP_MODE       Find destination mode
            
            *MOVE.B      #14,D0
            *LEA         DATA_STR,A1
            *TRAP        #15             ; OP code DNE
           
            RTS
            
*-------------------------------------------------------------------------*
* Move Long
*-------------------------------------------------------------------------*            
op0010      BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Word
*-------------------------------------------------------------------------*             
op0011      BRA         op_DATA

*-------------------------------------------------------------------------*
* Negate, No Operation, Load Effective Address, Jump to Subroutine, 
* Return from Subroutine, Move Multiple Registers
*-------------------------------------------------------------------------*             
op0100    
            *NEG
            MOVE.W      (A2),D1                 ; move operation into D1
	        ANDI.W	    #%0000000011000000,D4   ; get the size
	        ANDI.W	    #%1111111100000000,D1	; Get bits 8-15
	        CMP.W	    #%0100010000000000,D1	; Check for NEG
	        BEQ         op_NEG
	        
            *NOP
            CLR.L       D0                      ; clear D0
            MOVE.W      #%0100111001110001,D0   ; move the NOP code into D0
            CLR.L       D1                      ; clear D1
            MOVE.W      (A2),D1                 ; move the original operation into D1
            CMP.W       D0,D1                   ; compare D0 and D1
            BEQ         op_NOP                  ; if they're equal, the operation is NOP
            
            *LEA
            MOVE.L      #%0000000000000011,D4
            ANDI.W      #%1111000111000000,D1
            CMP.W       #%0100000111000000,D1
            BEQ         op_LEA
            
            *JSR
            MOVE.W      (A2),D1                 ; move the original operation into D1 
            ANDI.W      #%1111111111000000,D1   ; Get bits 6-15 for compare
            CMP.W       #%0100111010000000,D1   ; Check for JSR
            BEQ         op_JSR
            
            *RTS
            MOVE.W      (A2),D1                 ; move the original operation into D1
            CMP.W       #%0100111001110101,D1	; Check for RTS
            BEQ         op_RTS

            
            BRA         op_DATA                 ; invalid

          
op0101      BRA         op_DATA

*-------------------------------------------------------------------------*
* Branch Subroutine, Branch Always, Branch Conditionally
*-------------------------------------------------------------------------*             
op0110    
            *BRA
            CLR.L       D0
            MOVE.W      (A2),D0
            ANDI.W      #%1111111100000000,D0 ; bitmask the first 6 bits (bits 8-15)
            LSR.L       #8,D0                 ; separate them
            CLR.L       D1
            MOVE.W      (A2),D1
            ANDI.W      #%0000000011111111,D1 ; bitmask the last 6 bits (bits 0-7)
            CMP.W       #%01100000,D0         ; standard first 8 bits of a BRA op
            BEQ         op_BRA                ; if they're equal, OP code is BRA

            BRA         op_DATA
            
op0111      BRA         op_DATA

*-------------------------------------------------------------------------*
* Inclusive Or, Signed Divide
*-------------------------------------------------------------------------*             
op1000    
            * OR
            JSR         op_OR
            JSR         OR_opmode
            RTS

            * OP Code not found// prob not necessary?
            BRA         op_DATA

*-------------------------------------------------------------------------*
* Subtract
*-------------------------------------------------------------------------*             
op1001      BRA         op_DATA
            
op1010      BRA         op_DATA

*-------------------------------------------------------------------------*
* Exclusive Or, Compare
*-------------------------------------------------------------------------*             
op1011      BRA         op_DATA

*-------------------------------------------------------------------------*
* Signed Multiply
*-------------------------------------------------------------------------*            
op1100      BRA         op_DATA

*-------------------------------------------------------------------------*
* Add Address, Add
*-------------------------------------------------------------------------*            
op1101      BRA         op_DATA

*-------------------------------------------------------------------------*
* Arithmetic Shift Left, Arithmetic Shift Right, Logical Shift Left, 
* Logical Shift Right, Rotate Left, Rotate Right
*-------------------------------------------------------------------------*            
op1110      *LSL
            MOVE.W      (A2),D1
            ANDI.W      #%1111111111000000,D1
            CMP.W       #%1110001111000000,D1       ; LSL EA mode
            BEQ         LSL_ea
            MOVE.W      (A2),D1
            ANDI.W      #%1111000100111000,D1
            CMP.W       #%1110000100001000,D1
            BEQ         LSL_count
            CMP.W       #%1110000100101000,D1
            BEQ         LSL_reg
            
            BRA         op_DATA
            
op1111      BRA         op_DATA

LSL_ea      JSR         op_LSL_ea
            *** NEEDS TO BE FINISHED
            RTS

LSL_count   JSR         op_LSL
            MOVE.L      #14,D0
            LEA         POUND,A1
            TRAP        #15             ; print #
            
            MOVE.W      (A2),D1
            ANDI.W      #%0000111000000000,D1
            LSR.L       #8,D1
            LSR.L       #1,D1
            MOVE.L      #16,D2
            
            MOVE.L      #15,D0
            TRAP        #15             ; print the register
            
            MOVE.L      #14,D0
            LEA         COMMA,A1
            TRAP        #15             ; print a comma
            
            MOVE.L      #14,D0
            LEA         DATA_REG,A1
            TRAP        #15             ; print 'D'
            
            MOVE.W      (A2),D1
            ANDI.W      #%0000000000000111,D1
            MOVE.L      #16,D2
            
            MOVE.L      #15,D0
            TRAP        #15             ; print the register
            
            RTS

LSL_reg     JSR         op_LSL
            MOVE.L      #14,D0
            LEA         DATA_REG,A1
            TRAP        #15             ; print 'D'
            
            MOVE.W      (A2),D1
            ANDI.W      #%0000111000000000,D1
            LSR.L       #8,D1
            LSR.L       #1,D1
            MOVE.L      #16,D2
            
            MOVE.L      #15,D0
            TRAP        #15             ; print the register
            
            MOVE.L      #14,D0
            LEA         COMMA,A1
            TRAP        #15             ; print a comma
            
            MOVE.L      #14,D0
            LEA         DATA_REG,A1
            TRAP        #15             ; print 'D'
            
            MOVE.W      (A2),D1
            ANDI.W      #%0000000000000111,D1
            MOVE.L      #16,D2
            
            MOVE.L      #15,D0
            TRAP        #15             ; print the register


            RTS
            

OR_opmode   CMP.W       #%0000,D4
            BEQ         print_B
            CMP.W       #%0100,D4
            BEQ         print_B
            CMP.W       #%0001,D4
            BEQ         print_W
            CMP.W       #%0101,D4
            BEQ         print_W
            CMP.W       #%0010,D4
            BEQ         print_L
            CMP.W       #%0110,D4
            BEQ         print_L
            CMP.W       #%0111,D4
            BEQ         op_DATA

print_add   MOVE.L      A3,D1           ; Move the current address to D1
            MOVE.L      #15,D0          ; Move the I/O code to D0 to print the number in D1
            MOVE.L      #16,D2          ; Print the number in base 16
            TRAP        #15             ; print
            RTS
           
print_B     MOVE.L      #14,D0
            LEA         B_STR,A1
            TRAP        #15             ; print .B
            RTS

print_W     MOVE.L      #14,D0
            LEA         W_STR,A1
            TRAP        #15             ; print .W
            RTS

print_L     MOVE.L      #14,D0
            LEA         L_STR,A1
            TRAP        #15             ; print .L
            RTS
            
op_NOP      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         NOP_STR,A1
            TRAP        #15             ; OP code DNE
            RTS
            
op_DATA     JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         DATA_STR,A1
            TRAP        #15             ; OP code DNE
            RTS
            
op_BRA      MOVE.L      #%11111111,D2   ; $FF into D2
            MOVE.L      #%00000000,D3   ; $00 into D3
            
            CMP.B       D1,D3           ; check the value of the last 8 bits against $00
            BEQ         op_BRA16        ; if equal, it's a 16 bit displacement
            
            CMP.B       D1,D2           ; check the value of the last 8 bits against $FF
            BEQ         op_BRA32        ; if equal, it's a 32 bit displacement
            
            JSR         op_NOP          ; OP code DNE
            RTS

op_BRA16    JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         BRA16_STR,A1
            TRAP        #15             ; 16 bit displacement
            RTS

op_BRA32    JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         BRA32_STR,A1
            TRAP        #15             ; 32 bit displacement
            RTS
          
op_LEA      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         LEA_STR,A1
            TRAP        #15
            RTS

op_JSR      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         JSR_STR,A1
            TRAP        #15
            RTS
         
op_OR       JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         OR_STR,A1
            TRAP        #15
            RTS
            
op_ORI      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         ORI_STR,A1      ; print the op
            TRAP        #15
            BRA         opcode_size     ; find the size and print
            RTS
            
op_BCLR     JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         BCLR_STR,A1     ; print the op
            TRAP        #15
            RTS
            
opcode_size MOVE.W      (A2),D1
            ANDI.W      #%0000000011000000,D1
            CMP.W       #%0000000000000000,D1   ; check for byte
            BEQ         print_B
            CMP.W       #%0000000001000000,D1   ; check for word
            BEQ         print_W
            CMP.W       #%0000000010000000,D1   ; check for long
            BEQ         print_L
            
op_NEG      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         NEG_STR,A1      ; print the op
            TRAP        #15
            BRA         opcode_size     ; find the size and print
            RTS

op_RTS      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         RTS_STR,A1      ; print the op
            TRAP        #15
            RTS
            
op_LSL      JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         LSL_STR,A1
            TRAP        #15             ; print the operation
            
            JSR         opcode_size     ; print the size
            
            RTS
            
op_LSL_ea   JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         LSL_STR,A1
            TRAP        #15             ; print the operation
            
            RTS
            
op_CMPI     JSR         print_add       ; print the address
            MOVE.L      #14,D0
            LEA         CMPI_STR,A1
            TRAP        #15
            BRA         opcode_size     ; print the size
            RTS
            
            *BRA         op_DATA
            
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

FIND_EAMODE   MOVE.B  D5,D2
              ANDI.B  #EA_REG,D2      Get the EA register    
              ANDI.B  #EA_MODE,D5     Get the EA Mode
              LSR.B   #3,D5
              BRA     MODE_SELECT 
 

*------------------------------------------------------------------------*
* This Subroutine performs the same way as EA, only we get the 
* Desination reg and mode (mainly for testing simpler commands where
* we know the what register and mode are, 
* D4 - is expected to carry an the op-mode
* D3 - has the appropriate register
*             
OP_MODE       MOVE.B  D4,D5         Get OPMODE (this is for destination mode, reg testing)
              MOVE.B  D3,D2         Get reg number then go to appropriate mode

*-----------------------------------------------------------------------
* This goes to the appropriate mode whether we start with FIND_EAMODE
* or OP_MODE
* D5 - is the mode
* D2 - is expected to have the reg number
*


MODE_SELECT   CMP.B   #0,D5     MODE ZERO Goes to DATA REG DIRECT
              BEQ     M_ZERO
              CMP.B   #1,D5
              BEQ     M_ONE     Address Reg Direct
              CMP.B   #2,D5
              BEQ     M_TWO     Address Reg Indirect
              CMP.B   #3,D5
              BEQ     M_THREE   Address Reg Indirect Post Inc
              CMP.B   #4,D5
              BEQ     M_FOUR    Address Reg Indirect Pre Dec
              CMP.B   #5,D5
              BEQ     M_FIVE
              CMP.B   #6,D5
              BEQ     M_SIX
              CMP.B   #7,D5
              BEQ     M_SEVEN
            
         

*-------------------------------------
* Mode zero is data register direct mode
* D2 - has the Register
* 
M_ZERO    MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick
                
          MOVE.B     #14,D0              Print the 'D'
          LEA        DATA_REG,A1         
          TRAP       #15
         
          CLR         D1                 Get EA Register
          MOVE.B      D2,D1                          
                
          MOVE.B     #3,D0               EA REG in D1
          TRAP       #15                 Display it

          MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
          RTS                            Leave this place 
 
 
 
*------------------------------------------- 
* Mode One is Address Register Direct
* D2 has the register
*
M_ONE     MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick
                
          MOVE.B     #14,D0              Print the 'A'
          LEA        ADDR_REG,A1         
          TRAP       #15
         
          CLR         D1                 Get EA Register
          MOVE.B      D2,D1                          
                
          MOVE.B     #3,D0               EA REG in D1
          TRAP       #15                 Display it

          MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
          RTS                            Leave this place 


*---------------------------------------------
* Mode Two is Address Register Indirect
* (A2)
*
M_TWO       MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick
            MOVE.B     #14,D0              Print the '('
            LEA        L_PAREN,A1
            TRAP       #15
            
            
            MOVE.B     #14,D0              Print the 'A'
            LEA        ADDR_REG,A1         
            TRAP       #15

            CLR        D1                  Get EA Register
            MOVE.B     D2,D1                          
                
            MOVE.B     #3,D0               EA REG in D1
            TRAP       #15                 Display it
            
           
            MOVE.B     #14,D0              Print the ')'
            LEA        R_PAREN,A1
            TRAP       #15
            
            MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
            RTS                            Leave this place 


*--------------------------------------------------------*
* Mode is Register Indirect Post Increment Mode
*
*
*    
M_THREE     MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick

            MOVE.B     #14,D0              Print the '('
            LEA        L_PAREN,A1
            TRAP       #15
            
            
            MOVE.B     #14,D0              Print the 'A'
            LEA        ADDR_REG,A1         
            TRAP       #15

            CLR        D1                  Get EA Register
            MOVE.B     D2,D1                          
                
            MOVE.B     #3,D0               EA REG in D1
            TRAP       #15                 Display it
            
           
            MOVE.B     #14,D0              Print the ')'
            LEA        R_PAREN,A1
            TRAP       #15

            MOVE.B     #14,D0              Print the '+'
            LEA        INCREMENT,A1
            TRAP       #15

            MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
            RTS                            Leave this place 


*--------------------------------------------------------------
* Mode is Register Indirect Pre-Decrement Mode
*
*            

M_FOUR      MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick
            
            MOVE.B     #14,D0              Print the '-'
            LEA        DECREMENT,A1
            TRAP       #15           

            MOVE.B     #14,D0              Print the '('
            LEA        L_PAREN,A1
            TRAP       #15
            
            
            MOVE.B     #14,D0              Print the 'A'
            LEA        ADDR_REG,A1         
            TRAP       #15

            CLR        D1                  Get EA Register
            MOVE.B     D2,D1                          
                
            MOVE.B     #3,D0               EA REG in D1
            TRAP       #15                 Display it
            
           
            MOVE.B     #14,D0              Print the ')'
            LEA        R_PAREN,A1
            TRAP       #15


            MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
            RTS                            Leave this place 



M_FIVE      BRA exit

M_SIX       BRA exit



*--------------------------------------------*
* Mode seven is special, it does stuff
* like absolute addressing and immediate 
* data.
* D2 - is the register data
* D5 - the mode data
*
M_SEVEN     CMP.B   #0,D2
            BEQ     ABS_SHORTADDR
            CMP.B   #1,D2
            BEQ     ABS_LONGADDR
            CMP.B   #2,D2
            BEQ     exit            NOT DONE
            CMP.B   #3,D2
            BEQ     exit            NOT DONE
            CMP.B   #4,D2       
            BEQ     IMMED_DATA

            

ABS_SHORTADDR   BRA exit


ABS_LONGADDR    BRA exit


IMMED_DATA  BRA exit





*-------------------------------------------*
* For replacing the current Register with 
* the SP register. EX (SP),D1...
*   
*   
STACK_PREG

            MOVE.B  #14,D0
            LEA     SP_REG,A1
            TRAP    #15
            
*-------------------------------------------*


            
exit        SIMHALT             ; halt simulator

* Put variables and constants here
prompt_start DC.B        'What is the starting address?',CR,LF,0
prompt_end   DC.B        'What is the ending address?',CR,LF,0
input        DCB.B       256,0
invalidAdd   DC.B        'ERROR',0
COMMA        DC.B        ',',0
TAB          DC.B        '    ',0
B_STR        DC.B        '.B ',0
W_STR        DC.B        '.W ',0
L_STR        DC.B        '.L ',0
L_PAREN      DC.B        '(',0
R_PAREN      DC.B        ')',0
INCREMENT    DC.B        '+',0
DECREMENT    DC.B        '-',0
POUND        DC.B        '#',0
*------------------------------------------------------------------*
DATA_STR     DC.B        '      DATA',CR,LF,0
NOP_STR      DC.B        '      NOP',CR,LF,0
MOVEB_STR    DC.B        '      MOVE.B',0
BRA16_STR    DC.B        '      BRA - 16-bit displacement **FINISH HIM',0
BRA32_STR    DC.B        '      BRA - 32-bit displacement **FINISH HIM',0
LEA_STR      DC.B        '      LEA       **FINITOOOO',0
JSR_STR      DC.B        '      JSR',0
OR_STR       DC.B        '      OR',0
ORI_STR      DC.B        '      ORI',0
NEG_STR      DC.B        '      NEG',0
RTS_STR      DC.B        '      RTS',0
BCLR_STR     DC.B        '      BCLR',0
LSL_STR      DC.B        '      LSL',0
CMPI_STR     DC.B        '      CMPI',0

*------------------------------------------------------------------*
* EA REGISTERS
*------------------------------------------------------------------*
* DATA Register

DATA_REG        DC.B        'D',0
ADDR_REG        DC.B        'A',0
SP_REG          DC.B        'SP',0

*------------------------------------------------------------------*
INST_LINE       DCB.B       256,0   String for one line of instruction

             END         START        ; last line of source























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
