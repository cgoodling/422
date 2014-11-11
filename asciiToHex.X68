*-----------------------------------------------------------
* Title      : Convert ASCII in D1 to hex
* Written by : Kaley & Cole
* Date       : 11/11/14
* Description: Small piece of disassembler project
*-----------------------------------------------------------

*--------------------- HEX FOR OUTPUT ---------------------*
CR          EQU         $0D
LF          EQU         $0A
NULL        EQU         $00
TAB         EQU         $09

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

            ORG         $1000
START:                  ; first instruction of program

* Put program code here
toHex       MOVE.B      D2,D3
            LSR.L       #8,D2
            
            CMP.B       #hexZero,D3
            BLT         restart
            
            CMP.B       #hexF,D3
            BGT         restart
            
            CMP.B       #$40,D3
            BEQ         restart
            
            CMP.B       #hexNine,D3
            BLE         numToHex
            BRA         charToHex
            
numToHex    SUBI.B      #zeroToNine,D3
            BRA         nextChar
            
charToHex   SUBI.B      #aToF,D3
            BRA         nextChar

nextChar    ROR.L       #4,D3
            SUB.B       #1,D1
            CMP.B       #1,D1
            BGE         toHex
            RTS
            
restart     MOVE.W      #$FF00,D1
            MOVE        #11,D0
            TRAP        #15
            
            LEA         invalidAdd,A1
            MOVE.B      #14,D0
            TRAP        #15
            
            *BRA         getStart

            SIMHALT             ; halt simulator

* Put variables and constants here

invalidAdd  DC.B        'Invalid address. Must start at at least 7000 and be even.',CR,LF
            DC.B        'Must end at most at FFFF, and start must be less than end.',CR,LF,0

            END         START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
