import os
var gameStart*: bool = false


# Function to clear the terminal 
proc clearTerminal*() =
    if defined(windows): 
        discard os.execShellCmd("cls") 
    else: discard os.execShellCmd("clear")

# takes playerINput and checks they typed correct answers
proc chkAnser(playerInput:string) = 
    var playerInput = playerInput
    var input: bool = true

    while input:

        case playerInput:
            of "start", "Start":
                echo "Game is starting"
                gameStart = true
                input = false
                

            of "quit", "Quit":
                echo "Game is exiting"
                input = false
                clearTerminal()
                

            else:
                echo "Please type start or quit!"
                var newInput = readLine(stdin)
                playerInput = newInput


# Main Menu - type start or quit passes player Input

proc welcomeScreen*():string =
    echo "Welcome to a Hero's Journey!"
    echo "Type Start to play or Quit to exit."
    
    let playerInput:string = readLine(stdin)
    chkAnser(playerInput)
