; test values
    lda #$05
    sta $0F
    lda #$04
    sta $10
    lda #$00
    sta $11

; draw a 4x4 pixel block on top left corner
; color in $OF; row in $10 col in $11
    lda #$00
    sta $13
    lda $10
    sta $12
    ldy #$07 ; multiply row by 64
mult_64:
    asl $12
    rol $13
    dey
    bne mult_64
    asl $11 ; multiply col by 4
    asl $11
    clc
    lda $12 ; add to destination
    adc $11
    sta $12
    lda $13
    lda #$00
    sta $13
    clc
    lda $13
    adc #$02 ; add screen base address
    sta $13
    ldy #$00
    jsr line
    ldy #$00
    jsr line
    ldy #$00
    jsr line
    ldy #$00
    jsr line
    rts

line:
    lda $0F
    jsr pixel
    iny
    jsr pixel
    iny
    jsr pixel
    iny
    jsr pixel
    clc
    lda $12
    adc #$20
    sta $12
    lda $13
    adc #$00
    sta $13
    rts
pixel:
    sta ($12),y
    rts


