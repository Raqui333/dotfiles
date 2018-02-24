#!/usr/bin/python3.5

import curses

def main(win):
    y, x = win.getmaxyx()

    curses.init_pair(1, curses.COLOR_BLACK, curses.COLOR_WHITE)
    curses.init_pair(2, curses.COLOR_WHITE, curses.COLOR_CYAN)
    curses.init_pair(3, curses.COLOR_RED, curses.COLOR_BLACK)

    titleBar = " [q] to quit "

    msgTitle = " Teste Python Curses "

    while True:
        win.refresh()
    
        mouseY, mouseX = win.getyx()
        mousePosition = " Mouse Position: " + str(mouseY) + ", " + str(mouseX)

        ## Title Bar
        win.addstr(0, 0, titleBar, curses.color_pair(1))
        win.addstr(0, len(titleBar), "", curses.color_pair(2))
        
        win.addstr(0, x - len(mousePosition), mousePosition, curses.color_pair(1))
        win.addstr(0, x - len(mousePosition) - 1, "", curses.color_pair(2))

        win.addstr(0, len(titleBar) + 1, " " * (x - len(titleBar) - len(mousePosition) - 2), curses.color_pair(2))

        ## Title
        win.addstr((y // 2), (x // 2 - (len(msgTitle) // 2)), msgTitle, curses.color_pair(3))

        ## Move cursor
        win.move(2,0)

        ## Options
        key = win.getkey()
        
        if key == "q":
            break

curses.wrapper(main)
