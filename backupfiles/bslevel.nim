import welcome
#Display the level
const
    WIDTH = 41
    HEIGHT = 15

# Creating an enum identifier
type
    EnityType* = enum 
        etEmpty, etWall, etMonster, etHero
    
    # Like Vectors in godot engine
    Position* = tuple[x,y: int]

    Board* = object 
        grid: array[0..HEIGHT-1, array[0..WIDTH-1,char]]
        heroPos: Position
        monPos: Position

proc initBoard*():Board =
    var board = Board()
    # Define each row as an array of characters
    let boardData = [
        "#########################################",
        "#  ss         #   G  #                  #",
        "# s#########  ######## ################ #",
        "# #           # K   N#      ##          #",
        "# # ##### ### ### #### ###  ##  ####### #",
        "# #       ###   Z  Z   ###      ######  #",
        "# #### s####     Z Z   ### ######      ##",
        "# ####s #### ############# ###### # # # #",
        "#   ## s#### ############  ###### # #C# #",
        "# # ##  ####       S     # ##     # ### #",
        "# #    S ##### #######  ##  ##### #     #",
        "# #####  ##### #######  ### ##### ##### #",
        "#                                       #",
        "################   ######################",
        "################ H ######################"
    ]

    #Initialize the board
    for row in 0..HEIGHT-1:
        for col in 0..WIDTH-1:
            board.grid[row][col] = boardData[row][col]
            #Find initial hero position
            if boardData[row][col] == 'H':
                board.heroPos = (x: row, y:col)

    result = board

proc printBoard*(board: Board) =
    for row in 0..HEIGHT-1:
        for col in 0..WIDTH-1:
            stdout.write board.grid[row][col]
        echo "" #Print new line after each row

#[Checks What kind of enity and what to do.
returns a bool value.
]#
proc checkEnity(enity:char)=
    #Case syntax of the Enum
    case enity

    of 'S','Z','K','N','G':
        echo "Message: "
        echo "I'm a Monster \n"

    of '#':
        echo "Message: "
        echo "I'm a wall! You shall not pass. \n"

    of 'C':
        echo "Message: "
        echo "You found a chest. You opened it and found the Master Sword. \n"


    else:
        echo "Message: "
        echo "What are you!? \n"
        
proc moveHero*(board: var Board) = 
    var oldPos = board.heroPos 
    var newPos = oldPos 

    echo "To Move Press: W for up, D for Right, S for Down, A for Left"
    var direction = readLine(stdin)
    
    case direction:
        of "w","W": newPos.x -= 1 # move UP
        of "S","s": newPos.x += 1 # move Down
        of "A","a": newPos.y -= 1 # move Left
        of "D","d": newPos.y += 1 # move right 

    if board.grid[newPos.x][newPos.y] == ' ':
        # Update the board with the new hero position 
        board.grid[oldPos.x][oldPos.y] = ' ' 
        board.grid[newPos.x][newPos.y] = 'H' 
        board.heroPos = newPos 
        
        clearTerminal()
        printBoard(board)
    else:
        clearTerminal()
        var enity = board.grid[newPos.x][newPos.y]
        checkEnity(enity)
        printBoard(board)

    
proc checkPosition(board: var Board) = 
    var board = board
    var newPos = board.heroPos
    echo "CheckPosition: ",newPos
    

if isMainModule:
    var mylevel = initBoard()
    printBoard(mylevel)
    while true:
        moveHero(mylevel)
        checkPosition(myLevel)
        