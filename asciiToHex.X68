*-----------------------------------------------------------
* Title      : Convert ASCII to hex
* Written by : Kaley & Cole
* Date       : 11/11/14
* Description: Small piece of disassembler project
*-----------------------------------------------------------

*--------------------- HEX FOR OUTPUT ---------------------*
            OPT         CRE
CR          EQU         $0D
LF          EQU         $0A

            ORG         $1000
START:                  ; first instruction of program
            MOVE.W      #%0100111001110001, $7000
            
            MOVE.B      #14,D0
            LEA         prompt,A1
            TRAP        #15             ; prompt for address
            
            MOVE.B      #2,D0
            LEA         input,A1
            TRAP        #15             ; store user input
            
            JSR         asciiToHex      ; convert user input to hex
            
            MOVE.L      D3,A1
            MOVE.L      D3,A2
            CLR.L       D0
            CLR.L       D1
            CLR.L       D2
            CLR.L       D3
            CLR.L       D4
            CLR.L       D5
            CLR.L       D6
            CLR.L       D7
            
            MOVE.W      (A1)+,D0
            JSR         opcode
            
            JSR         exit

* Put program code here
******************************** OPCODE **********************************
opcode      CLR.L       D7
            LEA         JUMPTABLE,A0
            JSR         OC_decode
            CLR.L       D1
            MOVE.L      D0,D1
            MOVE.B      #12,D2
            LSR.W       D2,D7
            MULU        #6,D7
            JSR         00(A0,D7)
            
OC_decode   MOVE.W      D0,D1
            MOVE.W      D0,D7
            ANDI.W      #%0000000000111111,D1
            MOVE.B      D1,D5
            
            ROR.W       #6,D0
            MOVE.W      D0,D1
            ANDI.W      #%0000000000000111,D1
            MOVE.B      D1,D4
            
            ROR.W       #3,D0
            MOVE.W      D0,D1
            ANDI.W      #%0000000000000111,D1
            MOVE.B      D1,D3
            
            RTS

JUMPTABLE   JMP         code0000
            JMP         code0001
            JMP         code0010
            JMP         code0011
            JMP         code0100
            JMP         code0101
            JMP         code0110
            JMP         code0111
            JMP         code1000
            JMP         code1001
            JMP         code1010
            JMP         code1011
            JMP         code1100
            JMP         code1101
            JMP         code1110
            JMP         code1111
            
code0000    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0001    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0010    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0011    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0100    CLR.L       D0
            MOVE.W      #%0100111001110001,D0
            CLR.L       D1
            MOVE.W      (A2)+,D1
            CMP.W       D0,D1
            BEQ         op_NOP
            
            MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0101    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0110    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code0111    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1000    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1001    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1010    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1011    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1100    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1101    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
           
code1110    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
code1111    MOVE.B      #14,D0
            LEA         error,A1
            TRAP        #15             ; OP code DNE
            RTS
            
op_NOP      MOVE.L      #14,D0
            LEA         NOP,A1
            TRAP        #15             ; OP code DNE
            RTS

******************************* ASCII TO HEX *****************************
* D0 = temp value, D1 = length of string, D2 = counter, D3 = ret val
* A1 = memory location of beginning of the string
asciiToHex  CMP.B       #8,D1           ; check that length is <= 8
            BGT         invalidAdd
            CMP.B       #0,D1           ; check that length is > 0
            BLE         invalidAdd
            
            CLR.L       D3              ; clear return value
            SUBQ.B      #1,D1           ; subtract 1 from the counter
            
ATH_loop    ROL.L       #4,D3           ; shift bits left by 4
            MOVE.B      (A1)+,D0        ; copy next byte from memory to convert
            CMP.B       #$39,D0         ; if the value is < 39 its a number
            BGT         ATH_letter      ; its its not a number process it as a letter
            CMP.B       #$30,D0         ; if the value is < 30 its invalid
            BLT         invalidAdd
            SUBI.B      #$30,D0         ; its a valid number, subtract 30
            BRA         ATH_done
            
ATH_letter  CMP.B       #$66,D0         ; if the value is > 66 its invalid
            BGT         invalidAdd
            CMP.B       #$61,D0         ; if the value is >= 61 its lowercase
            BGE         ATH_lower       ; process it as a lowercase letter
            
            CMP.B       #$46,D0         ; if the value is less than 46 its invalid
            BGT         invalidAdd
            CMP.B       #$41,D0         ; if the value is less than 41 its invalid
            BLT         invalidAdd
            SUBI.B      #$37,D0         ; valid letter, subtract 37
            BRA         ATH_done
            
ATH_lower   SUBI.B      #$57,D0         ; convert lowercase letter to hex
            BRA         ATH_done
            
ATH_done    OR.L        D0,D3           ; OR the result to the retVal
            DBF         D1,ATH_loop     ; decrement counter and loop while they're > 0
            CLR.L       D1              ; done
            RTS
            
exit    SIMHALT             ; halt simulator

* Put variables and constants here
prompt      DC.B        'What is the address?',CR,LF,'Must be greater than 10000 and less than 3FFFF.',CR,LF,0
input       DCB.B        256,0
invalidAdd  DC.B        'ERROR',0
error       DC.B        'OP Code not written yet',CR,LF,0
NOP         DC.B        'NOP',CR,LF,0

            END         START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
