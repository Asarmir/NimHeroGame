import json, shared


#Creates the hero With begining stats
proc makeAHero*(): Hero =
    # Properly initalize the hero object
    result = Hero(
        symbol: 'H',
        hp: 10,
        maxHp: 10,
        atk:15,
        def: 15,
        agi: 10,
        item: (name: "Sword", atk: 15)
    )
    echo "What shall we call you hero?"
    result.name = readLine(stdin)

# Load the JSON file
let jsonFile* = parseFile("./Assets/monsters.json")
#Makes sequence of type Monster
var monsters* = newSeq[Monster]()

# Converts jsonNode into Monster Obj
proc makeAMonster*(myFile: JsonNode): seq[Monster] =
    monsters.setLen(0) # Clear existing monsters
    for monsterData in jsonFile:
        let symbolStr = monsterData["symbol"].getStr()
        let monster = Monster(
            name: monsterData["name"].getStr(),
            symbol: symbolStr[0],
            hp: monsterData["hp"].getInt(),
            maxHp: monsterData["maxhp"].getInt(),
            atk: monsterData["atk"].getInt(),
            def: monsterData["def"].getInt(),
            agi: monsterData["agi"].getInt(),
            drops: (name: "Gold", amount: 100)
        )
        monsters.add(monster)
    return monsters

#figure out how to check types in an If statement
proc displayStats*[T](char: T) =
    
    if char is Hero:
        echo "Name: ", (cast[Hero](char)).name, " Hp: ", (cast[Hero](char)).hp, "/", (cast[Hero](char)).maxHp, " ATK: ", (cast[Hero](char)).atk, " DEF: ", (cast[Hero](char)).def, " AGI: ", (cast[Hero](char)).agi, " Position: ", (cast[Hero](char)).position
        echo "Item: ", (cast[Hero](char)).item.name, " Atk: ", (cast[Hero](char)).item.atk
    
    if char is Monster:
        echo "Name: ", (cast[Monster](char)).name, " Hp: ", (cast[Monster](char)).hp, "/", (cast[Monster](char)).maxHp, " ATK: ", (cast[Monster](char)).atk, " DEF: ", (cast[Monster](char)).def, " AGI: ", (cast[Monster](char)).agi, " Position: ", char.position
        echo "Drop: ", (cast[Monster](char)).drops.name, " Amount: ", (cast[Monster](char)).drops.amount
    
# Takes in enemies attack and applies it to the target hp.
# proc takeDmg*(char:Character,damage: int)=
#     var dmg = damage
#     char.def -= dmg
#     char.hp = char.hp - dmg 
#     if char.hp < 0:
#         char.hp = 0
    
when isMainModule:
    var hero = makeAHero()
    echo "\nHero stats:"
    displayStats(hero)

    discard makeAMonster(jsonFile)
    for mon in monsters:
        if mon.name == "Zombie":
            echo "\nZombie stats:"
            displayStats(mon)

# echo jsonFile.pretty()
# echo jsonFile[0]
# echo jsonFile[0]["name"].getStr()
