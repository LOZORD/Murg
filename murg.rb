#include gems here
require "rubygems"

require "colored"
#a combined array numbers corresponding the previous word string
#old_arr = ["red",0,"green",1,"yellow",2,"blue",3,"magenta",4,"cyan",5]

puts "Welcome to MURG, a terminal text-based game.
Made by Leo Rudberg (LOZORD) in 2013-14. Written in Ruby.".magenta()
	
$arr = [0,1,2,3,4,5,"red","green","yellow","blue","magenta","cyan"]




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
	puts "I apologize to all the colorblind folks out there!"
end




#TODO FIXME how do I calculate complements?
#red-cyan
#green-magenta
#blue-yellow

$rng = Random.new
#rng2 = Random.new

currLevel = 0

$points = 0 

c = "s"

continue = true

NUM_LEVELS = 8

def secsToMillisecs(t)
	return t*1000
end

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

$timeAmount = secsToMillisecs(120)

def printJumble(color, word)

	#arr = [0,1,2,3,4,5,"red","green","yellow","blue","magenta","cyan"]

	#word = rng.rand(6..11)

	#color = rng.rand(0..5)

	color = color % 6

	#puts "Entered printJumble!"

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

def colorThenWord ()
	
	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color, word)

	entry1 = gets.chomp
	entry2 = gets.chomp

	if (entry1 == $arr[color+6] && entry2 == $arr[word])
			return 1
	else
			return 0
	end


end

def wordThenColor()

	color = $rng.rand(0..5)
	word = $rng.rand(6..11)

	printJumble(color,word)

	entry1 = gets.chomp
	#TODO how to get one line instead of two ie parse spaces?
	entry2 = gets.chomp

	if (entry1 == $arr[word] && entry2 == $arr[color+6])
			return 1
	else
			return 0
	end

end


def firstWordSecondColor()

	color1 = $rng.rand(0..5)
	word1 = $rng.rand(6..11)

	color2 = $rng.rand(0..5)
	word2 = $rng.rand(6..11)

	printJumble(color1,word1)
	printJumble(color2,word2)

	entry1 = gets.chomp
	entry2 = gets.chomp

	if (entry1 == $arr[word1] && entry2 == $arr[color2+6])
			return 1
	else
			return 0
	end

end

def firstColorSecondWord()

	color1 = $rng.rand(0..5)
	word1 = $rng.rand(6..11)

	color2 = $rng.rand(0..5)
	word2 = $rng.rand(6..11)

	printJumble(color1,word1)
	printJumble(color2,word2)

	entry1 = gets.chomp
	entry2 = gets.chomp

	if(entry1 == $arr[color1+6] && entry2 == $arr[word2])
			return 1
	else
			return 0
	end

end

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




def playLevel (n)
	
	lvl = n % NUM_LEVELS

	oldPoints = $points

	case lvl
	when 0
		puts "Write the color, not the word"
		$points += singleColor()
	when 1
		puts "Write the word, not the color"
		$points += singleWord()
	when 2
		puts "Write the color, followed by the word"
		$points += colorThenWord()
	when 3
		puts "Write the word, followed by the color"
		$points += wordThenColor()
	when 4
		puts "Write the first color, then the second word"
		$points += firstColorSecondWord()
	when 5
		puts "Write the first word, then the second color"
		$points += firstWordSecondColor()
	when 6
		puts "Write the complement color"
		$points += complementColor()
	when 7
		puts "Write the complement word"
		$points += complementWord()
	else
		puts "ERROR in playLevel"
		return
	end

	if (oldPoints != $points)
			puts "Success!".green()
	else
			puts "Failure".red()
	end

#	time = 0 #FIXME
#	while (time != 0)
		#stuff here
#	end
	
	puts "Level over".cyan()

end

puts "Please enter 'h' if this is your first time playing".blue()

while (continue)

	puts "Please enter 's' to begin or 'q' to quit".yellow()
	
	c = gets.chomp

	if c == "s"
		puts "Starting the level"
		playLevel(currLevel)
		currLevel += 1
	elsif c == "q"
		continue = false 
	elsif c == "HELLO"
		puts "Hello to you!"
	##elsif c == "t"
	#	puts "TESTING"
	#	x = gets.chomp
	#	y = gets.chomp

	#	x = x.to_i
	#	y = y.to_i

	#	printJumble(x,y)
	elsif c == "h"
		printColorHelp()
	else
		puts c
		puts "JUNK ERROR"
	end


end 	

	


puts ("Congrats! You got to level #{currLevel}, with #{$points} points!")
