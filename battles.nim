import character, shared, level, json, welcome

var attacker:Character
var defender:Character
var canAtk:bool = false

var battleMap = @[
        #  <-- Col -->
        "-----------------",#1  ^
        "                 ",#2  |
        "                 ",#3 row
        "                 ",#4  |
        "  H           M  ",#5  V
        "-----------------" #6
    ]
var battleScene = initBoard(battleMap)

#Takes in the enemy and the hero. M is replaced By correct Monster
#Enemy and hero stats should be displayed above or below the board.
proc displayBattle*(monster: Monster,hero:Hero):Board =
    for row in 0..<battleScene.height:
        for col in 0..<battleScene.width:
            if battleScene.grid[row][col] == 'M':
                battleScene.grid[row][col] = monster.symbol
        
    displayStats(monster)# add character.nim display stat
    printBoard(battleScene)
    displayStats(hero) # Display hero stats



# After the first move this takes over until one is dead.
proc takeTurns(atk:Character,def:Character)=
    # Hero switch from attack to Defense
    if atk.symbol == 'H':
        let newAttacker = def
        defender = atk
        attacker = newAttacker
        canAtk = true
        var monster = cast[Monster](def)
        var hero = cast[Hero](atk)
        clearTerminal()
        discard displayBattle(monster,hero)


    elif atk.kind == etMonster:
        let newAttacker = def
        defender = atk
        attacker = newAttacker
        canAtk = true
        var monster = cast[Monster](atk)
        var hero = cast[Hero](def)
        clearTerminal()
        discard displayBattle(monster,hero)
    
    else:
        echo "The battle has stalled!"
        canAtk = false
        


proc checkHealth(hero:Hero,monster:Monster): bool =
    if hero.hp <= 0:
        hero.hp = 0
        echo "Hero has died!!"
        return true

    elif monster.hp <= 0:
        monster.hp = 0
        echo monster.name, " was defeated!!"
        return true

    else:
        return false

proc takeDmg(attacker:Character, defender: Character) =
    # echo "In TakeDmg"
    if attacker.symbol == 'H':
        echo "\nHero is Attacking"
        var hero = cast[Hero](attacker)
        var dmg = abs(hero.atk + hero.item.atk - defender.def )
        echo "Hero dmg: ",dmg, "\n", readLine(stdin)
        defender.hp = defender.hp - dmg
        takeTurns(hero,defender)

    elif attacker.symbol != 'H':
        echo "\n",attacker.name, " is Attacking \n"
        var dmg = abs(attacker.atk - defender.def)
        echo "Monster dmg: ",dmg, "\n", readLine(stdin)
        defender.hp = defender.hp - dmg
        takeTurns(attacker,defender)
    else:
        echo "Not atking"

# Check agi between hero and monster.
proc goFirst(hero:Hero, monster:Monster)=
    # echo "goFirst Proc"
    # echo "Hero agi: ",hero.agi, " Monster agi: ",monster.agi
    if hero.agi > monster.agi:
        echo "Hero is attacking first!", readLine(stdin)
        attacker = hero
        defender = monster
        takeDmg(attacker,defender)
    else:
        echo "Monster is attacking first!",readLine(stdin)
        attacker = monster
        defender = hero
        takeDmg(attacker,defender)
        

if isMainModule:
    var hero = makeAHero()
    var battleLvl = initBoard(battleMap)

    var myEnity:seq[Monster] = @[]
    let newMonster = Monster(
            name: "Skeleton",
            symbol: 'S',
            kind: etMonster,
            hp: 25,
            maxHp: 25,
            atk: 10,
            def: 10,
            agi: 5,
            position: (0,0),
            drops: (name: "Gold", amount: 100)
        )
    myEnity.add(newMonster)
    var skeleton = myEnity[0]
    # Game Loop Logic for battle
    var dead = checkHealth(hero,skeleton)
    discard displayBattle(skeleton, hero)
    goFirst(hero,skeleton)
    while not dead:
        if canAtk == true:
            takeDmg(attacker,defender)
        dead = checkHealth(hero,skeleton)