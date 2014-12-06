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
                MOVE.L      #$00000000,A0
                MOVE.L      #$00000000,A1
                MOVE.L      #$00000000,A2
                MOVE.L      #$00000000,A3
                MOVE.L      #$00000000,A4
                MOVE.L      #$00000000,A5
                MOVE.L      #$00000000,A6
                MOVE.L      #$00000000,A7       ; clear all address registers
                * For testing  
                ******************************* BRA TESTING *************************** 6000 - 603A
                MOVE.W      #$6055, $6000       BRA A+55
                MOVE.W      #$6000, $6002       BRA A+5555
                MOVE.W      #$5555, $6004       5555 following
                MOVE.W      #$60FF, $6006       BRA A+55555555
                MOVE.W      #$5555, $6008
                MOVE.W      #$5555, $600A       55555555 following
                
                MOVE.W      #$6555, $600C       BCS A+55
                MOVE.W      #$6500, $600E       BCS A+5555
                MOVE.W      #$5555, $6010       5555 following
                MOVE.W      #$65FF, $6012       BCS A+55555555
                MOVE.W      #$5555, $6014
                MOVE.W      #$5555, $6016       55555555 following
                
                MOVE.W      #$6C55, $6018       BGE A+55
                MOVE.W      #$6C00, $601A       BGE A+5555
                MOVE.W      #$5555, $601C       5555 following
                MOVE.W      #$6CFF, $601E       BGE A+55555555
                MOVE.W      #$5555, $6020
                MOVE.W      #$5555, $6022       55555555 following
                
                MOVE.W      #$6D55, $6024       BLT A+55
                MOVE.W      #$6D00, $6026       BLT A+5555
                MOVE.W      #$5555, $6028       5555 following
                MOVE.W      #$6DFF, $602A       BLT A+55555555
                MOVE.W      #$5555, $602C
                MOVE.W      #$5555, $602E       55555555 following
                
                MOVE.W      #$6855, $6030       BVC A+55
                MOVE.W      #$6800, $6032       BVC A+5555
                MOVE.W      #$5555, $6034       5555 following
                MOVE.W      #$68FF, $6036       BVC A+55555555
                MOVE.W      #$5555, $6038
                MOVE.W      #$5555, $603A       55555555 following
                ***********************************************************************

                *********************NEG TESTING************************ 603C - 6076
                MOVE.W      #$4401, $603C       NEG.B D1
                MOVE.W      #$4441, $603E       NEG.W D1
                MOVE.W      #$4481, $6040       NEG.L D1
                
                MOVE.W      #$4409, $6042       DATA (mode 1)
                MOVE.W      #$4449, $6044       DATA (mode 1)
                MOVE.W      #$4489, $6046       DATA (mode 1)
                
                MOVE.W      #$4411, $6048       NEG.B (A1)
                MOVE.W      #$4451, $604A       NEG.W (A1)
                MOVE.W      #$4491, $604C       NEG.L (A1)
              
                MOVE.W      #$4419, $604E       NEG.B (A1)+
                MOVE.W      #$4459, $6050       NEG.W (A1)+
                MOVE.W      #$4499, $6052       NEG.L (A1)+
                
                MOVE.W      #$4421, $6054       NEG.B -(A1)
                MOVE.W      #$4461, $6056       NEG.W -(A1)
                MOVE.W      #$44A1, $6058       NEG.L -(A1)
               
                MOVE.W      #$4438, $605A       NEG.B $AAAA 
                MOVE.W      #$AAAA, $605C
                MOVE.W      #$4478, $605E       NEG.W $AAAA
                MOVE.W      #$AAAA, $6060
                MOVE.W      #$44B8, $6062       NEG.L $AAAA
                MOVE.W      #$AAAA, $6064
                
                MOVE.W      #$4439, $6066       NEG.B $AAAAAAAA
                MOVE.W      #$AAAA, $6068
                MOVE.W      #$AAAA, $606A
                MOVE.W      #$4479, $606C       NEG.W $AAAAAAAA
                MOVE.W      #$AAAA, $606E
                MOVE.W      #$AAAA, $6070
                MOVE.W      #$44B9, $6072       NEG.L $AAAAAAAA
                MOVE.W      #$AAAA, $6074
                MOVE.W      #$AAAA, $6076
                ********************************************************
                
                *** 60A4 TO 6114 EMPTY IN MEMORY - OPEN FOR TESTING ***
                ************************** OR TESTING ************************ 6078 - 611E
                ** EA Source ** .B
                MOVE.W      #$8A03, $6078       OR.B D3,D5
                MOVE.W      #$8A0B, $607A       OR.B A3,D5 ---- INVALID, DATA
                MOVE.W      #$8A13, $607C       OR.B (A3),D5
                MOVE.W      #$8A1B, $607E       OR.B (A3)+,D5
                MOVE.W      #$8A23, $6080       OR.B -(A3),D5
                MOVE.W      #$8A2B, $6082       OR.B (D16,AN) ?
                MOVE.W      #$8A33, $6084       OR.B (D8,AN,XN) ?
                MOVE.W      #$8A38, $6086
                MOVE.W      #$AAAA, $6088       OR.B #$AAAA,D5
                MOVE.W      #$8A39, $608A
                MOVE.W      #$AAAA, $608C       OR.B #$AAAAAAAA,D5
                MOVE.W      #$AAAA, $608E
                MOVE.W      #$8A3C, $6090
                MOVE.W      #$ABCD, $6092       OR.B #$ABCD,D5 ...???                
                
                ** EA Destination ** .B
                MOVE.W      #$8A03, $6094       OR.B D5,D3 ---- INVALID, DATA
                MOVE.W      #$8B0B, $6096       OR.B D5,A3 ---- INVALID, DATA
                MOVE.W      #$8B13, $6098       OR.B D5,(A3)
                MOVE.W      #$8B1B, $609A       OR.B D5,(A3)+
                MOVE.W      #$8B23, $609C       OR.B D5,-(A3)
                MOVE.W      #$8B2B, $609E       OR.B (D16,AN) ?
                MOVE.W      #$8B33, $60A0       OR.B (D8,AN,XN) ?
                MOVE.W      #$8B38, $60A2
                MOVE.W      #$AAAA, $60A4       OR.B D5,#$AAAA
                MOVE.W      #$8B39, $60A6
                MOVE.W      #$AAAA, $60A8       OR.B D5,#$AAAAAAAA
                MOVE.W      #$AAAA, $60AA
                MOVE.W      #$8B3C, $60AC
                MOVE.W      #$ABCD, $60AE       OR.B D5,#$ABCD ---- INVALID, DATA
                
                ** EA Source ** .W
                MOVE.W      #$8A43, $60B0       OR.W D3,D5
                MOVE.W      #$8A4B, $60B2       OR.W A3,D5 ---- INVALID, DATA
                MOVE.W      #$8A53, $60B4       OR.W (A3),D5
                MOVE.W      #$8A5B, $60B6       OR.W (A3)+,D5
                MOVE.W      #$8A63, $60B8       OR.W -(A3),D5
                MOVE.W      #$8A6B, $60BA       OR.W (D16,AN) ?
                MOVE.W      #$8A73, $60BC       OR.W (D8,AN,XN) ?
                MOVE.W      #$8A78, $60BE
                MOVE.W      #$AAAA, $60C0       OR.W #$AAAA,D5
                MOVE.W      #$8A79, $60C2
                MOVE.W      #$AAAA, $60C4       OR.W #$AAAAAAAA,D5
                MOVE.W      #$AAAA, $60C6
                MOVE.W      #$8A7C, $60C8
                MOVE.W      #$ABCD, $60CA       OR.W #$ABCD,D5 ...???                
                
                ** EA Destination ** .W
                MOVE.W      #$8B43, $60CC       OR.W D5,D3 ---- INVALID, DATA
                MOVE.W      #$8B4B, $60CE       OR.W D5,A3 ---- INVALID, DATA
                MOVE.W      #$8B53, $60D0       OR.W D5,(A3)
                MOVE.W      #$8B5B, $60D2       OR.W D5,(A3)+
                MOVE.W      #$8B63, $60D4       OR.W D5,-(A3)
                MOVE.W      #$8B6B, $60D6       OR.W (D16,AN) ?
                MOVE.W      #$8B73, $60D8       OR.W (D8,AN,XN) ?
                MOVE.W      #$8B78, $60DA
                MOVE.W      #$AAAA, $60DC       OR.W D5,#$AAAA
                MOVE.W      #$8B79, $60DE
                MOVE.W      #$AAAA, $60E0       OR.W D5,#$AAAAAAAA
                MOVE.W      #$AAAA, $60E2
                MOVE.W      #$8B7C, $60E4
                MOVE.W      #$ABCD, $60E6       OR.W D5,#$ABCD ---- INVALID, DATA
                
                ** EA Source ** .L
                MOVE.W      #$8A83, $60E8       OR.W D3,D5
                MOVE.W      #$8A8B, $60EA       OR.W A3,D5 ---- INVALID, DATA
                MOVE.W      #$8A93, $60EC       OR.W (A3),D5
                MOVE.W      #$8A9B, $60EE       OR.W (A3)+,D5
                MOVE.W      #$8AA3, $60F0       OR.W -(A3),D5
                MOVE.W      #$8AAB, $60F2       OR.W (D16,AN) ?
                MOVE.W      #$8AB3, $60F4       OR.W (D8,AN,XN) ?
                MOVE.W      #$8AB8, $60F6
                MOVE.W      #$AAAA, $60F8       OR.W #$AAAA,D5
                MOVE.W      #$8AB9, $60FA
                MOVE.W      #$AAAA, $60FC       OR.W #$AAAAAAAA,D5
                MOVE.W      #$AAAA, $60FE
                MOVE.W      #$8ABC, $6100
                MOVE.W      #$ABCD, $6102       OR.W #$ABCD,D5 ...???                
                
                ** EA Destination ** .L
                MOVE.W      #$8B83, $6104       OR.W D5,D3 ---- INVALID, DATA
                MOVE.W      #$8B8B, $6106       OR.W D5,A3 ---- INVALID, DATA
                MOVE.W      #$8B93, $6108       OR.W D5,(A3)
                MOVE.W      #$8B9B, $610A       OR.W D5,(A3)+
                MOVE.W      #$8BA3, $610C       OR.W D5,-(A3)
                MOVE.W      #$8BAB, $610E       OR.W (D16,AN) ?
                MOVE.W      #$8BB3, $6110       OR.W (D8,AN,XN) ?
                MOVE.W      #$8BB8, $6112
                MOVE.W      #$AAAA, $6114   OR.W D5,#$AAAA
                MOVE.W      #$8BB9, $6116
                MOVE.W      #$AAAA, $6118   OR.W D5,#$AAAAAAAA
                MOVE.W      #$AAAA, $611A
                MOVE.W      #$8BBC, $611C
                MOVE.W      #$ABCD, $611E   OR.W D5,#$ABCD ---- INVALID, DATA
                *****************************************************************
                
                **********************LSL/LSR TESTING******************* 6120 - 6166
                *** NO EA ***
                * LSL COUNT *
                MOVE.W      #$E70D, $6120       LSL.B #3,D5
                MOVE.W      #$E74D, $6122       LSL.W #3,D5
                MOVE.W      #$E78D, $6124       LSL.L #3,D5
                * LSL REGISTER *
                MOVE.W      #$E72D, $6126       LSL.B D3,D5
                MOVE.W      #$E76D, $6128       LSL.W D3,D5
                MOVE.W      #$E7AD, $612A       LSL.L D3,D5
                * LSR COUNT *
                MOVE.W      #$E60D, $612C       LSR.B #3,D5
                MOVE.W      #$E64D, $612E       LSR.W #3,D5
                MOVE.W      #$E68D, $6130       LSR.L #3,D5
                * LSR REGISTER *
                MOVE.W      #$E62D, $6132       LSR.B D3,D5
                MOVE.W      #$E66D, $6134       LSR.W D3,D5
                MOVE.W      #$E6AD, $6136       LSR.L D3,D5
                
                *** EA MODES ***
                * LSR Dn * -- INVALID
                MOVE.W      #$E2C5, $6138
                * LSL Dn * -- INVALID
                MOVE.W      #$E3C5, $613A
                * LSR An * -- INVALID
                MOVE.W      #$E2CD, $613C
                * LSL An * -- INVALID
                MOVE.W      #$E3CD, $613E
                * LSR (An) *
                MOVE.W      #$E2D5, $6140
                * LSL (An) *
                MOVE.W      #$E3D5, $6142
                * LSR (An)+ *
                MOVE.W      #$E2DD, $6144
                * LSL (An)+ *
                MOVE.W      #$E3DD, $6146
                * LSR -(An) *
                MOVE.W      #$E2E5, $6148
                * LSL -(An) *
                MOVE.W      #$E3E5, $614A
                * LSR (d16,An) *
                MOVE.W      #$E2ED, $614C
                * LSL (d16,An) *
                MOVE.W      #$E3ED, $614E
                * LSR (d8,An,Xn) *
                MOVE.W      #$E2F5, $6150
                * LSL (d8,An,Xn) *
                MOVE.W      #$E3F5, $6152
                * LSR (xxx).W *
                MOVE.W      #$E2F8, $6154
                MOVE.W      #$AAAA, $6156
                * LSL (xxx).W *
                MOVE.W      #$E3F8, $6158
                MOVE.W      #$AAAA, $615A
                * LSR (xxx).L *
                MOVE.W      #$E2F9, $615C
                MOVE.W      #$AAAA, $615E
                MOVE.W      #$AAAA, $6160
                * LSL (xxx).L *
                MOVE.W      #$E3F9, $6162
                MOVE.W      #$AAAA, $6164
                MOVE.W      #$AAAA, $6166

                *******************************************************
                
                **********************ASL/ASR TESTING******************* 6168 - 61AE
                *** NO EA ***
                * ASL COUNT *
                MOVE.W      #$E705, $6168       ASL.B #3,D5
                MOVE.W      #$E745, $616A       ASL.W #3,D5
                MOVE.W      #$E785, $616C       ASL.L #3,D5
                * ASL REGISTER *
                MOVE.W      #$E725, $616E       ASL.B D3,D5
                MOVE.W      #$E765, $6170       ASL.W D3,D5
                MOVE.W      #$E7A5, $6172       ASL.L D3,D5
                * ASR COUNT *
                MOVE.W      #$E605, $6174       ASR.B #3,D5
                MOVE.W      #$E645, $6176       ASR.W #3,D5
                MOVE.W      #$E685, $6178       ASR.L #3,D5
                * ASR REGISTER *
                MOVE.W      #$E625, $617A       ASR.B D3,D5
                MOVE.W      #$E665, $617C       ASR.W D3,D5
                MOVE.W      #$E6A5, $617E       ASR.L D3,D5
                
                *** EA MODES ***
                * ASR Dn * -- INVALID
                MOVE.W      #$E0C5, $6180
                * ASL Dn * -- INVALID
                MOVE.W      #$E1C5, $6182
                * ASR An * -- INVALID
                MOVE.W      #$E0CD, $6184
                * ASL An * -- INVALID
                MOVE.W      #$E1CD, $6186
                * ASR (An) *
                MOVE.W      #$E0D5, $6188
                * ASL (An) *
                MOVE.W      #$E1D5, $618A
                * ASR (An)+ *
                MOVE.W      #$E0DD, $618C
                * ASL (An)+ *
                MOVE.W      #$E1DD, $618E
                * ASR -(An) *
                MOVE.W      #$E0E5, $6190
                * ASL -(An) *
                MOVE.W      #$E1E5, $6192
                * ASR (d16,An) *
                MOVE.W      #$E0ED, $6194
                * ASL (d16,An) *
                MOVE.W      #$E1ED, $6196
                * ASR (d8,An,Xn) *
                MOVE.W      #$E0F5, $6198
                * ASL (d8,An,Xn) *
                MOVE.W      #$E1F5, $619A
                * ASR (xxx).W *
                MOVE.W      #$E0F8, $619C
                MOVE.W      #$AAAA, $619E
                * ASL (xxx).W *
                MOVE.W      #$E1F8, $61A0
                MOVE.W      #$AAAA, $61A2
                * ASR (xxx).L *
                MOVE.W      #$E0F9, $61A4
                MOVE.W      #$AAAA, $61A6
                MOVE.W      #$AAAA, $61A8
                * ASL (xxx).L *
                MOVE.W      #$E1F9, $61AA
                MOVE.W      #$AAAA, $61AC
                MOVE.W      #$AAAA, $61AE
                *******************************************************
                
                **********************ROL/ROR TESTING******************* 61B0 - 61F6
                *** NO EA ***
                * ROL COUNT *
                MOVE.W      #$E71D, $61B0       ROL.B #3,D5
                MOVE.W      #$E75D, $61B2       ROL.W #3,D5
                MOVE.W      #$E79D, $61B4       ROL.L #3,D5
                * ROL REGISTER *
                MOVE.W      #$E73D, $61B6       ROL.B D3,D5
                MOVE.W      #$E77D, $61B8       ROL.W D3,D5
                MOVE.W      #$E7BD, $61BA       ROL.L D3,D5
                * ROR COUNT *
                MOVE.W      #$E61D, $61BC       ROR.B #3,D5
                MOVE.W      #$E65D, $61BE       ROR.W #3,D5
                MOVE.W      #$E69D, $61C0       ROR.L #3,D5
                * ROR REGISTER *
                MOVE.W      #$E63D, $61C2       ROR.B D3,D5
                MOVE.W      #$E67D, $61C4       ROR.W D3,D5
                MOVE.W      #$E6BD, $61C6       ROR.L D3,D5
                
                *** EA MODES ***
                * ROR Dn * -- INVALID
                MOVE.W      #$E6C5, $61C8
                * ROL Dn * -- INVALID
                MOVE.W      #$E7C5, $61CA
                * ROR An * -- INVALID
                MOVE.W      #$E6CD, $61CC
                * ROL An * -- INVALID
                MOVE.W      #$E7CD, $61CE
                * ROR (An) *
                MOVE.W      #$E6D5, $61D0
                * ROL (An) *
                MOVE.W      #$E7D5, $61D2
                * ROR (An)+ *
                MOVE.W      #$E6DD, $61D4
                * ROL (An)+ *
                MOVE.W      #$E7DD, $61D6
                * ROR -(An) *
                MOVE.W      #$E6E5, $61D8
                * ROL -(An) *
                MOVE.W      #$E7E5, $61DA
                * ROR (d16,An) *
                MOVE.W      #$E6ED, $61DC
                * ROL (d16,An) *
                MOVE.W      #$E7ED, $61DE
                * ROR (d8,An,Xn) *
                MOVE.W      #$E6F5, $61E0
                * ROL (d8,An,Xn) *
                MOVE.W      #$E7F5, $61E2
                * ROR (xxx).W *
                MOVE.W      #$E6F8, $61E4
                MOVE.W      #$AAAA, $61E6
                * ROL (xxx).W *
                MOVE.W      #$E7F8, $61E8
                MOVE.W      #$AAAA, $61EA
                * ROR (xxx).L *
                MOVE.W      #$E6F9, $61EC
                MOVE.W      #$AAAA, $61EE
                MOVE.W      #$AAAA, $61F0
                * ROL (xxx).L *
                MOVE.W      #$E7F9, $61F2
                MOVE.W      #$AAAA, $61F4
                MOVE.W      #$AAAA, $61F6

                *******************************************************

                *******************************************************     $61F8 - $620E
                * JSR TESTS    
                *        
                MOVE.W      #$4EB8, $61F8
                MOVE.W      #$6000, $61FA           JSR $6000
                MOVE.W      #$4E91, $61FC           JSR (A1)
                MOVE.W      #$4E93, $61FE           JSR (A3)
                MOVE.W      #$4EB9, $6200
                MOVE.W      #$0000, $6202           JSR $00008000
                MOVE.W      #$8000, $6204
                
                MOVE.W      #$4E80, $6206           Attempt JSR D0
                MOVE.W      #$4E88, $6208           Attempt JSR A0
                MOVE.W      #$4E98, $620A           Attempt JSR (A1)+
                MOVE.W      #$4EA0, $620C           Attempt JSR -(A1)
                MOVE.W      #$4EBC, $620E           Attempt JSR #(DATA)
                
                *******************************************************     $6210 - $622A
                * LEA Tests
                *
                MOVE.W      #$43D5, $6210            LEA (A5),A1
                MOVE.W      #$4DF8, $6212            LEA  $4000,A6
                MOVE.W      #$4000, $6214

                MOVE.W      #$49F9, $6216            LEA  $8000,A4
                MOVE.W      #$0000, $6218
                MOVE.W      #$8000, $621A                                
                
                MOVE.W      #$47F9, $621C            LEA  $000505AB,A3
                MOVE.W      #$0005, $621E
                MOVE.W      #$05AB, $6220     
                
                MOVE.W      #$41C0, $6222            Attempt LEA Dn,A0
                MOVE.W      #$41C8, $6224            Attempt LEA An,A0
                MOVE.W      #$41D8, $6226            Attempt LEA (An)+,A0
                MOVE.W      #$41E0, $6228            Attempt LEA -(An),A0
                MOVE.W      #$41F0, $622A            Attempt LEA #(DATA),A0
                
                *******************************************************
                * MULS Tests
                
                MOVE.W      #$CBC3, $622C           MULS.W D3,D5
                MOVE.W      #$CBCB, $622E           MULS.W A3,D5 --- DATA INVALID INPUT
                MOVE.W      #$CBD3, $6230           MULS.W (A3),D5
                MOVE.W      #$CBDB, $6232           MULS.W (A3)+,D5
                MOVE.W      #$CBE3, $6234           MULS.W -(A3),D5
                MOVE.W      #$CBEB, $6236           MULS.W (d16,An)
                MOVE.W      #$CBF3, $6238           MULS.W (d8,An,Xn)
                MOVE.W      #$CBF8, $623A           MULS.W #$ABCD,D5
                MOVE.W      #$ABCD, $623C
                MOVE.W      #$CBF9, $623E           MULS.W #$ABCDEF00,D5
                MOVE.W      #$ABCD, $6240
                MOVE.W      #$EF00, $6242
                MOVE.W      #$CBFC, $6244           MULS.W #$1234567,D5
                MOVE.W      #$1234, $6246
                MOVE.W      #$5678, $6248
                
                *******************************************************
                * DIVS Tests
                
                MOVE.W      #$8BC3, $6248           DIVS.W D3,D5
                MOVE.W      #$8BCB, $624A           DIVS.W A3,D5 --- DATA INVALID INPUT
                MOVE.W      #$8BD3, $624C           DIVS.W (A3),D5
                MOVE.W      #$8BDB, $624E           DIVS.W (A3)+,D5
                MOVE.W      #$8BE3, $6250           DIVS.W -(A3),D5
                MOVE.W      #$8BEB, $6252           DIVS.W (d16,An)
                MOVE.W      #$8BF3, $6254           DIVS.W (d8,An,Xn)
                MOVE.W      #$8BF8, $6256           DIVS.W #$ABCD,D5
                MOVE.W      #$ABCD, $6258
                MOVE.W      #$8BF9, $625A           DIVS.W #$ABCDEF00,D5
                MOVE.W      #$ABCD, $625C
                MOVE.W      #$EF00, $625E
                MOVE.W      #$8BFC, $6260           DIVS.W #$1234567,D5
                MOVE.W      #$1234, $6262
                MOVE.W      #$5678, $6264
                
                *******************************************************
                * ADDA Tests
                
                MOVE.W      #$D0C9,$9664        ADDA.W    A1,A0     
                MOVE.W      #$D2C3,$9666        ADDA.W    D3,A1  
                MOVE.W      #$D4D3,$9668        ADDA.W    (A3),A2      
                MOVE.W      #$D6DD,$966A        ADDA.W    (A5)+,A3
                MOVE.W      #$D8E6,$966C        ADDA.W    -(A6),A4
                MOVE.L      #$DAE90190,$966E    ADDA.W    (400,A1),A5 (Attempt)  
                MOVE.L      #$DCF85000,$9672    ADDA.W    $5000,A6
                MOVE.W      #$DEF9,$9676        ADDA.W    $8000,A7
                MOVE.L      #$00008000,$9678    
                MOVE.L      #$DEFC8000,$967C    ADDA.W    #$8000,A7  
                
                MOVE.W      #$D1C9,$9680        ADDA.L    A1,A0     
                MOVE.W      #$D3C3,$9682        ADDA.L    D3,A1  
                MOVE.W      #$D5D3,$9684        ADDA.L    (A3),A2      
                MOVE.W      #$D7DD,$9686        ADDA.L    (A5)+,A3
                MOVE.W      #$D9E6,$9688        ADDA.L    -(A6),A4
                MOVE.L      #$DBE90190,$968A    ADDA.L    (400,A1),A5 (Attempt)  
                MOVE.L      #$DDF85000,$968E    ADDA.L    $5000,A6
                MOVE.W      #$DFF9,$9692        ADDA.L    $8000,A7
                MOVE.L      #$00008000,$9694    
                MOVE.W      #$DFFC,$9698        ADDA.L    #$8000,A7  
                MOVE.L      #$00008000,$969A     

                * ADD & ADDA TESTS
                *******************************************************
                * <EA> -> Dn ADD Tests
                *
                * ADD.B  
                
                MOVE.L      #$D9385530,$969E   ADD.B D4,$5530
                MOVE.L      #$DA380044,$96A2   ADD.B $44,D5
                   
                * ADD.W
                
                * ADD.L
                
                *******************************************************
                * Dn -> <EA> Tests
                
                * ADD.B
                
                * ADD.W

                * ADD.L
                *******************************************************
            
                *MOVE.W      #$0C01, $622C       CMPI.B #$ xx,D1             ONLY CMPI
                *MOVE.W      #$0C51, $622E       CMPI.W #$ xxxx,(A1)         ONLY CMPI
                *MOVE.W      #$0C99, $6230       CMPI.L #$ xxxxxxxx,(A1)+    ONLY CMPI
                *MOVE.W      #$4E80, $6232       JSR
                *MOVE.W      #$4E75, $6234       RTS                     WRONG OUTPUT
                *MOVE.W      #$0B91, $6236       BCLR D5,A1              ONLY showing BCLR
                *MOVE.W      #$3246, $6238       MOVE.W D6,A1            WRONG OUTPUT
                *MOVE.W      #$0002, $623A
                *MOVE.W      #$00EC, $623C       ORI.B  #$EC,D2
                *MOVE.W      #$0045, $623E
                *MOVE.W      #$0123, $6240       ORI.W  #$0123,D5
                *MOVE.W      #$0085, $6242       ORI.L  #$xxxxxxxx, D5
                *MOVE.W      #$1234, $6246
                *MOVE.W      #$5678, $6248             12345678    
                *MOVE.W      #$43F8, $624A
                *MOVE.W      #$7000, $624C       LEA $7000,A1
                *MOVE.W      #$4E71, $624E       NOP                             Extra blank line after return
                *MOVE.W      #$1200, $6250       MOVE.B D0,D1                    WRONG
                *MOVE.W      #$1607, $6252       MOVE.B D7,D3                    WRONG
                *MOVE.W      #$B501, $6254       EOR.B	D2,D1
                *MOVE.W      #$B178, $6256       EOR.W	D0,$XXXX
                *MOVE.W      #$4000, $6258            	    4000
                *MOVE.W      #$B7B9, $625A       EOR.L  D3,$XXXXXXXX
                *MOVE.W      #$1234, $625C                  1234
                *MOVE.W      #$5678, $625E                      5678
                *MOVE.W      #$B79A, $6260       EOR.L  D3,(A2)+
                 MOVE.W      #$B411, $96B0       CMP.B  (A1),D2

                 MOVE.W      #$B063, $96B2		CMP.W	-(A3),D0
                 MOVE.W      #$B449, $96B4	    CMP.W	A1,D2
                 MOVE.W      #$B489, $96B6    	CMP.L	A1,D2
                 MOVE.W      #$B03C, $96B8	    CMP.B	#$xx,D0
                 MOVE.W      #$0001, $96BA                01
                 MOVE.W      #$B038, $96BC	    CMP.B	$xxxx,D0
                 MOVE.W      #$0005, $96BE               0005
                 MOVE.W      #$B008, $96C0      CMP.B	A0,D0     TEST CASE(Should be DATA)   
                 MOVE.W      #$B0B9, $96C2      CMP.L   $xxxxxxxx,D0
                 MOVE.W      #$1234, $96C4               1234
                 MOVE.W      #$5678, $96C6                   5678
                 MOVE.W      #$B0BC, $96C8      CMP.L   #$xxxxxxxx,D0
                 MOVE.W      #$1234, $96CA               1234
                 MOVE.W      #$5678, $96CC                   5678
                 MOVE.W      #$B25A, $96CE      CMP.W   (A2)+,D1         
                 MOVE.W      #$B401, $96D0      CMP.B   D1,D2         

            
                 

                
                
            
************************** END OF TESTING *******************************************************************
                LEA         STACK,SP            Load the stack
            
                MOVE.B      #14,D0
                LEA         prompt_start,A1
                TRAP #15                        ; prompt for starting address
            
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP #15                        ; store user input
            
                JSR         asciiToHexS         ; convert user input from start address to hex
                MOVE.B      #14,D0
                LEA         prompt_end,A1
                TRAP        #15                 ; prompt for ending address
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP        #15                 ; store user input
                JSR         asciiToHexE         ; convert user input for end address to hex
            
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
                
                MOVE.W      #$0000,$3000        ; set counter to 0
                LEA         $5000,A5            ; move the starting address of the output string to A1
                LEA         $4000,A4
                MOVE.W      A5,A6               ; move the ending address of the output string here too (empty string)
                BRA         loop_start          ; start the loop
                
loop_start
                CMP.L       A3,A2               ; check to see if end is reached
                BGT         exit                ; nothing left, exit program
                       
                MOVE.L      #$3000, A0          ; Move address of count into A0
                ADD.W       #%01,(A0)           ; increment count by one
                CMP.W       #$001E,(A0)         ; check to see if count is 30
                BEQ         next_page           ; if over 30, go to next page
                
                MOVE.W      (A2),D0             ; MOVEs INSTRUCTION in A1 to D0
                JSR         print_add           ; print the address
                JSR         opcode              ; decode the opcode
            
                BRA         loop_exit
                
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
                JMP         op1101              ADD,ADDA
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
            
                        
                JSR         FIND_OPMODE         Find destination mode
            
                *MOVE.B      #14,D0
                *LEA         DATA_STR,A1
                *TRAP        #15                 OP code DNE
           
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
	            ANDI.W	    #$FF00,D1
    	        CMP.W	    #$4400,D1
	            BEQ         op_NEG	            ; Check for NEG
	        
                *NOP
                MOVE.L      (A2),D1             ; move the original operation into D1
                CMP.W       #$4E71,D1               ; compare D0 and D1
                BEQ         op_NOP              ; if they're equal, the operation is NOP
            
                *LEA
                ANDI.W      #$F1C0,D1
                CMP.W       #$41C0,D1
                BEQ         op_LEA

                *JSR
                MOVE.W      (A2),D1             ; move the original operation into D1 
                ANDI.W      #$FFC0,D1
                CMP.W       #$4E80,D1
                BEQ         op_JSR              ; check bits 6-15 to compare for JSR
            
                *RTS
                MOVE.W      (A2),D1             ; move the original operation into D1
                CMP.W       #$4E75,D1
                BEQ         op_RTS              ; check for RTS
            
                BRA         op_DATA             ; invalid

          
op0101          BRA         op_DATA

*-------------------------------------------------------------------------*
* Branch Subroutine, Branch Always, Branch Conditionally
*-------------------------------------------------------------------------*             
op0110          *BRA
                CLR.L       D0
                MOVE.W      (A2),D0
                ANDI.W      #$FF00,D0
                LSR.L       #8,D0                   ; separate the first 8 bits (bits 8-15)
                CLR.L       D1
                MOVE.W      (A2),D1
                ANDI.W      #$00FF,D1
                CMP.W       #$60,D0                 ; standard first 8 bits of a BRA op
                BEQ         op_BRA                  ; if they're equal, OP code is BRA
                                            
                CMP.W       #$65,D0                 * Check for BCS
                BEQ         op_BCS
                
                CMP.W       #$6C,D0                 * Check for BGE
                BEQ         op_BGE

                CMP.W       #$6D,D0                 * Check for BLT
                BEQ         op_BLT
                
                CMP.W       #$68,D0                 * Check for BVC
                BEQ         op_BVC

                BRA         op_DATA                 * Otherwise branch to data
            
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
op1001          MOVE.W      (A2),D1                 Move operation into D1 
                ANDI.W      #$F000,D1               MASK for SUB operation
                CMP.W       #$9000,D1
                BEQ         op_SUB                  

                
                BRA         op_DATA



*-------------------------------------------------------------------------*
*
*-------------------------------------------------------------------------*
            
op1010          BRA         op_DATA

*-------------------------------------------------------------------------*
* Exclusive Or, Compare
*-------------------------------------------------------------------------*             
op1011          
                *EOR
	            MOVE.W	    (A2),D0             * copy op for compare
	            ANDI.W	    #$F100,D0           * grab identifier bits
	            CMP.W	    #$B100,D0           * check to see if EOR
                BEQ         op_EOR
                
                *CMP
                CMP.W       #$B000,D0
                BEQ         op_CMP

                BRA         op_DATA

*-------------------------------------------------------------------------*
* Signed Multiply
*-------------------------------------------------------------------------*            
op1100          CMP.B       #$07,D4             * check for Signed Multiply Word
                BEQ         op_MULS
                
                BRA         op_DATA
                
*-------------------------------------------------------------------------*
* Add Address, Add
*-------------------------------------------------------------------------*            
op1101          BRA         op_ADD  Jump to Add operation

*-------------------------------------------------------------------------*
* Arithmetic Shift Left, Arithmetic Shift Right, Logical Shift Left, 
* Logical Shift Right, Rotate Left, Rotate Right
*-------------------------------------------------------------------------*            
op1110          MOVE.W      (A2),D0             * move original op into D0
                ANDI.W      #$00C0,D0           * mask to find if it's an EA shift
                CMP.W       #$00C0,D0           * check for EA shifts
                BEQ         SHIFT_ea

                BRA         SHIFT_no_ea
                            
op1111          BRA         op_DATA

*************************************** OPS *************************************
op_DIVS         LEA         DIVSW_STR,A5
                MOVE.L      A5,(A6)+            * add the operation to the output
                BRA         op_SIGN_MD
                
op_MULS         LEA         MULSW_STR,A5        * add the operation to the output
                MOVE.L      A5,(A6)+
                BRA         op_SIGN_MD
                
op_SIGN_MD
                MOVE.W      D5,D0               * copy the EA bits into D0
                ANDI.W      #$38,D0             * Separate the mode
                CMP.W       #$07,D0             * check if its mode 1
                BEQ         op_DATA             * if it is, it's invalid
                
                ADD.W       #$02,A2             * increment the current operation address
                JSR         FIND_EAMODE         * create the left side of the operation
                
                JSR         PRINT_COMMA
                
                MOVE.L      #$00000000,D4       * Move our Dn mode to D4
                JSR         FIND_OPMODE         * Now move to our mode
                
                JSR         PRINT_init          * print the output string
                
                BRA         loop_exit           * address has been processed

SHIFT_ea        MOVE.W      (A2),D0             * move original op into D0
                MOVE.W      (A2),D2             * move the original op into D2

                ANDI.W      #$0E00,D0           * mask to find out which shift it is
                *LSL/LSR
                CMP.W       #$0200,D0           * check for LSL/LSR
                BEQ         op_LS
                
                *ASL/ASR
                CMP.W       #$0000,D0           * check for ASL/ASR
                BEQ         op_AS
                
                *ROL/ROR
                CMP.W       #$0600,D0           * check for ROL/ROR
                BEQ         op_RO
                
                BRA         op_DATA
                
SHIFT_no_ea     MOVE.W      (A2),D0             * move the original op into D0
                MOVE.W      (A2),D1             * move the original op into D1
                MOVE.W      (A2),D2             * move the original op into D2
                MOVE.W      (A2),D3             * move the original op into D3
                MOVE.W      (A2),D4             * move the original op into D4
                MOVE.W      (A2),D5             * move the original op into D5
                MOVE.W      (A2),D6
                AND.L       #$0E00,D1           * move the count/register into D1
                AND.L       #$0018,D2           * move the type of shift to D2
                AND.L       #$0020,D4           * move the i/r field into D4
                AND.L       #$0007,D5           * move the register into D5
                AND.L       #$00C0,D3           * move the size into D3
                
                CMP.W       #$0000,D2           * check for Arithmetic shift
                BEQ         AS_NO_EA
                
                CMP.W       #$0018,D2           * check for Rotate
                BEQ         RO_NO_EA
                
                CMP.W       #$0008,D2           * check for Logical shift
                BEQ         LS_NO_EA
                
                BRA         op_DATA
                
AS_NO_EA        JSR         AS_FIND_DIR
                JSR         SHIFT_IR
                RTS
                
AS_FIND_DIR     AND.L       #$0100,D6           * move the direction into D2
                CMP.L       #$0100,D6           * check for left rotate
                BEQ         op_ASL_STR
                CMP.L       #$0000,D6           * check for right rotate
                BEQ         op_ASR_STR

op_ASL_STR      LEA         ASL_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS
                
op_ASR_STR      LEA         ASR_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS

RO_NO_EA        JSR         RO_FIND_DIR
                JSR         SHIFT_IR
                RTS
                
RO_FIND_DIR     AND.L       #$0100,D6           * move the direction into D3
                CMP.L       #$0100,D6           * check for left rotate
                BEQ         op_ROL_STR
                CMP.L       #$0000,D6           * check for right rotate
                BEQ         op_ROR_STR

op_ROL_STR      LEA         ROL_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS
                
op_ROR_STR      LEA         ROR_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS

LS_NO_EA        JSR         LS_FIND_DIR
                JSR         SHIFT_IR
                RTS

LS_FIND_DIR     ANDI.W      #$0100,D6
                CMP.W       #$0100,D6
                BEQ         op_LSL_STR
                CMP.W       #$0000,D6
                BEQ         op_LSR_STR
                
op_LSL_STR      LEA         LSL_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS
                
op_LSR_STR      LEA         LSR_STR,A5
                MOVE.L      A5,(A6)+            * add the op to the string
                RTS
                
op_RO           MOVE.W      (A2),D0             * move the original op into D0
                MOVE.W      (A2),D1             * move the original op into D1
                MOVE.W      (A2),D2             * move the original op into D2
                MOVE.W      (A2),D3             * move the original op into D3
                MOVE.W      (A2),D4             * move the original op into D4
                MOVE.W      (A2),D5             * move the original op into D5
                MOVE.W      (A2),D6             * move the original op into D6
                JSR         RO_FIND_DIR         * find the direction of the operation

                JSR         op_SHIFT_EA
                
                RTS
                
op_AS           MOVE.W      (A2),D0             * move the original op into D0
                MOVE.W      (A2),D1             * move the original op into D1
                MOVE.W      (A2),D2             * move the original op into D2
                MOVE.W      (A2),D3             * move the original op into D3
                MOVE.W      (A2),D4             * move the original op into D4
                MOVE.W      (A2),D5             * move the original op into D5
                JSR         AS_FIND_DIR         * find the direction of the operation
               
                JSR         op_SHIFT_EA
                
                RTS
                
op_LS           MOVE.W      (A2),D0             * move the original op into D0
                MOVE.W      (A2),D1             * move the original op into D1
                MOVE.W      (A2),D2             * move the original op into D2
                MOVE.W      (A2),D3             * move the original op into D3
                MOVE.W      (A2),D4             * move the original op into D4
                MOVE.W      (A2),D5             * move the original op into D5
                JSR         LS_FIND_DIR         * find the direction of the operation
               
                JSR         op_SHIFT_EA
                
                RTS
            
                
SHIFT_IR        JSR         opcode_size_str     * add the size to the string
                CMP.W       #$0000,D4           * check for count shift
                BEQ         SHIFT_count
                CMP.W       #$0020,D4           * check for register shift
                BEQ         SHIFT_reg
                
op_SHIFT_EA     LEA         TAB,A5
                MOVE.L      A5,(A6)+   
                
                CMP.W       #%00111100,D5       ; mode 7, reg 4 invalid
                BEQ         op_DATA
                
                MOVEM.L     D0/D5,-(SP)         ; store D0 on the stack
                MOVE.L      D5,D0               ; move D5 to D0 to change it
                ANDI.L      #%00111000,D0       ; separate the mode
                CMP.W       #%00000000,D0       ; check if its mode 0
                BEQ         op_DATA             * if it is, it's invalid
                CMP.W       #%00001000,D0       ; check if its mode 1
                BEQ         op_DATA             * if it is, it's invalid
                MOVEM.L     (SP)+,D0/D5
                
                ADD.W       #$02,A2             ; move to the next instruction
                JSR         FIND_EAMODE
                
                JSR         PRINT_init
                ADD.W       #$02,A2
                BRA         loop_exit

SHIFT_count     LEA         POUND,A5
                MOVE.L      A5,(A6)+            ; add # to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #$0E00,D1
                LSR.L       #8,D1
                LSR.L       #1,D1               ; shift to get the register
                ADD.W       #$30,D1             ; convert ascii number to hex
            
                MOVE.B      D1,(A4)+            ; move the register to A4
                MOVE.B      #$00,(A4)+          ; add the string terminating character
                MOVE.W      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                LEA         COMMA,A5            ; add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #$0007,D1
                ADD.W       #$30,D1             ; convert the register to hex

                MOVE.B      D1,(A4)+            ; move the register to A4
                MOVE.B      #$00,(A4)+          ; add the string terminating character
                MOVE.W      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                JSR         PRINT_init          ; print the string
                ADD.W       #$02,A2
                BRA         loop_exit

SHIFT_reg       LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add 'D'y to the string
            
                MOVE.W      (A2),D1
                ANDI.W      #$0E00,D1
                LSR.L       #8,D1
                LSR.L       #1,D1               ; shift to get the register
                ADD.W       #$30,D1             ; convert ascii number to hex
            
                MOVE.B      D1,(A4)+            ; move the register to A4
                MOVE.B      #$00,(A4)+          ; add the string terminating character
                MOVE.W      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                LEA         COMMA,A5            ; add a comma to the string
                MOVE.L      A5,(A6)+
            
                LEA         DATA_REG,A5
                MOVE.L      A5,(A6)+            ; add a 'D' to the string
                        
                MOVE.W      (A2),D1
                ANDI.W      #$0007,D1
                ADD.W       #$30,D1             ; convert the register to hex

                MOVE.B      D1,(A4)+            ; move the register to A4
                MOVE.B      #$00,(A4)+          ; add the string terminating character
                MOVE.W      A4,D0
                SUB.W       #$02,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            ; add the register to the string
            
                JSR         PRINT_init          ; print the string
                ADD.W       #$02,A2
                BRA         loop_exit

EOR_opmode      CMP.W       #%0100,D4           ; check if byte
                BEQ         print_B_str         ; go add .B to string
                CMP.W       #%0101,D4           ; check if word
                BEQ         print_W_str         ; go add .W to string
                CMP.W       #%0110,D4           ; check if long
                BEQ         print_L_str         ; go add .L to string
                BRA         op_DATA

CMP_opmode      CMP.W       #%0000,D4           ; check if byte
                BEQ         print_B_str         ; go add .B to string
                CMP.W       #%0001,D4           ; check if word
                BEQ         print_W_str         ; go add .W to string
                CMP.W       #%0010,D4           ; check if long
                BEQ         print_L_str         ; go add .L to string
                BRA         op_DATA
                

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
                MOVE.L      A4,A0               Clear the output address location
                MOVE.L      A2,D0
                MOVE.L      #$00000004,D1
                MOVE.L      #$00000000,D2
                MOVE.L      #$00000000,D3
                JSR         HEXTOASCII
                                
                ADD.L       #$08,A4
                MOVE.B      #$00,(A4)+          Add the string terminating character
                MOVE.L      A4,D0
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+            Add the register to the output string
                
                MOVEM.L     (SP)+,D0-D7         ; restore the state
                RTS
            
op_NOP          LEA         NOP_STR,A5
                MOVE.L      A5,(A6)+            ; add the operation to the string
                JSR         PRINT_init          ; print the string
                BRA         loop_exit
            
op_DATA         JSR         clearTempVars
                JSR         clearOutputStr
                MOVE.L      #$00004000,A4
                MOVE.L      #$00005000,A6
                JSR         print_add

                LEA         DATA_STR,A5
                MOVE.L      A5,(A6)+            ; add DATA to string
                
                LEA         TAB,A5
                MOVE.L      A5,(A6)+            ; add tab to string                    
                
                MOVE.L      A4,A0               Clear the output address location
                MOVE.W      (A2),D0
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
                
                JSR         PRINT_init
                
                ADD.W       #$02,A2
                
                BRA         loop_exit
            
op_BRA          LEA         BRA_STR,A5
                MOVE.L      A5,(A6)+
                JSR         FIND_DISP
                BRA         loop_exit
             
FIND_DISP       LEA         DOLLAH,A5
                MOVE.L      A5,(A6)+
                
                CMP.B       #$00,D1             ; check the value of the last 8 bits against $00
                BEQ         op_DISP16           ; if equal, it's a 16 bit displacement
            
                CMP.B       #$FF,D1             ; check the value of the last 8 bits against $FF
                BEQ         op_DISP32           ; if equal, it's a 32 bit displacement
            
                BRA         op_DISP8            ; otherwise, it's an 8 bit displacement
                
                RTS

op_DISP8        MOVEM.L     D0-D7,-(SP)         * Save the state

                MOVE.L      A2,D0               * Move current address in
                ADD.L       D1,D0               * Add our displacement to current address
                
                MOVE.L      A4,A0               * Move temp value pointer to A0
                MOVE.L      #$00000004,D1       * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7         * Restore previous state
                
                ADD.L       #$08,A4             * Prep temp variables
                MOVE.B      #$00,(A4)+          * Add terminating character
                MOVE.L      A4,D0               * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                ADD.L       #%10,A2
                BRA         loop_exit
            
op_DISP16       MOVEM.L     D0-D7,-(SP)         * Save the state

                MOVE.L      A2,D0               * Move current address in
                ADD.W       #$02,A2             * Advance the pointer
                MOVE.W      (A2)+,D1            * Advance pointer beyond data
                ADD.L       D1,D0               * Add our displacement to current address
                
                MOVE.L      A4,A0               * Move temp value pointer to A0
                MOVE.L      #$00000004,D1       * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7         * Restore previous state
                
                ADD.L       #$08,A4             * Prep temp variables
                MOVE.B      #$00,(A4)+          * Add terminating character
                MOVE.L      A4,D0               * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                BRA         loop_exit

op_DISP32       MOVEM.L     D0-D7,-(SP)         * Save the state

                MOVE.L      A2,D0               * Move current address in
                ADD.W       #$02,A2             * Advance the pointer
                MOVE.L      (A2)+,D1            * Advance pointer beyond data
                ADD.L       D1,D0               * Add our displacement to current address
                
                MOVE.L      A4,A0               * Move temp value pointer to A0
                MOVE.L      #$00000004,D1       * prepare for ASCII output
                CLR         D2
                CLR         D3
                JSR         HEXTOASCII
                
                MOVEM.L     (SP)+,D0-D7         * Restore previous state
                
                ADD.L       #$08,A4             * Prep temp variables
                MOVE.B      #$00,(A4)+          * Add terminating character
                MOVE.L      A4,D0               * Print displacement
                SUB.L       #$09,D0
                MOVE.L      D0,A5
                MOVE.L      A5,(A6)+
                JSR         PRINT_init
                *ADD.L       #%100,A2
                BRA         loop_exit

op_BCS          LEA         BCS_STR,A5
                MOVE.L      A5,(A6)+
                JSR         FIND_DISP
                BRA         loop_exit                * eventually should jump to a repeat loop
                
op_BGE          LEA         BGE_STR,A5
                MOVE.L      A5,(A6)+
                JSR         FIND_DISP
                BRA         loop_exit                * eventually should jump to a repeat loop

op_BLT          LEA         BLT_STR,A5
                MOVE.L      A5,(A6)+
                JSR         FIND_DISP
                BRA         loop_exit                * eventually should jump to a repeat loop

op_BVC          LEA         BVC_STR,A5
                MOVE.L      A5,(A6)+
                JSR         FIND_DISP
                BRA         loop_exit                * eventually should jump to a repeat loop

op_CMP          LEA         CMP_STR,A5
                MOVE.L      A5,(A6)+
                JSR         CMP_opmode               * find the size and add it to the string
                
                MOVE.L      D5,D0
                ****Check for .B of An,Dn
                ANDI.W      #$01F8,D0
                CMPI.W      #$B401,D0
                BEQ         op_DATA
                
                MOVE.L      D5,D0
                
                ANDI.W      #$0038,D0           * mask the mode
                ADD.W       #$0002,A2           * increment the current address
                JSR         FIND_EAMODE         * create the RIGHT side of the operation
                JSR         PRINT_COMMA
                MOVE.L      #$00000000,D4       * set mode to 0
                JSR         FIND_OPMODE

                JSR         PRINT_init
                BRA         loop_exit

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
            
                *---NEED TO INSERT INCORRECT EA-MODE CHECKS HERE---*
                CMP.W       #%00111100,D5       Check for illegal #(data) mode
                BEQ         op_DATA         
                
                MOVEM.L     D0,-(SP)            Just in case store whatever is in D)
                MOVE.W      D5,D0               Move D5 to D0
                ANDI.W      #%00111000,D0       Mask EA mode-bits
                CMP.W       #%00000000,D0       Check for illegal Dn mode
                BEQ         op_DATA
                CMP.W       #%00001000,D0       Check for illegal An mode
                BEQ         op_DATA 
                CMP.W       #%00011000,D0       Check for illegal (An)+ mode
                BEQ         op_DATA 
                CMP.W       #%00100000,D0       Check for illegal -(An) mode
                BEQ         op_DATA 
                
                MOVEM.L     (SP)+,D0            Pop off the stack

                ADD.W       #$02,A2             MOVE TO JUST AHEAD OF THE INSTRUCTION (this is important for correct EA mode 7)
                
                JSR         FIND_EAMODE         We have our EA-bits in D5

                JSR         PRINT_COMMA         Print the comma

                MOVEM.L     D4,-(SP)            save contents of D4 on stack
                MOVE.B      #1,D4               Move our An mode to D4
                JSR         FIND_OPMODE         Now move to our mode
            
                JSR         PRINT_init          Print the output string
            
                MOVEM.L     (SP)+,D4            restore D4 before we go back
            
                BRA         loop_exit
            
*--------------------------------------------------------------*
* Jump to Subroutine 
*
*

op_JSR          LEA         JSR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
            
                JSR         PRINT_TAB           Print the tab
                
                CMP.W       #%00111100,D5       Check for illegal #(data) mode
                BEQ         op_DATA         
                
                MOVEM.L     D0,-(SP)            Just in case store whatever is in D)
                MOVE.W      D5,D0               Move D5 to D0
                ANDI.W      #%00111000,D0       Mask EA mode-bits
                CMP.W       #%00000000,D0       Check for illegal Dn mode
                BEQ         op_DATA
                CMP.W       #%00001000,D0       Check for illegal An mode
                BEQ         op_DATA 
                CMP.W       #%00011000,D0       Check for illegal (An)+ mode
                BEQ         op_DATA 
                CMP.W       #%00100000,D0       Check for illegal -(An) mode
                BEQ         op_DATA 
                
                MOVEM.L     (SP)+,D0            Pop off the stack
                
                ADD.W       #$02,A2             Advance pointer beyond instruction
                
                JSR         FIND_EAMODE         Find EA mode
                
                JSR         PRINT_init          ; print the string
                BRA         loop_exit

*---------------------------------------------------------------*
op_EOR          LEA         EOR_STR,A5
                MOVE.L      A5,(A6)+
                JSR         EOR_opmode          ; find the size and add it to the string
                
                MOVE.L      D5,D0
                ANDI.W      #$0038,D0         ; mask the mode
                ** CHECK IF MODE IS INVALID **
                CMPI.W      #$0008,D0           ; check for invalid mode 1   
                BEQ         op_DATA             ; mode 1, An, is invalid
                CMPI.W      #$003C,D0           ; check for invalid mode 7 reg 4
                BEQ         op_DATA             ; mode 7 reg 4, #<data>, is invalid
                
                MOVE.L      #$00000000,D4       * set mode to 0
                JSR         FIND_OPMODE
                JSR         PRINT_COMMA

                ADD.W       #$0002,A2           * increment the current address
                JSR         FIND_EAMODE         * create the RIGHT side of the operation
                JSR         PRINT_init
                BRA         loop_exit
                

op_OR           LEA         OR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                JSR         OR_opmode           ; find the size and add it to the string
            
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
            
                JSR         PRINT_init          * print the string
                BRA         loop_exit
                
op_OR_DEST      CMPI.W      #$003C,D5           * mode 7, register 4 is invalid
                BEQ         op_DATA
                MOVE.L      D5,D0
                ANDI.W      #$0038,D0           * mask the mode
                CMPI.W      #$0000,D0           * mode 0 is invalid
                BEQ         op_DATA
                CMPI.W      #$0008,D0           * mode 1 is invalid
                BEQ         op_DATA
                
                MOVE.L      #$00000000,D4       * set mode to 0
                JSR         FIND_OPMODE         * create the LEFT side of the operation
                
                JSR         PRINT_COMMA

                ADD.W       #$0002,A2           * increment the current address
                JSR         FIND_EAMODE         * create the RIGHT side of the operation
                
                JSR         PRINT_init
                
                BRA         loop_exit

op_OR_SRC       MOVE.L      D5,D0
                ANDI.W      #$0038,D0           * mask the mode
                CMPI.W      #$0008,D0           * mode 1 is invalid
                BEQ         op_DATA
                
                ADD.W       #$0002,A2           * increment the current address
                JSR         FIND_EAMODE         * create the left side of the operation

                JSR         PRINT_COMMA
                
                MOVE.L      #$00000000,D4       * set mode to 0                
                JSR         FIND_OPMODE         * create the right side of the operation    
                JSR         PRINT_init
                
                BRA         loop_exit

op_ORI          LEA         ORI_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3           * move the size into D3  
                JSR         opcode_size_str     ; find the size and add it to the string
                
                MOVE.W      (A2),D1
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
                BRA         loop_exit
            
op_BCLR         LEA         BCLR_STR,A5         ; add the op to the string
                MOVE.L      A5,(A6)+
            
                **** FINDING/ADDING EA TO STRING HERE
                JSR         PRINT_init
                BRA         loop_exit
            
***************************************************************************       
opcode_size_str CMP.W       #$0000,D3
                BEQ         print_B_str         ; its a byte
                CMP.W       #$0040,D3
                BEQ         print_W_str         ; its a word
                CMP.W       #$0080,D3
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

            
PRINT_loop      CMP.L       #$FFFFFFFF,(A5)     ; if the value at A5 is all F's, you've reached the end
                BEQ         PRINT_exit          ; exit
                MOVE.L      #14,D0
                MOVE.L      (A5),A1             ; load the address pointed at by A5 to A1
                TRAP        #15                 ; print what the address points to
                ADDA.L      #$00000004,A5       ; increment A5 by a long
                BRA         PRINT_loop          ; loop
                RTS

PRINT_exit      MOVE.B      #14,D0
                LEA         new_line,A1
                TRAP        #15
                RTS
***************************************************************************
op_NEG          LEA         NEG_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3           * move the size into D3  
                JSR         opcode_size_str     ; find the size and add it to the string            
            
                **** ADD TESTING
                MOVEM.L     D5,-(SP)            ; save the state of D5
                ANDI.B      #%00111000,D5       ; separate the EA mode
                CMP.B       #%00001000,D5       ; check if it's mode 1
                BEQ         op_DATA             ; if is, it's invalid
                MOVEM.L     (SP)+,D5            ; restore D5 if it isn't
                
                ADD.W       #$02,A2             Advance just ahead of instruction
                
                JSR         FIND_EAMODE
            
                JSR         PRINT_init          ; print the string
                BRA         loop_exit
*---------------------------------------------------------------------------------*
* RTS: Return From Subroutine
*
*
op_RTS          LEA         RTS_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string            
                JSR         PRINT_init          ; print the string
                ADD.W       #02,A2              Advance pointer just after instruction
                BRA         loop_exit

*---------------------------------------------------------------------------------*

op_LSL          LEA         LSL_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3           * move the size into D3         
                JSR         opcode_size_str     ; find the size and add it to the string            
                RTS
          
op_LSR          LEA         LSR_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3           * move the size into D3  
                JSR         opcode_size_str     ; find the size and add it to the string            
                RTS
            
            
op_CMPI         LEA         CMPI_STR,A5
                MOVE.L      A5,(A6)+            ; add the op to the string
                MOVE.W      (A2),D3
                ANDI.L      #$00C0,D3           * move the size into D3  
                JSR         opcode_size_str     ; find the size and add it to the string            
            
                **** FINDING/ADDING EA TO STRING HERE
            
                JSR         PRINT_init          ; print the string
                RTS
                
                
                
*------------------------------------------------------------------*
* op_SUB & op_ADDA
*
op_SUB         LEA      SUB_STR,A5      Go to SUB mode
               MOVE.L   A5,(A6)+        Load SUB String


               CMP.B    #3,D4           ADDA.W
               BEQ      OP_ADDRESS     Go to SUBA.W Mode
                                
               CMP.B    #7,D4           ADDA.L
               BEQ      OP_ADDRESS     Go to SUBA.L Mode
  

               CMP.B    #0,D4           FIND OUT THE MODE for SUB
               BEQ      ARITH_MODE_1    <EA> -> Dn Byte
               CMP.B    #1,D4
               BEQ      ARITH_MODE_1    <EA> -> Dn Word 
               CMP.B    #2,D4
               BEQ      ARITH_MODE_1    <EA> -> Dn Long
               

               CMP.B    #4,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Byte
               CMP.B    #5,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Word
               CMP.B    #6,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Long



            
*------------------------------------------------------------------*
* op_ADD also op_ADDA
*

op_ADD         LEA      ADD_STR,A5      Go to ADD mode
               MOVE.L   A5,(A6)+        Load ADD String


               CMP.B    #3,D4           ADDA.W
               BEQ      OP_ADDRESS     Go to ADDA.W Mode
                                
               CMP.B    #7,D4           ADDA.L
               BEQ      OP_ADDRESS     Go to ADDA.L Mode
  

               CMP.B    #0,D4           FIND OUT THE MODE for ADD
               BEQ      ARITH_MODE_1    <EA> -> Dn Byte
               CMP.B    #1,D4
               BEQ      ARITH_MODE_1    <EA> -> Dn Word 
               CMP.B    #2,D4
               BEQ      ARITH_MODE_1    <EA> -> Dn Long
               

               CMP.B    #4,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Byte
               CMP.B    #5,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Word
               CMP.B    #6,D4
               BEQ      ARITH_MODE_2    Dn -> <EA> Long


*------------------------------------------------------------*
* OP_ADDRESS is Specifically for methods like
* SUBA or ADDA that have the 'A' Suffix and similar addressing
* behavior
*
*               
               
OP_ADDRESS     LEA      ADDR_A,A5       Load the ADDA String
               MOVE.L   A5,(A6)+     
               
               CMP.B    #3,D4           Is this a long operation?
               BNE      LONG_ADD

WORD_ADD       JSR      print_W_str     Then it's a word operation
               MOVE.L   D6,-(SP)        Save D6, just in case
               CLR      D6
               MOVE.B   #1,D6           Set Word flag (in case immediate data is used)
               BRA      OP_ADDR_CONT    Continue operation

LONG_ADD       JSR      print_L_str
               MOVE.L   D6,-(SP)        Save D6, just in case
               CLR      D6
               MOVE.B   #2,D6           Set Long flag (in case immediate data is used)


OP_ADDR_CONT   JSR      PRINT_TAB

               ADD.W    #$02,A2         Advance the pointer past the instruction
               JSR      FIND_EAMODE     Get EA MODE
               
               JSR      PRINT_COMMA     Comma
               
               MOVE.L   D4,-(SP)        Save D4 for a minute
               CLR      D4              
               MOVE.L   #1,D4
               
               JSR      FIND_OPMODE
            
               MOVEM.L  (SP)+,D6/D4     Restore D6 & D4

               JSR      PRINT_init      Print the string
                
               BRA      loop_exit            Done
               
               
               
               
**************************************************************
* Arithmetic Mode 1 is for <EA> -> Dn Effective Addressing              
* This modal behavior is used by Add, and Sub alike
* D3: Should have the Dn register number.
* D4: Should contain the OPMode bits to determine the 
* D5: Should contain the EA-Bits (6 total)
* D6: Is the expected flag value for immediate data usage
* Operation size. (000)Byte, (001) Word, (010) Long
*
ARITH_MODE_1   MOVE.L   D6,-(SP)        Save D6, just in case
               CLR      D6              Clear it out

               CMP.B    #1,D4           FIND OUT THE SIZE
               BEQ      ARITH1_WORD     <EA> -> Dn Word
               CMP.B    #2,D4
               BEQ      ARITH1_LONG     <EA> -> Dn Long 
               
ARITH1_BYTE    JSR      print_B_str     Set the '.B' Suffix
               MOVE.B   #0,D6           Set the byte flag (for immediate data useage)
               BRA      ARITH_ONE_CONT  Continue

ARITH1_WORD    JSR      print_W_str     Set the '.W' Suffix
               MOVE.B   #1,D6           Set the word flag (for immediate data useage)
               BRA      ARITH_ONE_CONT  Continue

ARITH1_LONG    JSR      print_L_str     Set the '.L' Suffix
               MOVE.B   #2,D6           Set the Long flag (for immediate data useage)


ARITH_ONE_CONT ADD.W    #$02,A2         Advance the pointer past the instruction
               
               JSR      FIND_EAMODE     Get EA MODE 
               JSR      PRINT_COMMA     Comma
               
               MOVE.L   D4,-(SP)        Save D4 for a minute
               CLR      D4              
               MOVE.L   #0,D4           Manually set Dn for Destination
               
               JSR      FIND_OPMODE
            
               MOVEM.L  (SP)+,D4       Restore  D4

               JSR      PRINT_init      Print the string
               BRA      loop_exit


**************************************************************
* Arithmetic Mode 2 is for Dn -> <EA> Effective Addressing              
* This modal behavior is used by Add, and Sub alike
* D3: Should have the Dn register number.
* D4: Should contain the OPMode bits to determine the 
* D5: Should contain the EA-Bits (6 total)
* D6: Is the expected flag value for immediate data usage 
* (not used here)
* Operation size. (100)Byte, (101) Word, (110) Long
*
ARITH_MODE_2   CMP.B    #5,D4           FIND OUT THE SIZE
               BEQ      ARITH2_WORD     Dn -> <EA> Word
               CMP.B    #6,D4
               BEQ      ARITH2_LONG     Dn -> <EA> Long 
               
ARITH2_BYTE    JSR      print_B_str     Set the '.B' Suffix
               BRA      ARITH_TWO_CONT  Continue

ARITH2_WORD    JSR      print_W_str     Set the '.W' Suffix
               BRA      ARITH_TWO_CONT  Continue

ARITH2_LONG    JSR      print_L_str     Set the '.L' Suffix


ARITH_TWO_CONT  MOVEM.L     D0/D1,-(SP) Save the D0,D1 Register

                MOVE.B      D5,D0
                MOVE.B      D5,D1
                ANDI.B      #EA_REG,D1  Get the EA Reg        
                ANDI.B      #EA_MODE,D0 Get the EA Mode
                LSR.B       #3,D0           

                CMP.B       #0,D0       Check for illegal Dn mode
                BEQ         op_DATA
                CMP.B       #1,D0       Check for illegal An mode
                BEQ         op_DATA
    
                CMP.B       #7,D0       Check for mode 7 Reg 4
                BEQ         CHECK_REG


ARITH2_RESUME   MOVEM.L    (SP)+,D0/D1     Release D0,D1 from stack

                MOVE.L     D4,-(SP)        Save D4 for a minute
                CLR        D4              
                MOVE.L     #0,D4           Manually set Dn for Source
                   
                JSR        FIND_OPMODE     Get Dn register
                JSR        PRINT_COMMA     Get Comma
        
                ADD.W      #$02,A2         Advance the pointer past the instruction
                JSR        FIND_EAMODE     Get <EA> operand  

                MOVEM.L    (SP)+,D4        Restore  D4

                JSR        PRINT_init      Print the string
                BRA        loop_exit 


CHECK_REG       CMP.B       #2,D1          Check for illegal reg (d16,PC)
                BEQ         op_DATA
                CMP.B       #3,D1          Check for illegal reg (d8,PC,Xn)
                BEQ         op_DATA
                CMP.B       #4,D1          Check for illegal reg #(data) immediate data
                BEQ         op_DATA
                BRA         ARITH2_RESUME  Otherwise continue.

                 
                
               






*-------------------------------------------------*   
   
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
                BEQ         op_DATA
                CMP.B       #6,D5
                BEQ         op_DATA
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
                BEQ         op_DATA
                CMP.B       #3,D2
                BEQ         op_DATA
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


next_page       CMP.L       A3,A2               ; check if end address has been reached
                BEQ         exit                ; exit the program
                
                MOVE.B      #14,D0
                LEA         prompt_new,A1
                TRAP #15                        ; prompt user to press enter
                
                MOVE.B      #2,D0
                LEA         input,A1
                TRAP #15                        ; input used to wait for enter
                
                MOVE.L      #$0000,$3000        ; set counter to 0
                BRA         loop_start          ; go back to start of the loop
                
                
                
                

loop_exit       MOVE.L      #$000000,A1
                CMP.L       A3,A2               ; check to see if end address has been reached
                BGT         exit                ; if reached, end the program
                
                JSR         clearTempVars       ; clear the temporary variables for the output string
                JSR         clearOutputStr      ; clear the output string
                MOVE.L      #$00004000,A4
                MOVE.L      #$00005000,A5
                MOVE.L      #$00005000,A6
                CLR.L       D0
                CLR.L       D1
                CLR.L       D2
                CLR.L       D3
                CLR.L       D4
                CLR.L       D5
                CLR.L       D6
                CLR.L       D7                  ; clear all of the registers
                BRA         loop_start          ; go back to the start of the loop
    
exit            
                SIMHALT                         ; halt simulator

* Put variables and constants here
prompt_start    DC.B        'What is the starting address?',CR,LF,0
prompt_end      DC.B        'What is the ending address?',CR,LF,0
prompt_new      DC.B        'Press enter to continue',CR,LF,0
input           DCB.B       256,0
invalidAdd      DC.B        'ERROR',0
new_line        DC.B        '',CR,LF,0
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
DATA_STR        DC.B        '      DATA',0
NOP_STR         DC.B        '      NOP',0
MOVEB_STR       DC.B        '      MOVE.B',0
BRA_STR         DC.B        '      BRA  ',0
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
BCS_STR         DC.B        '      BCS  ',0
BGE_STR         DC.B        '      BGE  ',0
BLT_STR         DC.B        '      BLT  ',0
BVC_STR         DC.B        '      BVC  ',0
ROL_STR         DC.B        '      ROL',0
ROR_STR         DC.B        '      ROR',0
ASL_STR         DC.B        '      ASL',0
ASR_STR         DC.B        '      ASR',0
ADDA_STR        DC.B        '      ADDA',0
ADD_STR         DC.B        '      ADD',0
SUBA_STR        DC.B        '      SUBA',0
SUB_STR         DC.B        '      SUB',0
MULSW_STR       DC.B        '      MULS.W   ',0
DIVSW_STR       DC.B        '      DIVS.W   ',0
CMP_STR         DC.B        '      CMP',0

*------------------------------------------------------------------*
* EA REGISTERS
*------------------------------------------------------------------*
* DATA Register

DATA_REG        DC.B        'D',0
ADDR_REG        DC.B        'A',0
ADDR_A          DC.B        'A',0
SP_REG          DC.B        'SP',0

*------------------------------------------------------------------*
INST_LINE       DCB.B       256,0                   String for one line of instruction

                END         START                   ; last line of source















































*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
