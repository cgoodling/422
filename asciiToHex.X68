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
taskA       EQU         $02
taskB       EQU         $0E

            ORG         $1000
START:                  ; first instruction of program
            MOVE.B      #14,D0
            LEA         prompt,A1
            TRAP        #15             ; prompt for address
            
            MOVE.B      #2,D0
            LEA         input,A1
            TRAP        #15             ; store user input
            
            JSR         asciiToHex      ; convert user input to hex

* Put program code here
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
            BRA         ATH_exit
            
ATH_exit    SIMHALT             ; halt simulator

* Put variables and constants here
prompt      DC.B        'What is the address?',CR,LF,'Must be greater than 10000 and less than 3FFFF.',CR,LF,0

input       DCB.B        256,0

invalidAdd  DC.B        'ERROR',0

            END         START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
