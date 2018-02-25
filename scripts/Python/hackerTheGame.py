#!/usr/bin/python3.5

## Hacker - The Game
## Run and see About

## I'm going to make this game for fun
## and of course learn with it

## import modules
from time import sleep
from os import system

## Colors
class color:
    reset = "\033[00m"

    red         = "\033[0;31m"
    green       = "\033[0;32m"
    yellow      = "\033[0;33m"
    dark_blue   = "\033[0;34m"
    purple      = "\033[0;35m"
    light_blue  = "\033[0;36m"
    white       = "\033[0;37m"

    class bold:
        red         = "\033[1;31m"
        green       = "\033[1;32m"
        yellow      = "\033[1;33m"
        dark_blue   = "\033[1;34m"
        purple      = "\033[1;35m"
        light_blue  = "\033[1;36m"
        white       = "\033[1;37m"

## Features
class feature:
    italic       = "\033[3m"
    underline    = "\033[4m"
    alert        = "\033[5m"
    background   = "\033[7m"

## Title of the game
gameTitle = color.bold.red + \
        "░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░░░░░░░░░▀█▀░█░█░█▀▀░░░█▀▀░█▀█░█▄█░█▀▀\n" \
        "░█▀█░█▀█░█░░░█▀▄░█▀▀░█▀▄░░░▄▄▄░░░░█░░█▀█░█▀▀░░░█░█░█▀█░█░█░█▀▀\n" \
        "░▀░▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░░░░░░░░░▀░░▀░▀░▀▀▀░░░▀▀▀░▀░▀░▀░▀░▀▀▀\n" + color.reset

## Main menu of the game
def startMenu(option):
    anwser = option

    system("clear")
    print(gameTitle)

    ## Options in main Menu
    print(color.bold.green + " [0] " + color.bold.white + "-" + color.bold.yellow + " Quit ")
    print(color.bold.green + " [1] " + color.bold.white + "-" + color.bold.yellow + " Play ")
    print(color.bold.green + " [2] " + color.bold.white + "-" + color.bold.yellow + " About \n")

    if anwser == None: anwser = input(color.reset + "> ")
    return anwser

## About
def aboutMenu(option):
    anwser = option

    system("clear")
    print(gameTitle)

    aboutText = " This game has created to study \n" \
                " created in python3.5 by me \n" \
                " I chose the title 'Hacker - The Game' because... \n" \
                " I'm a hacker. \n"

    print(color.bold.light_blue + aboutText)

    ## Options in AboutMenu
    print(color.bold.green + " [0] " + color.bold.white + "-" + color.bold.yellow + " Quit ")
    print(color.bold.green + " [1] " + color.bold.white + "-" + color.bold.yellow + " Back \n")

    if anwser == None: anwser = input(color.reset + "> ")
    return anwser

## The Game
def main():
    system("clear")
    print(gameTitle)

    print(color.green + feature.underline + " Welcome to the Hacker Area \n")

    print(color.green + " Booting Device: \n")
    
    ## Hide Cursor
    system("setterm -cursor off")

    ## Progress Bar
    print("   " , end="")
    
    for i in range(0,30):
        print(color.bold.green + feature.background + " ", end="", flush=True)
        sleep(0.03)

    ## Game
    sleep(1)
    print(color.green + "\n\n in construction \n")

    ## Back Cursor
    system("setterm -cursor on")

## Menu
def menu(option):
    firstMenu = startMenu(option)

    if firstMenu == "0":
        quit()
    elif firstMenu == "1":
        main()
    elif firstMenu == "2":
        secondMenu = aboutMenu(None)
        
        if secondMenu == "0":
            quit()
        elif secondMenu == "1":
            menu(None)
        else:
            print("error: no option:", secondMenu)
            sleep(1)
            menu("2")
    else:
        print("error: no option:", firstMenu)
        sleep(1)
        menu(None)

## Run Menu
menu(None)
