# Creating an enum identifier
type 
    EnityType* = enum 
        etEmpty, etWall, etMonster, etChest
    
    # Like Vectors in godot engine
    Position* = tuple[x,y: int]

    Enity* = ref object of RootObj
        name*: string
        symbol*: char
        kind*: EnityType
        position*: Position

    Character* = ref object of Enity
        hp*: int # Current hp
        maxhp*: int #Total hp
        atk*: int # deals dmg
        def*: int # determines how much dmg you take based on aggressers atk values
        agi*: int  # determines who goes first
        
    
    Hero* = ref object of Character
        item*: tuple[name: string, atk: int]

    Monster* = ref object of Character
        drops*: tuple[name: string, amount: int]

    Board* = object 
        grid*: seq[seq[char]] #Allows me to store data dynamically
        width*: int #store dimension
        height*: int # width and height combine makes a vector2d
        entities*: seq[Enity]
        # heroPos*: Position

proc initBoard*(mapData: seq[string]):Board =
    # Set the board object to an variable I can munipulate
    var board = Board()

    # Sets dimensions based on the map data
    board.height = mapData.len
    board.width = if mapData.len > 0: mapData[0].len else: 0

    #Initialize the grid
    board.grid = newSeq[seq[char]](board.height)
    for i in 0..<board.height:
        board.grid[i] = newSeq[char](board.width)
    
    # fill the grid
    for row in 0..<board.height:
        for col in 0..<board.width:
            board.grid[row][col] = mapData[row][col]
    # let (entities, heroPos) = findEnitites(board)
    # board.entities = entities
    # board.heroPos = heroPos
    
    result = board

proc printBoard*(board: Board) =
    for row in 0..<board.height:
        for col in 0..<board.width:
            stdout.write board.grid[row][col]
        echo "" #Print new line after each row