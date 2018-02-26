#!/usr/bin/python3.5

import curses
import time

def main(std):
    while True:
        curses.init_color(0, 1000, 0, 0)
        time.sleep(0.2)
        std.refresh()

        curses.init_color(0, 0, 1000, 0)
        time.sleep(0.2)
        std.refresh()

        curses.init_color(0, 0, 0, 1000)
        time.sleep(0.2)
        std.refresh()

curses.wrapper(main)
