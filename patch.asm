; Langrisser II (J) (r02) - MD+ audio patch
;
; The original game normally queues sounds through $FD7A using SOUND_COMMAND
; and SOUND_PRIORITY. A few cutscenes write directly to Z80 RAM; the hooks
; below redirect those sites back through the same original interface.

IO_Z80BUS                      equ $A11100

SOUND_COMMAND                  equ $FFA6DA
SOUND_PRIORITY                 equ $FFA6DB
Z80_SOUND_PRIORITY             equ $A01FFE
Z80_SOUND_COMMAND              equ $A01FFF

ORIGINAL_SOUND_STOP            equ $FCBA
ORIGINAL_SOUND_FADE            equ $FCCE
ORIGINAL_SOUND_SEND            equ $FD7A

MD_PLUS_OVERLAY_PORT           equ $0003F7FA
MD_PLUS_RESPONSE_PORT          equ $0003F7FC
MD_PLUS_CMD_PORT               equ $0003F7FE

MD_PLUS_FIRST_BGM_TRACK        equ 2
MD_PLUS_TABLE_END              equ $FFFF

; Hooks: ------------------------------------------------------------------------------------------

        ; Opening sequence. This replaces: move.l #$0002D918,D0
        org     $2D1BE
        jsr     MD_PLUS_PLAY_SEGA

        ; Replace the game's standard Z80 mailbox writer with our dispatcher.
        org     ORIGINAL_SOUND_SEND
        jmp     MD_PLUS_SOUND_DISPATCH

; Direct sound writes: ---------------------------------------------------------------------------
;
; These original routines bypass $FD7A and write straight to $A01FFE/$A01FFF.
; Each hook now re-enters the game's standard sound-command path.

        org     $21C32                          ; BGM $29
        jsr     QUEUE_BGM_29
        jmp     $21C5C

        org     $2215E                          ; Fade $FD
        jsr     ORIGINAL_SOUND_FADE
        jmp     $22188

        org     $25F92                          ; BGM $2E
        jsr     QUEUE_BGM_2E
        jmp     $25FBC

        org     $29662                          ; BGM $01
        jsr     QUEUE_BGM_01
        jmp     $2968C

        org     $2D0C2                          ; Stop $FE
        jsr     ORIGINAL_SOUND_STOP
        jmp     $2D0EC

        org     $2D344                          ; BGM $2A
        jsr     QUEUE_BGM_2A
        jmp     $2D36E

        org     $2D50C                          ; Fade $FD
        jsr     ORIGINAL_SOUND_FADE
        jmp     $2D536

        org     $2D59C                          ; Fade $FD
        jsr     ORIGINAL_SOUND_FADE
        jmp     $2D5C6

        org     $2D694                          ; Stop $FE
        jsr     ORIGINAL_SOUND_STOP
        jmp     $2D6BE

        org     $2D7CE                          ; BGM $2A
        jsr     QUEUE_BGM_2A
        jmp     $2D7F8

        org     $2D806                          ; Stop $FE
        jsr     ORIGINAL_SOUND_STOP
        jmp     $2D830

        org     $2D83A                          ; BGM $2A
        jsr     QUEUE_BGM_2A
        jmp     $2D864

        org     $2DEE0                          ; Stop $FE
        jsr     ORIGINAL_SOUND_STOP
        jmp     $2DF0A

        org     $2DF14                          ; BGM $2A
        jsr     QUEUE_BGM_2A
        jmp     $2DF3E

        org     $2E47C                          ; BGM $2B
        jsr     QUEUE_BGM_2B
        jmp     $2E4A6

        org     $2F73E                          ; Stop $FE
        jsr     ORIGINAL_SOUND_STOP
        jmp     $2F768

        org     $2F772                          ; BGM $2C
        jsr     QUEUE_BGM_2C
        jmp     $2F79C

        org     $30BD4                          ; Fade $FD
        jsr     ORIGINAL_SOUND_FADE
        jmp     $30BFE

        org     $30C90                          ; BGM $2D
        jsr     QUEUE_BGM_2D
        jmp     $30CBA

; Patch code in unused ROM padding: ---------------------------------------------------------------

        org     $311B0

; Fixed-command wrappers preserve all registers and feed direct cutscene BGM
; requests back through the original SOUND_COMMAND/SOUND_PRIORITY interface.

QUEUE_BGM_01:
        move.b  #$01,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_29:
        move.b  #$29,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_2A:
        move.b  #$2A,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_2B:
        move.b  #$2B,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_2C:
        move.b  #$2C,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_2D:
        move.b  #$2D,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM_2E:
        move.b  #$2E,(SOUND_COMMAND).l
        bra.w   QUEUE_BGM

QUEUE_BGM:
        clr.b   (SOUND_PRIORITY).l
        jmp     ORIGINAL_SOUND_SEND

; Track table: ------------------------------------------------------------------------------------
;
; Each word is [MD+ command][original BGM command]. $11 plays once and $12
; loops. The external MD+ track number is the table position plus 2 because
; MD+ track 1 is reserved for the opening SEGA sequence.

        align   2

MD_PLUS_TRACK_TABLE:
        dc.w    $122A                           ; MD+ 02 - Opening Theme (Part 1)
        dc.w    $112B                           ; MD+ 03 - Opening Theme (Part 2)
        dc.w    $122E                           ; MD+ 04 - Main Theme of Langrisser
        dc.w    $1201                           ; MD+ 05 - Neo Holy War
        dc.w    $1209                           ; MD+ 06 - Leon
        dc.w    $1202                           ; MD+ 07 - Knight's Errand
        dc.w    $120A                           ; MD+ 08 - Bargas
        dc.w    $1208                           ; MD+ 09 - One's Side
        dc.w    $1221                           ; MD+ 10 - Morgan
        dc.w    $1203                           ; MD+ 11 - No Surrender
        dc.w    $120C                           ; MD+ 12 - Jessica
        dc.w    $120D                           ; MD+ 13 - Ancient Magic
        dc.w    $1222                           ; MD+ 14 - The Evil Person
        dc.w    $1228                           ; MD+ 15 - Enemy Reinforcements
        dc.w    $120E                           ; MD+ 16 - Riana
        dc.w    $1204                           ; MD+ 17 - Fight it Out
        dc.w    $1223                           ; MD+ 18 - Eggbert
        dc.w    $1205                           ; MD+ 19 - The Legend of Sword
        dc.w    $1229                           ; MD+ 20 - Shop
        dc.w    $1224                           ; MD+ 21 - Imelda
        dc.w    $1225                           ; MD+ 22 - The Dark Princess
        dc.w    $1226                           ; MD+ 23 - Bosel
        dc.w    $120B                           ; MD+ 24 - Aniki
        dc.w    $1206                           ; MD+ 25 - Soldier
        dc.w    $1227                           ; MD+ 26 - Bernhardt
        dc.w    $1207                           ; MD+ 27 - The Last Battle
        dc.w    $112C                           ; MD+ 28 - Ending Theme (Part 1)
        dc.w    $1230                           ; MD+ 29 - A Story Forever (Part 1)
        dc.w    $112D                           ; MD+ 30 - A Story Forever (Part 2)
        dc.w    $1131                           ; MD+ 31 - Ending Theme (Part 4)
        dc.w    $122F                           ; MD+ 32 - Requiem
        dc.w    MD_PLUS_TABLE_END

; Central sound dispatcher: ----------------------------------------------------------------------

MD_PLUS_SOUND_DISPATCH:
        ; Nonzero priority is used by sound effects. Preserve the original path.
        tst.b   (SOUND_PRIORITY).l
        bne.w   WRITE_ORIGINAL_SOUND

        movem.l D0-D3/A2,-(SP)
        moveq   #0,D0
        move.b  (SOUND_COMMAND).l,D0

        cmpi.b  #$FE,D0
        beq.w   MD_PLUS_STOP
        cmpi.b  #$FD,D0
        beq.w   MD_PLUS_FADE

        moveq   #MD_PLUS_FIRST_BGM_TRACK,D2
        lea     MD_PLUS_TRACK_TABLE,A2

MD_PLUS_FIND_TRACK:
        move.w  (A2)+,D1
        cmpi.w  #MD_PLUS_TABLE_END,D1
        beq.w   MD_PLUS_NOT_HANDLED
        cmp.b   D1,D0
        beq.s   MD_PLUS_TRACK_FOUND
        addq.b  #1,D2
        bra.s   MD_PLUS_FIND_TRACK

MD_PLUS_TRACK_FOUND:
        move.b  D2,D1                           ; Keep the $11/$12 command byte.
        jsr     WRITE_MD_PLUS_FUNCTION
        movem.l (SP)+,D0-D3/A2
        rts

MD_PLUS_NOT_HANDLED:
        movem.l (SP)+,D0-D3/A2
        bra.w   WRITE_ORIGINAL_SOUND

MD_PLUS_STOP:
        move.w  #$1300,D1                       ; Pause immediately.
        jsr     WRITE_MD_PLUS_FUNCTION
        movem.l (SP)+,D0-D3/A2
        bra.w   WRITE_ORIGINAL_SOUND

MD_PLUS_FADE:
        move.w  #$13FF,D1                       ; Pause with fadeout.
        jsr     WRITE_MD_PLUS_FUNCTION
        movem.l (SP)+,D0-D3/A2
        bra.w   WRITE_ORIGINAL_SOUND

; Original $FD7A behavior, kept in one place for SFX and unhandled commands.

WRITE_ORIGINAL_SOUND:
        move.w  #$100,(IO_Z80BUS).l

WRITE_ORIGINAL_SOUND_WAIT:
        btst    #0,(IO_Z80BUS).l
        bne.s   WRITE_ORIGINAL_SOUND_WAIT
        move.b  (SOUND_PRIORITY).l,(Z80_SOUND_PRIORITY).l
        move.b  (SOUND_COMMAND).l,(Z80_SOUND_COMMAND).l
        move.w  #0,(IO_Z80BUS).l
        rts

; MD+ interface: ----------------------------------------------------------------------------------

MD_PLUS_PLAY_SEGA:
        move.l  D1,-(SP)
        move.w  #$1101,D1                       ; Play external track 1 once.
        jsr     WRITE_MD_PLUS_FUNCTION
        move.l  (SP)+,D1
        move.l  #$0002D918,D0                   ; Replaced original instruction.
        rts

WRITE_MD_PLUS_FUNCTION:
        move.w  #$CD54,(MD_PLUS_OVERLAY_PORT)
        move.w  D1,(MD_PLUS_CMD_PORT)
        move.w  #$0000,(MD_PLUS_OVERLAY_PORT)
        rts
