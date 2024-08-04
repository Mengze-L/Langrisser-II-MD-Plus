
IO_Z80BUS                                       equ $A11100

TOTAL_TRACKS                                    equ 31

; Constants: ---------------------------------------------------------------------------------
        MD_PLUS_OVERLAY_PORT:                   equ $0003F7FA
        MD_PLUS_CMD_PORT:                       equ $0003F7FE
        MD_PLUS_RESPONSE_PORT:                  equ $0003F7FC
	
; OVERWRITES: --------------------------------------------------------------------------------------

        org     $2D1BE
        jsr     MD_PLUS_PLAY_SEGA

        org     $FD7A                           ; General Sounds Routine
        jsr     PROCESS_GENERAL_SOUNDS
        jmp     $FDA8

        org     $21C32                          ; 29
        move.l  D0,-(SP)
        move.b  #$29,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $21C5C

        org     $2215E                          ; FD
        move.l  D0,-(SP)
        move.b  #$FD,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $22188

        org     $25F92                          ; 2E
        move.l  D0,-(SP)
        move.b  #$2E,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $25FBC

        org     $29662                          ; 01
        move.l  D0,-(SP)
        move.b  #$01,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2968C

        org     $2D0C2                          ; FE
        move.l  D0,-(SP)
        move.b  #$FE,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D0EC

        org     $2D344                          ; 2A
        move.l  D0,-(SP)
        move.b  #$2A,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D36E

        org     $2D50C                          ; FD
        move.l  D0,-(SP)
        move.b  #$FD,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D536

        org     $2D59C                          ; FD
        move.l  D0,-(SP)
        move.b  #$FD,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D5C6

        org     $2D694                          ; FE
        move.l  D0,-(SP)
        move.b  #$FE,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D6BE

        org     $2D7CE                          ; 2A
        move.l  D0,-(SP)
        move.b  #$2A,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D7F8

        org     $2D806                          ; FE
        move.l  D0,-(SP)
        move.b  #$FE,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D830

        org     $2D83A                          ; 2A
        move.l  D0,-(SP)
        move.b  #$2A,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2D864

        org     $2DEE0                          ; FE
        move.l  D0,-(SP)
        move.b  #$FE,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2DF0A

        org     $2DF14                          ; 2A
        move.l  D0,-(SP)
        move.b  #$2A,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2DF3E

        org     $2E47C                          ; 2B
        move.l  D0,-(SP)
        move.b  #$2B,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2E4A6

        org     $2F73E                          ; FE
        move.l  D0,-(SP)
        move.b  #$FE,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2F768

        org     $2F772                          ; 2C
        move.l  D0,-(SP)
        move.b  #$2C,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $2F79C

        org     $30BD4                          ; FD
        move.l  D0,-(SP)
        move.b  #$FD,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $30BFE

        org     $30C90                          ; 2D
        move.l  D0,-(SP)
        move.b  #$2D,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        jmp     $30CBA


; PADDED SPACE: ------------------------------------------------------------------------------------

        org     $311B0

MD_PLUS_PLAY_SEGA:
        move.l  D1,-(SP)
        move.w  #($1100|1),D1                   ; Play Track 1
        jsr     WRITE_MD_PLUS_FUNCTION
        move.l  (SP)+,D1
        move.l  #$0002D918,D0                   ; Adopt original instruction
        rts

; TABLES: ------------------------------------------------------------------------------------------
    align 2

AUDIO_TBL     ;cmd;code ; #Track Name                 #No.
        dc.w    $122A   ; Opening Theme (Part 1)       01
        dc.w    $112B   ; Opening Theme (Part 2)       02
        dc.w    $122E   ; Main Theme of Langrisser     03
        dc.w    $1201   ; Neo Holy War                 04
        dc.w    $1209   ; Leon                         05
        dc.w    $1202   ; Knight's Errand              06
        dc.w    $120A   ; Bargas                       07
        dc.w    $1208   ; One's Side                   08
        dc.w    $1221   ; Morgan                       09
        dc.w    $1203   ; No Surrender                 10
        dc.w    $120C   ; Jessica                      11
        dc.w    $120D   ; Ancient Magic                12
        dc.w    $1222   ; The Evil Person              13
        dc.w    $1228   ; Enemy Reinforcements         14
        dc.w    $120E   ; Riana                        15
        dc.w    $1204   ; Fight it Out                 16
        dc.w    $1223   ; Eggbert                      17
        dc.w    $1205   ; The Legend of Sword          18
        dc.w    $1229   ; Shop                         19
        dc.w    $1224   ; Imelda                       20
        dc.w    $1225   ; The Dark Princess            21
        dc.w    $1226   ; Bosel                        22
        dc.w    $120B   ; Aniki                        23
        dc.w    $1206   ; Soldier                      24
        dc.w    $1227   ; Bernhardt                    25
        dc.w    $1207   ; The Last Battle              26
        dc.w    $112C   ; Ending Theme (Part 1)        27
        dc.w    $1230   ; A Story Forever (Part 1)     28
        dc.w    $112D   ; A Story Forever (Part 2)     29
        dc.w    $1131   ; Ending Theme (Part 4)        30
        dc.w    $122F   ; Requiem                      31

; Sound: -------------------------------------------------------------------------------------

PLAY_SOUND:
        movem.l D1-D3/A2,-(SP)
        cmpi.b  #$FE,D0 
        beq.w   MD_PLUS_STOP
        cmpi.b  #$FD,D0 
        beq.w   MD_PLUS_FADE

        move.l  #$00,D2                         ; Set D2 to 0 as counter (track number)
        move.l  #$00,D3                         ; Set D3 to 0 as counter (table index)
        lea     AUDIO_TBL,A2                    ; Load audio table address into A2
LOOP
        move.w  (A2,D3),D1                      ; Load table entry into D1
        cmp.b   D1,D0                           ; Compare given sound ID in D0 to table entry loaded into D1
        beq.s   READY                           ; If given sound ID matches the entry, D2 is our track number, so we branch to .READY
                                                ; sound ID did not match:
        addi    #1,D2                           ; Increment D2 (track number)
        addi    #2,D3                           ; Increment D3 by word-size (table index)
        cmp.b   #TOTAL_TRACKS+1,D2              ; If we reached the total number of tracks, abort. (plus 1 for loop-breaking)
        beq.s   PASSTHROUGH                     ; If D2 equals TOTAL_TRACKS+1, no match found, branch to .PASSTHROUGH, break loop
        bra.s   LOOP                            ; Branch to .LOOP
READY
        addi    #2,D2                           ; Increment D2 by 1 (skipped in the last repetition of the loop), increment again by 1 because track 1 is SEGA and tracks starting at 2
        move.b  D2,D1                           ; Set play command, compose by setting byte from track-counter into word-sized command:
                                                ; given: [cmd][sID] -> after: [cmd][trackNo]
        jsr     WRITE_MD_PLUS_FUNCTION
        movem.l (SP)+,D1-D3/A2
        rts

PASSTHROUGH
        move.w  #$100,(IO_Z80BUS).l
PASSTHROUGH_WAIT_Z80BUS        
        btst    #0,(IO_Z80BUS).l
        bne.s   PASSTHROUGH_WAIT_Z80BUS
        move.b  #0,($A01FFE).l
        move.b  D0,($A01FFF).l
        move.w  #0,(IO_Z80BUS).l
        movem.l (SP)+,D1-D3/A2
        rts

MD_PLUS_STOP
        move.w  #$1300,D1                               ; Send cmd: pause track, no fade
        jsr     WRITE_MD_PLUS_FUNCTION
        bra.w   PASSTHROUGH

MD_PLUS_FADE
        move.w  #$13FF,D1                               ; Send cmd: pause track with fadeout
        jsr     WRITE_MD_PLUS_FUNCTION
        bra.w   PASSTHROUGH

WRITE_MD_PLUS_FUNCTION:
	move.w  #$CD54,(MD_PLUS_OVERLAY_PORT)           ; Open interface
	move.w  D1,(MD_PLUS_CMD_PORT)                   ; Send command to interface
	move.w  #$0000,(MD_PLUS_OVERLAY_PORT)           ; Close interface
	rts

PROCESS_GENERAL_SOUNDS:
        cmpi.b  #0,($FFA6DB).l
        beq     MD_PLUS_CANDIDATE
        move.w  #$100,(IO_Z80BUS).l
GENERAL_SOUNDS_WAIT_Z80BUS
        btst    #0,(IO_Z80BUS).l
        bne.s   GENERAL_SOUNDS_WAIT_Z80BUS
        move.b  ($FFA6DB).l,($A01FFE).l
        move.b  ($FFA6DA).l,($A01FFF).l
        move.w  #0,(IO_Z80BUS).l
        rts
MD_PLUS_CANDIDATE
        move.l  D0,-(SP)
        move.b  ($FFA6DA).l,D0
        jsr     PLAY_SOUND
        move.l  (SP)+,D0
        rts

