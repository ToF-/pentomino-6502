; draw a 4 pixel block on top left corner

    lda #$05
    sta $0200
    sta $0201
    sta $0220
    sta $0221
    rts
