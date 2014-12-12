*---------------------------------------------------------------
* Title      : M68k Disassembler Tests
* Written by : Kaley & Cole & Abby
* Date       : 11/11/14
* Description: This file is included at the beginning of the
*              disassembler code for loading M68k instructions
*              starting at $6000
*---------------------------------------------------------------
          ORG     $6000

*********************************************************************
*********************************************************************
*
*MOVE
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*MOVE.B
*////////////////////////////////////////////////////////////////////
    BRA         leave
    JSR         leave
    MOVE.B      D3,D4                   *Move byte data from D3 to D4
    *MOVE.B      D3,A4                   *Move byte data from D3 to A4
    MOVE.B      D3,(A4)                 *Move byte data from D3 to object in A4
    MOVE.B      D3,(A4)+                *Move byte data from D3 to object in A4 and increase pointer by 1
    MOVE.B      D3,-(A4)                *Move byte data from D3 to object in A4 after decrease pointer by 1
    MOVE.B      D3,$1234                *Move byte data from D3 to absolute address WORD
    MOVE.B      D3,$12345678            *Move byte data from D3 to absolute address LONG WORD
    *MOVE.B      D3,#$55                 *Move byte data from D3 to immediate data $55                
    
    *MOVE.B      A3,D4                   *Move byte data from A3 to D4
    *MOVE.B      A3,A4                   *Move byte data from A3 to A4
    *MOVE.B      A3,(A4)                 *Move byte data from A3 to object in A4
    *MOVE.B      A3,(A4)+                *Move byte data from A3 to object in A4 and increase pointer by 1
    *MOVE.B      A3,-(A4)                *Move byte data from A3 to object in A4 after decrease pointer by 1
    *MOVE.B      A3,$1234                *Move byte data from A3 to absolute address WORD
    *MOVE.B      A3,$12345678            *Move byte data from A3 to absolute address LONG WORD
    *MOVE.B      A3,#$55                 *Move byte data from A3 to immediate data $55
    
    MOVE.B      (A3),D4                 *Move byte data from (A3) to D4
    *MOVE.B      (A3),A4                 *Move byte data from (A3) to A4
    MOVE.B      (A3),(A4)               *Move byte data from (A3) to object in A4
    MOVE.B      (A3),(A4)+              *Move byte data from (A3) to object in A4 and increase pointer by 1
    MOVE.B      (A3),-(A4)              *Move byte data from (A3) to object in A4 after decrease pointer by 1
    MOVE.B      (A3),$1234              *Move byte data from (A3) to absolute address WORD
    MOVE.B      (A3),$12345678          *Move byte data from (A3) to absolute address LONG WORD
    *MOVE.B      (A3),#$55               *Move byte data from (A3) to immediate data $55
    
    MOVE.B      (A3)+,D4                *Move byte data from (A3)+ to D4
    *MOVE.B      (A3)+,A4                *Move byte data from (A3)+ to A4
    MOVE.B      (A3)+,(A4)              *Move byte data from (A3)+ to object in A4
    MOVE.B      (A3)+,(A4)+             *Move byte data from (A3)+ to object in A4 and increase pointer by 1
    MOVE.B      (A3)+,-(A4)             *Move byte data from (A3)+ to object in A4 after decrease pointer by 1
    MOVE.B      (A3)+,$1234             *Move byte data from (A3)+ to absolute address WORD
    MOVE.B      (A3)+,$12345678         *Move byte data from (A3)+ to absolute address LONG WORD
    *MOVE.B      (A3)+,#$55              *Move byte data from (A3)+ to immediate data $55
    
    MOVE.B      -(A3),D4                *Move byte data from -(A3) to D4
    *MOVE.B      -(A3),A4                *Move byte data from -(A3) to A4
    MOVE.B      -(A3),(A4)              *Move byte data from -(A3) to object in A4
    MOVE.B      -(A3),(A4)+             *Move byte data from -(A3) to object in A4 and increase pointer by 1
    MOVE.B      -(A3),-(A4)             *Move byte data from -(A3) to object in A4 after decrease pointer by 1
    MOVE.B      -(A3),$1234             *Move byte data from -(A3) to absolute address WORD
    MOVE.B      -(A3),$12345678         *Move byte data from -(A3) to absolute address LONG WORD
    *MOVE.B      -(A3),#$55              *Move byte data from -(A3) to immediate data $55
    
    MOVE.B      $1234,D4                *Move byte data from $1234 to D4
    *MOVE.B      $1234,A4                *Move byte data from $1234 to A4
    MOVE.B      $1234,(A4)              *Move byte data from $1234 to object in A4
    MOVE.B      $1234,(A4)+             *Move byte data from $1234 to object in A4 and increase pointer by 1
    MOVE.B      $1234,-(A4)             *Move byte data from $1234 to object in A4 after decrease pointer by 1
    MOVE.B      $1234,$1234             *Move byte data from $1234 to absolute address WORD
    MOVE.B      $1234,$12345678         *Move byte data from $1234 to absolute address LONG WORD
    *MOVE.B      $1234,#$55              *Move byte data from $1234 to immediate data $55
    
    MOVE.B      $12345678,D4            *Move byte data from $12345678 to D4
    *MOVE.B      $12345678,A4            *Move byte data from $12345678 to A4
    MOVE.B      $12345678,(A4)          *Move byte data from $12345678 to object in A4
    MOVE.B      $12345678,(A4)+         *Move byte data from $12345678 to object in A4 and increase pointer by 1
    MOVE.B      $12345678,-(A4)         *Move byte data from $12345678 to object in A4 after decrease pointer by 1
    MOVE.B      $12345678,$1234         *Move byte data from $12345678 to absolute address WORD
    MOVE.B      $12345678,$12345678     *Move byte data from $12345678 to absolute address LONG WORD
    *MOVE.B      $12345678,#$55          *Move byte data from $12345678 to immediate data $55
    
    MOVE.B      #$55,D4                 *Move byte data from #$55 to D4
    *MOVE.B      #$55,A4                 *Move byte data from #$55 to A4
    MOVE.B      #$55,(A4)               *Move byte data from #$55 to object in A4
    MOVE.B      #$55,(A4)+              *Move byte data from #$55 to object in A4 and increase pointer by 1
    MOVE.B      #$55,-(A4)              *Move byte data from #$55 to object in A4 after decrease pointer by 1
    MOVE.B      #$55,$1234              *Move byte data from #$55 to absolute address WORD
    MOVE.B      #$55,$12345678          *Move byte data from #$55 to absolute address LONG WORD
    *MOVE.B      #$55,#$55               *Move byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*MOVE.W
*////////////////////////////////////////////////////////////////////    

    MOVE.W      D3,D4                   *Move word data from D3 to D4
    *MOVE.W      D3,A4                   *Move word data from D3 to A4
    MOVE.W      D3,(A4)                 *Move word data from D3 to object in A4
    MOVE.W      D3,(A4)+                *Move word data from D3 to object in A4 and increase pointer by 1
    MOVE.W      D3,-(A4)                *Move word data from D3 to object in A4 after decrease pointer by 1
    MOVE.W      D3,$1234                *Move word data from D3 to absolute address WORD
    MOVE.W      D3,$12345678            *Move word data from D3 to absolute address LONG WORD
    *MOVE.W      D3,#$5555               *Move word data from D3 to immediate data $5555 
    
    MOVE.W      A3,D4                   *Move word data from A3 to D4
    *MOVE.W      A3,A4                   *Move word data from A3 to A4
    MOVE.W      A3,(A4)                 *Move word data from A3 to object in A4
    MOVE.W      A3,(A4)+                *Move word data from A3 to object in A4 and increase pointer by 1
    MOVE.W      A3,-(A4)                *Move word data from A3 to object in A4 after decrease pointer by 1
    MOVE.W      A3,$1234                *Move word data from A3 to absolute address WORD
    MOVE.W      A3,$12345678            *Move word data from A3 to absolute address LONG WORD
    *MOVE.W      A3,#$5555               *Move word data from A3 to immediate data $5555
    
    MOVE.W      (A3),D4                 *Move word data from (A3) to D4
    *MOVE.W      (A3),A4                 *Move word data from (A3) to A4
    MOVE.W      (A3),(A4)               *Move word data from (A3) to object in A4
    MOVE.W      (A3),(A4)+              *Move word data from (A3) to object in A4 and increase pointer by 1
    MOVE.W      (A3),-(A4)              *Move word data from (A3) to object in A4 after decrease pointer by 1
    MOVE.W      (A3),$1234              *Move word data from (A3) to absolute address WORD
    MOVE.W      (A3),$12345678          *Move word data from (A3) to absolute address LONG WORD
    *MOVE.W      (A3),#$5555             *Move word data from (A3) to immediate data $5555
    
    MOVE.W      (A3)+,D4                *Move word data from (A3)+ to D4
    *MOVE.W      (A3)+,A4                *Move word data from (A3)+ to A4
    MOVE.W      (A3)+,(A4)              *Move word data from (A3)+ to object in A4
    MOVE.W      (A3)+,(A4)+             *Move word data from (A3)+ to object in A4 and increase pointer by 1
    MOVE.W      (A3)+,-(A4)             *Move word data from (A3)+ to object in A4 after decrease pointer by 1
    MOVE.W      (A3)+,$1234             *Move word data from (A3)+ to absolute address WORD
    MOVE.W      (A3)+,$12345678         *Move word data from (A3)+ to absolute address LONG WORD
    *MOVE.W      (A3)+,#$5555            *Move word data from (A3)+ to immediate data $5555
    
    MOVE.W      -(A3),D4                *Move word data from -(A3) to D4
    *MOVE.W      -(A3),A4                *Move word data from -(A3) to A4
    MOVE.W      -(A3),(A4)              *Move word data from -(A3) to object in A4
    MOVE.W      -(A3),(A4)+             *Move word data from -(A3) to object in A4 and increase pointer by 1
    MOVE.W      -(A3),-(A4)             *Move word data from -(A3) to object in A4 after decrease pointer by 1
    MOVE.W      -(A3),$1234             *Move word data from -(A3) to absolute address WORD
    MOVE.W      -(A3),$12345678         *Move word data from -(A3) to absolute address LONG WORD
    *MOVE.W      -(A3),#$5555            *Move word data from -(A3) to immediate data $5555
    
    MOVE.W      $1234,D4                *Move word data from $1234 to D4
    *MOVE.W      $1234,A4                *Move word data from $1234 to A4
    MOVE.W      $1234,(A4)              *Move word data from $1234 to object in A4
    MOVE.W      $1234,(A4)+             *Move word data from $1234 to object in A4 and increase pointer by 1
    MOVE.W      $1234,-(A4)             *Move word data from $1234 to object in A4 after decrease pointer by 1
    MOVE.W      $1234,$1234             *Move word data from $1234 to absolute address WORD
    MOVE.W      $1234,$12345678         *Move word data from $1234 to absolute address LONG WORD
    *MOVE.W      $1234,#$5555            *Move word data from $1234 to immediate data $5555
    
    MOVE.W      $12345678,D4            *Move word data from $12345678 to D4
    *MOVE.W      $12345678,A4            *Move word data from $12345678 to A4
    MOVE.W      $12345678,(A4)          *Move word data from $12345678 to object in A4
    MOVE.W      $12345678,(A4)+         *Move word data from $12345678 to object in A4 and increase pointer by 1
    MOVE.W      $12345678,-(A4)         *Move word data from $12345678 to object in A4 after decrease pointer by 1
    MOVE.W      $12345678,$1234         *Move word data from $12345678 to absolute address WORD
    MOVE.W      $12345678,$12345678     *Move word data from $12345678 to absolute address LONG WORD
    *MOVE.W      $12345678,#$5555        *Move word data from $12345678 to immediate data $5555
    
    MOVE.W      #$5555,D4               *Move word data from #$5555 to D4
    *MOVE.W      #$5555,A4               *Move word data from #$5555 to A4
    MOVE.W      #$5555,(A4)             *Move word data from #$5555 to object in A4
    MOVE.W      #$5555,(A4)+            *Move word data from #$5555 to object in A4 and increase pointer by 1
    MOVE.W      #$5555,-(A4)            *Move word data from #$5555 to object in A4 after decrease pointer by 1
    MOVE.W      #$5555,$1234            *Move word data from #$5555 to absolute address WORD
    MOVE.W      #$5555,$12345678        *Move word data from #$5555 to absolute address LONG WORD
    *MOVE.W      #$5555,#$5555           *Move word data from #$5555 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*MOVE.L
*////////////////////////////////////////////////////////////////////

    MOVE.L      D3,D4                   *Move long word data from D3 to D4
    *MOVE.L      D3,A4                   *Move long word data from D3 to A4
    MOVE.L      D3,(A4)                 *Move long word data from D3 to object in A4
    MOVE.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
    MOVE.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
    MOVE.L      D3,$1234                *Move long word data from D3 to absolute address WORD
    MOVE.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORD
    *MOVE.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
    
    MOVE.L      A3,D4                   *Move long word data from A3 to D4
    *MOVE.L      A3,A4                   *Move long word data from A3 to A4
    MOVE.L      A3,(A4)                 *Move long word data from A3 to object in A4
    MOVE.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
    MOVE.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
    MOVE.L      A3,$1234                *Move long word data from A3 to absolute address WORD
    MOVE.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
    *MOVE.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
    MOVE.L      (A3),D4                 *Move long word data from (A3) to D4
    *MOVE.L      (A3),A4                 *Move long word data from (A3) to A4
    MOVE.L      (A3),(A4)               *Move long word data from (A3) to object in A4
    MOVE.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
    MOVE.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
    MOVE.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
    MOVE.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
    *MOVE.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
    MOVE.L      (A3)+,D4                *Move long word data from (A3)+ to D4
    *MOVE.L      (A3)+,A4                *Move long word data from (A3)+ to A4
    MOVE.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
    MOVE.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
    MOVE.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
    MOVE.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
    MOVE.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
    *MOVE.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
    
    MOVE.L      -(A3),D4                *Move long word data from -(A3) to D4
    *MOVE.L      -(A3),A4                *Move long word data from -(A3) to A4
    MOVE.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
    MOVE.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
    MOVE.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
    MOVE.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
    MOVE.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
    *MOVE.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
    MOVE.L      $1234,D4                *Move long word data from $1234 to D4
    *MOVE.L      $1234,A4                *Move long word data from $1234 to A4
    MOVE.L      $1234,(A4)              *Move long word data from $1234 to object in A4
    MOVE.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
    MOVE.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
    MOVE.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
    MOVE.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
    *MOVE.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
    MOVE.L      $12345678,D4            *Move long word data from $12345678 to D4
    *MOVE.L      $12345678,A4            *Move long word data from $12345678 to A4
    MOVE.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
    MOVE.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
    MOVE.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
    MOVE.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
    MOVE.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
    *MOVE.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
    MOVE.L      #$55555555,D4           *Move long word data from #$55555555 to D4
    *MOVE.L      #$55555555,A4           *Move long word data from #$55555555 to A4
    MOVE.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
    MOVE.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
    MOVE.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
    MOVE.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
    MOVE.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
    *MOVE.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*MOVEA
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*MOVEA.W
*////////////////////////////////////////////////////////////////////
    
    *MOVEA.W      D3,D4                   *Move word data from D3 to D4
    MOVEA.W      D3,A4                   *Move word data from D3 to A4
*    MOVEA.W      D3,(A4)                 *Move word data from D3 to object in A4
*    MOVEA.W      D3,(A4)+                *Move word data from D3 to object in A4 and increase pointer by 1
*    MOVEA.W      D3,-(A4)                *Move word data from D3 to object in A4 after decrease pointer by 1
*    MOVEA.W      D3,$1234                *Move word data from D3 to absolute address WORD
*    MOVEA.W      D3,$12345678            *Move word data from D3 to absolute address LONG WORD
*    MOVEA.W      D3,#$5555               *Move word data from D3 to immediate data $5555 
    
    *MOVEA.W      A3,D4                   *Move word data from A3 to D4
    MOVEA.W      A3,A4                   *Move word data from A3 to A4
*    MOVEA.W      A3,(A4)                 *Move word data from A3 to object in A4
*    MOVEA.W      A3,(A4)+                *Move word data from A3 to object in A4 and increase pointer by 1
*    MOVEA.W      A3,-(A4)                *Move word data from A3 to object in A4 after decrease pointer by 1
*    MOVEA.W      A3,$1234                *Move word data from A3 to absolute address WORD
*    MOVEA.W      A3,$12345678            *Move word data from A3 to absolute address LONG WORD
*    MOVEA.W      A3,#$5555               *Move word data from A3 to immediate data $5555
    
    *MOVEA.W      (A3),D4                 *Move word data from (A3) to D4
    MOVEA.W      (A3),A4                 *Move word data from (A3) to A4
*    MOVEA.W      (A3),(A4)               *Move word data from (A3) to object in A4
*    MOVEA.W      (A3),(A4)+              *Move word data from (A3) to object in A4 and increase pointer by 1
*    MOVEA.W      (A3),-(A4)              *Move word data from (A3) to object in A4 after decrease pointer by 1
*    MOVEA.W      (A3),$1234              *Move word data from (A3) to absolute address WORD
*    MOVEA.W      (A3),$12345678          *Move word data from (A3) to absolute address LONG WORD
*    MOVEA.W      (A3),#$5555             *Move word data from (A3) to immediate data $5555
    
    *MOVEA.W      (A3)+,D4                *Move word data from (A3)+ to D4
    MOVEA.W      (A3)+,A4                *Move word data from (A3)+ to A4
*    MOVEA.W      (A3)+,(A4)              *Move word data from (A3)+ to object in A4
*    MOVEA.W      (A3)+,(A4)+             *Move word data from (A3)+ to object in A4 and increase pointer by 1
*    MOVEA.W      (A3)+,-(A4)             *Move word data from (A3)+ to object in A4 after decrease pointer by 1
*    MOVEA.W      (A3)+,$1234             *Move word data from (A3)+ to absolute address WORD
*    MOVEA.W      (A3)+,$12345678         *Move word data from (A3)+ to absolute address LONG WORD
*    MOVEA.W      (A3)+,#$5555            *Move word data from (A3)+ to immediate data $5555
    
    *MOVEA.W      -(A3),D4                *Move word data from -(A3) to D4
    MOVEA.W      -(A3),A4                *Move word data from -(A3) to A4
*    MOVEA.W      -(A3),(A4)              *Move word data from -(A3) to object in A4
*    MOVEA.W      -(A3),(A4)+             *Move word data from -(A3) to object in A4 and increase pointer by 1
*    MOVEA.W      -(A3),-(A4)             *Move word data from -(A3) to object in A4 after decrease pointer by 1
*    MOVEA.W      -(A3),$1234             *Move word data from -(A3) to absolute address WORD
*    MOVEA.W      -(A3),$12345678         *Move word data from -(A3) to absolute address LONG WORD
*    MOVEA.W      -(A3),#$5555            *Move word data from -(A3) to immediate data $5555
    
    *MOVEA.W      $1234,D4                *Move word data from $1234 to D4
    MOVEA.W      $1234,A4                *Move word data from $1234 to A4
*    MOVEA.W      $1234,(A4)              *Move word data from $1234 to object in A4
*    MOVEA.W      $1234,(A4)+             *Move word data from $1234 to object in A4 and increase pointer by 1
*    MOVEA.W      $1234,-(A4)             *Move word data from $1234 to object in A4 after decrease pointer by 1
*    MOVEA.W      $1234,$1234             *Move word data from $1234 to absolute address WORD
*    MOVEA.W      $1234,$12345678         *Move word data from $1234 to absolute address LONG WORD
*    MOVEA.W      $1234,#$5555            *Move word data from $1234 to immediate data $5555
    
    *MOVEA.W      $12345678,D4            *Move word data from $12345678 to D4
    MOVEA.W      $12345678,A4            *Move word data from $12345678 to A4
*    MOVEA.W      $12345678,(A4)          *Move word data from $12345678 to object in A4
*    MOVEA.W      $12345678,(A4)+         *Move word data from $12345678 to object in A4 and increase pointer by 1
*    MOVEA.W      $12345678,-(A4)         *Move word data from $12345678 to object in A4 after decrease pointer by 1
*    MOVEA.W      $12345678,$1234         *Move word data from $12345678 to absolute address WORD
*    MOVEA.W      $12345678,$12345678     *Move word data from $12345678 to absolute address LONG WORD
*    MOVEA.W      $12345678,#$5555        *Move word data from $12345678 to immediate data $5555
    
    *MOVEA.W      #$5555,D4               *Move word data from #$5555 to D4
    MOVEA.W      #$5555,A4               *Move word data from #$5555 to A4
*    MOVEA.W      #$5555,(A4)             *Move word data from #$5555 to object in A4
*    MOVEA.W      #$5555,(A4)+            *Move word data from #$5555 to object in A4 and increase pointer by 1
*    MOVEA.W      #$5555,-(A4)            *Move word data from #$5555 to object in A4 after decrease pointer by 1
*    MOVEA.W      #$5555,$1234            *Move word data from #$5555 to absolute address WORD
*    MOVEA.W      #$5555,$12345678        *Move word data from #$5555 to absolute address LONG WORD
*    MOVEA.W      #$5555,#$5555           *Move word data from #$5555 to immediate data $5555  

*////////////////////////////////////////////////////////////////////
*MOVEA.L
*////////////////////////////////////////////////////////////////////
    
*    MOVEA.L      D3,D4                   *Move long word data from D3 to D4
    MOVEA.L      D3,A4                   *Move long word data from D3 to A4
*    MOVEA.L      D3,(A4)                 *Move long word data from D3 to object in A4
*    MOVEA.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
*    MOVEA.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
*    MOVEA.L      D3,$1234                *Move long word data from D3 to absolute address WORD
*    MOVEA.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORD
*    MOVEA.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
   
*    MOVEA.L      A3,D4                   *Move long word data from A3 to D4
    MOVEA.L      A3,A4                   *Move long word data from A3 to A4
*    MOVEA.L      A3,(A4)                 *Move long word data from A3 to object in A4
*    MOVEA.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
*    MOVEA.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
*    MOVEA.L      A3,$1234                *Move long word data from A3 to absolute address WORD
*    MOVEA.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
*    MOVEA.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
*    MOVEA.L      (A3),D4                 *Move long word data from (A3) to D4
    MOVEA.L      (A3),A4                 *Move long word data from (A3) to A4
*    MOVEA.L      (A3),(A4)               *Move long word data from (A3) to object in A4
*    MOVEA.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
*    MOVEA.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
*    MOVEA.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
*    MOVEA.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
*    MOVEA.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
*    MOVEA.L      (A3)+,D4                *Move long word data from (A3)+ to D4
    MOVEA.L      (A3)+,A4                *Move long word data from (A3)+ to A4
*    MOVEA.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
*    MOVEA.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
*    MOVEA.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
*    MOVEA.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
*    MOVEA.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
*    MOVEA.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
    
*    MOVEA.L      -(A3),D4                *Move long word data from -(A3) to D4
    MOVEA.L      -(A3),A4                *Move long word data from -(A3) to A4
*    MOVEA.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
*    MOVEA.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
*    MOVEA.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
*    MOVEA.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
*    MOVEA.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
*    MOVEA.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
*    MOVEA.L      $1234,D4                *Move long word data from $1234 to D4
    MOVEA.L      $1234,A4                *Move long word data from $1234 to A4
*    MOVEA.L      $1234,(A4)              *Move long word data from $1234 to object in A4
*    MOVEA.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
*    MOVEA.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
*    MOVEA.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
*    MOVEA.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
*    MOVEA.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
*    MOVEA.L      $12345678,D4            *Move long word data from $12345678 to D4
    MOVEA.L      $12345678,A4            *Move long word data from $12345678 to A4
*    MOVEA.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
*    MOVEA.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
*    MOVEA.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
*    MOVEA.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
*    MOVEA.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
*    MOVEA.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
*    MOVEA.L      #$55555555,D4           *Move long word data from #$55555555 to D4
    MOVEA.L      #$55555555,A4           *Move long word data from #$55555555 to A4
*    MOVEA.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
*    MOVEA.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
*    MOVEA.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
*    MOVEA.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
*    MOVEA.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
*    MOVEA.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555 
    
*********************************************************************
*********************************************************************
*
*MOVEM
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*MOVEM.W
*////////////////////////////////////////////////////////////////////
    
*     MOVEM.W      D3,D4                   *Move word data from D3 to D4
*     MOVEM.W      D3,A4                   *Move word data from D3 to A4
*     MOVEM.W      D3,(A4)                 *Move word data from D3 to object in A4
*     MOVEM.W      D3,(A4)+                *Move word data from D3 to object in A4 and increase pointer by 1
*     MOVEM.W      D3,-(A4)                *Move word data from D3 to object in A4 after decrease pointer by 1
*     MOVEM.W      D3,$1234                *Move word data from D3 to absolute address WORD
*     MOVEM.W      D3,$12345678            *Move word data from D3 to absolute address LONG WORD
*     MOVEM.W      D3,#$5555               *Move word data from D3 to immediate data $5555 
    
*     MOVEM.W      A3,D4                   *Move word data from A3 to D4
*     MOVEM.W      A3,A4                   *Move word data from A3 to A4
     MOVEM.W      A3,(A4)                 *Move word data from A3 to object in A4
*     MOVEM.W      A3,(A4)+                *Move word data from A3 to object in A4 and increase pointer by 1
     MOVEM.W      A3,-(A4)                *Move word data from A3 to object in A4 after decrease pointer by 1
     MOVEM.W      A3,$1234                *Move word data from A3 to absolute address WORD
     MOVEM.W      A3,$12345678            *Move word data from A3 to absolute address LONG WORD
*     MOVEM.W      A3,#$5555               *Move word data from A3 to immediate data $5555
    
     MOVEM.W      (A3),D4                 *Move word data from (A3) to D4
     MOVEM.W      (A3),A4                 *Move word data from (A3) to A4
*     MOVEM.W      (A3),(A4)               *Move word data from (A3) to object in A4
*     MOVEM.W      (A3),(A4)+              *Move word data from (A3) to object in A4 and increase pointer by 1
*     MOVEM.W      (A3),-(A4)              *Move word data from (A3) to object in A4 after decrease pointer by 1
*     MOVEM.W      (A3),$1234              *Move word data from (A3) to absolute address WORD
*     MOVEM.W      (A3),$12345678          *Move word data from (A3) to absolute address LONG WORD
*     MOVEM.W      (A3),#$5555             *Move word data from (A3) to immediate data $5555
    
*     MOVEM.W      (A3)+,D4                *Move word data from (A3)+ to D4
*     MOVEM.W      (A3)+,A4                *Move word data from (A3)+ to A4
*     MOVEM.W      (A3)+,(A4)              *Move word data from (A3)+ to object in A4
*     MOVEM.W      (A3)+,(A4)+             *Move word data from (A3)+ to object in A4 and increase pointer by 1
*     MOVEM.W      (A3)+,-(A4)             *Move word data from (A3)+ to object in A4 after decrease pointer by 1
*     MOVEM.W      (A3)+,$1234             *Move word data from (A3)+ to absolute address WORD
*     MOVEM.W      (A3)+,$12345678         *Move word data from (A3)+ to absolute address LONG WORD
*     MOVEM.W      (A3)+,#$5555            *Move word data from (A3)+ to immediate data $5555
    
*     MOVEM.W      -(A3),D4                *Move word data from -(A3) to D4
*     MOVEM.W      -(A3),A4                *Move word data from -(A3) to A4
*     MOVEM.W      -(A3),(A4)              *Move word data from -(A3) to object in A4
*     MOVEM.W      -(A3),(A4)+             *Move word data from -(A3) to object in A4 and increase pointer by 1
*     MOVEM.W      -(A3),-(A4)             *Move word data from -(A3) to object in A4 after decrease pointer by 1
*     MOVEM.W      -(A3),$1234             *Move word data from -(A3) to absolute address WORD
*     MOVEM.W      -(A3),$12345678         *Move word data from -(A3) to absolute address LONG WORD
*     MOVEM.W      -(A3),#$5555            *Move word data from -(A3) to immediate data $5555
    
*     MOVEM.W      $1234,D4                *Move word data from $1234 to D4
*     MOVEM.W      $1234,A4                *Move word data from $1234 to A4
*     MOVEM.W      $1234,(A4)              *Move word data from $1234 to object in A4
*     MOVEM.W      $1234,(A4)+             *Move word data from $1234 to object in A4 and increase pointer by 1
*     MOVEM.W      $1234,-(A4)             *Move word data from $1234 to object in A4 after decrease pointer by 1
*     MOVEM.W      $1234,$1234             *Move word data from $1234 to absolute address WORD
*     MOVEM.W      $1234,$12345678         *Move word data from $1234 to absolute address LONG WORD
*     MOVEM.W      $1234,#$5555            *Move word data from $1234 to immediate data $5555
    
*     MOVEM.W      $12345678,D4            *Move word data from $12345678 to D4
*     MOVEM.W      $12345678,A4            *Move word data from $12345678 to A4
*     MOVEM.W      $12345678,(A4)          *Move word data from $12345678 to object in A4
*     MOVEM.W      $12345678,(A4)+         *Move word data from $12345678 to object in A4 and increase pointer by 1
*     MOVEM.W      $12345678,-(A4)         *Move word data from $12345678 to object in A4 after decrease pointer by 1
*     MOVEM.W      $12345678,$1234         *Move word data from $12345678 to absolute address WORD
*     MOVEM.W      $12345678,$12345678     *Move word data from $12345678 to absolute address LONG WORD
*     MOVEM.W      $12345678,#$5555        *Move word data from $12345678 to immediate data $5555
    
*     MOVEM.W      #$5555,D4               *Move word data from #$5555 to D4
*     MOVEM.W      #$5555,A4               *Move word data from #$5555 to A4
*     MOVEM.W      #$5555,(A4)             *Move word data from #$5555 to object in A4
*     MOVEM.W      #$5555,(A4)+            *Move word data from #$5555 to object in A4 and increase pointer by 1
*     MOVEM.W      #$5555,-(A4)            *Move word data from #$5555 to object in A4 after decrease pointer by 1
*     MOVEM.W      #$5555,$1234            *Move word data from #$5555 to absolute address WORD
*     MOVEM.W      #$5555,$12345678        *Move word data from #$5555 to absolute address LONG WORD
*     MOVEM.W      #$5555,#$5555           *Move word data from #$5555 to immediate data $5555  

*////////////////////////////////////////////////////////////////////
*MOVEM.L
*////////////////////////////////////////////////////////////////////
    
*     MOVEM.L      D3,D4                   *Move long word data from D3 to D4
*     MOVEM.L      D3,A4                   *Move long word data *     MOVEM.L      D3,(A4)                 *Move long word data from D3 to object in A4
*     MOVEM.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
*     MOVEM.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
*     MOVEM.L      D3,$1234                *Move long word data from D3 to absolute address WORD
*     MOVEM.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORDdress LONG WORD
*     MOVEM.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
   
*     MOVEM.L      A3,D4                   *Move long word data from A3 to D4
*     MOVEM.L      A3,A4                   *Move long word data from A3 to A4
     MOVEM.L      A3,(A4)                 *Move long word data from A3 to object in A4
*     MOVEM.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
     MOVEM.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
     MOVEM.L      A3,$1234                *Move long word data from A3 to absolute address WORD
     MOVEM.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
*     MOVEM.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
     MOVEM.L      (A3),D4                 *Move long word data from (A3) to D4
     MOVEM.L      (A3),A4                 *Move long word data from (A3) to A4
*     MOVEM.L      (A3),(A4)               *Move long word data from (A3) to object in A4
*     MOVEM.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
*     MOVEM.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
*     MOVEM.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
*     MOVEM.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
*     MOVEM.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
*     MOVEM.L      (A3)+,D4                *Move long word data from (A3)+ to D4
*     MOVEM.L      (A3)+,A4                *Move long word data from (A3)+ to A4
*     MOVEM.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
*     MOVEM.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
*     MOVEM.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
*     MOVEM.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
*     MOVEM.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
*     MOVEM.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
    
*     MOVEM.L      -(A3),D4                *Move long word data from -(A3) to D4
*     MOVEM.L      -(A3),A4                *Move long word data from -(A3) to A4
*     MOVEM.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
*     MOVEM.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
*     MOVEM.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
*     MOVEM.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
*     MOVEM.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
*     MOVEM.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
*     MOVEM.L      $1234,D4                *Move long word data from $1234 to D4
*     MOVEM.L      $1234,A4                *Move long word data from $1234 to A4
*     MOVEM.L      $1234,(A4)              *Move long word data from $1234 to object in A4
*     MOVEM.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
*     MOVEM.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
*     MOVEM.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
*     MOVEM.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
*     MOVEM.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
*     MOVEM.L      $12345678,D4            *Move long word data from $12345678 to D4
*     MOVEM.L      $12345678,A4            *Move long word data from $12345678 to A4
*     MOVEM.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
*     MOVEM.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
*     MOVEM.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
*     MOVEM.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
*     MOVEM.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
*     MOVEM.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
*     MOVEM.L      #$55555555,D4           *Move long word data from #$55555555 to D4
*     MOVEM.L      #$55555555,A4           *Move long word data from #$55555555 to A4
*     MOVEM.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
*     MOVEM.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
*     MOVEM.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
*     MOVEM.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
*     MOVEM.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
*     MOVEM.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*SUB
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*SUB.B
*////////////////////////////////////////////////////////////////////

    SUB.B      D3,D4                   *SUB byte data from D3 to D4
*    SUB.B      D3,A4                   *SUB byte data from D3 to A4
    SUB.B      D3,(A4)                 *SUB byte data from D3 to object in A4
    SUB.B      D3,(A4)+                *SUB byte data from D3 to object in A4 and increase pointer by 1
    SUB.B      D3,-(A4)                *SUB byte data from D3 to object in A4 after decrease pointer by 1
    SUB.B      D3,$1234                *SUB byte data from D3 to absolute address WORD
    SUB.B      D3,$12345678            *SUB byte data from D3 to absolute address LONG WORD
*    SUB.B      D3,#$55                 *SUB byte data from D3 to immediate data $55                
    
*    SUB.B      A3,D4                   *SUB byte data from A3 to D4
*    SUB.B      A3,A4                   *SUB byte data from A3 to A4
*    SUB.B      A3,(A4)                 *SUB byte data from A3 to object in A4
*    SUB.B      A3,(A4)+                *SUB byte data from A3 to object in A4 and increase pointer by 1
*    SUB.B      A3,-(A4)                *SUB byte data from A3 to object in A4 after decrease pointer by 1
*    SUB.B      A3,$1234                *SUB byte data from A3 to absolute address WORD
*    SUB.B      A3,$12345678            *SUB byte data from A3 to absolute address LONG WORD
*    SUB.B      A3,#$55                 *SUB byte data from A3 to immediate data $55
    
    SUB.B      (A3),D4                 *SUB byte data from (A3) to D4
*    SUB.B      (A3),A4                 *SUB byte data from (A3) to A4
*    SUB.B      (A3),(A4)               *SUB byte data from (A3) to object in A4
*    SUB.B      (A3),(A4)+              *SUB byte data from (A3) to object in A4 and increase pointer by 1
*    SUB.B      (A3),-(A4)              *SUB byte data from (A3) to object in A4 after decrease pointer by 1
*    SUB.B      (A3),$1234              *SUB byte data from (A3) to absolute address WORD
*    SUB.B      (A3),$12345678          *SUB byte data from (A3) to absolute address LONG WORD
*    SUB.B      (A3),#$55               *SUB byte data from (A3) to immediate data $55
    
    SUB.B      (A3)+,D4                *SUB byte data from (A3)+ to D4
*    SUB.B      (A3)+,A4                *SUB byte data from (A3)+ to A4
*    SUB.B      (A3)+,(A4)              *SUB byte data from (A3)+ to object in A4
*    SUB.B      (A3)+,(A4)+             *SUB byte data from (A3)+ to object in A4 and increase pointer by 1
*    SUB.B      (A3)+,-(A4)             *SUB byte data from (A3)+ to object in A4 after decrease pointer by 1
*    SUB.B      (A3)+,$1234             *SUB byte data from (A3)+ to absolute address WORD
*    SUB.B      (A3)+,$12345678         *SUB byte data from (A3)+ to absolute address LONG WORD
*    SUB.B      (A3)+,#$55              *SUB byte data from (A3)+ to immediate data $55
    
    SUB.B      -(A3),D4                *SUB byte data from -(A3) to D4
*    SUB.B      -(A3),A4                *SUB byte data from -(A3) to A4
*    SUB.B      -(A3),(A4)              *SUB byte data from -(A3) to object in A4
*    SUB.B      -(A3),(A4)+             *SUB byte data from -(A3) to object in A4 and increase pointer by 1
*    SUB.B      -(A3),-(A4)             *SUB byte data from -(A3) to object in A4 after decrease pointer by 1
*    SUB.B      -(A3),$1234             *SUB byte data from -(A3) to absolute address WORD
*    SUB.B      -(A3),$12345678         *SUB byte data from -(A3) to absolute address LONG WORD
*    SUB.B      -(A3),#$55              *SUB byte data from -(A3) to immediate data $55
    
    SUB.B      $1234,D4                *SUB byte data from $1234 to D4
*    SUB.B      $1234,A4                *SUB byte data from $1234 to A4
*    SUB.B      $1234,(A4)              *SUB byte data from $1234 to object in A4
*    SUB.B      $1234,(A4)+             *SUB byte data from $1234 to object in A4 and increase pointer by 1
*    SUB.B      $1234,-(A4)             *SUB byte data from $1234 to object in A4 after decrease pointer by 1
*    SUB.B      $1234,$1234             *SUB byte data from $1234 to absolute address WORD
*    SUB.B      $1234,$12345678         *SUB byte data from $1234 to absolute address LONG WORD
*    SUB.B      $1234,#$55              *SUB byte data from $1234 to immediate data $55
    
    SUB.B      $12345678,D4            *SUB byte data from $12345678 to D4
*    SUB.B      $12345678,A4            *SUB byte data from $12345678 to A4
*    SUB.B      $12345678,(A4)          *SUB byte data from $12345678 to object in A4
*    SUB.B      $12345678,(A4)+         *SUB byte data from $12345678 to object in A4 and increase pointer by 1
*    SUB.B      $12345678,-(A4)         *SUB byte data from $12345678 to object in A4 after decrease pointer by 1
*    SUB.B      $12345678,$1234         *SUB byte data from $12345678 to absolute address WORD
*    SUB.B      $12345678,$12345678     *SUB byte data from $12345678 to absolute address LONG WORD
*    SUB.B      $12345678,#$55          *SUB byte data from $12345678 to immediate data $55
    
    SUB.B      #$55,D4                 *SUB byte data from #$55 to D4
*    SUB.B      #$55,A4                 *SUB byte data from #$55 to A4
*    SUB.B      #$55,(A4)               *SUB byte data from #$55 to object in A4
*    SUB.B      #$55,(A4)+              *SUB byte data from #$55 to object in A4 and increase pointer by 1
*    SUB.B      #$55,-(A4)              *SUB byte data from #$55 to object in A4 after decrease pointer by 1
*    SUB.B      #$55,$1234              *SUB byte data from #$55 to absolute address WORD
*    SUB.B      #$55,$12345678          *SUB byte data from #$55 to absolute address LONG WORD
*    SUB.B      #$55,#$55               *SUB byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*SUB.W
*////////////////////////////////////////////////////////////////////    

    SUB.W      D3,D4                   *SUB word data from D3 to D4
    SUB.W      D3,A4                   *SUB word data from D3 to A4
    SUB.W      D3,(A4)                 *SUB word data from D3 to object in A4
    SUB.W      D3,(A4)+                *SUB word data from D3 to object in A4 and increase pointer by 1
    SUB.W      D3,-(A4)                *SUB word data from D3 to object in A4 after decrease pointer by 1
    SUB.W      D3,$1234                *SUB word data from D3 to absolute address WORD
    SUB.W      D3,$12345678            *SUB word data from D3 to absolute address LONG WORD
*    SUB.W      D3,#$5555               *SUB word data from D3 to immediate data $5555 
    
    SUB.W      A3,D4                   *SUB word data from A3 to D4
*    SUB.W      A3,A4                   *SUB word data from A3 to A4
*    SUB.W      A3,(A4)                 *SUB word data from A3 to object in A4
*    SUB.W      A3,(A4)+                *SUB word data from A3 to object in A4 and increase pointer by 1
*    SUB.W      A3,-(A4)                *SUB word data from A3 to object in A4 after decrease pointer by 1
*    SUB.W      A3,$1234                *SUB word data from A3 to absolute address WORD
*    SUB.W      A3,$12345678            *SUB word data from A3 to absolute address LONG WORD
*    SUB.W      A3,#$5555               *SUB word data from A3 to immediate data $5555
    
    SUB.W      (A3),D4                 *SUB word data from (A3) to D4
*    SUB.W      (A3),A4                 *SUB word data from (A3) to A4
*    SUB.W      (A3),(A4)               *SUB word data from (A3) to object in A4
*    SUB.W      (A3),(A4)+              *SUB word data from (A3) to object in A4 and increase pointer by 1
*    SUB.W      (A3),-(A4)              *SUB word data from (A3) to object in A4 after decrease pointer by 1
*    SUB.W      (A3),$1234              *SUB word data from (A3) to absolute address WORD
*    SUB.W      (A3),$12345678          *SUB word data from (A3) to absolute address LONG WORD
*    SUB.W      (A3),#$5555             *SUB word data from (A3) to immediate data $5555
    
    SUB.W      (A3)+,D4                *SUB word data from (A3)+ to D4
*    SUB.W      (A3)+,A4                *SUB word data from (A3)+ to A4
*    SUB.W      (A3)+,(A4)              *SUB word data from (A3)+ to object in A4
*    SUB.W      (A3)+,(A4)+             *SUB word data from (A3)+ to object in A4 and increase pointer by 1
*    SUB.W      (A3)+,-(A4)             *SUB word data from (A3)+ to object in A4 after decrease pointer by 1
*    SUB.W      (A3)+,$1234             *SUB word data from (A3)+ to absolute address WORD
*    SUB.W      (A3)+,$12345678         *SUB word data from (A3)+ to absolute address LONG WORD
*    SUB.W      (A3)+,#$5555            *SUB word data from (A3)+ to immediate data $5555
    
    SUB.W      -(A3),D4                *SUB word data from -(A3) to D4
*    SUB.W      -(A3),A4                *SUB word data from -(A3) to A4
*    SUB.W      -(A3),(A4)              *SUB word data from -(A3) to object in A4
*    SUB.W      -(A3),(A4)+             *SUB word data from -(A3) to object in A4 and increase pointer by 1
*    SUB.W      -(A3),-(A4)             *SUB word data from -(A3) to object in A4 after decrease pointer by 1
*    SUB.W      -(A3),$1234             *SUB word data from -(A3) to absolute address WORD
*    SUB.W      -(A3),$12345678         *SUB word data from -(A3) to absolute address LONG WORD
*    SUB.W      -(A3),#$5555            *SUB word data from -(A3) to immediate data $5555
    
    SUB.W      $1234,D4                *SUB word data from $1234 to D4
*    SUB.W      $1234,A4                *SUB word data from $1234 to A4
*    SUB.W      $1234,(A4)              *SUB word data from $1234 to object in A4
*    SUB.W      $1234,(A4)+             *SUB word data from $1234 to object in A4 and increase pointer by 1
*    SUB.W      $1234,-(A4)             *SUB word data from $1234 to object in A4 after decrease pointer by 1
*    SUB.W      $1234,$1234             *SUB word data from $1234 to absolute address WORD
*    SUB.W      $1234,$12345678         *SUB word data from $1234 to absolute address LONG WORD
*    SUB.W      $1234,#$5555            *SUB word data from $1234 to immediate data $5555
    
    SUB.W      $12345678,D4            *SUB word data from $12345678 to D4
*    SUB.W      $12345678,A4            *SUB word data from $12345678 to A4
*    SUB.W      $12345678,(A4)          *SUB word data from $12345678 to object in A4
*    SUB.W      $12345678,(A4)+         *SUB word data from $12345678 to object in A4 and increase pointer by 1
*    SUB.W      $12345678,-(A4)         *SUB word data from $12345678 to object in A4 after decrease pointer by 1
*    SUB.W      $12345678,$1234         *SUB word data from $12345678 to absolute address WORD
*    SUB.W      $12345678,$12345678     *SUB word data from $12345678 to absolute address LONG WORD
*    SUB.W      $12345678,#$5555        *SUB word data from $12345678 to immediate data $5555
    
    SUB.W      #$5555,D4               *SUB word data from #$5555 to D4
*    SUB.W      #$5555,A4               *SUB word data from #$5555 to A4
*    SUB.W      #$5555,(A4)             *SUB word data from #$5555 to object in A4
*    SUB.W      #$5555,(A4)+            *SUB word data from #$5555 to object in A4 and increase pointer by 1
*    SUB.W      #$5555,-(A4)            *SUB word data from #$5555 to object in A4 after decrease pointer by 1
*    SUB.W      #$5555,$1234            *SUB word data from #$5555 to absolute address WORD
*    SUB.W      #$5555,$12345678        *SUB word data from #$5555 to absolute address LONG WORD
*    SUB.W      #$5555,#$5555           *SUB word data from #$5555 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*SUB.L
*////////////////////////////////////////////////////////////////////

    SUB.L      D3,D4                   *SUB long word data from D3 to D4
*    SUB.L      D3,A4                   *SUB long word data from D3 to A4
*    SUB.L      D3,(A4)                 *SUB long word data from D3 to object in A4
*    SUB.L      D3,(A4)+                *SUB long word data from D3 to object in A4 and increase pointer by 1
*    SUB.L      D3,-(A4)                *SUB long word data from D3 to object in A4 after decrease pointer by 1
*    SUB.L      D3,$1234                *SUB long word data from D3 to absolute address WORD
*    SUB.L      D3,$12345678            *SUB long word data from D3 to absolute address LONG WORD
*    SUB.L      D3,#$55555555           *SUB long word data from D3 to immediate data $55555555 
    
    SUB.L      A3,D4                   *SUB long word data from A3 to D4
*    SUB.L      A3,A4                   *SUB long word data from A3 to A4
*    SUB.L      A3,(A4)                 *SUB long word data from A3 to object in A4
*    SUB.L      A3,(A4)+                *SUB long word data from A3 to object in A4 and increase pointer by 1
*    SUB.L      A3,-(A4)                *SUB long word data from A3 to object in A4 after decrease pointer by 1
*    SUB.L      A3,$1234                *SUB long word data from A3 to absolute address WORD
*    SUB.L      A3,$12345678            *SUB long word data from A3 to absolute address LONG WORD
*    SUB.L      A3,#$55555555           *SUB long word data from A3 to immediate data $55555555
    
    SUB.L      (A3),D4                 *SUB long word data from (A3) to D4
*    SUB.L      (A3),A4                 *SUB long word data from (A3) to A4
*    SUB.L      (A3),(A4)               *SUB long word data from (A3) to object in A4
*    SUB.L      (A3),(A4)+              *SUB long word data from (A3) to object in A4 and increase pointer by 1
*    SUB.L      (A3),-(A4)              *SUB long word data from (A3) to object in A4 after decrease pointer by 1
*    SUB.L      (A3),$1234              *SUB long word data from (A3) to absolute address WORD
*    SUB.L      (A3),$12345678          *SUB long word data from (A3) to absolute address LONG WORD
*    SUB.L      (A3),#$55555555         *SUB long word data from (A3) to immediate data $55555555
    
    SUB.L      (A3)+,D4                *SUB long word data from (A3)+ to D4
*    SUB.L      (A3)+,A4                *SUB long word data from (A3)+ to A4
*    SUB.L      (A3)+,(A4)              *SUB long word data from (A3)+ to object in A4
*    SUB.L      (A3)+,(A4)+             *SUB long word data from (A3)+ to object in A4 and increase pointer by 1
*    SUB.L      (A3)+,-(A4)             *SUB long word data from (A3)+ to object in A4 after decrease pointer by 1
*    SUB.L      (A3)+,$1234             *SUB long word data from (A3)+ to absolute address WORD
*    SUB.L      (A3)+,$12345678         *SUB long word data from (A3)+ to absolute address LONG WORD
*    SUB.L      (A3)+,#$55555555        *SUB long word data from (A3)+ to immediate data $55555555
    
    SUB.L      -(A3),D4                *SUB long word data from -(A3) to D4
*    SUB.L      -(A3),A4                *SUB long word data from -(A3) to A4
*    SUB.L      -(A3),(A4)              *SUB long word data from -(A3) to object in A4
*    SUB.L      -(A3),(A4)+             *SUB long word data from -(A3) to object in A4 and increase pointer by 1
*    SUB.L      -(A3),-(A4)             *SUB long word data from -(A3) to object in A4 after decrease pointer by 1
*    SUB.L      -(A3),$1234             *SUB long word data from -(A3) to absolute address WORD
*    SUB.L      -(A3),$12345678         *SUB long word data from -(A3) to absolute address LONG WORD
*    SUB.L      -(A3),#$55555555        *SUB long word data from -(A3) to immediate data $55555555
    
    SUB.L      $1234,D4                *SUB long word data from $1234 to D4
*    SUB.L      $1234,A4                *SUB long word data from $1234 to A4
*    SUB.L      $1234,(A4)              *SUB long word data from $1234 to object in A4
*    SUB.L      $1234,(A4)+             *SUB long word data from $1234 to object in A4 and increase pointer by 1
*    SUB.L      $1234,-(A4)             *SUB long word data from $1234 to object in A4 after decrease pointer by 1
*    SUB.L      $1234,$1234             *SUB long word data from $1234 to absolute address WORD
*    SUB.L      $1234,$12345678         *SUB long word data from $1234 to absolute address LONG WORD
*    SUB.L      $1234,#$55555555        *SUB long word data from $1234 to immediate data $55555555
    
    SUB.L      $12345678,D4            *SUB long word data from $12345678 to D4
*    SUB.L      $12345678,A4            *SUB long word data from $12345678 to A4
*    SUB.L      $12345678,(A4)          *SUB long word data from $12345678 to object in A4
*    SUB.L      $12345678,(A4)+         *SUB long word data from $12345678 to object in A4 and increase pointer by 1
*    SUB.L      $12345678,-(A4)         *SUB long word data from $12345678 to object in A4 after decrease pointer by 1
*    SUB.L      $12345678,$1234         *SUB long word data from $12345678 to absolute address WORD
*    SUB.L      $12345678,$12345678     *SUB long word data from $12345678 to absolute address LONG WORD
*    SUB.L      $12345678,#$55555555    *SUB long word data from $12345678 to immediate data $55555555
    
    SUB.L      #$55555555,D4           *SUB long word data from #$55555555 to D4
*    SUB.L      #$55555555,A4           *SUB long word data from #$55555555 to A4
*    SUB.L      #$55555555,(A4)         *SUB long word data from #$55555555 to object in A4
*    SUB.L      #$55555555,(A4)+        *SUB long word data from #$55555555 to object in A4 and increase pointer by 1
*    SUB.L      #$55555555,-(A4)        *SUB long word data from #$55555555 to object in A4 after decrease pointer by 1
*    SUB.L      #$55555555,$1234        *SUB long word data from #$55555555 to absolute address WORD
*    SUB.L      #$55555555,$12345678    *SUB long word data from #$55555555 to absolute address LONG WORD
*    SUB.L      #$55555555,#$55555555   *SUB long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*SUBQ
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*SUBQ.B
*////////////////////////////////////////////////////////////////////

*     SUBQ.B      D3,D4                   *SUBQ byte data from D3 to D4
*     SUBQ.B      D3,A4                   *SUBQ byte data from D3 to A4
*     SUBQ.B      D3,(A4)                 *SUBQ byte data from D3 to object in A4
*     SUBQ.B      D3,(A4)+                *SUBQ byte data from D3 to object in A4 and increase pointer by 1
*     SUBQ.B      D3,-(A4)                *SUBQ byte data from D3 to object in A4 after decrease pointer by 1
*     SUBQ.B      D3,$1234                *SUBQ byte data from D3 to absolute address WORD
*     SUBQ.B      D3,$12345678            *SUBQ byte data from D3 to absolute address LONG WORD
*     SUBQ.B      D3,#$55                 *SUBQ byte data from D3 to immediate data $55                
*    
*     SUBQ.B      A3,D4                   *SUBQ byte data from A3 to D4
*     SUBQ.B      A3,A4                   *SUBQ byte data from A3 to A4
*     SUBQ.B      A3,(A4)                 *SUBQ byte data from A3 to object in A4
*     SUBQ.B      A3,(A4)+                *SUBQ byte data from A3 to object in A4 and increase pointer by 1
*     SUBQ.B      A3,-(A4)                *SUBQ byte data from A3 to object in A4 after decrease pointer by 1
*     SUBQ.B      A3,$1234                *SUBQ byte data from A3 to absolute address WORD
*     SUBQ.B      A3,$12345678            *SUBQ byte data from A3 to absolute address LONG WORD
*     SUBQ.B      A3,#$55                 *SUBQ byte data from A3 to immediate data $55
*    
*     SUBQ.B      (A3),D4                 *SUBQ byte data from (A3) to D4
*     SUBQ.B      (A3),A4                 *SUBQ byte data from (A3) to A4
*     SUBQ.B      (A3),(A4)               *SUBQ byte data from (A3) to object in A4
*     SUBQ.B      (A3),(A4)+              *SUBQ byte data from (A3) to object in A4 and increase pointer by 1
*     SUBQ.B      (A3),-(A4)              *SUBQ byte data from (A3) to object in A4 after decrease pointer by 1
*     SUBQ.B      (A3),$1234              *SUBQ byte data from (A3) to absolute address WORD
*     SUBQ.B      (A3),$12345678          *SUBQ byte data from (A3) to absolute address LONG WORD
*     SUBQ.B      (A3),#$55               *SUBQ byte data from (A3) to immediate data $55
*    
*     SUBQ.B      (A3)+,D4                *SUBQ byte data from (A3)+ to D4
*     SUBQ.B      (A3)+,A4                *SUBQ byte data from (A3)+ to A4
*     SUBQ.B      (A3)+,(A4)              *SUBQ byte data from (A3)+ to object in A4
*     SUBQ.B      (A3)+,(A4)+             *SUBQ byte data from (A3)+ to object in A4 and increase pointer by 1
*     SUBQ.B      (A3)+,-(A4)             *SUBQ byte data from (A3)+ to object in A4 after decrease pointer by 1
*     SUBQ.B      (A3)+,$1234             *SUBQ byte data from (A3)+ to absolute address WORD
*     SUBQ.B      (A3)+,$12345678         *SUBQ byte data from (A3)+ to absolute address LONG WORD
*     SUBQ.B      (A3)+,#$55              *SUBQ byte data from (A3)+ to immediate data $55
*    
*     SUBQ.B      -(A3),D4                *SUBQ byte data from -(A3) to D4
*     SUBQ.B      -(A3),A4                *SUBQ byte data from -(A3) to A4
*     SUBQ.B      -(A3),(A4)              *SUBQ byte data from -(A3) to object in A4
*     SUBQ.B      -(A3),(A4)+             *SUBQ byte data from -(A3) to object in A4 and increase pointer by 1
*     SUBQ.B      -(A3),-(A4)             *SUBQ byte data from -(A3) to object in A4 after decrease pointer by 1
*     SUBQ.B      -(A3),$1234             *SUBQ byte data from -(A3) to absolute address WORD
*     SUBQ.B      -(A3),$12345678         *SUBQ byte data from -(A3) to absolute address LONG WORD
*     SUBQ.B      -(A3),#$55              *SUBQ byte data from -(A3) to immediate data $55
*    
*     SUBQ.B      $1234,D4                *SUBQ byte data from $1234 to D4
*     SUBQ.B      $1234,A4                *SUBQ byte data from $1234 to A4
*     SUBQ.B      $1234,(A4)              *SUBQ byte data from $1234 to object in A4
*     SUBQ.B      $1234,(A4)+             *SUBQ byte data from $1234 to object in A4 and increase pointer by 1
*     SUBQ.B      $1234,-(A4)             *SUBQ byte data from $1234 to object in A4 after decrease pointer by 1
*     SUBQ.B      $1234,$1234             *SUBQ byte data from $1234 to absolute address WORD
*     SUBQ.B      $1234,$12345678         *SUBQ byte data from $1234 to absolute address LONG WORD
*     SUBQ.B      $1234,#$55              *SUBQ byte data from $1234 to immediate data $55
*    
*     SUBQ.B      $12345678,D4            *SUBQ byte data from $12345678 to D4
*     SUBQ.B      $12345678,A4            *SUBQ byte data from $12345678 to A4
*     SUBQ.B      $12345678,(A4)          *SUBQ byte data from $12345678 to object in A4
*     SUBQ.B      $12345678,(A4)+         *SUBQ byte data from $12345678 to object in A4 and increase pointer by 1
*     SUBQ.B      $12345678,-(A4)         *SUBQ byte data from $12345678 to object in A4 after decrease pointer by 1
*     SUBQ.B      $12345678,$1234         *SUBQ byte data from $12345678 to absolute address WORD
*     SUBQ.B      $12345678,$12345678     *SUBQ byte data from $12345678 to absolute address LONG WORD
*     SUBQ.B      $12345678,#$55          *SUBQ byte data from $12345678 to immediate data $55
    
     SUBQ.B      #5,D4                 *SUBQ byte data from #5 to D4
*     SUBQ.B      #5,A4                 *SUBQ byte data from #5 to A4
     SUBQ.B      #5,(A4)               *SUBQ byte data from #5 to object in A4
     SUBQ.B      #5,(A4)+              *SUBQ byte data from #5 to object in A4 and increase pointer by 1
     SUBQ.B      #5,-(A4)              *SUBQ byte data from #5 to object in A4 after decrease pointer by 1
     SUBQ.B      #5,$1234              *SUBQ byte data from #5 to absolute address WORD
     SUBQ.B      #5,$12345678          *SUBQ byte data from #5 to absolute address LONG WORD
*     SUBQ.B      #5,#$55               *SUBQ byte data from #5 to immediate data $55

*////////////////////////////////////////////////////////////////////
*SUBQ.W
*////////////////////////////////////////////////////////////////////    

*    SUBQ.W      D3,D4                   *SUBQ word data from D3 to D4
*    SUBQ.W      D3,A4                   *SUBQ word data from D3 to A4
*    SUBQ.W      D3,(A4)                 *SUBQ word data from D3 to object in A4
*    SUBQ.W      D3,(A4)+                *SUBQ word data from D3 to object in A4 and increase pointer by 1
*    SUBQ.W      D3,-(A4)                *SUBQ word data from D3 to object in A4 after decrease pointer by 1
*    SUBQ.W      D3,$1234                *SUBQ word data from D3 to absolute address WORD
*    SUBQ.W      D3,$12345678            *SUBQ word data from D3 to absolute address LONG WORD
*    SUBQ.W      D3,#$5555               *SUBQ word data from D3 to immediate data $5555 
*    
*    SUBQ.W      A3,D4                   *SUBQ word data from A3 to D4
*    SUBQ.W      A3,A4                   *SUBQ word data from A3 to A4
*    SUBQ.W      A3,(A4)                 *SUBQ word data from A3 to object in A4
*    SUBQ.W      A3,(A4)+                *SUBQ word data from A3 to object in A4 and increase pointer by 1
*    SUBQ.W      A3,-(A4)                *SUBQ word data from A3 to object in A4 after decrease pointer by 1
*    SUBQ.W      A3,$1234                *SUBQ word data from A3 to absolute address WORD
*    SUBQ.W      A3,$12345678            *SUBQ word data from A3 to absolute address LONG WORD
*    SUBQ.W      A3,#$5555               *SUBQ word data from A3 to immediate data $5555
*    
*    SUBQ.W      (A3),D4                 *SUBQ word data from (A3) to D4
*    SUBQ.W      (A3),A4                 *SUBQ word data from (A3) to A4
*    SUBQ.W      (A3),(A4)               *SUBQ word data from (A3) to object in A4
*    SUBQ.W      (A3),(A4)+              *SUBQ word data from (A3) to object in A4 and increase pointer by 1
*    SUBQ.W      (A3),-(A4)              *SUBQ word data from (A3) to object in A4 after decrease pointer by 1
*    SUBQ.W      (A3),$1234              *SUBQ word data from (A3) to absolute address WORD
*    SUBQ.W      (A3),$12345678          *SUBQ word data from (A3) to absolute address LONG WORD
*    SUBQ.W      (A3),#$5555             *SUBQ word data from (A3) to immediate data $5555
*    
*    SUBQ.W      (A3)+,D4                *SUBQ word data from (A3)+ to D4
*    SUBQ.W      (A3)+,A4                *SUBQ word data from (A3)+ to A4
*    SUBQ.W      (A3)+,(A4)              *SUBQ word data from (A3)+ to object in A4
*    SUBQ.W      (A3)+,(A4)+             *SUBQ word data from (A3)+ to object in A4 and increase pointer by 1
*    SUBQ.W      (A3)+,-(A4)             *SUBQ word data from (A3)+ to object in A4 after decrease pointer by 1
*    SUBQ.W      (A3)+,$1234             *SUBQ word data from (A3)+ to absolute address WORD
*    SUBQ.W      (A3)+,$12345678         *SUBQ word data from (A3)+ to absolute address LONG WORD
*    SUBQ.W      (A3)+,#$5555            *SUBQ word data from (A3)+ to immediate data $5555
*    
*    SUBQ.W      -(A3),D4                *SUBQ word data from -(A3) to D4
*    SUBQ.W      -(A3),A4                *SUBQ word data from -(A3) to A4
*    SUBQ.W      -(A3),(A4)              *SUBQ word data from -(A3) to object in A4
*    SUBQ.W      -(A3),(A4)+             *SUBQ word data from -(A3) to object in A4 and increase pointer by 1
*    SUBQ.W      -(A3),-(A4)             *SUBQ word data from -(A3) to object in A4 after decrease pointer by 1
*    SUBQ.W      -(A3),$1234             *SUBQ word data from -(A3) to absolute address WORD
*    SUBQ.W      -(A3),$12345678         *SUBQ word data from -(A3) to absolute address LONG WORD
*    SUBQ.W      -(A3),#$5555            *SUBQ word data from -(A3) to immediate data $5555
*    
*    SUBQ.W      $1234,D4                *SUBQ word data from $1234 to D4
*    SUBQ.W      $1234,A4                *SUBQ word data from $1234 to A4
*    SUBQ.W      $1234,(A4)              *SUBQ word data from $1234 to object in A4
*    SUBQ.W      $1234,(A4)+             *SUBQ word data from $1234 to object in A4 and increase pointer by 1
*    SUBQ.W      $1234,-(A4)             *SUBQ word data from $1234 to object in A4 after decrease pointer by 1
*    SUBQ.W      $1234,$1234             *SUBQ word data from $1234 to absolute address WORD
*    SUBQ.W      $1234,$12345678         *SUBQ word data from $1234 to absolute address LONG WORD
*    SUBQ.W      $1234,#$5555            *SUBQ word data from $1234 to immediate data $5555
*    
*    SUBQ.W      $12345678,D4            *SUBQ word data from $12345678 to D4
*    SUBQ.W      $12345678,A4            *SUBQ word data from $12345678 to A4
*    SUBQ.W      $12345678,(A4)          *SUBQ word data from $12345678 to object in A4
*    SUBQ.W      $12345678,(A4)+         *SUBQ word data from $12345678 to object in A4 and increase pointer by 1
*    SUBQ.W      $12345678,-(A4)         *SUBQ word data from $12345678 to object in A4 after decrease pointer by 1
*    SUBQ.W      $12345678,$1234         *SUBQ word data from $12345678 to absolute address WORD
*    SUBQ.W      $12345678,$12345678     *SUBQ word data from $12345678 to absolute address LONG WORD
*    SUBQ.W      $12345678,#$5555        *SUBQ word data from $12345678 to immediate data $5555
    
    SUBQ.W      #5,D4               *SUBQ word data from #5 to D4
    SUBQ.W      #5,A4               *SUBQ word data from #5 to A4
    SUBQ.W      #5,(A4)             *SUBQ word data from #5 to object in A4
    SUBQ.W      #5,(A4)+            *SUBQ word data from #5 to object in A4 and increase pointer by 1
    SUBQ.W      #5,-(A4)            *SUBQ word data from #5 to object in A4 after decrease pointer by 1
    SUBQ.W      #5,$1234            *SUBQ word data from #5 to absolute address WORD
    SUBQ.W      #5,$12345678        *SUBQ word data from #5 to absolute address LONG WORD
*    SUBQ.W      #5,#$5555           *SUBQ word data from #5 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*SUBQ.L
*////////////////////////////////////////////////////////////////////

*    SUBQ.L      D3,D4                   *SUBQ long word data from D3 to D4
*    SUBQ.L      D3,A4                   *SUBQ long word data from D3 to A4
*    SUBQ.L      D3,(A4)                 *SUBQ long word data from D3 to object in A4
*    SUBQ.L      D3,(A4)+                *SUBQ long word data from D3 to object in A4 and increase pointer by 1
*    SUBQ.L      D3,-(A4)                *SUBQ long word data from D3 to object in A4 after decrease pointer by 1
*    SUBQ.L      D3,$1234                *SUBQ long word data from D3 to absolute address WORD
*    SUBQ.L      D3,$12345678            *SUBQ long word data from D3 to absolute address LONG WORD
*    SUBQ.L      D3,#$55555555           *SUBQ long word data from D3 to immediate data $55555555 
*    
*    SUBQ.L      A3,D4                   *SUBQ long word data from A3 to D4
*    SUBQ.L      A3,A4                   *SUBQ long word data from A3 to A4
*    SUBQ.L      A3,(A4)                 *SUBQ long word data from A3 to object in A4
*    SUBQ.L      A3,(A4)+                *SUBQ long word data from A3 to object in A4 and increase pointer by 1
*    SUBQ.L      A3,-(A4)                *SUBQ long word data from A3 to object in A4 after decrease pointer by 1
*    SUBQ.L      A3,$1234                *SUBQ long word data from A3 to absolute address WORD
*    SUBQ.L      A3,$12345678            *SUBQ long word data from A3 to absolute address LONG WORD
*    SUBQ.L      A3,#$55555555           *SUBQ long word data from A3 to immediate data $55555555
*    
*    SUBQ.L      (A3),D4                 *SUBQ long word data from (A3) to D4
*    SUBQ.L      (A3),A4                 *SUBQ long word data from (A3) to A4
*    SUBQ.L      (A3),(A4)               *SUBQ long word data from (A3) to object in A4
*    SUBQ.L      (A3),(A4)+              *SUBQ long word data from (A3) to object in A4 and increase pointer by 1
*    SUBQ.L      (A3),-(A4)              *SUBQ long word data from (A3) to object in A4 after decrease pointer by 1
*    SUBQ.L      (A3),$1234              *SUBQ long word data from (A3) to absolute address WORD
*    SUBQ.L      (A3),$12345678          *SUBQ long word data from (A3) to absolute address LONG WORD
*    SUBQ.L      (A3),#$55555555         *SUBQ long word data from (A3) to immediate data $55555555
*    
*    SUBQ.L      (A3)+,D4                *SUBQ long word data from (A3)+ to D4
*    SUBQ.L      (A3)+,A4                *SUBQ long word data from (A3)+ to A4
*    SUBQ.L      (A3)+,(A4)              *SUBQ long word data from (A3)+ to object in A4
*    SUBQ.L      (A3)+,(A4)+             *SUBQ long word data from (A3)+ to object in A4 and increase pointer by 1
*    SUBQ.L      (A3)+,-(A4)             *SUBQ long word data from (A3)+ to object in A4 after decrease pointer by 1
*    SUBQ.L      (A3)+,$1234             *SUBQ long word data from (A3)+ to absolute address WORD
*    SUBQ.L      (A3)+,$12345678         *SUBQ long word data from (A3)+ to absolute address LONG WORD
*    SUBQ.L      (A3)+,#$55555555        *SUBQ long word data from (A3)+ to immediate data $55555555
*    
*    SUBQ.L      -(A3),D4                *SUBQ long word data from -(A3) to D4
*    SUBQ.L      -(A3),A4                *SUBQ long word data from -(A3) to A4
*    SUBQ.L      -(A3),(A4)              *SUBQ long word data from -(A3) to object in A4
*    SUBQ.L      -(A3),(A4)+             *SUBQ long word data from -(A3) to object in A4 and increase pointer by 1
*    SUBQ.L      -(A3),-(A4)             *SUBQ long word data from -(A3) to object in A4 after decrease pointer by 1
*    SUBQ.L      -(A3),$1234             *SUBQ long word data from -(A3) to absolute address WORD
*    SUBQ.L      -(A3),$12345678         *SUBQ long word data from -(A3) to absolute address LONG WORD
*    SUBQ.L      -(A3),#$55555555        *SUBQ long word data from -(A3) to immediate data $55555555
*    
*    SUBQ.L      $1234,D4                *SUBQ long word data from $1234 to D4
*    SUBQ.L      $1234,A4                *SUBQ long word data from $1234 to A4
*    SUBQ.L      $1234,(A4)              *SUBQ long word data from $1234 to object in A4
*    SUBQ.L      $1234,(A4)+             *SUBQ long word data from $1234 to object in A4 and increase pointer by 1
*    SUBQ.L      $1234,-(A4)             *SUBQ long word data from $1234 to object in A4 after decrease pointer by 1
*    SUBQ.L      $1234,$1234             *SUBQ long word data from $1234 to absolute address WORD
*    SUBQ.L      $1234,$12345678         *SUBQ long word data from $1234 to absolute address LONG WORD
*    SUBQ.L      $1234,#$55555555        *SUBQ long word data from $1234 to immediate data $55555555
*    
*    SUBQ.L      $12345678,D4            *SUBQ long word data from $12345678 to D4
*    SUBQ.L      $12345678,A4            *SUBQ long word data from $12345678 to A4
*    SUBQ.L      $12345678,(A4)          *SUBQ long word data from $12345678 to object in A4
*    SUBQ.L      $12345678,(A4)+         *SUBQ long word data from $12345678 to object in A4 and increase pointer by 1
*    SUBQ.L      $12345678,-(A4)         *SUBQ long word data from $12345678 to object in A4 after decrease pointer by 1
*    SUBQ.L      $12345678,$1234         *SUBQ long word data from $12345678 to absolute address WORD
*    SUBQ.L      $12345678,$12345678     *SUBQ long word data from $12345678 to absolute address LONG WORD
*    SUBQ.L      $12345678,#$55555555    *SUBQ long word data from $12345678 to immediate data $55555555
    
    SUBQ.L      #5,D4           *SUBQ long word data from #5 to D4
    SUBQ.L      #5,A4           *SUBQ long word data from #5 to A4
    SUBQ.L      #5,(A4)         *SUBQ long word data from #5 to object in A4
    SUBQ.L      #5,(A4)+        *SUBQ long word data from #5 to object in A4 and increase pointer by 1
    SUBQ.L      #5,-(A4)        *SUBQ long word data from #5 to object in A4 after decrease pointer by 1
    SUBQ.L      #5,$1234        *SUBQ long word data from #5 to absolute address WORD
    SUBQ.L      #5,$12345678    *SUBQ long word data from #5 to absolute address LONG WORD
*    SUBQ.L      #5,#5   *SUBQ long word data from #5 to immediate data 5


*********************************************************************
*********************************************************************
*
*MULS
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*MULS.W
*////////////////////////////////////////////////////////////////////
    
     MULS.W      D3,D4                   *Move word data from D3 to D4
*     MULS.W      D3,A4                   *Move word data from D3 to A4
*     MULS.W      D3,(A4)                 *Move word data from D3 to object in A4
*     MULS.W      D3,(A4)+                *Move word data from D3 to object in A4 and increase pointer by 1
*     MULS.W      D3,-(A4)                *Move word data from D3 to object in A4 after decrease pointer by 1
*     MULS.W      D3,$1234                *Move word data from D3 to absolute address WORD
*     MULS.W      D3,$12345678            *Move word data from D3 to absolute address LONG WORD
*     MULS.W      D3,#$5555               *Move word data from D3 to immediate data $5555 
    
*     MULS.W      A3,D4                   *Move word data from A3 to D4
*     MULS.W      A3,A4                   *Move word data from A3 to A4
*     MULS.W      A3,(A4)                 *Move word data from A3 to object in A4
*     MULS.W      A3,(A4)+                *Move word data from A3 to object in A4 and increase pointer by 1
*     MULS.W      A3,-(A4)                *Move word data from A3 to object in A4 after decrease pointer by 1
*     MULS.W      A3,$1234                *Move word data from A3 to absolute address WORD
*     MULS.W      A3,$12345678            *Move word data from A3 to absolute address LONG WORD
*     MULS.W      A3,#$5555               *Move word data from A3 to immediate data $5555
    
     MULS.W      (A3),D4                 *Move word data from (A3) to D4
*     MULS.W      (A3),A4                 *Move word data from (A3) to A4
*     MULS.W      (A3),(A4)               *Move word data from (A3) to object in A4
*     MULS.W      (A3),(A4)+              *Move word data from (A3) to object in A4 and increase pointer by 1
*     MULS.W      (A3),-(A4)              *Move word data from (A3) to object in A4 after decrease pointer by 1
*     MULS.W      (A3),$1234              *Move word data from (A3) to absolute address WORD
*     MULS.W      (A3),$12345678          *Move word data from (A3) to absolute address LONG WORD
*     MULS.W      (A3),#$5555             *Move word data from (A3) to immediate data $5555
    
     MULS.W      (A3)+,D4                *Move word data from (A3)+ to D4
*     MULS.W      (A3)+,A4                *Move word data from (A3)+ to A4
*     MULS.W      (A3)+,(A4)              *Move word data from (A3)+ to object in A4
*     MULS.W      (A3)+,(A4)+             *Move word data from (A3)+ to object in A4 and increase pointer by 1
*     MULS.W      (A3)+,-(A4)             *Move word data from (A3)+ to object in A4 after decrease pointer by 1
*     MULS.W      (A3)+,$1234             *Move word data from (A3)+ to absolute address WORD
*     MULS.W      (A3)+,$12345678         *Move word data from (A3)+ to absolute address LONG WORD
*     MULS.W      (A3)+,#$5555            *Move word data from (A3)+ to immediate data $5555
    
     MULS.W      -(A3),D4                *Move word data from -(A3) to D4
*     MULS.W      -(A3),A4                *Move word data from -(A3) to A4
*     MULS.W      -(A3),(A4)              *Move word data from -(A3) to object in A4
*     MULS.W      -(A3),(A4)+             *Move word data from -(A3) to object in A4 and increase pointer by 1
*     MULS.W      -(A3),-(A4)             *Move word data from -(A3) to object in A4 after decrease pointer by 1
*     MULS.W      -(A3),$1234             *Move word data from -(A3) to absolute address WORD
*     MULS.W      -(A3),$12345678         *Move word data from -(A3) to absolute address LONG WORD
*     MULS.W      -(A3),#$5555            *Move word data from -(A3) to immediate data $5555
    
     MULS.W      $1234,D4                *Move word data from $1234 to D4
*     MULS.W      $1234,A4                *Move word data from $1234 to A4
*     MULS.W      $1234,(A4)              *Move word data from $1234 to object in A4
*     MULS.W      $1234,(A4)+             *Move word data from $1234 to object in A4 and increase pointer by 1
*     MULS.W      $1234,-(A4)             *Move word data from $1234 to object in A4 after decrease pointer by 1
*     MULS.W      $1234,$1234             *Move word data from $1234 to absolute address WORD
*     MULS.W      $1234,$12345678         *Move word data from $1234 to absolute address LONG WORD
*     MULS.W      $1234,#$5555            *Move word data from $1234 to immediate data $5555
    
     MULS.W      $12345678,D4            *Move word data from $12345678 to D4
*     MULS.W      $12345678,A4            *Move word data from $12345678 to A4
*     MULS.W      $12345678,(A4)          *Move word data from $12345678 to object in A4
*     MULS.W      $12345678,(A4)+         *Move word data from $12345678 to object in A4 and increase pointer by 1
*     MULS.W      $12345678,-(A4)         *Move word data from $12345678 to object in A4 after decrease pointer by 1
*     MULS.W      $12345678,$1234         *Move word data from $12345678 to absolute address WORD
*     MULS.W      $12345678,$12345678     *Move word data from $12345678 to absolute address LONG WORD
*     MULS.W      $12345678,#$5555        *Move word data from $12345678 to immediate data $5555
    
     MULS.W      #$5555,D4               *Move word data from #$5555 to D4
*     MULS.W      #$5555,A4               *Move word data from #$5555 to A4
*     MULS.W      #$5555,(A4)             *Move word data from #$5555 to object in A4
*     MULS.W      #$5555,(A4)+            *Move word data from #$5555 to object in A4 and increase pointer by 1
*     MULS.W      #$5555,-(A4)            *Move word data from #$5555 to object in A4 after decrease pointer by 1
*     MULS.W      #$5555,$1234            *Move word data from #$5555 to absolute address WORD
*     MULS.W      #$5555,$12345678        *Move word data from #$5555 to absolute address LONG WORD
*     MULS.W      #$5555,#$5555           *Move word data from #$5555 to immediate data $5555  

*////////////////////////////////////////////////////////////////////
*MULS.L
*////////////////////////////////////////////////////////////////////
    
*     MULS.L      D3,D4                   *Move long word data from D3 to D4
*     MULS.L      D3,A4                   *Move long word data from D3 to A4
*     MULS.L      D3,(A4)                 *Move long word data from D3 to object in A4
*     MULS.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
*     MULS.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
*     MULS.L      D3,$1234                *Move long word data from D3 to absolute address WORD
*     MULS.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORD
*     MULS.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
   
*     MULS.L      A3,D4                   *Move long word data from A3 to D4
*     MULS.L      A3,A4                   *Move long word data from A3 to A4
*     MULS.L      A3,(A4)                 *Move long word data from A3 to object in A4
*     MULS.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
*     MULS.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
*     MULS.L      A3,$1234                *Move long word data from A3 to absolute address WORD
*     MULS.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
*     MULS.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
*     MULS.L      (A3),D4                 *Move long word data from (A3) to D4
*     MULS.L      (A3),A4                 *Move long word data from (A3) to A4
*     MULS.L      (A3),(A4)               *Move long word data from (A3) to object in A4
*     MULS.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
*     MULS.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
*     MULS.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
*     MULS.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
*     MULS.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
*     MULS.L      (A3)+,D4                *Move long word data from (A3)+ to D4
*     MULS.L      (A3)+,A4                *Move long word data from (A3)+ to A4
*     MULS.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
*     MULS.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
*     MULS.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
*     MULS.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
*     MULS.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
*     MULS.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
   
*     MULS.L      -(A3),D4                *Move long word data from -(A3) to D4
*     MULS.L      -(A3),A4                *Move long word data from -(A3) to A4
*     MULS.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
*     MULS.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
*     MULS.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
*     MULS.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
*     MULS.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
*     MULS.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
*     MULS.L      $1234,D4                *Move long word data from $1234 to D4
*     MULS.L      $1234,A4                *Move long word data from $1234 to A4
*     MULS.L      $1234,(A4)              *Move long word data from $1234 to object in A4
*     MULS.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
*     MULS.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
*     MULS.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
*     MULS.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
*     MULS.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
*     MULS.L      $12345678,D4            *Move long word data from $12345678 to D4
*     MULS.L      $12345678,A4            *Move long word data from $12345678 to A4
*     MULS.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
*     MULS.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
*     MULS.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
*     MULS.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
*     MULS.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
*     MULS.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
*     MULS.L      #$55555555,D4           *Move long word data from #$55555555 to D4
*     MULS.L      #$55555555,A4           *Move long word data from #$55555555 to A4
*     MULS.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
*     MULS.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
*     MULS.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
*     MULS.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
*     MULS.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
*     MULS.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555
  
*********************************************************************
*********************************************************************
*
*DIVS
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*DIVS.W
*////////////////////////////////////////////////////////////////////
    
     DIVS.W      D3,D4                   *Move word data from D3 to D4
*     DIVS.W      D3,A4                   *Move word data from D3 to A4
*     DIVS.W      D3,(A4)                 *Move word data from D3 to object in A4
*     DIVS.W      D3,(A4)+                *Move word data from D3 to object in A4 and increase pointer by 1
*     DIVS.W      D3,-(A4)                *Move word data from D3 to object in A4 after decrease pointer by 1
*     DIVS.W      D3,$1234                *Move word data from D3 to absolute address WORD
*     DIVS.W      D3,$12345678            *Move word data from D3 to absolute address LONG WORD
*     DIVS.W      D3,#$5555               *Move word data from D3 to immediate data $5555 
    
*     DIVS.W      A3,D4                   *Move word data from A3 to D4
*     DIVS.W      A3,A4                   *Move word data from A3 to A4
*     DIVS.W      A3,(A4)                 *Move word data from A3 to object in A4
*     DIVS.W      A3,(A4)+                *Move word data from A3 to object in A4 and increase pointer by 1
*     DIVS.W      A3,-(A4)                *Move word data from A3 to object in A4 after decrease pointer by 1
*     DIVS.W      A3,$1234                *Move word data from A3 to absolute address WORD
*     DIVS.W      A3,$12345678            *Move word data from A3 to absolute address LONG WORD
*     DIVS.W      A3,#$5555               *Move word data from A3 to immediate data $5555
    
     DIVS.W      (A3),D4                 *Move word data from (A3) to D4
*     DIVS.W      (A3),A4                 *Move word data from (A3) to A4
*     DIVS.W      (A3),(A4)               *Move word data from (A3) to object in A4
*     DIVS.W      (A3),(A4)+              *Move word data from (A3) to object in A4 and increase pointer by 1
*     DIVS.W      (A3),-(A4)              *Move word data from (A3) to object in A4 after decrease pointer by 1
*     DIVS.W      (A3),$1234              *Move word data from (A3) to absolute address WORD
*     DIVS.W      (A3),$12345678          *Move word data from (A3) to absolute address LONG WORD
*     DIVS.W      (A3),#$5555             *Move word data from (A3) to immediate data $5555
    
     DIVS.W      (A3)+,D4                *Move word data from (A3)+ to D4
*     DIVS.W      (A3)+,A4                *Move word data from (A3)+ to A4
*     DIVS.W      (A3)+,(A4)              *Move word data from (A3)+ to object in A4
*     DIVS.W      (A3)+,(A4)+             *Move word data from (A3)+ to object in A4 and increase pointer by 1
*     DIVS.W      (A3)+,-(A4)             *Move word data from (A3)+ to object in A4 after decrease pointer by 1
*     DIVS.W      (A3)+,$1234             *Move word data from (A3)+ to absolute address WORD
*     DIVS.W      (A3)+,$12345678         *Move word data from (A3)+ to absolute address LONG WORD
*     DIVS.W      (A3)+,#$5555            *Move word data from (A3)+ to immediate data $5555
    
     DIVS.W      -(A3),D4                *Move word data from -(A3) to D4
*     DIVS.W      -(A3),A4                *Move word data from -(A3) to A4
*     DIVS.W      -(A3),(A4)              *Move word data from -(A3) to object in A4
*     DIVS.W      -(A3),(A4)+             *Move word data from -(A3) to object in A4 and increase pointer by 1
*     DIVS.W      -(A3),-(A4)             *Move word data from -(A3) to object in A4 after decrease pointer by 1
*     DIVS.W      -(A3),$1234             *Move word data from -(A3) to absolute address WORD
*     DIVS.W      -(A3),$12345678         *Move word data from -(A3) to absolute address LONG WORD
*     DIVS.W      -(A3),#$5555            *Move word data from -(A3) to immediate data $5555
    
     DIVS.W      $1234,D4                *Move word data from $1234 to D4
*     DIVS.W      $1234,A4                *Move word data from $1234 to A4
*     DIVS.W      $1234,(A4)              *Move word data from $1234 to object in A4
*     DIVS.W      $1234,(A4)+             *Move word data from $1234 to object in A4 and increase pointer by 1
*     DIVS.W      $1234,-(A4)             *Move word data from $1234 to object in A4 after decrease pointer by 1
*     DIVS.W      $1234,$1234             *Move word data from $1234 to absolute address WORD
*     DIVS.W      $1234,$12345678         *Move word data from $1234 to absolute address LONG WORD
*     DIVS.W      $1234,#$5555            *Move word data from $1234 to immediate data $5555
    
     DIVS.W      $12345678,D4            *Move word data from $12345678 to D4
*     DIVS.W      $12345678,A4            *Move word data from $12345678 to A4
*     DIVS.W      $12345678,(A4)          *Move word data from $12345678 to object in A4
*     DIVS.W      $12345678,(A4)+         *Move word data from $12345678 to object in A4 and increase pointer by 1
*     DIVS.W      $12345678,-(A4)         *Move word data from $12345678 to object in A4 after decrease pointer by 1
*     DIVS.W      $12345678,$1234         *Move word data from $12345678 to absolute address WORD
*     DIVS.W      $12345678,$12345678     *Move word data from $12345678 to absolute address LONG WORD
*     DIVS.W      $12345678,#$5555        *Move word data from $12345678 to immediate data $5555
    
     DIVS.W      #$5555,D4               *Move word data from #$5555 to D4
*     DIVS.W      #$5555,A4               *Move word data from #$5555 to A4
*     DIVS.W      #$5555,(A4)             *Move word data from #$5555 to object in A4
*     DIVS.W      #$5555,(A4)+            *Move word data from #$5555 to object in A4 and increase pointer by 1
*     DIVS.W      #$5555,-(A4)            *Move word data from #$5555 to object in A4 after decrease pointer by 1
*     DIVS.W      #$5555,$1234            *Move word data from #$5555 to absolute address WORD
*     DIVS.W      #$5555,$12345678        *Move word data from #$5555 to absolute address LONG WORD
*     DIVS.W      #$5555,#$5555           *Move word data from #$5555 to immediate data $5555  

*////////////////////////////////////////////////////////////////////
*DIVS.L
*////////////////////////////////////////////////////////////////////
    
*     DIVS.L      D3,D4                   *Move long word data from D3 to D4
*     DIVS.L      D3,A4                   *Move long word data from D3 to A4
*     DIVS.L      D3,(A4)                 *Move long word data from D3 to object in A4
*     DIVS.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
*     DIVS.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
*     DIVS.L      D3,$1234                *Move long word data from D3 to absolute address WORD
*     DIVS.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORD
*     DIVS.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
   
*     DIVS.L      A3,D4                   *Move long word data from A3 to D4
*     DIVS.L      A3,A4                   *Move long word data from A3 to A4
*     DIVS.L      A3,(A4)                 *Move long word data from A3 to object in A4
*     DIVS.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
*     DIVS.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
*     DIVS.L      A3,$1234                *Move long word data from A3 to absolute address WORD
*     DIVS.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
*     DIVS.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
*     DIVS.L      (A3),D4                 *Move long word data from (A3) to D4
*     DIVS.L      (A3),A4                 *Move long word data from (A3) to A4
*     DIVS.L      (A3),(A4)               *Move long word data from (A3) to object in A4
*     DIVS.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
*     DIVS.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
*     DIVS.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
*     DIVS.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
*     DIVS.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
*     DIVS.L      (A3)+,D4                *Move long word data from (A3)+ to D4
*     DIVS.L      (A3)+,A4                *Move long word data from (A3)+ to A4
*     DIVS.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
*     DIVS.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
*     DIVS.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
*     DIVS.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
*     DIVS.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
*     DIVS.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
   
*     DIVS.L      -(A3),D4                *Move long word data from -(A3) to D4
*     DIVS.L      -(A3),A4                *Move long word data from -(A3) to A4
*     DIVS.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
*     DIVS.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
*     DIVS.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
*     DIVS.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
*     DIVS.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
*     DIVS.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
*     DIVS.L      $1234,D4                *Move long word data from $1234 to D4
*     DIVS.L      $1234,A4                *Move long word data from $1234 to A4
*     DIVS.L      $1234,(A4)              *Move long word data from $1234 to object in A4
*     DIVS.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
*     DIVS.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
*     DIVS.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
*     DIVS.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
*     DIVS.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
*     DIVS.L      $12345678,D4            *Move long word data from $12345678 to D4
*     DIVS.L      $12345678,A4            *Move long word data from $12345678 to A4
*     DIVS.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
*     DIVS.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
*     DIVS.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
*     DIVS.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
*     DIVS.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
*     DIVS.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
*     DIVS.L      #$55555555,D4           *Move long word data from #$55555555 to D4
*     DIVS.L      #$55555555,A4           *Move long word data from #$55555555 to A4
*     DIVS.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
*     DIVS.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
*     DIVS.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
*     DIVS.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
*     DIVS.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
*     DIVS.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*LEA
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*LEA.L
*////////////////////////////////////////////////////////////////////
    
*     LEA.L      D3,D4                   *Move long word data from D3 to D4
*     LEA.L      D3,A4                   *Move long word data from D3 to A4
*     LEA.L      D3,(A4)                 *Move long word data from D3 to object in A4
*     LEA.L      D3,(A4)+                *Move long word data from D3 to object in A4 and increase pointer by 1
*     LEA.L      D3,-(A4)                *Move long word data from D3 to object in A4 after decrease pointer by 1
*     LEA.L      D3,$1234                *Move long word data from D3 to absolute address WORD
*     LEA.L      D3,$12345678            *Move long word data from D3 to absolute address LONG WORD
*     LEA.L      D3,#$55555555           *Move long word data from D3 to immediate data $55555555 
   
*     LEA.L      A3,D4                   *Move long word data from A3 to D4
*     LEA.L      A3,A4                   *Move long word data from A3 to A4
*     LEA.L      A3,(A4)                 *Move long word data from A3 to object in A4
*     LEA.L      A3,(A4)+                *Move long word data from A3 to object in A4 and increase pointer by 1
*     LEA.L      A3,-(A4)                *Move long word data from A3 to object in A4 after decrease pointer by 1
*     LEA.L      A3,$1234                *Move long word data from A3 to absolute address WORD
*     LEA.L      A3,$12345678            *Move long word data from A3 to absolute address LONG WORD
*     LEA.L      A3,#$55555555           *Move long word data from A3 to immediate data $55555555
    
*     LEA.L      (A3),D4                 *Move long word data from (A3) to D4
     LEA.L      (A3),A4                 *Move long word data from (A3) to A4
*     LEA.L      (A3),(A4)               *Move long word data from (A3) to object in A4
*     LEA.L      (A3),(A4)+              *Move long word data from (A3) to object in A4 and increase pointer by 1
*     LEA.L      (A3),-(A4)              *Move long word data from (A3) to object in A4 after decrease pointer by 1
*     LEA.L      (A3),$1234              *Move long word data from (A3) to absolute address WORD
*     LEA.L      (A3),$12345678          *Move long word data from (A3) to absolute address LONG WORD
*     LEA.L      (A3),#$55555555         *Move long word data from (A3) to immediate data $55555555
    
*     LEA.L      (A3)+,D4                *Move long word data from (A3)+ to D4
*     LEA.L      (A3)+,A4                *Move long word data from (A3)+ to A4
*     LEA.L      (A3)+,(A4)              *Move long word data from (A3)+ to object in A4
*     LEA.L      (A3)+,(A4)+             *Move long word data from (A3)+ to object in A4 and increase pointer by 1
*     LEA.L      (A3)+,-(A4)             *Move long word data from (A3)+ to object in A4 after decrease pointer by 1
*     LEA.L      (A3)+,$1234             *Move long word data from (A3)+ to absolute address WORD
*     LEA.L      (A3)+,$12345678         *Move long word data from (A3)+ to absolute address LONG WORD
*     LEA.L      (A3)+,#$55555555        *Move long word data from (A3)+ to immediate data $55555555
   
*     LEA.L      -(A3),D4                *Move long word data from -(A3) to D4
*     LEA.L      -(A3),A4                *Move long word data from -(A3) to A4
*     LEA.L      -(A3),(A4)              *Move long word data from -(A3) to object in A4
*     LEA.L      -(A3),(A4)+             *Move long word data from -(A3) to object in A4 and increase pointer by 1
*     LEA.L      -(A3),-(A4)             *Move long word data from -(A3) to object in A4 after decrease pointer by 1
*     LEA.L      -(A3),$1234             *Move long word data from -(A3) to absolute address WORD
*     LEA.L      -(A3),$12345678         *Move long word data from -(A3) to absolute address LONG WORD
*     LEA.L      -(A3),#$55555555        *Move long word data from -(A3) to immediate data $55555555
    
*     LEA.L      $1234,D4                *Move long word data from $1234 to D4
     LEA.L      $1234,A4                *Move long word data from $1234 to A4
*     LEA.L      $1234,(A4)              *Move long word data from $1234 to object in A4
*     LEA.L      $1234,(A4)+             *Move long word data from $1234 to object in A4 and increase pointer by 1
*     LEA.L      $1234,-(A4)             *Move long word data from $1234 to object in A4 after decrease pointer by 1
*     LEA.L      $1234,$1234             *Move long word data from $1234 to absolute address WORD
*     LEA.L      $1234,$12345678         *Move long word data from $1234 to absolute address LONG WORD
*     LEA.L      $1234,#$55555555        *Move long word data from $1234 to immediate data $55555555
    
*     LEA.L      $12345678,D4            *Move long word data from $12345678 to D4
     LEA.L      $12345678,A4            *Move long word data from $12345678 to A4
*     LEA.L      $12345678,(A4)          *Move long word data from $12345678 to object in A4
*     LEA.L      $12345678,(A4)+         *Move long word data from $12345678 to object in A4 and increase pointer by 1
*     LEA.L      $12345678,-(A4)         *Move long word data from $12345678 to object in A4 after decrease pointer by 1
*     LEA.L      $12345678,$1234         *Move long word data from $12345678 to absolute address WORD
*     LEA.L      $12345678,$12345678     *Move long word data from $12345678 to absolute address LONG WORD
*     LEA.L      $12345678,#$55555555    *Move long word data from $12345678 to immediate data $55555555
    
*     LEA.L      #$55555555,D4           *Move long word data from #$55555555 to D4
*     LEA.L      #$55555555,A4           *Move long word data from #$55555555 to A4
*     LEA.L      #$55555555,(A4)         *Move long word data from #$55555555 to object in A4
*     LEA.L      #$55555555,(A4)+        *Move long word data from #$55555555 to object in A4 and increase pointer by 1
*     LEA.L      #$55555555,-(A4)        *Move long word data from #$55555555 to object in A4 after decrease pointer by 1
*     LEA.L      #$55555555,$1234        *Move long word data from #$55555555 to absolute address WORD
*     LEA.L      #$55555555,$12345678    *Move long word data from #$55555555 to absolute address LONG WORD
*     LEA.L      #$55555555,#$55555555   *Move long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*OR
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*OR.B
*////////////////////////////////////////////////////////////////////

    OR.B      D3,D4                   *OR byte data from D3 to D4
*    OR.B      D3,A4                   *OR byte data from D3 to A4
    OR.B      D3,(A4)                 *OR byte data from D3 to object in A4
    OR.B      D3,(A4)+                *OR byte data from D3 to object in A4 and increase pointer by 1
    OR.B      D3,-(A4)                *OR byte data from D3 to object in A4 after decrease pointer by 1
    OR.B      D3,$1234                *OR byte data from D3 to absolute address WORD
    OR.B      D3,$12345678            *OR byte data from D3 to absolute address LONG WORD
*    OR.B      D3,#$55                 *OR byte data from D3 to immediate data $55                
    
*    OR.B      A3,D4                   *OR byte data from A3 to D4
*    OR.B      A3,A4                   *OR byte data from A3 to A4
*    OR.B      A3,(A4)                 *OR byte data from A3 to object in A4
*    OR.B      A3,(A4)+                *OR byte data from A3 to object in A4 and increase pointer by 1
*    OR.B      A3,-(A4)                *OR byte data from A3 to object in A4 after decrease pointer by 1
*    OR.B      A3,$1234                *OR byte data from A3 to absolute address WORD
*    OR.B      A3,$12345678            *OR byte data from A3 to absolute address LONG WORD
*    OR.B      A3,#$55                 *OR byte data from A3 to immediate data $55
    
    OR.B      (A3),D4                 *OR byte data from (A3) to D4
*    OR.B      (A3),A4                 *OR byte data from (A3) to A4
*    OR.B      (A3),(A4)               *OR byte data from (A3) to object in A4
*    OR.B      (A3),(A4)+              *OR byte data from (A3) to object in A4 and increase pointer by 1
*    OR.B      (A3),-(A4)              *OR byte data from (A3) to object in A4 after decrease pointer by 1
*    OR.B      (A3),$1234              *OR byte data from (A3) to absolute address WORD
*    OR.B      (A3),$12345678          *OR byte data from (A3) to absolute address LONG WORD
*    OR.B      (A3),#$55               *OR byte data from (A3) to immediate data $55
    
    OR.B      (A3)+,D4                *OR byte data from (A3)+ to D4
*    OR.B      (A3)+,A4                *OR byte data from (A3)+ to A4
*    OR.B      (A3)+,(A4)              *OR byte data from (A3)+ to object in A4
*    OR.B      (A3)+,(A4)+             *OR byte data from (A3)+ to object in A4 and increase pointer by 1
*    OR.B      (A3)+,-(A4)             *OR byte data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.B      (A3)+,$1234             *OR byte data from (A3)+ to absolute address WORD
*    OR.B      (A3)+,$12345678         *OR byte data from (A3)+ to absolute address LONG WORD
*    OR.B      (A3)+,#$55              *OR byte data from (A3)+ to immediate data $55
    
    OR.B      -(A3),D4                *OR byte data from -(A3) to D4
*    OR.B      -(A3),A4                *OR byte data from -(A3) to A4
*    OR.B      -(A3),(A4)              *OR byte data from -(A3) to object in A4
*    OR.B      -(A3),(A4)+             *OR byte data from -(A3) to object in A4 and increase pointer by 1
*    OR.B      -(A3),-(A4)             *OR byte data from -(A3) to object in A4 after decrease pointer by 1
*    OR.B      -(A3),$1234             *OR byte data from -(A3) to absolute address WORD
*    OR.B      -(A3),$12345678         *OR byte data from -(A3) to absolute address LONG WORD
*    OR.B      -(A3),#$55              *OR byte data from -(A3) to immediate data $55
    
    OR.B      $1234,D4                *OR byte data from $1234 to D4
*    OR.B      $1234,A4                *OR byte data from $1234 to A4
*    OR.B      $1234,(A4)              *OR byte data from $1234 to object in A4
*    OR.B      $1234,(A4)+             *OR byte data from $1234 to object in A4 and increase pointer by 1
*    OR.B      $1234,-(A4)             *OR byte data from $1234 to object in A4 after decrease pointer by 1
*    OR.B      $1234,$1234             *OR byte data from $1234 to absolute address WORD
*    OR.B      $1234,$12345678         *OR byte data from $1234 to absolute address LONG WORD
*    OR.B      $1234,#$55              *OR byte data from $1234 to immediate data $55
    
    OR.B      $12345678,D4            *OR byte data from $12345678 to D4
*    OR.B      $12345678,A4            *OR byte data from $12345678 to A4
*    OR.B      $12345678,(A4)          *OR byte data from $12345678 to object in A4
*    OR.B      $12345678,(A4)+         *OR byte data from $12345678 to object in A4 and increase pointer by 1
*    OR.B      $12345678,-(A4)         *OR byte data from $12345678 to object in A4 after decrease pointer by 1
*    OR.B      $12345678,$1234         *OR byte data from $12345678 to absolute address WORD
*    OR.B      $12345678,$12345678     *OR byte data from $12345678 to absolute address LONG WORD
*    OR.B      $12345678,#$55          *OR byte data from $12345678 to immediate data $55
    
    OR.B      #$55,D4                 *OR byte data from #$55 to D4
*    OR.B      #$55,A4                 *OR byte data from #$55 to A4
*    OR.B      #$55,(A4)               *OR byte data from #$55 to object in A4
*    OR.B      #$55,(A4)+              *OR byte data from #$55 to object in A4 and increase pointer by 1
*    OR.B      #$55,-(A4)              *OR byte data from #$55 to object in A4 after decrease pointer by 1
*    OR.B      #$55,$1234              *OR byte data from #$55 to absolute address WORD
*    OR.B      #$55,$12345678          *OR byte data from #$55 to absolute address LONG WORD
*    OR.B      #$55,#$55               *OR byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*OR.W
*////////////////////////////////////////////////////////////////////    

    OR.W      D3,D4                   *OR word data from D3 to D4
*    OR.W      D3,A4                   *OR word data from D3 to A4
    OR.W      D3,(A4)                 *OR word data from D3 to object in A4
    OR.W      D3,(A4)+                *OR word data from D3 to object in A4 and increase pointer by 1
    OR.W      D3,-(A4)                *OR word data from D3 to object in A4 after decrease pointer by 1
    OR.W      D3,$1234                *OR word data from D3 to absolute address WORD
    OR.W      D3,$12345678            *OR word data from D3 to absolute address LONG WORD
*    OR.W      D3,#$5555               *OR word data from D3 to immediate data $5555 
    
*    OR.W      A3,D4                   *OR word data from A3 to D4
*    OR.W      A3,A4                   *OR word data from A3 to A4
*    OR.W      A3,(A4)                 *OR word data from A3 to object in A4
*    OR.W      A3,(A4)+                *OR word data from A3 to object in A4 and increase pointer by 1
*    OR.W      A3,-(A4)                *OR word data from A3 to object in A4 after decrease pointer by 1
*    OR.W      A3,$1234                *OR word data from A3 to absolute address WORD
*    OR.W      A3,$12345678            *OR word data from A3 to absolute address LONG WORD
*    OR.W      A3,#$5555               *OR word data from A3 to immediate data $5555
    
    OR.W      (A3),D4                 *OR word data from (A3) to D4
*    OR.W      (A3),A4                 *OR word data from (A3) to A4
*    OR.W      (A3),(A4)               *OR word data from (A3) to object in A4
*    OR.W      (A3),(A4)+              *OR word data from (A3) to object in A4 and increase pointer by 1
*    OR.W      (A3),-(A4)              *OR word data from (A3) to object in A4 after decrease pointer by 1
*    OR.W      (A3),$1234              *OR word data from (A3) to absolute address WORD
*    OR.W      (A3),$12345678          *OR word data from (A3) to absolute address LONG WORD
*    OR.W      (A3),#$5555             *OR word data from (A3) to immediate data $5555
    
    OR.W      (A3)+,D4                *OR word data from (A3)+ to D4
*    OR.W      (A3)+,A4                *OR word data from (A3)+ to A4
*    OR.W      (A3)+,(A4)              *OR word data from (A3)+ to object in A4
*    OR.W      (A3)+,(A4)+             *OR word data from (A3)+ to object in A4 and increase pointer by 1
*    OR.W      (A3)+,-(A4)             *OR word data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.W      (A3)+,$1234             *OR word data from (A3)+ to absolute address WORD
*    OR.W      (A3)+,$12345678         *OR word data from (A3)+ to absolute address LONG WORD
*    OR.W      (A3)+,#$5555            *OR word data from (A3)+ to immediate data $5555
    
    OR.W      -(A3),D4                *OR word data from -(A3) to D4
*    OR.W      -(A3),A4                *OR word data from -(A3) to A4
*    OR.W      -(A3),(A4)              *OR word data from -(A3) to object in A4
*    OR.W      -(A3),(A4)+             *OR word data from -(A3) to object in A4 and increase pointer by 1
*    OR.W      -(A3),-(A4)             *OR word data from -(A3) to object in A4 after decrease pointer by 1
*    OR.W      -(A3),$1234             *OR word data from -(A3) to absolute address WORD
*    OR.W      -(A3),$12345678         *OR word data from -(A3) to absolute address LONG WORD
*    OR.W      -(A3),#$5555            *OR word data from -(A3) to immediate data $5555
    
    OR.W      $1234,D4                *OR word data from $1234 to D4
*    OR.W      $1234,A4                *OR word data from $1234 to A4
*    OR.W      $1234,(A4)              *OR word data from $1234 to object in A4
*    OR.W      $1234,(A4)+             *OR word data from $1234 to object in A4 and increase pointer by 1
*    OR.W      $1234,-(A4)             *OR word data from $1234 to object in A4 after decrease pointer by 1
*    OR.W      $1234,$1234             *OR word data from $1234 to absolute address WORD
*    OR.W      $1234,$12345678         *OR word data from $1234 to absolute address LONG WORD
*    OR.W      $1234,#$5555            *OR word data from $1234 to immediate data $5555
    
    OR.W      $12345678,D4            *OR word data from $12345678 to D4
*    OR.W      $12345678,A4            *OR word data from $12345678 to A4
*    OR.W      $12345678,(A4)          *OR word data from $12345678 to object in A4
*    OR.W      $12345678,(A4)+         *OR word data from $12345678 to object in A4 and increase pointer by 1
*    OR.W      $12345678,-(A4)         *OR word data from $12345678 to object in A4 after decrease pointer by 1
*    OR.W      $12345678,$1234         *OR word data from $12345678 to absolute address WORD
*    OR.W      $12345678,$12345678     *OR word data from $12345678 to absolute address LONG WORD
*    OR.W      $12345678,#$5555        *OR word data from $12345678 to immediate data $5555
    
    OR.W      #$5555,D4               *OR word data from #$5555 to D4
*    OR.W      #$5555,A4               *OR word data from #$5555 to A4
*    OR.W      #$5555,(A4)             *OR word data from #$5555 to object in A4
*    OR.W      #$5555,(A4)+            *OR word data from #$5555 to object in A4 and increase pointer by 1
*    OR.W      #$5555,-(A4)            *OR word data from #$5555 to object in A4 after decrease pointer by 1
*    OR.W      #$5555,$1234            *OR word data from #$5555 to absolute address WORD
*    OR.W      #$5555,$12345678        *OR word data from #$5555 to absolute address LONG WORD
*    OR.W      #$5555,#$5555           *OR word data from #$5555 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*OR.L
*////////////////////////////////////////////////////////////////////

    OR.L      D3,D4                   *OR long word data from D3 to D4
    OR.L      D3,4                   *OR long word data from D3 to A4
    OR.L      D3,(A4)                 *OR long word data from D3 to object in A4
    OR.L      D3,(A4)+                *OR long word data from D3 to object in A4 and increase pointer by 1
    OR.L      D3,-(A4)                *OR long word data from D3 to object in A4 after decrease pointer by 1
    OR.L      D3,$1234                *OR long word data from D3 to absolute address WORD
    OR.L      D3,$12345678            *OR long word data from D3 to absolute address LONG WORD
*    OR.L      D3,#$55555555           *OR long word data from D3 to immediate data $55555555 
    
*    OR.L      A3,D4                   *OR long word data from A3 to D4
*    OR.L      A3,A4                   *OR long word data from A3 to A4
*    OR.L      A3,(A4)                 *OR long word data from A3 to object in A4
*    OR.L      A3,(A4)+                *OR long word data from A3 to object in A4 and increase pointer by 1
*    OR.L      A3,-(A4)                *OR long word data from A3 to object in A4 after decrease pointer by 1
*    OR.L      A3,$1234                *OR long word data from A3 to absolute address WORD
*    OR.L      A3,$12345678            *OR long word data from A3 to absolute address LONG WORD
*    OR.L      A3,#$55555555           *OR long word data from A3 to immediate data $55555555
    
    OR.L      (A3),D4                 *OR long word data from (A3) to D4
*    OR.L      (A3),A4                 *OR long word data from (A3) to A4
*    OR.L      (A3),(A4)               *OR long word data from (A3) to object in A4
*    OR.L      (A3),(A4)+              *OR long word data from (A3) to object in A4 and increase pointer by 1
*    OR.L      (A3),-(A4)              *OR long word data from (A3) to object in A4 after decrease pointer by 1
*    OR.L      (A3),$1234              *OR long word data from (A3) to absolute address WORD
*    OR.L      (A3),$12345678          *OR long word data from (A3) to absolute address LONG WORD
*    OR.L      (A3),#$55555555         *OR long word data from (A3) to immediate data $55555555
    
    OR.L      (A3)+,D4                *OR long word data from (A3)+ to D4
*    OR.L      (A3)+,A4                *OR long word data from (A3)+ to A4
*    OR.L      (A3)+,(A4)              *OR long word data from (A3)+ to object in A4
*    OR.L      (A3)+,(A4)+             *OR long word data from (A3)+ to object in A4 and increase pointer by 1
*    OR.L      (A3)+,-(A4)             *OR long word data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.L      (A3)+,$1234             *OR long word data from (A3)+ to absolute address WORD
*    OR.L      (A3)+,$12345678         *OR long word data from (A3)+ to absolute address LONG WORD
*    OR.L      (A3)+,#$55555555        *OR long word data from (A3)+ to immediate data $55555555
    
    OR.L      -(A3),D4                *OR long word data from -(A3) to D4
*    OR.L      -(A3),A4                *OR long word data from -(A3) to A4
*    OR.L      -(A3),(A4)              *OR long word data from -(A3) to object in A4
*    OR.L      -(A3),(A4)+             *OR long word data from -(A3) to object in A4 and increase pointer by 1
*    OR.L      -(A3),-(A4)             *OR long word data from -(A3) to object in A4 after decrease pointer by 1
*    OR.L      -(A3),$1234             *OR long word data from -(A3) to absolute address WORD
*    OR.L      -(A3),$12345678         *OR long word data from -(A3) to absolute address LONG WORD
*    OR.L      -(A3),#$55555555        *OR long word data from -(A3) to immediate data $55555555
    
    OR.L      $1234,D4                *OR long word data from $1234 to D4
*    OR.L      $1234,A4                *OR long word data from $1234 to A4
*    OR.L      $1234,(A4)              *OR long word data from $1234 to object in A4
*    OR.L      $1234,(A4)+             *OR long word data from $1234 to object in A4 and increase pointer by 1
*    OR.L      $1234,-(A4)             *OR long word data from $1234 to object in A4 after decrease pointer by 1
*    OR.L      $1234,$1234             *OR long word data from $1234 to absolute address WORD
*    OR.L      $1234,$12345678         *OR long word data from $1234 to absolute address LONG WORD
*    OR.L      $1234,#$55555555        *OR long word data from $1234 to immediate data $55555555
    
    OR.L      $12345678,D4            *OR long word data from $12345678 to D4
*    OR.L      $12345678,A4            *OR long word data from $12345678 to A4
*    OR.L      $12345678,(A4)          *OR long word data from $12345678 to object in A4
*    OR.L      $12345678,(A4)+         *OR long word data from $12345678 to object in A4 and increase pointer by 1
*    OR.L      $12345678,-(A4)         *OR long word data from $12345678 to object in A4 after decrease pointer by 1
*    OR.L      $12345678,$1234         *OR long word data from $12345678 to absolute address WORD
*    OR.L      $12345678,$12345678     *OR long word data from $12345678 to absolute address LONG WORD
*    OR.L      $12345678,#$55555555    *OR long word data from $12345678 to immediate data $55555555
    
    OR.L      #$55555555,D4           *OR long word data from #$55555555 to D4
*    OR.L      #$55555555,A4           *OR long word data from #$55555555 to A4
*    OR.L      #$55555555,(A4)         *OR long word data from #$55555555 to object in A4
*    OR.L      #$55555555,(A4)+        *OR long word data from #$55555555 to object in A4 and increase pointer by 1
*    OR.L      #$55555555,-(A4)        *OR long word data from #$55555555 to object in A4 after decrease pointer by 1
*    OR.L      #$55555555,$1234        *OR long word data from #$55555555 to absolute address WORD
*    OR.L      #$55555555,$12345678    *OR long word data from #$55555555 to absolute address LONG WORD
*    OR.L      #$55555555,#$55555555   *OR long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*ORI
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*ORI.B
*////////////////////////////////////////////////////////////////////

*    ORI.B      D3,D4                   *ORI byte data from D3 to D4
*    ORI.B      D3,A4                   *ORI byte data from D3 to A4
*    ORI.B      D3,(A4)                 *ORI byte data from D3 to object in A4
*    ORI.B      D3,(A4)+                *ORI byte data from D3 to object in A4 and increase pointer by 1
*    ORI.B      D3,-(A4)                *ORI byte data from D3 to object in A4 after decrease pointer by 1
*    ORI.B      D3,$1234                *ORI byte data from D3 to absolute address WORID
*    ORI.B      D3,$12345678            *ORI byte data from D3 to absolute address LONG WORID
*    ORI.B      D3,#$55                 *ORI byte data from D3 to immediate data $55                
*    
*    ORI.B      A3,D4                   *ORI byte data from A3 to D4
*    ORI.B      A3,A4                   *ORI byte data from A3 to A4
*    ORI.B      A3,(A4)                 *ORI byte data from A3 to object in A4
*    ORI.B      A3,(A4)+                *ORI byte data from A3 to object in A4 and increase pointer by 1
*    ORI.B      A3,-(A4)                *ORI byte data from A3 to object in A4 after decrease pointer by 1
*    ORI.B      A3,$1234                *ORI byte data from A3 to absolute address WORID
*    ORI.B      A3,$12345678            *ORI byte data from A3 to absolute address LONG WORID
*    ORI.B      A3,#$55                 *ORI byte data from A3 to immediate data $55
*    
*    ORI.B      (A3),D4                 *ORI byte data from (A3) to D4
*    ORI.B      (A3),A4                 *ORI byte data from (A3) to A4
*    ORI.B      (A3),(A4)               *ORI byte data from (A3) to object in A4
*    ORI.B      (A3),(A4)+              *ORI byte data from (A3) to object in A4 and increase pointer by 1
*    ORI.B      (A3),-(A4)              *ORI byte data from (A3) to object in A4 after decrease pointer by 1
*    ORI.B      (A3),$1234              *ORI byte data from (A3) to absolute address WORID
*    ORI.B      (A3),$12345678          *ORI byte data from (A3) to absolute address LONG WORID
*    ORI.B      (A3),#$55               *ORI byte data from (A3) to immediate data $55
*    
*    ORI.B      (A3)+,D4                *ORI byte data from (A3)+ to D4
*    ORI.B      (A3)+,A4                *ORI byte data from (A3)+ to A4
*    ORI.B      (A3)+,(A4)              *ORI byte data from (A3)+ to object in A4
*    ORI.B      (A3)+,(A4)+             *ORI byte data from (A3)+ to object in A4 and increase pointer by 1
*    ORI.B      (A3)+,-(A4)             *ORI byte data from (A3)+ to object in A4 after decrease pointer by 1
*    ORI.B      (A3)+,$1234             *ORI byte data from (A3)+ to absolute address WORID
*    ORI.B      (A3)+,$12345678         *ORI byte data from (A3)+ to absolute address LONG WORID
*    ORI.B      (A3)+,#$55              *ORI byte data from (A3)+ to immediate data $55
*    
*    ORI.B      -(A3),D4                *ORI byte data from -(A3) to D4
*    ORI.B      -(A3),A4                *ORI byte data from -(A3) to A4
*    ORI.B      -(A3),(A4)              *ORI byte data from -(A3) to object in A4
*    ORI.B      -(A3),(A4)+             *ORI byte data from -(A3) to object in A4 and increase pointer by 1
*    ORI.B      -(A3),-(A4)             *ORI byte data from -(A3) to object in A4 after decrease pointer by 1
*    ORI.B      -(A3),$1234             *ORI byte data from -(A3) to absolute address WORID
*    ORI.B      -(A3),$12345678         *ORI byte data from -(A3) to absolute address LONG WORID
*    ORI.B      -(A3),#$55              *ORI byte data from -(A3) to immediate data $55
*    
*    ORI.B      $1234,D4                *ORI byte data from $1234 to D4
*    ORI.B      $1234,A4                *ORI byte data from $1234 to A4
*    ORI.B      $1234,(A4)              *ORI byte data from $1234 to object in A4
*    ORI.B      $1234,(A4)+             *ORI byte data from $1234 to object in A4 and increase pointer by 1
*    ORI.B      $1234,-(A4)             *ORI byte data from $1234 to object in A4 after decrease pointer by 1
*    ORI.B      $1234,$1234             *ORI byte data from $1234 to absolute address WORID
*    ORI.B      $1234,$12345678         *ORI byte data from $1234 to absolute address LONG WORID
*    ORI.B      $1234,#$55              *ORI byte data from $1234 to immediate data $55
*    
*    ORI.B      $12345678,D4            *ORI byte data from $12345678 to D4
*    ORI.B      $12345678,A4            *ORI byte data from $12345678 to A4
*    ORI.B      $12345678,(A4)          *ORI byte data from $12345678 to object in A4
*    ORI.B      $12345678,(A4)+         *ORI byte data from $12345678 to object in A4 and increase pointer by 1
*    ORI.B      $12345678,-(A4)         *ORI byte data from $12345678 to object in A4 after decrease pointer by 1
*    ORI.B      $12345678,$1234         *ORI byte data from $12345678 to absolute address WORID
*    ORI.B      $12345678,$12345678     *ORI byte data from $12345678 to absolute address LONG WORID
*    ORI.B      $12345678,#$55          *ORI byte data from $12345678 to immediate data $55
*    
    ORI.B      #$55,D4                 *ORI byte data from #$55 to D4
*    ORI.B      #$55,A4                 *ORI byte data from #$55 to A4
    ORI.B      #$55,(A4)               *ORI byte data from #$55 to object in A4
    ORI.B      #$55,(A4)+              *ORI byte data from #$55 to object in A4 and increase pointer by 1
    ORI.B      #$55,-(A4)              *ORI byte data from #$55 to object in A4 after decrease pointer by 1
    ORI.B      #$55,$1234              *ORI byte data from #$55 to absolute address WORID
    ORI.B      #$55,$12345678          *ORI byte data from #$55 to absolute address LONG WORID
*    ORI.B      #$55,#$55               *ORI byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*ORI.W
*////////////////////////////////////////////////////////////////////    
*
*    ORI.W      D3,D4                   *ORI wORId data from D3 to D4
*    ORI.W      D3,A4                   *ORI wORId data from D3 to A4
*    ORI.W      D3,(A4)                 *ORI wORId data from D3 to object in A4
*    ORI.W      D3,(A4)+                *ORI wORId data from D3 to object in A4 and increase pointer by 1
*    ORI.W      D3,-(A4)                *ORI wORId data from D3 to object in A4 after decrease pointer by 1
*    ORI.W      D3,$1234                *ORI wORId data from D3 to absolute address WORID
*    ORI.W      D3,$12345678            *ORI wORId data from D3 to absolute address LONG WORID
*    ORI.W      D3,#$5555               *ORI wORId data from D3 to immediate data $5555 
*    
*    ORI.W      A3,D4                   *ORI wORId data from A3 to D4
*    ORI.W      A3,A4                   *ORI wORId data from A3 to A4
*    ORI.W      A3,(A4)                 *ORI wORId data from A3 to object in A4
*    ORI.W      A3,(A4)+                *ORI wORId data from A3 to object in A4 and increase pointer by 1
*    ORI.W      A3,-(A4)                *ORI wORId data from A3 to object in A4 after decrease pointer by 1
*    ORI.W      A3,$1234                *ORI wORId data from A3 to absolute address WORID
*    ORI.W      A3,$12345678            *ORI wORId data from A3 to absolute address LONG WORID
*    ORI.W      A3,#$5555               *ORI wORId data from A3 to immediate data $5555
*    
*    ORI.W      (A3),D4                 *ORI wORId data from (A3) to D4
*    ORI.W      (A3),A4                 *ORI wORId data from (A3) to A4
*    ORI.W      (A3),(A4)               *ORI wORId data from (A3) to object in A4
*    ORI.W      (A3),(A4)+              *ORI wORId data from (A3) to object in A4 and increase pointer by 1
*    ORI.W      (A3),-(A4)              *ORI wORId data from (A3) to object in A4 after decrease pointer by 1
*    ORI.W      (A3),$1234              *ORI wORId data from (A3) to absolute address WORID
*    ORI.W      (A3),$12345678          *ORI wORId data from (A3) to absolute address LONG WORID
*    ORI.W      (A3),#$5555             *ORI wORId data from (A3) to immediate data $5555
*    
*    ORI.W      (A3)+,D4                *ORI wORId data from (A3)+ to D4
*    ORI.W      (A3)+,A4                *ORI wORId data from (A3)+ to A4
*    ORI.W      (A3)+,(A4)              *ORI wORId data from (A3)+ to object in A4
*    ORI.W      (A3)+,(A4)+             *ORI wORId data from (A3)+ to object in A4 and increase pointer by 1
*    ORI.W      (A3)+,-(A4)             *ORI wORId data from (A3)+ to object in A4 after decrease pointer by 1
*    ORI.W      (A3)+,$1234             *ORI wORId data from (A3)+ to absolute address WORID
*    ORI.W      (A3)+,$12345678         *ORI wORId data from (A3)+ to absolute address LONG WORID
*    ORI.W      (A3)+,#$5555            *ORI wORId data from (A3)+ to immediate data $5555
*    
*    ORI.W      -(A3),D4                *ORI wORId data from -(A3) to D4
*    ORI.W      -(A3),A4                *ORI wORId data from -(A3) to A4
*    ORI.W      -(A3),(A4)              *ORI wORId data from -(A3) to object in A4
*    ORI.W      -(A3),(A4)+             *ORI wORId data from -(A3) to object in A4 and increase pointer by 1
*    ORI.W      -(A3),-(A4)             *ORI wORId data from -(A3) to object in A4 after decrease pointer by 1
*    ORI.W      -(A3),$1234             *ORI wORId data from -(A3) to absolute address WORID
*    ORI.W      -(A3),$12345678         *ORI wORId data from -(A3) to absolute address LONG WORID
*    ORI.W      -(A3),#$5555            *ORI wORId data from -(A3) to immediate data $5555
*    
*    ORI.W      $1234,D4                *ORI wORId data from $1234 to D4
*    ORI.W      $1234,A4                *ORI wORId data from $1234 to A4
*    ORI.W      $1234,(A4)              *ORI wORId data from $1234 to object in A4
*    ORI.W      $1234,(A4)+             *ORI wORId data from $1234 to object in A4 and increase pointer by 1
*    ORI.W      $1234,-(A4)             *ORI wORId data from $1234 to object in A4 after decrease pointer by 1
*    ORI.W      $1234,$1234             *ORI wORId data from $1234 to absolute address WORID
*    ORI.W      $1234,$12345678         *ORI wORId data from $1234 to absolute address LONG WORID
*    ORI.W      $1234,#$5555            *ORI wORId data from $1234 to immediate data $5555
*    
*    ORI.W      $12345678,D4            *ORI wORId data from $12345678 to D4
*    ORI.W      $12345678,A4            *ORI wORId data from $12345678 to A4
*    ORI.W      $12345678,(A4)          *ORI wORId data from $12345678 to object in A4
*    ORI.W      $12345678,(A4)+         *ORI wORId data from $12345678 to object in A4 and increase pointer by 1
*    ORI.W      $12345678,-(A4)         *ORI wORId data from $12345678 to object in A4 after decrease pointer by 1
*    ORI.W      $12345678,$1234         *ORI wORId data from $12345678 to absolute address WORID
*    ORI.W      $12345678,$12345678     *ORI wORId data from $12345678 to absolute address LONG WORID
*    ORI.W      $12345678,#$5555        *ORI wORId data from $12345678 to immediate data $5555
*    
    ORI.W      #$5555,D4               *ORI wORId data from #$5555 to D4
*    ORI.W      #$5555,A4               *ORI wORId data from #$5555 to A4
    ORI.W      #$5555,(A4)             *ORI wORId data from #$5555 to object in A4
    ORI.W      #$5555,(A4)+            *ORI wORId data from #$5555 to object in A4 and increase pointer by 1
    ORI.W      #$5555,-(A4)            *ORI wORId data from #$5555 to object in A4 after decrease pointer by 1
    ORI.W      #$5555,$1234            *ORI wORId data from #$5555 to absolute address WORID
    ORI.W      #$5555,$12345678        *ORI wORId data from #$5555 to absolute address LONG WORID
*    ORI.W      #$5555,#$5555           *ORI wORId data from #$5555 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*ORI.L
*////////////////////////////////////////////////////////////////////
*
*    ORI.L      D3,D4                   *ORI long wORId data from D3 to D4
*    ORI.L      D3,4                   *ORI long wORId data from D3 to A4
*    ORI.L      D3,(A4)                 *ORI long wORId data from D3 to object in A4
*    ORI.L      D3,(A4)+                *ORI long wORId data from D3 to object in A4 and increase pointer by 1
*    ORI.L      D3,-(A4)                *ORI long wORId data from D3 to object in A4 after decrease pointer by 1
*    ORI.L      D3,$1234                *ORI long wORId data from D3 to absolute address WORID
*    ORI.L      D3,$12345678            *ORI long wORId data from D3 to absolute address LONG WORID
*    ORI.L      D3,#$55555555           *ORI long wORId data from D3 to immediate data $55555555 
*    
*    ORI.L      A3,D4                   *ORI long wORId data from A3 to D4
*    ORI.L      A3,A4                   *ORI long wORId data from A3 to A4
*    ORI.L      A3,(A4)                 *ORI long wORId data from A3 to object in A4
*    ORI.L      A3,(A4)+                *ORI long wORId data from A3 to object in A4 and increase pointer by 1
*    ORI.L      A3,-(A4)                *ORI long wORId data from A3 to object in A4 after decrease pointer by 1
*    ORI.L      A3,$1234                *ORI long wORId data from A3 to absolute address WORID
*    ORI.L      A3,$12345678            *ORI long wORId data from A3 to absolute address LONG WORID
*    ORI.L      A3,#$55555555           *ORI long wORId data from A3 to immediate data $55555555
*    
*    ORI.L      (A3),D4                 *ORI long wORId data from (A3) to D4
*    ORI.L      (A3),A4                 *ORI long wORId data from (A3) to A4
*    ORI.L      (A3),(A4)               *ORI long wORId data from (A3) to object in A4
*    ORI.L      (A3),(A4)+              *ORI long wORId data from (A3) to object in A4 and increase pointer by 1
*    ORI.L      (A3),-(A4)              *ORI long wORId data from (A3) to object in A4 after decrease pointer by 1
*    ORI.L      (A3),$1234              *ORI long wORId data from (A3) to absolute address WORID
*    ORI.L      (A3),$12345678          *ORI long wORId data from (A3) to absolute address LONG WORID
*    ORI.L      (A3),#$55555555         *ORI long wORId data from (A3) to immediate data $55555555
*    
*    ORI.L      (A3)+,D4                *ORI long wORId data from (A3)+ to D4
*    ORI.L      (A3)+,A4                *ORI long wORId data from (A3)+ to A4
*    ORI.L      (A3)+,(A4)              *ORI long wORId data from (A3)+ to object in A4
*    ORI.L      (A3)+,(A4)+             *ORI long wORId data from (A3)+ to object in A4 and increase pointer by 1
*    ORI.L      (A3)+,-(A4)             *ORI long wORId data from (A3)+ to object in A4 after decrease pointer by 1
*    ORI.L      (A3)+,$1234             *ORI long wORId data from (A3)+ to absolute address WORID
*    ORI.L      (A3)+,$12345678         *ORI long wORId data from (A3)+ to absolute address LONG WORID
*    ORI.L      (A3)+,#$55555555        *ORI long wORId data from (A3)+ to immediate data $55555555
*    
*    ORI.L      -(A3),D4                *ORI long wORId data from -(A3) to D4
*    ORI.L      -(A3),A4                *ORI long wORId data from -(A3) to A4
*    ORI.L      -(A3),(A4)              *ORI long wORId data from -(A3) to object in A4
*    ORI.L      -(A3),(A4)+             *ORI long wORId data from -(A3) to object in A4 and increase pointer by 1
*    ORI.L      -(A3),-(A4)             *ORI long wORId data from -(A3) to object in A4 after decrease pointer by 1
*    ORI.L      -(A3),$1234             *ORI long wORId data from -(A3) to absolute address WORID
*    ORI.L      -(A3),$12345678         *ORI long wORId data from -(A3) to absolute address LONG WORID
*    ORI.L      -(A3),#$55555555        *ORI long wORId data from -(A3) to immediate data $55555555
*    
*    ORI.L      $1234,D4                *ORI long wORId data from $1234 to D4
*    ORI.L      $1234,A4                *ORI long wORId data from $1234 to A4
*    ORI.L      $1234,(A4)              *ORI long wORId data from $1234 to object in A4
*    ORI.L      $1234,(A4)+             *ORI long wORId data from $1234 to object in A4 and increase pointer by 1
*    ORI.L      $1234,-(A4)             *ORI long wORId data from $1234 to object in A4 after decrease pointer by 1
*    ORI.L      $1234,$1234             *ORI long wORId data from $1234 to absolute address WORID
*    ORI.L      $1234,$12345678         *ORI long wORId data from $1234 to absolute address LONG WORID
*    ORI.L      $1234,#$55555555        *ORI long wORId data from $1234 to immediate data $55555555
*    
*    ORI.L      $12345678,D4            *ORI long wORId data from $12345678 to D4
*    ORI.L      $12345678,A4            *ORI long wORId data from $12345678 to A4
*    ORI.L      $12345678,(A4)          *ORI long wORId data from $12345678 to object in A4
*    ORI.L      $12345678,(A4)+         *ORI long wORId data from $12345678 to object in A4 and increase pointer by 1
*    ORI.L      $12345678,-(A4)         *ORI long wORId data from $12345678 to object in A4 after decrease pointer by 1
*    ORI.L      $12345678,$1234         *ORI long wORId data from $12345678 to absolute address WORID
*    ORI.L      $12345678,$12345678     *ORI long wORId data from $12345678 to absolute address LONG WORID
*    ORI.L      $12345678,#$55555555    *ORI long wORId data from $12345678 to immediate data $55555555
*    
    ORI.L      #$55555555,D4           *ORI long wORId data from #$55555555 to D4
*    ORI.L      #$55555555,A4           *ORI long wORId data from #$55555555 to A4
    ORI.L      #$55555555,(A4)         *ORI long wORId data from #$55555555 to object in A4
    ORI.L      #$55555555,(A4)+        *ORI long wORId data from #$55555555 to object in A4 and increase pointer by 1
    ORI.L      #$55555555,-(A4)        *ORI long wORId data from #$55555555 to object in A4 after decrease pointer by 1
    ORI.L      #$55555555,$1234        *ORI long wORId data from #$55555555 to absolute address WORID
    ORI.L      #$55555555,$12345678    *ORI long wORId data from #$55555555 to absolute address LONG WORID
*    ORI.L      #$55555555,#$55555555   *ORI long wORId data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*OR
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*OR.B
*////////////////////////////////////////////////////////////////////

    OR.B      D3,D4                   *OR byte data from D3 to D4
*    OR.B      D3,A4                   *OR byte data from D3 to A4
    OR.B      D3,(A4)                 *OR byte data from D3 to object in A4
    OR.B      D3,(A4)+                *OR byte data from D3 to object in A4 and increase pointer by 1
    OR.B      D3,-(A4)                *OR byte data from D3 to object in A4 after decrease pointer by 1
    OR.B      D3,$1234                *OR byte data from D3 to absolute address WORD
    OR.B      D3,$12345678            *OR byte data from D3 to absolute address LONG WORD
*    OR.B      D3,#$55                 *OR byte data from D3 to immediate data $55                
    
*    OR.B      A3,D4                   *OR byte data from A3 to D4
*    OR.B      A3,A4                   *OR byte data from A3 to A4
*    OR.B      A3,(A4)                 *OR byte data from A3 to object in A4
*    OR.B      A3,(A4)+                *OR byte data from A3 to object in A4 and increase pointer by 1
*    OR.B      A3,-(A4)                *OR byte data from A3 to object in A4 after decrease pointer by 1
*    OR.B      A3,$1234                *OR byte data from A3 to absolute address WORD
*    OR.B      A3,$12345678            *OR byte data from A3 to absolute address LONG WORD
*    OR.B      A3,#$55                 *OR byte data from A3 to immediate data $55
    
    OR.B      (A3),D4                 *OR byte data from (A3) to D4
*    OR.B      (A3),A4                 *OR byte data from (A3) to A4
*    OR.B      (A3),(A4)               *OR byte data from (A3) to object in A4
*    OR.B      (A3),(A4)+              *OR byte data from (A3) to object in A4 and increase pointer by 1
*    OR.B      (A3),-(A4)              *OR byte data from (A3) to object in A4 after decrease pointer by 1
*    OR.B      (A3),$1234              *OR byte data from (A3) to absolute address WORD
*    OR.B      (A3),$12345678          *OR byte data from (A3) to absolute address LONG WORD
*    OR.B      (A3),#$55               *OR byte data from (A3) to immediate data $55
    
    OR.B      (A3)+,D4                *OR byte data from (A3)+ to D4
*    OR.B      (A3)+,A4                *OR byte data from (A3)+ to A4
*    OR.B      (A3)+,(A4)              *OR byte data from (A3)+ to object in A4
*    OR.B      (A3)+,(A4)+             *OR byte data from (A3)+ to object in A4 and increase pointer by 1
*    OR.B      (A3)+,-(A4)             *OR byte data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.B      (A3)+,$1234             *OR byte data from (A3)+ to absolute address WORD
*    OR.B      (A3)+,$12345678         *OR byte data from (A3)+ to absolute address LONG WORD
*    OR.B      (A3)+,#$55              *OR byte data from (A3)+ to immediate data $55
    
    OR.B      -(A3),D4                *OR byte data from -(A3) to D4
*    OR.B      -(A3),A4                *OR byte data from -(A3) to A4
*    OR.B      -(A3),(A4)              *OR byte data from -(A3) to object in A4
*    OR.B      -(A3),(A4)+             *OR byte data from -(A3) to object in A4 and increase pointer by 1
*    OR.B      -(A3),-(A4)             *OR byte data from -(A3) to object in A4 after decrease pointer by 1
*    OR.B      -(A3),$1234             *OR byte data from -(A3) to absolute address WORD
*    OR.B      -(A3),$12345678         *OR byte data from -(A3) to absolute address LONG WORD
*    OR.B      -(A3),#$55              *OR byte data from -(A3) to immediate data $55
    
    OR.B      $1234,D4                *OR byte data from $1234 to D4
*    OR.B      $1234,A4                *OR byte data from $1234 to A4
*    OR.B      $1234,(A4)              *OR byte data from $1234 to object in A4
*    OR.B      $1234,(A4)+             *OR byte data from $1234 to object in A4 and increase pointer by 1
*    OR.B      $1234,-(A4)             *OR byte data from $1234 to object in A4 after decrease pointer by 1
*    OR.B      $1234,$1234             *OR byte data from $1234 to absolute address WORD
*    OR.B      $1234,$12345678         *OR byte data from $1234 to absolute address LONG WORD
*    OR.B      $1234,#$55              *OR byte data from $1234 to immediate data $55
    
    OR.B      $12345678,D4            *OR byte data from $12345678 to D4
*    OR.B      $12345678,A4            *OR byte data from $12345678 to A4
*    OR.B      $12345678,(A4)          *OR byte data from $12345678 to object in A4
*    OR.B      $12345678,(A4)+         *OR byte data from $12345678 to object in A4 and increase pointer by 1
*    OR.B      $12345678,-(A4)         *OR byte data from $12345678 to object in A4 after decrease pointer by 1
*    OR.B      $12345678,$1234         *OR byte data from $12345678 to absolute address WORD
*    OR.B      $12345678,$12345678     *OR byte data from $12345678 to absolute address LONG WORD
*    OR.B      $12345678,#$55          *OR byte data from $12345678 to immediate data $55
    
    OR.B      #$55,D4                 *OR byte data from #$55 to D4
*    OR.B      #$55,A4                 *OR byte data from #$55 to A4
*    OR.B      #$55,(A4)               *OR byte data from #$55 to object in A4
*    OR.B      #$55,(A4)+              *OR byte data from #$55 to object in A4 and increase pointer by 1
*    OR.B      #$55,-(A4)              *OR byte data from #$55 to object in A4 after decrease pointer by 1
*    OR.B      #$55,$1234              *OR byte data from #$55 to absolute address WORD
*    OR.B      #$55,$12345678          *OR byte data from #$55 to absolute address LONG WORD
*    OR.B      #$55,#$55               *OR byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*OR.W
*////////////////////////////////////////////////////////////////////    

    OR.W      D3,D4                   *OR word data from D3 to D4
*    OR.W      D3,A4                   *OR word data from D3 to A4
    OR.W      D3,(A4)                 *OR word data from D3 to object in A4
    OR.W      D3,(A4)+                *OR word data from D3 to object in A4 and increase pointer by 1
    OR.W      D3,-(A4)                *OR word data from D3 to object in A4 after decrease pointer by 1
    OR.W      D3,$1234                *OR word data from D3 to absolute address WORD
    OR.W      D3,$12345678            *OR word data from D3 to absolute address LONG WORD
*    OR.W      D3,#$5555               *OR word data from D3 to immediate data $5555 
    
*    OR.W      A3,D4                   *OR word data from A3 to D4
*    OR.W      A3,A4                   *OR word data from A3 to A4
*    OR.W      A3,(A4)                 *OR word data from A3 to object in A4
*    OR.W      A3,(A4)+                *OR word data from A3 to object in A4 and increase pointer by 1
*    OR.W      A3,-(A4)                *OR word data from A3 to object in A4 after decrease pointer by 1
*    OR.W      A3,$1234                *OR word data from A3 to absolute address WORD
*    OR.W      A3,$12345678            *OR word data from A3 to absolute address LONG WORD
*    OR.W      A3,#$5555               *OR word data from A3 to immediate data $5555
    
    OR.W      (A3),D4                 *OR word data from (A3) to D4
*    OR.W      (A3),A4                 *OR word data from (A3) to A4
*    OR.W      (A3),(A4)               *OR word data from (A3) to object in A4
*    OR.W      (A3),(A4)+              *OR word data from (A3) to object in A4 and increase pointer by 1
*    OR.W      (A3),-(A4)              *OR word data from (A3) to object in A4 after decrease pointer by 1
*    OR.W      (A3),$1234              *OR word data from (A3) to absolute address WORD
*    OR.W      (A3),$12345678          *OR word data from (A3) to absolute address LONG WORD
*    OR.W      (A3),#$5555             *OR word data from (A3) to immediate data $5555
    
    OR.W      (A3)+,D4                *OR word data from (A3)+ to D4
*    OR.W      (A3)+,A4                *OR word data from (A3)+ to A4
*    OR.W      (A3)+,(A4)              *OR word data from (A3)+ to object in A4
*    OR.W      (A3)+,(A4)+             *OR word data from (A3)+ to object in A4 and increase pointer by 1
*    OR.W      (A3)+,-(A4)             *OR word data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.W      (A3)+,$1234             *OR word data from (A3)+ to absolute address WORD
*    OR.W      (A3)+,$12345678         *OR word data from (A3)+ to absolute address LONG WORD
*    OR.W      (A3)+,#$5555            *OR word data from (A3)+ to immediate data $5555
    
    OR.W      -(A3),D4                *OR word data from -(A3) to D4
*    OR.W      -(A3),A4                *OR word data from -(A3) to A4
*    OR.W      -(A3),(A4)              *OR word data from -(A3) to object in A4
*    OR.W      -(A3),(A4)+             *OR word data from -(A3) to object in A4 and increase pointer by 1
*    OR.W      -(A3),-(A4)             *OR word data from -(A3) to object in A4 after decrease pointer by 1
*    OR.W      -(A3),$1234             *OR word data from -(A3) to absolute address WORD
*    OR.W      -(A3),$12345678         *OR word data from -(A3) to absolute address LONG WORD
*    OR.W      -(A3),#$5555            *OR word data from -(A3) to immediate data $5555
    
    OR.W      $1234,D4                *OR word data from $1234 to D4
*    OR.W      $1234,A4                *OR word data from $1234 to A4
*    OR.W      $1234,(A4)              *OR word data from $1234 to object in A4
*    OR.W      $1234,(A4)+             *OR word data from $1234 to object in A4 and increase pointer by 1
*    OR.W      $1234,-(A4)             *OR word data from $1234 to object in A4 after decrease pointer by 1
*    OR.W      $1234,$1234             *OR word data from $1234 to absolute address WORD
*    OR.W      $1234,$12345678         *OR word data from $1234 to absolute address LONG WORD
*    OR.W      $1234,#$5555            *OR word data from $1234 to immediate data $5555
    
    OR.W      $12345678,D4            *OR word data from $12345678 to D4
*    OR.W      $12345678,A4            *OR word data from $12345678 to A4
*    OR.W      $12345678,(A4)          *OR word data from $12345678 to object in A4
*    OR.W      $12345678,(A4)+         *OR word data from $12345678 to object in A4 and increase pointer by 1
*    OR.W      $12345678,-(A4)         *OR word data from $12345678 to object in A4 after decrease pointer by 1
*    OR.W      $12345678,$1234         *OR word data from $12345678 to absolute address WORD
*    OR.W      $12345678,$12345678     *OR word data from $12345678 to absolute address LONG WORD
*    OR.W      $12345678,#$5555        *OR word data from $12345678 to immediate data $5555
    
    OR.W      #$5555,D4               *OR word data from #$5555 to D4
*    OR.W      #$5555,A4               *OR word data from #$5555 to A4
*    OR.W      #$5555,(A4)             *OR word data from #$5555 to object in A4
*    OR.W      #$5555,(A4)+            *OR word data from #$5555 to object in A4 and increase pointer by 1
*    OR.W      #$5555,-(A4)            *OR word data from #$5555 to object in A4 after decrease pointer by 1
*    OR.W      #$5555,$1234            *OR word data from #$5555 to absolute address WORD
*    OR.W      #$5555,$12345678        *OR word data from #$5555 to absolute address LONG WORD
*    OR.W      #$5555,#$5555           *OR word data from #$5555 to immediate data $5555
    
*////////////////////////////////////////////////////////////////////
*OR.L
*////////////////////////////////////////////////////////////////////

    OR.L      D3,D4                   *OR long word data from D3 to D4
    OR.L      D3,4                   *OR long word data from D3 to A4
    OR.L      D3,(A4)                 *OR long word data from D3 to object in A4
    OR.L      D3,(A4)+                *OR long word data from D3 to object in A4 and increase pointer by 1
    OR.L      D3,-(A4)                *OR long word data from D3 to object in A4 after decrease pointer by 1
    OR.L      D3,$1234                *OR long word data from D3 to absolute address WORD
    OR.L      D3,$12345678            *OR long word data from D3 to absolute address LONG WORD
*    OR.L      D3,#$55555555           *OR long word data from D3 to immediate data $55555555 
    
*    OR.L      A3,D4                   *OR long word data from A3 to D4
*    OR.L      A3,A4                   *OR long word data from A3 to A4
*    OR.L      A3,(A4)                 *OR long word data from A3 to object in A4
*    OR.L      A3,(A4)+                *OR long word data from A3 to object in A4 and increase pointer by 1
*    OR.L      A3,-(A4)                *OR long word data from A3 to object in A4 after decrease pointer by 1
*    OR.L      A3,$1234                *OR long word data from A3 to absolute address WORD
*    OR.L      A3,$12345678            *OR long word data from A3 to absolute address LONG WORD
*    OR.L      A3,#$55555555           *OR long word data from A3 to immediate data $55555555
    
    OR.L      (A3),D4                 *OR long word data from (A3) to D4
*    OR.L      (A3),A4                 *OR long word data from (A3) to A4
*    OR.L      (A3),(A4)               *OR long word data from (A3) to object in A4
*    OR.L      (A3),(A4)+              *OR long word data from (A3) to object in A4 and increase pointer by 1
*    OR.L      (A3),-(A4)              *OR long word data from (A3) to object in A4 after decrease pointer by 1
*    OR.L      (A3),$1234              *OR long word data from (A3) to absolute address WORD
*    OR.L      (A3),$12345678          *OR long word data from (A3) to absolute address LONG WORD
*    OR.L      (A3),#$55555555         *OR long word data from (A3) to immediate data $55555555
    
    OR.L      (A3)+,D4                *OR long word data from (A3)+ to D4
*    OR.L      (A3)+,A4                *OR long word data from (A3)+ to A4
*    OR.L      (A3)+,(A4)              *OR long word data from (A3)+ to object in A4
*    OR.L      (A3)+,(A4)+             *OR long word data from (A3)+ to object in A4 and increase pointer by 1
*    OR.L      (A3)+,-(A4)             *OR long word data from (A3)+ to object in A4 after decrease pointer by 1
*    OR.L      (A3)+,$1234             *OR long word data from (A3)+ to absolute address WORD
*    OR.L      (A3)+,$12345678         *OR long word data from (A3)+ to absolute address LONG WORD
*    OR.L      (A3)+,#$55555555        *OR long word data from (A3)+ to immediate data $55555555
    
    OR.L      -(A3),D4                *OR long word data from -(A3) to D4
*    OR.L      -(A3),A4                *OR long word data from -(A3) to A4
*    OR.L      -(A3),(A4)              *OR long word data from -(A3) to object in A4
*    OR.L      -(A3),(A4)+             *OR long word data from -(A3) to object in A4 and increase pointer by 1
*    OR.L      -(A3),-(A4)             *OR long word data from -(A3) to object in A4 after decrease pointer by 1
*    OR.L      -(A3),$1234             *OR long word data from -(A3) to absolute address WORD
*    OR.L      -(A3),$12345678         *OR long word data from -(A3) to absolute address LONG WORD
*    OR.L      -(A3),#$55555555        *OR long word data from -(A3) to immediate data $55555555
    
    OR.L      $1234,D4                *OR long word data from $1234 to D4
*    OR.L      $1234,A4                *OR long word data from $1234 to A4
*    OR.L      $1234,(A4)              *OR long word data from $1234 to object in A4
*    OR.L      $1234,(A4)+             *OR long word data from $1234 to object in A4 and increase pointer by 1
*    OR.L      $1234,-(A4)             *OR long word data from $1234 to object in A4 after decrease pointer by 1
*    OR.L      $1234,$1234             *OR long word data from $1234 to absolute address WORD
*    OR.L      $1234,$12345678         *OR long word data from $1234 to absolute address LONG WORD
*    OR.L      $1234,#$55555555        *OR long word data from $1234 to immediate data $55555555
    
    OR.L      $12345678,D4            *OR long word data from $12345678 to D4
*    OR.L      $12345678,A4            *OR long word data from $12345678 to A4
*    OR.L      $12345678,(A4)          *OR long word data from $12345678 to object in A4
*    OR.L      $12345678,(A4)+         *OR long word data from $12345678 to object in A4 and increase pointer by 1
*    OR.L      $12345678,-(A4)         *OR long word data from $12345678 to object in A4 after decrease pointer by 1
*    OR.L      $12345678,$1234         *OR long word data from $12345678 to absolute address WORD
*    OR.L      $12345678,$12345678     *OR long word data from $12345678 to absolute address LONG WORD
*    OR.L      $12345678,#$55555555    *OR long word data from $12345678 to immediate data $55555555
    
    OR.L      #$55555555,D4           *OR long word data from #$55555555 to D4
*    OR.L      #$55555555,A4           *OR long word data from #$55555555 to A4
*    OR.L      #$55555555,(A4)         *OR long word data from #$55555555 to object in A4
*    OR.L      #$55555555,(A4)+        *OR long word data from #$55555555 to object in A4 and increase pointer by 1
*    OR.L      #$55555555,-(A4)        *OR long word data from #$55555555 to object in A4 after decrease pointer by 1
*    OR.L      #$55555555,$1234        *OR long word data from #$55555555 to absolute address WORD
*    OR.L      #$55555555,$12345678    *OR long word data from #$55555555 to absolute address LONG WORD
*    OR.L      #$55555555,#$55555555   *OR long word data from #$55555555 to immediate data $55555555

*********************************************************************
*********************************************************************
*
*NEG
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*NEG.B
*////////////////////////////////////////////////////////////////////

    NEG.B      D3                      *NEG byte data from D3            
    NEG.B      (A3)                    *NEG immediate address A3
    NEG.B      (A3)+                   *NEG immediate post increment A3
    NEG.B      -(A3)                   *NEG immediate post decrement A3
    NEG.B      $1234                   *NEG word address 1234
    NEG.B      $12345678               *NEG long word address 12345678

*////////////////////////////////////////////////////////////////////
*NEG.W
*////////////////////////////////////////////////////////////////////    

    NEG.W      D3                      *NEG byte data from D3            
    NEG.W      (A3)                    *NEG immediate address A3
    NEG.W      (A3)+                   *NEG immediate post increment A3
    NEG.W      -(A3)                   *NEG immediate post decrement A3
    NEG.W      $1234                   *NEG word address 1234
    NEG.W      $12345678               *NEG long word address 12345678
    
*////////////////////////////////////////////////////////////////////
*NEG.L
*////////////////////////////////////////////////////////////////////

    NEG.L      D3                      *NEG byte data from D3            
    NEG.L      (A3)                    *NEG immediate address A3
    NEG.L      (A3)+                   *NEG immediate post increment A3
    NEG.L      -(A3)                   *NEG immediate post decrement A3
    NEG.L      $1234                   *NEG word address 1234
    NEG.L      $12345678               *NEG long word address 12345678

*********************************************************************
*********************************************************************
*
*EOR
*
*********************************************************************
*********************************************************************

*////////////////////////////////////////////////////////////////////
*EOR.B
*////////////////////////////////////////////////////////////////////

    EOR.B      D3,D4                   *EOR byte data from D3 to D4
    *EOR.B      D3,A4                   *EOR byte data from D3 to A4
    EOR.B      D3,(A4)                 *EOR byte data from D3 to object in A4
    EOR.B      D3,(A4)+                *EOR byte data from D3 to object in A4 and increase pointer by 1
    EOR.B      D3,-(A4)                *EOR byte data from D3 to object in A4 after decrease pointer by 1
    EOR.B      D3,$1234                *EOR byte data from D3 to absolute address WEORD
    EOR.B      D3,$12345678            *EOR byte data from D3 to absolute address LONG WEORD
*    EOR.B      D3,#$55                 *EOR byte data from D3 to immediate data $55                
    
*    EOR.B      A3,D4                   *EOR byte data from A3 to D4
*    EOR.B      A3,A4                   *EOR byte data from A3 to A4
*    EOR.B      A3,(A4)                 *EOR byte data from A3 to object in A4
*    EOR.B      A3,(A4)+                *EOR byte data from A3 to object in A4 and increase pointer by 1
*    EOR.B      A3,-(A4)                *EOR byte data from A3 to object in A4 after decrease pointer by 1
*    EOR.B      A3,$1234                *EOR byte data from A3 to absolute address WEORD
*    EOR.B      A3,$12345678            *EOR byte data from A3 to absolute address LONG WEORD
*    EOR.B      A3,#$55                 *EOR byte data from A3 to immediate data $55
*    
*    EOR.B      (A3),D4                 *EOR byte data from (A3) to D4
*    EOR.B      (A3),A4                 *EOR byte data from (A3) to A4
*    EOR.B      (A3),(A4)               *EOR byte data from (A3) to object in A4
*    EOR.B      (A3),(A4)+              *EOR byte data from (A3) to object in A4 and increase pointer by 1
*    EOR.B      (A3),-(A4)              *EOR byte data from (A3) to object in A4 after decrease pointer by 1
*    EOR.B      (A3),$1234              *EOR byte data from (A3) to absolute address WEORD
*    EOR.B      (A3),$12345678          *EOR byte data from (A3) to absolute address LONG WEORD
*    EOR.B      (A3),#$55               *EOR byte data from (A3) to immediate data $55
*    
*    EOR.B      (A3)+,D4                *EOR byte data from (A3)+ to D4
*    EOR.B      (A3)+,A4                *EOR byte data from (A3)+ to A4
*    EOR.B      (A3)+,(A4)              *EOR byte data from (A3)+ to object in A4
*    EOR.B      (A3)+,(A4)+             *EOR byte data from (A3)+ to object in A4 and increase pointer by 1
*    EOR.B      (A3)+,-(A4)             *EOR byte data from (A3)+ to object in A4 after decrease pointer by 1
*    EOR.B      (A3)+,$1234             *EOR byte data from (A3)+ to absolute address WEORD
*    EOR.B      (A3)+,$12345678         *EOR byte data from (A3)+ to absolute address LONG WEORD
*    EOR.B      (A3)+,#$55              *EOR byte data from (A3)+ to immediate data $55
*    
*    EOR.B      -(A3),D4                *EOR byte data from -(A3) to D4
*    EOR.B      -(A3),A4                *EOR byte data from -(A3) to A4
*    EOR.B      -(A3),(A4)              *EOR byte data from -(A3) to object in A4
*    EOR.B      -(A3),(A4)+             *EOR byte data from -(A3) to object in A4 and increase pointer by 1
*    EOR.B      -(A3),-(A4)             *EOR byte data from -(A3) to object in A4 after decrease pointer by 1
*    EOR.B      -(A3),$1234             *EOR byte data from -(A3) to absolute address WEORD
*    EOR.B      -(A3),$12345678         *EOR byte data from -(A3) to absolute address LONG WEORD
*    EOR.B      -(A3),#$55              *EOR byte data from -(A3) to immediate data $55
*    
 *    EOR.B      $1234,D4                *EOR byte data from $1234 to D4
*    EOR.B      $1234,A4                *EOR byte data from $1234 to A4
*    EOR.B      $1234,(A4)              *EOR byte data from $1234 to object in A4
*    EOR.B      $1234,(A4)+             *EOR byte data from $1234 to object in A4 and increase pointer by 1
*    EOR.B      $1234,-(A4)             *EOR byte data from $1234 to object in A4 after decrease pointer by 1
*    EOR.B      $1234,$1234             *EOR byte data from $1234 to absolute address WEORD
*    EOR.B      $1234,$12345678         *EOR byte data from $1234 to absolute address LONG WEORD
*    EOR.B      $1234,#$55              *EOR byte data from $1234 to immediate data $55
*    
*    EOR.B      $12345678,D4            *EOR byte data from $12345678 to D4
*    EOR.B      $12345678,A4            *EOR byte data from $12345678 to A4
*    EOR.B      $12345678,(A4)          *EOR byte data from $12345678 to object in A4
*    EOR.B      $12345678,(A4)+         *EOR byte data from $12345678 to object in A4 and increase pointer by 1
*    EOR.B      $12345678,-(A4)         *EOR byte data from $12345678 to object in A4 after decrease pointer by 1
*    EOR.B      $12345678,$1234         *EOR byte data from $12345678 to absolute address WEORD
*    EOR.B      $12345678,$12345678     *EOR byte data from $12345678 to absolute address LONG WEORD
*    EOR.B      $12345678,#$55          *EOR byte data from $12345678 to immediate data $55
*    
*    EOR.B      #$55,D4                 *EOR byte data from #$55 to D4
*    EOR.B      #$55,A4                 *EOR byte data from #$55 to A4
*    EOR.B      #$55,(A4)               *EOR byte data from #$55 to object in A4
*    EOR.B      #$55,(A4)+              *EOR byte data from #$55 to object in A4 and increase pointer by 1
*    EOR.B      #$55,-(A4)              *EOR byte data from #$55 to object in A4 after decrease pointer by 1
*    EOR.B      #$55,$1234              *EOR byte data from #$55 to absolute address WEORD
*    EOR.B      #$55,$12345678          *EOR byte data from #$55 to absolute address LONG WEORD
*    EOR.B      #$55,#$55               *EOR byte data from #$55 to immediate data $55

*////////////////////////////////////////////////////////////////////
*EOR.W
*////////////////////////////////////////////////////////////////////    

    EOR.W      D3,D4                   *EOR wEORd data from D3 to D4
*    EOR.W      D3,A4                   *EOR wEORd data from D3 to A4
    EOR.W      D3,(A4)                 *EOR wEORd data from D3 to object in A4
    EOR.W      D3,(A4)+                *EOR wEORd data from D3 to object in A4 and increase pointer by 1
    EOR.W      D3,-(A4)                *EOR wEORd data from D3 to object in A4 after decrease pointer by 1
    EOR.W      D3,$1234                *EOR wEORd data from D3 to absolute address WEORD
    EOR.W      D3,$12345678            *EOR wEORd data from D3 to absolute address LONG WEORD
*    EOR.W      D3,#$5555               *EOR wEORd data from D3 to immediate data $5555 
*    
*    EOR.W      A3,D4                   *EOR wEORd data from A3 to D4
*    EOR.W      A3,A4                   *EOR wEORd data from A3 to A4
*    EOR.W      A3,(A4)                 *EOR wEORd data from A3 to object in A4
*    EOR.W      A3,(A4)+                *EOR wEORd data from A3 to object in A4 and increase pointer by 1
*    EOR.W      A3,-(A4)                *EOR wEORd data from A3 to object in A4 after decrease pointer by 1
*    EOR.W      A3,$1234                *EOR wEORd data from A3 to absolute address WEORD
*    EOR.W      A3,$12345678            *EOR wEORd data from A3 to absolute address LONG WEORD
*    EOR.W      A3,#$5555               *EOR wEORd data from A3 to immediate data $5555
*    
*    EOR.W      (A3),D4                 *EOR wEORd data from (A3) to D4
*    EOR.W      (A3),A4                 *EOR wEORd data from (A3) to A4
*    EOR.W      (A3),(A4)               *EOR wEORd data from (A3) to object in A4
*    EOR.W      (A3),(A4)+              *EOR wEORd data from (A3) to object in A4 and increase pointer by 1
*    EOR.W      (A3),-(A4)              *EOR wEORd data from (A3) to object in A4 after decrease pointer by 1
*    EOR.W      (A3),$1234              *EOR wEORd data from (A3) to absolute address WEORD
*    EOR.W      (A3),$12345678          *EOR wEORd data from (A3) to absolute address LONG WEORD
*    EOR.W      (A3),#$5555             *EOR wEORd data from (A3) to immediate data $5555
*    
*    EOR.W      (A3)+,D4                *EOR wEORd data from (A3)+ to D4
*    EOR.W      (A3)+,A4                *EOR wEORd data from (A3)+ to A4
*    EOR.W      (A3)+,(A4)              *EOR wEORd data from (A3)+ to object in A4
*    EOR.W      (A3)+,(A4)+             *EOR wEORd data from (A3)+ to object in A4 and increase pointer by 1
*    EOR.W      (A3)+,-(A4)             *EOR wEORd data from (A3)+ to object in A4 after decrease pointer by 1
*    EOR.W      (A3)+,$1234             *EOR wEORd data from (A3)+ to absolute address WEORD
*    EOR.W      (A3)+,$12345678         *EOR wEORd data from (A3)+ to absolute address LONG WEORD
*    EOR.W      (A3)+,#$5555            *EOR wEORd data from (A3)+ to immediate data $5555
*    
*    EOR.W      -(A3),D4                *EOR wEORd data from -(A3) to D4
*    EOR.W      -(A3),A4                *EOR wEORd data from -(A3) to A4
*    EOR.W      -(A3),(A4)              *EOR wEORd data from -(A3) to object in A4
*    EOR.W      -(A3),(A4)+             *EOR wEORd data from -(A3) to object in A4 and increase pointer by 1
*    EOR.W      -(A3),-(A4)             *EOR wEORd data from -(A3) to object in A4 after decrease pointer by 1
*    EOR.W      -(A3),$1234             *EOR wEORd data from -(A3) to absolute address WEORD
*    EOR.W      -(A3),$12345678         *EOR wEORd data from -(A3) to absolute address LONG WEORD
*    EOR.W      -(A3),#$5555            *EOR wEORd data from -(A3) to immediate data $5555
*    
*    EOR.W      $1234,D4                *EOR wEORd data from $1234 to D4
*    EOR.W      $1234,A4                *EOR wEORd data from $1234 to A4
*    EOR.W      $1234,(A4)              *EOR wEORd data from $1234 to object in A4
*    EOR.W      $1234,(A4)+             *EOR wEORd data from $1234 to object in A4 and increase pointer by 1
*    EOR.W      $1234,-(A4)             *EOR wEORd data from $1234 to object in A4 after decrease pointer by 1
*    EOR.W      $1234,$1234             *EOR wEORd data from $1234 to absolute address WEORD
*    EOR.W      $1234,$12345678         *EOR wEORd data from $1234 to absolute address LONG WEORD
*    EOR.W      $1234,#$5555            *EOR wEORd data from $1234 to immediate data $5555
*    
*    EOR.W      $12345678,D4            *EOR wEORd data from $12345678 to D4
*    EOR.W      $12345678,A4            *EOR wEORd data from $12345678 to A4
*    EOR.W      $12345678,(A4)          *EOR wEORd data from $12345678 to object in A4
*    EOR.W      $12345678,(A4)+         *EOR wEORd data from $12345678 to object in A4 and increase pointer by 1
*    EOR.W      $12345678,-(A4)         *EOR wEORd data from $12345678 to object in A4 after decrease pointer by 1
*    EOR.W      $12345678,$1234         *EOR wEORd data from $12345678 to absolute address WEORD
*    EOR.W      $12345678,$12345678     *EOR wEORd data from $12345678 to absolute address LONG WEORD
*    EOR.W      $12345678,#$5555        *EOR wEORd data from $12345678 to immediate data $5555
*    
*    EOR.W      #$5555,D4               *EOR wEORd data from #$5555 to D4
*    EOR.W      #$5555,A4               *EOR wEORd data from #$5555 to A4
*    EOR.W      #$5555,(A4)             *EOR wEORd data from #$5555 to object in A4
*    EOR.W      #$5555,(A4)+            *EOR wEORd data from #$5555 to object in A4 and increase pointer by 1
*    EOR.W      #$5555,-(A4)            *EOR wEORd data from #$5555 to object in A4 after decrease pointer by 1
*    EOR.W      #$5555,$1234            *EOR wEORd data from #$5555 to absolute address WEORD
*    EOR.W      #$5555,$12345678        *EOR wEORd data from #$5555 to absolute address LONG WEORD
*    EOR.W      #$5555,#$5555           *EOR wEORd data from #$5555 to immediate data $5555
*    
**********************************************************************
**
**BCC, BRA, JSR, RTS
**
**********************************************************************
**********************************************************************
    

leave
    
* Put variables and constants here

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
