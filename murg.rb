#As of Feb 9 2014
#include gems here
require "rubygems"
require "colored"

puts "Welcome to MURG, a terminal text-based game.
Made by Leo Rudberg (LOZORD) in 2013-14. Written in Ruby.".magenta()
	
#the main array containing the colors and their names
#a color names appears 6 indicies after its number
$arr = [0,1,2,3,4,5,"red","green","yellow","blue","magenta","cyan"]

#TODO add class structure to make all of these global vars nicer
#TODO fix BUGS below

#a "help menu function"
def printColorHelp()
	puts "Red looks like this".red()
	puts "Green looks like this".green()
	puts "Yellow looks like this".yellow()
	puts "Blue looks like this".blue()
	puts "Magenta looks like this".magenta()
	puts "Cyan looks like this".cyan()
	puts "Complements are:"
	puts "Red and Cyan"
	puts "Green and Magenta"
	puts "Blue and Yellow"
	puts "When prompted for 'color', enter the color in which the word appears"
	puts "When prompted for 'word', enter the word that is written"
	puts "Please enter all data in lowercase and in a single line when "\
	"prompted for two words"
	puts "Once you have attained the required points for a given level, "\
	 "you will be asked if you want to skip to the next level"
	puts "I apologize to all the colorblind folks out there!"
end


#the random number generator used in the game
$rng = Random.new

#the players progress in the game
$currLevel = 1

#the amount of successful answers
$points = 0 

#a user input variable, an artifact of my non-dynamic coding...
c = "s"

#bool for continuing gameplay 
#(i.e. whether player is allowed to continue if (s)he wants)
$continue = true

#the amount of types of levels
NUM_LEVELS = 8


#the time allotted to the player for a game round
#this decreases to a limit as play goes on
#starts at 150 seconds, aka 2.5 minutes
$timeAvailable = 150


#given the name of a color, it returns the name of its complement
def getComplement(color)
	case color

	when "red"
		return "cyan"
	when "green"
		return "magenta"
	when "yellow"
		return "blue"
	when "blue"
		return "yellow"
	when "magenta"
		return "green"
	when "cyan"
		return "red"
	else
		puts "ERROR in getComplement"
		return
	end

end


#the thoroughly used function that prints the name of a color given WORD
#in the color given COLOR
def printJumble(color, word)

	case color

	when 0
		puts $arr[word].red()
	when 1
		puts $arr[word].green()
	when 2
		puts $arr[word].yellow()
	when 3
		puts $arr[word].blue()
	when 4
		puts $arr[word].magenta()
	when 5
		puts $arr[word].cyan()
	end

end

#THE GAME MODES
#Game modes return a boolean-like 1 or 0 to the points counter
#if the player answers a question successfully

#gameplay mode 1/8
#asks for the color that the word is written in
def singleColor()

	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color, word)

	entry = gets.chomp

	if (entry == $arr[color+6])
			return 1
	else
			return 0
	end

end

#gameplay mode 2/8
#asks for the word that is written
def singleWord ()

	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color, word)

	entry = gets.chomp

	if (entry == $arr[word])
			return 1
	else
			return 0
	end

end

#gameplay mode 3/8
#asks for the color the word is written in,and then the word
def colorThenWord ()
	
	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color, word)

	lineArr = gets.chomp.split

	if (lineArr[0] == $arr[color+6] && lineArr[1] == $arr[word])
			return 1
	else
			return 0
	end


end

#gameplay mode 4/8
#asks for the word written, and then the color it is written in
def wordThenColor()

	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color,word)

	lineArr = gets.chomp.split

	if (lineArr[0] == $arr[word] && lineArr[1] == $arr[color+6])
			return 1
	else
			return 0
	end

end

#gameplay mode 5/8
#asks for the first word written,
#then the color of the second word written
def firstWordSecondColor()

	color1 = $rng.rand(0..5)
	word1 = $rng.rand(6..11)

	color2 = $rng.rand(0..5)
	word2 = $rng.rand(6..11)

	printJumble(color1,word1)
	printJumble(color2,word2)

	lineArr = gets.chomp.split

	if (lineArr[0] == $arr[word1] && lineArr[1] == $arr[color2+6])
			return 1
	else
			return 0
	end

end

#gameplay mode 6/8
#asks for the color of the first word written,
#then the second word written
def firstColorSecondWord()

	color1 = $rng.rand(0..5)
	word1 = $rng.rand(6..11)

	color2 = $rng.rand(0..5)
	word2 = $rng.rand(6..11)

	printJumble(color1,word1)
	printJumble(color2,word2)

	lineArr = gets.chomp.split

	if(lineArr[0] == $arr[color1+6] && lineArr[1] == $arr[word2])
			return 1
	else
			return 0
	end

end

#gameplay mode 7/8
#asks for the complement color of the color of the word written
def complementColor()
	
	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color,word)

	entry = gets.chomp

	if (entry == getComplement($arr[color+6]))
			return 1
	else
			return 0
	end

end

#gameplay mode 8/8
#asks for the complement color of the color name written
def complementWord()

	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color,word)

	entry = gets.chomp

	if (entry == getComplement($arr[word]))
			return 1
	else
			return 0
	end

end

#TODO see if the game modes can be combined into one
#gotta be DRY...


#play one of 8 levels
#when the level is over, add successes to points sum
def playLevel (n)
	
	lvl = ((n - 1) % NUM_LEVELS)

	oldPoints = $points

	# start = Time.now

	roundPoints = 0

	puts "You have #{$timeAvailable} seconds to score at " \
		"least #{$currLevel} points.\nGood luck!"

	case lvl
	when 0
		puts "Write the color, not the word"
	when 1
		puts "Write the word, not the color"
	when 2
		puts "Write the color, followed by the word"
	when 3
		puts "Write the word, followed by the color"
	when 4
		puts "Write the first color, then the second word"
	when 5
		puts "Write the first word, then the second color"
	when 6
		puts "Write the complement color"
	when 7
		puts "Write the complement word"
	else
		puts "ERROR in playLevel directions"
		return
	end

	#start the level timer
	start = Time.now

	while (Time.now < (start + $timeAvailable))

		if (((Time.now - start) % 10) == 0)
			puts "\t\t#{ime.now - start} seconds remaining"
		end

		case lvl
		when 0
			roundPoints += singleColor()
		when 1
			roundPoints += singleWord()
		when 2
			roundPoints += colorThenWord()
		when 3
			roundPoints += wordThenColor()
		when 4
			roundPoints += firstColorSecondWord()
		when 5
			roundPoints += firstWordSecondColor()
		when 6
			roundPoints += complementColor()
		when 7
			roundPoints += complementWord()
		else 
			puts "ERROR in playLevel selection"
			return
		end

		#early exit option if points satisfied
		if (roundPoints == $currLevel)
	 		puts "---POINT LEVEL REACHED---\nSkip ahead? (y/n)"
	 		c = gets.chomp
	 		if (c == "y")
	 			break
	 		end
	 	end
	end

	puts "LEVEL OVER".cyan()

	# BUG: Write the color, not the word
	# cyan
	# red
	# LEVEL OVER
	# Good job!
	# Please enter 's' to start or 'q' to quit

	# Please enter in a valid command!
	# Please enter 's' to start or 'q' to quit
		#maybe I hit enter twice?

	#Another BUG:
	#User keeps on hitting enter


	if ($currLevel > roundPoints)
		puts "You lose!".red()
		$continue = false
	else
		puts "Good job!".green()
		$currLevel += 1
		$points += roundPoints
		if ($timeAvailable > 10)
			$timeAvailable -= 5
		end
	end

end


#XXX fast forward to here (aka beginning a game)
puts "Please enter 'h' for help if this is your first time playing".blue()


#XXX THE MAIN GAME LOOP XXX
while ($continue)

	puts "Please enter 's' to start or 'q' to quit".yellow()
	
	c = gets.chomp

	#if the player chooses to start the level
	if c == "s"
		#puts "Starting the level"
		playLevel($currLevel)
		#$pointsNeeded += 1
	#if the player chooses to quit
	elsif c == "q"
		$continue = false
	#if the player wants help
	elsif c == "h"
		printColorHelp()
	#bad input
	else
		puts "Please enter in a valid command!"
	end

end 	


#XXX FINAL SCORE SUMMARY XXX
puts ("GAME OVER\n\tYou got to level #{$currLevel}, with #{$points} point(s)!".magenta())
puts "Thanks for playing!"
#END OF CODE
