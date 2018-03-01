#!/usr/bin/python3.6

## Modues
from tkinter import Label, Button, Tk, PhotoImage

## Class
class testGUI:
    def __init__(self, master):
        self.master = master

        ## Max and Min Size of the Window
        self.master.maxsize(800, 600)
        self.master.minsize(800, 600)

        ## title of the window
        self.master.title("Test Graphical Interface")
        
        ## get photo
        self.image = PhotoImage(file="/path/to/image")

        ## print photo
        self.label = Label(master, image=self.image)
        self.label.pack()

        ## button one
        self.playButton = Button(master, text="TEST ONE", command=self.test, width=20, height=2)
        self.playButton.place(y=(300 - 38 - (38 / 2) - 5), x=326)

        ## button two
        self.aboutButton = Button(master, text="TEST TWO", command=self.test, width=20, height=2)
        self.aboutButton.place(y=(300 - (38 / 2)), x=326)

        ## quit button
        self.quitButton = Button(master, text="QUIT", command=quit, width=20, height=2)
        self.quitButton.place(y=300 + (38 / 2) + 5, x=326)

    ## commands to run when buttons one and two is pressed
    def test(self):
        print("NOOB")

## run window
root = Tk()
win = testGUI(root)
root.mainloop()
