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
SRC_MODE    EQU    %00111000  
SRC_ADDR    EQU    %00000111    
    
* DST
DEST_MODE   EQU    %00111000
DEST_ADDR   EQU    %00111000

*----------------------------------------------------------*
START:                              ; first instruction of program
            
            MOVE.W      #%0100111001110001, $7000       NOP 
            MOVE.W      #%0001001000000000, $7010       MOVE.B D0,D1
            MOVE.W      #%0001001000000111, $7020
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
opcode      CLR.L       D7              ; Clear D7 (not sure if this is necessary..?)
            LEA         JUMPTABLE,A0    ; load the jump table into A0
            JSR         OC_decode       ; decode the opcode
            CLR.L       D1              ; clear D1
            MOVE.L      D0,D1           ; move instruction into D1
            MOVE.B      #12,D2          ; load the value 12 into D2
            
                       
            LSR.W       D2,D7           ; shift the original operation right by 12 bits
            MULU        #6,D7           ; multiply the new value in D7 by 6
            JSR         00(A0,D7)       ; find the corresponding code in the jump table
            
OC_decode   MOVE.W      D0,D1           ; move the original operation into D1
            MOVE.W      D0,D7           ; also move it into D7                      SRC (MOD|ADDR)
            ANDI.W      #%0000000000111111,D1 ; bitmask the last 6 bits (bits 0-5)
            MOVE.B      D1,D5           ; move the last 6 bits into D5
            
            ROR.W       #6,D0           ; rotate the operation to the right by 6 bits
            MOVE.W      D0,D1           ; move the new op value into D1                 DEST (MOD)
            ANDI.W      #%0000000000000111,D1 ; bitmask the last 3 bits (bits 6-8)
            MOVE.B      D1,D4           ; move these bits into D4
            
            ROR.W       #3,D0           ; rotate the operation to the right by 3 bits
            MOVE.W      D0,D1           ; move the new op value into D1                 DEST (ADDR)
            ANDI.W      #%0000000000000111,D1 ; bitmask the last 3 bits (bits 9-11)
            MOVE.B      D1,D3           ; move these bits into D3
            
            RTS

JUMPTABLE   JMP         code0000
            JMP         code0001        MOVE.B
            JMP         code0010
            JMP         code0011
            JMP         code0100        NOP
            JMP         code0101
            JMP         code0110        BRA
            JMP         code0111
            JMP         code1000
            JMP         code1001
            JMP         code1010
            JMP         code1011
            JMP         code1100
            JMP         code1101
            JMP         code1110
            JMP         code1111
            
code0000    BRA         op_DATA

*-------------------------------------------------------------------------*
* Move Byte
*
*
*-------------------------------------------------------------------------*      
code0001    *MOVEM.L     D1,-(SP)   Save what we have here in D1 just in case
            
            MOVE.W      (A2)+,D7        Get instruction, advance pointer
            
            MOVE.B      #14,D0          Place MOVE.B string
            LEA         MOVEB_STR,A1
            TRAP        #15
            
            
            MOVE.B      #14,D0          Space with a tab
            LEA         TAB,A1
            TRAP        #15
            
            *MOVEM.L     (SP)+,D1        Restore it

            CLR         D0              Empty D0
            MOVE.B      D5,D0           Copy D5
            ANDI.B      #SRC_MODE,D0    Get Mode of source
            LSR.B       #3,D0           Shift bits over (MODE IN D0)
            
            JSR         FIND_MODE       Get its mode
            
            MOVE.B      #14,D0          Place the comma
            LEA         COMMA,A1
            TRAP        #15
            
            
            MOVE        D4,D0           Get Destination Mode
            MOVE        D3,D5           Get Destination Address
            
            JSR         FIND_MODE       Find destination mode
            
            *MOVE.B      #14,D0
            *LEA         DATA_STR,A1
            *TRAP        #15             ; OP code DNE
           
            RTS
            
            
code0010    BRA         op_DATA
            
code0011    BRA         op_DATA
            
code0100    
            *NOP
            CLR.L       D0              ; clear D0
            MOVE.W      #%0100111001110001,D0 ; move the NOP code into D0
            CLR.L       D1              ; clear D1
            MOVE.W      (A2),D1         ; move the original operation into D1
            CMP.W       D0,D1           ; compare D0 and D1
            BEQ         op_NOP          ; if they're equal, the operation is NOP
            
            *LEA
            MOVE.L      #%0000000000000011,D4
            ANDI.W      #%1111000111000000,D1
            CMP.W       #%0100000111000000,D1
            BEQ         op_LEA
            
            *JSR
            MOVE.W      (A2),D1                 ; move the original operation into D1 after LEA check
            MOVE.L      #%0000000000101011,D4   ; Prep for EA 
            ANDI.W      #%1111111111000000,D1   ; Get bits 6-15 for compare
            CMP.W       #%0100111010000000,D1   ; Check for JSR
            BEQ         op_JSR
            
            BRA         op_DATA
            
code0101    BRA         op_DATA
            
code0110    CLR.L       D0
            MOVE.W      (A2),D0
            ANDI.W      #%1111111100000000,D0 ; bitmask the first 6 bits (bits 8-15)
            LSR.L       #8,D0                 ; separate them
            CLR.L       D1
            MOVE.W      (A2),D1
            ANDI.W      #%0000000011111111,D1 ; bitmask the last 6 bits (bits 0-7)
            CMP.W       #%01100000,D0         ; standard first 8 bits of a BRA op
            BEQ         op_BRA                ; if they're equal, OP code is BRA

            BRA         op_DATA
            
code0111    BRA         op_DATA
            
code1000    * OR
            JSR         op_OR
            JSR         OR_opmode
            RTS

            * OP Code not found// prob not necessary?
            BRA         op_DATA
            
code1001    BRA         op_DATA
            
code1010    BRA         op_DATA
            
code1011    BRA         op_DATA
            
code1100    BRA         op_DATA
            
code1101    BRA         op_DATA
           
code1110    BRA         op_DATA
            
code1111    BRA         op_DATA

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
            TRAP        #15
            RTS

print_W     MOVE.L      #14,D0
            LEA         W_STR,A1
            TRAP        #15
            RTS

print_L     MOVE.L      #14,D0
            LEA         L_STR,A1
            TRAP        #15
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
            
            
*------------------------------------------------------------------*
* Determine EA MODE 
* This will deterine what effective addressing mode to do
* D0 - Contains our mode
* D5 contains the byte with both Src mode and Src Addr
* D7 Contains the instruction
*
* 
FIND_MODE   
            CMP.B   #0,D0   Which mode?
            BEQ     M_ONE
            CMP.B   #1,D0
            BEQ     M_TWO
            CMP.B   #3,D0
            BEQ     M_THREE
            CMP.B   #4,D0
            BEQ     M_FOUR
            CMP.B   #5,D0
            BEQ     M_FIVE
            CMP.B   #6,D0
            BEQ     M_SIX
            CMP.B   #7,D0
            BEQ     M_SEVEN
            
         

*-------------------------------------
* Mode on is data register direct mode
* D0 - has the mode
* 
M_ONE    MOVEM.L    D0-D7/A0-A7,-(SP)   Save our stuff real quick
                
         MOVE.B     #14,D0              Print the 'D'
         LEA        DATA_REG,A1         
         TRAP       #15
         
         
            
         CLR         D1                 Get SRC Address
         MOVE.B      D5,D1              
         ANDI.B      #SRC_ADDR,D1
            
         
                
         MOVE.B     #3,D0               (SRC ADDRESS IS IN D1)
         TRAP       #15                 Display it

         MOVEM.L    (SP)+,D0-D7/A0-A7   Restore registers
         
         RTS                            Leave this place  


M_TWO       BRA exit

M_THREE     BRA exit

M_FOUR      BRA exit

M_FIVE      BRA exit

M_SIX       BRA exit

M_SEVEN     BRA exit


            
exit        SIMHALT             ; halt simulator

* Put variables and constants here
prompt_start DC.B        'What is the starting address?',CR,LF,0
prompt_end   DC.B        'What is the ending address?',CR,LF,0
input        DCB.B       256,0
invalidAdd   DC.B        'ERROR',0
COMMA        DC.B        ',',0
TAB          DC.B        '    ',0
B_STR        DC.B        '.B    ',0
W_STR        DC.B        '.W    ',0
L_STR        DC.B        '.L    ',0
*------------------------------------------------------------------*
DATA_STR     DC.B        '      DATA',CR,LF,0
NOP_STR      DC.B        '      NOP',CR,LF,0
MOVEB_STR    DC.B        '      MOVE.B',0
BRA16_STR    DC.B        '      BRA - 16-bit displacement **FINISH HIM',0
BRA32_STR    DC.B        '      BRA - 32-bit displacement **FINISH HIM',0
LEA_STR      DC.B        '      LEA       **FINITOOOO',0
JSR_STR      DC.B        '      JSR',0
OR_STR       DC.B        '      OR',0

*------------------------------------------------------------------*
* EA REGISTERS
*------------------------------------------------------------------*
* DATA Register

DATA_REG        DC.B        'D',0
ADD_REG         DC.B        'A',0


REG_D0          DC.B        'D0',0
REG_D1          DC.B        'D1',0
REG_D2          DC.B        'D2',0
REG_D3          DC.B        'D3',0
REG_D4          DC.B        'D4',0
REG_D5          DC.B        'D5',0
REG_D6          DC.B        'D6',0
REG_D7          DC.B        'D7',0
*------------------------------------------------------------------*
* Address Registers
REG_A0          DC.B        'A0',0
REG_A1          DC.B        'A1',0
REG_A2          DC.B        'A2',0
REG_A3          DC.B        'A3',0
REG_A4          DC.B        'A4',0
REG_A5          DC.B        'A5',0
REG_A6          DC.B        'A6',0
REG_A7          DC.B        'A7',0


*------------------------------------------------------------------*
INST_LINE       DCB.B       256,0   String for one line of instruction

             END         START        ; last line of source













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
