*-----------------------------------------------------------
* Title      : Convert ASCII in D1 to hex
* Written by : Kaley & Cole
* Date       : 11/11/14
* Description: Small piece of disassembler project
*-----------------------------------------------------------

*--------------------- HEX FOR OUTPUT ---------------------*
            OPT         CRE
CR          EQU         $0D
LF          EQU         $0A
NULL        EQU         $00
TAB         EQU         $09

CLEAR       EQU         %00000000
min_addr    EQU         $00001000

*** Ascii to Hex ***
hexZero     EQU         $30
hexOne      EQU         $31
hexTwo      EQU         $32
hexThree    EQU         $33
hexFour     EQU         $34
hexFive     EQU         $35
hexSix      EQU         $36
hexSeven    EQU         $37
hexEight    EQU         $38
hexNine     EQU         $39
hexA        EQU         $41
hexB        EQU         $42
hexC        EQU         $43
hexD        EQU         $44
hexE        EQU         $45
hexF        EQU         $46

zeroToNine  EQU         $30
aToF        EQU         $37

taskA       EQU         $02
taskB       EQU         $0E

            ORG         $1000
START:                  ; first instruction of program
            MOVE.B      #taskB,D0
            LEA         prompt,A1
            TRAP        #15
            
            MOVE.B      #taskA,D0
            LEA         input,A1
            TRAP        #15
            
            JSR         asciiToHex

* Put program code here
* D0 = temp value, D1 = length of string, D2 = counter, D3 = ret val
* A1 = memory location of beginning of the string

asciiToHex  CMP.B       #8,D1
            BGT         invalidAdd
            CMP.B       #0,D1
            BLE         invalidAdd
            
            CLR.L       D3
            SUBQ.B      #1,D1
            
ATH_loop    ROL.L       #4,D3
            MOVE.B      (A1)+,D0
            CMP.B       #$39,D0
            BGT         ATH_letter
            CMP.B       #$30,D0
            BLT         invalidAdd
            SUBI.B      #$30,D0
            BRA         ATH_done
            
ATH_letter  CMP.B       #$66,D0
            BGT         invalidAdd
            CMP.B       #$61,D0
            BGE         ATH_lower
            
            CMP.B       #$46,D0
            BGT         invalidAdd
            CMP.B       #$41,D0
            BLT         invalidAdd
            SUBI.B      #$37,D0
            BRA         ATH_done
            
ATH_lower   SUBI.B      #$57,D0
            BRA         ATH_done
            
ATH_done    OR.L        D0,D3
            DBF         D1,ATH_loop
            CLR.L       D1
            BRA         ATH_exit
            
ATH_exit    SIMHALT             ; halt simulator

* Put variables and constants here
prompt      DC.B        'What is the address?',CR,LF,'Must be greater than 10000 and less than 3FFFF.',CR,LF,0

input       DCB.B        256,0

            END         START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
