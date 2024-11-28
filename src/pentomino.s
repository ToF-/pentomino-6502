; test values
    ldy #$3f
init_test:
    lda $fe
    and #$0F
    sta $a000,y
    dey
    bpl init_test

; draw a board

board:
    ldy #$3F
square:
    lda $a000,y
    sta $0F
    tya
    pha
    lsr
    lsr
    lsr
    sta $10
    tya
    and #$07
    sta $11
    jsr block
    pla
    tay
    dey
    bpl square
    rts

; draw a 4x4 pixel block on top left corner
; color in $OF; row in $10 col in $11
; block location in $12-13


block:
    lda #$00 ; base address = $200
    sta $12
    lda #$02
    sta $13
    lda $10 ; row > 0 ? add row offset
    beq add_col
    tay
add_row:
    clc
    lda $12
    adc #$80
    sta $12
    lda $13
    adc #$00
    sta $13
    dey
    bne add_row
add_col:
    asl $11 ; multiply col by 4
    asl $11
    clc
    lda $12 ; add to destination
    adc $11
    sta $12
    lda $13
    adc #$00
    sta $13
lines:
    jsr line
    jsr line
    jsr line
    jsr line
    rts

line:

    ldy #$03
pixels:
    jsr pixel
    dey
    bpl pixels
    clc
    lda $12
    adc #$20
    sta $12
    lda $13
    adc #$00
    sta $13
    rts
pixel:
    lda $0F
    sta ($12),y
    rts


