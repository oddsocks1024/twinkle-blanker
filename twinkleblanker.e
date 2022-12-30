MODULE  'dos/dos',
        'exec/memory',
        'graphics/modeid',
        'intuition/intuition',
        'intuition/screens',
        'madblankersupport',
        'madhouse/madblankersupport',
        'tools/stayrandom'

DEF blankjob:PTR TO mbs_blankjob,
    screen:PTR TO screen,
    win:PTR TO window,
    colour: mbs_color,
    palette,
    screenheight,
    screenwidth,
    screenrastport,
    starlen,
    rout,
    colpref,
    i

PROC main()

     stayrandom()

    IF (madblankersupportbase:=OpenLibrary('madblankersupport.library',MADBLANKERSUPPORT_VMIN))<>NIL

        ->Mbs_debugmode()
        blankjob:=Mbs_getblankjob()
        screen:=Mbs_getscreenmodeprefs(HIRESLACE_KEY)

        IF (screen:=OpenScreenTagList (NIL,
                                      [SA_DEPTH , 8,
                                       SA_DISPLAYID, screen,
                                       SA_OVERSCAN, OSCAN_STANDARD,
                                       SA_QUIET, TRUE,
                                       SA_TITLE, 'My Blanker',
                                       NIL])) = NIL OR

                                       (win:=OpenWindowTagList (NIL,
                                                               [WA_ACTIVATE, TRUE,
                                                                WA_AUTOADJUST, TRUE,
                                                                WA_BORDERLESS, TRUE,
                                                                WA_CUSTOMSCREEN, screen,
                                                                WA_NOCAREREFRESH, TRUE,
                                                                NIL])) = NIL
            PrintF('Unable to open screen and/or window!\n')

        ELSE

            Mbs_clearmousepointer(screen)
            IF (palette := Mbs_allocpalette()) = NIL THEN PrintF('Warning cannot allocate palette!\n')
            Mbs_setpalettescreen (palette,screen)
            screenheight:=screen.height
            screenwidth:=screen.width
            screenrastport:=screen.rastport
            starlen:=Mbs_getprefs('starlen',5)
            rout:=Mbs_getprefs('rout',3)
            colpref:=Mbs_getprefs('colpref',2)

            IF colpref=1

                FOR i:=1 TO 255

                    colour.r:=i
                    colour.g:=0
                    colour.b:=0
                    Mbs_putpalettecolor(palette,i,colour)

                ENDFOR

            ENDIF

            IF colpref=2

                FOR i:=1 TO 255

                    colour.r:=0
                    colour.g:=i
                    colour.b:=0
                    Mbs_putpalettecolor(palette,i,colour)

                ENDFOR

            ENDIF

            IF colpref=3

                FOR i:=1 TO 255

                    colour.r:=0
                    colour.g:=0
                    colour.b:=i
                    Mbs_putpalettecolor(palette,i,colour)

                ENDFOR

            ENDIF

            Mbs_refreshpalette(palette,screen)
            SetAPen(screenrastport,50)

            IF rout =1 THEN routine()
            IF rout =2 THEN routine2()
            IF rout =3 THEN routine3()
            IF rout =4 THEN routine4()
            IF rout =5 THEN routine5()

        ENDIF

    ELSE

        PrintF('Unable to open Madblankersupport.library!\n')
        CleanUp(0)

    ENDIF

    IF palette THEN Mbs_freepalette(palette)
    IF win THEN CloseWindow(win)
    IF screen THEN CloseScreen(screen)

    Mbs_quit()
    CloseLibrary(madblankersupportbase)
    CleanUp(0)

ENDPROC

PROC routine()
DEF xpos,
    ypos,
    inc

    screenwidth:=(screenwidth-21)
    screenheight:=(screenheight-21)
    xpos:=Rnd(screenwidth)
    ypos:=Rnd(screenheight)
    inc:=0
    SetAPen(screenrastport,50)
    Mbs_beginautocycling(palette,1,255,1,1,0)

    WHILE Mbs_continueblanking()=MBSCB_CONTINUE

        inc:=inc+1

        IF inc>starlen
            inc:=1
            IF (xpos:=Rnd(screenwidth))<21 THEN xpos:=21
            IF (ypos:=Rnd(screenheight))<21 THEN ypos:=21
            SetAPen(screenrastport,Rnd(255))
        ENDIF

        WritePixel(screenrastport,xpos+inc,ypos)
        WritePixel(screenrastport,xpos,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos)
        WritePixel(screenrastport,xpos,ypos-inc)
        WaitTOF()

    ENDWHILE

    Mbs_endautocycling()

ENDPROC

PROC routine2()
DEF xpos,
    ypos,
    inc

    screenwidth:=(screenwidth-21)
    screenheight:=(screenheight-21)
    xpos:=Rnd(screenwidth)
    ypos:=Rnd(screenheight)
    inc:=0
    SetAPen(screenrastport,50)
    Mbs_beginautocycling(palette,1,255,1,1,0)

    WHILE Mbs_continueblanking()=MBSCB_CONTINUE

        inc:=inc+1

        IF inc>starlen
            inc:=1
            IF (xpos:=Rnd(screenwidth))<21 THEN xpos:=21
            IF (ypos:=Rnd(screenheight))<21 THEN ypos:=21
        ENDIF

        SetAPen(screenrastport,Rnd(255))
        WritePixel(screenrastport,xpos+inc,ypos)
        WritePixel(screenrastport,xpos,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos)
        WritePixel(screenrastport,xpos,ypos-inc)

        WaitTOF()

    ENDWHILE

    Mbs_endautocycling()

ENDPROC

PROC routine3()
DEF xpos,
    ypos,
    inc

    screenwidth:=(screenwidth-21)
    screenheight:=(screenheight-21)
    xpos:=Rnd(screenwidth)
    ypos:=Rnd(screenheight)
    inc:=0
    SetAPen(screenrastport,50)
    Mbs_beginautocycling(palette,1,255,1,1,0)

    WHILE Mbs_continueblanking()=MBSCB_CONTINUE

        inc:=inc+1

        IF inc>starlen
            inc:=1
            IF (xpos:=Rnd(screenwidth))<21 THEN xpos:=21
            IF (ypos:=Rnd(screenheight))<21 THEN ypos:=21
        ENDIF

        SetAPen(screenrastport,Rnd(255))
        WritePixel(screenrastport,xpos+inc,ypos)
        WritePixel(screenrastport,xpos,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos)
        WritePixel(screenrastport,xpos,ypos-inc)
        SetAPen(screenrastport,Rnd(255))
        WritePixel(screenrastport,xpos+inc,ypos+inc)
        WritePixel(screenrastport,xpos+inc,ypos-inc)
        WritePixel(screenrastport,xpos-inc,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos-inc)

        WaitTOF()

    ENDWHILE

    Mbs_endautocycling()

ENDPROC


PROC routine4()
DEF xpos,
    ypos,
    inc

    screenwidth:=(screenwidth-21)
    screenheight:=(screenheight-21)
    xpos:=Rnd(screenwidth)
    ypos:=Rnd(screenheight)
    inc:=0
    SetAPen(screenrastport,50)
    Mbs_beginautocycling(palette,1,255,1,11,0)

    WHILE Mbs_continueblanking()=MBSCB_CONTINUE

        inc:=inc+1

        IF inc>starlen
            inc:=1
            IF (xpos:=Rnd(screenwidth))<21 THEN xpos:=21
            IF (ypos:=Rnd(screenheight))<21 THEN ypos:=21
            SetAPen(screenrastport,Rnd(255))
        ENDIF

        WritePixel(screenrastport,xpos+inc,ypos+inc)
        WritePixel(screenrastport,xpos+inc,ypos-inc)
        WritePixel(screenrastport,xpos-inc,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos-inc)

        WaitTOF()

    ENDWHILE

    Mbs_endautocycling()

ENDPROC

PROC routine5()
DEF xpos,
    ypos,
    inc

    screenwidth:=(screenwidth-42)
    screenheight:=(screenheight-42)
    xpos:=Rnd(screenwidth)
    ypos:=Rnd(screenheight)
    inc:=0
    SetAPen(screenrastport,50)
    Mbs_beginautocycling(palette,1,255,1,11,0)

    WHILE Mbs_continueblanking()=MBSCB_CONTINUE

        inc:=inc+2

        IF inc>starlen
            inc:=0
            IF (xpos:=Rnd(screenwidth))<42 THEN xpos:=42
            IF (ypos:=Rnd(screenheight))<42 THEN ypos:=42
            SetAPen(screenrastport,Rnd(255))
        ENDIF

        WritePixel(screenrastport,xpos+inc,ypos+inc)
        WritePixel(screenrastport,xpos+inc,ypos-inc)
        WritePixel(screenrastport,xpos-inc,ypos+inc)
        WritePixel(screenrastport,xpos-inc,ypos-inc)

        WaitTOF()

    ENDWHILE

    Mbs_endautocycling()

ENDPROC
