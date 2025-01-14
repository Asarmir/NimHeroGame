import welcome, shared, character, json, battles

var mapData* = @[
        "#########################################",
        "#  SS         #   G  #                  #",
        "# S#########  ######## ################ #",
        "# #           # K   N#      ##          #",
        "# # ##### ### ### #### ###  ##  ####### #",
        "# #       ###   Z  Z   ###      ######  #",
        "# #### S####     Z Z   ### ######      ##",
        "# ####S #### ############# ###### # # # #",
        "#   ## S#### ############  ###### # #C# #",
        "# # ##  ####       S     # ##     # ### #",
        "# #    S ##### #######  ##  ##### #     #",
        "# #####  ##### #######  ### ##### ##### #",
        "#                                       #",
        "################   ######################",
        "################ H ######################"
    ]

proc createEnitites(board: Board, hero: Hero, monsterData:JsonNode):(seq[Enity])=
    var entities: seq[Enity] = @[]

    # Get monsters from Json file
    
    let monsterTemplates = makeAMonster(monsterData)

    for row in 0..<board.height:
        for col in 0..<board.width:
            case board.grid[row][col]:
                of 'H':
                    hero.position = (row,col)
                else:
                    # Check for monster based on their symbol
                    for monster in monsterTemplates:
                        if board.grid[row][col] == monster.symbol:
                            let newMonster = Monster(
                                    name: monster.name,
                                    symbol: monster.symbol,
                                    kind: etMonster,
                                    hp: monster.hp,
                                    maxHp: monster.maxhp,
                                    atk: monster.atk,
                                    def: monster.def,
                                    agi: monster.agi,
                                    position: (row,col),
                                    drops: monster.drops
                                )
                            entities.add(newMonster)

    return (entities)


        
proc handleEnity(enity:Enity,board: Board, hero:Hero):Monster=
    #Takes Entities and checks what monster and starts battle
    clearTerminal()
    if enity.kind == etMonster:
        let thisMonster = cast[Monster](enity)
        # discard displayBattle(thisMonster, hero)
    else:
        echo "Nothing to see here. Move on!"

proc findAEnity(enity:char, board: var Board, enPos:Position,  monsters: seq[Enity], hero:Hero) =
    echo "Monster symbol ",enity
    for i, mon in monsters:
        if mon.symbol == enity and mon.position == enPos:
            # echo "I found Monster"
            # echo "Monster: ", mon.name, " Type: ", typeof(mon), " Position: ", mon.position
            # echo "NewMonster type: ", typeof(thisMonster)," Name: ", mon.name
            # echo "Press ENter",readLine(stdin)
            discard handleEnity(mon,board,hero)

proc moveHero*(board: var Board, hero:Hero, monsters: seq[Enity]) = 
    var oldPos = hero.position 
    var newPos = oldPos 

    echo oldPos
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
        hero.position = newPos 
        clearTerminal()
        printBoard(board)
    else:
        var enity = board.grid[newPos.x][newPos.y]
        # Setup Position to find correct Monster
        var enPos:Position = (newPos.x, newPos.y)
        # echo "Enity Symbol: ",enity, " Position: ", enPos
        findAENity(enity, board, enPos, monsters,hero)


if isMainModule:
    var hero = makeAHero()
    var mylevel = initBoard(mapData)

    var myEnity =  createEnitites(myLevel,hero,jsonFile)
    printBoard(mylevel)
    # for i in myEnity:
    #     echo "Character: ",i.name, " Position: ",i.position
    while true:
        moveHero(mylevel,hero, myEnity)
        