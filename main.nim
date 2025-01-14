import welcome, character, level, battles

#Welcome Screen
let answer = welcomeScreen()
var gameEnd = false
var hero:Hero
var mon:Monster

# Basic Intro Story
echo """
    The sky was heavy with dark, brooding clouds when a lone figure appeared on the horizon. 
As the stranger approached the village, a few vigilant guards—ever on the lookout for monsters 
and bandits—fixed their eyes upon the newcomer.

"Who goes there, stranger?" one of the guards called out, his voice filled with a mix of 
suspicion and curiosity.

You replied calmly, "I am but a wandering warrior, seeking rest from my travels."

Upon hearing this, a sense of relief and hope washed over the guards' faces. 
"Please, valiant warrior, lend us your aid!" one of them implored, their voices tinged with 
desperation and gratitude.
"""
# Create the Hero
if gameStart == true:
    hero =  makeAHero()
    echo "\n\tPlease, Sir ",hero.name,"! The village head's twins have been taken by monstrous creatures! The boy is destined to be our next leader,"
    echo "while the girl, is blessed by god, guides us with her prophetic words. Her influence surpasses even that of the village head himself."
    echo "We beg of you, in the name of all that is holy, please rescue them! ",hero.name," steps forward, resolute."
    echo  "\"Very well,\" he declares."

#Main Game loop
while gameEnd != true:
    var inBattle = false
    var myLevel = initBoard(mapData)
    printBoard(myLevel)
    while inBattle != true: 
        moveHero(myLevel)
