#include gems here
require "rubygems"

require "colored"
#a combined array numbers corresponding the previous word string
old_arr = ["red",0,"green",1,"yellow",2,"blue",3,"magenta",4,"cyan",5]

arr = [0,1,2,3,4,5,"red","green","yellow","blue","magenta","cyan"]

#TODO how do I calculate complements?

rng = Random.new
#rng2 = Random.new

currLevel = 0 

c = "s"

continue = true

NUM_LEVELS = 8


def printJumble(word, color)

	arr = [0,1,2,3,4,5,"red","green","yellow","blue","magenta","cyan"]

	#word = rng.rand(6..11)

	#color = rng.rand(0..5)

	color = color % 6

	puts "Entered printJumble!"

	case color

	when 0
		puts arr[word].red()
	when 1
		puts arr[word].green()
	when 2
		puts arr[word].yellow()
	when 3
		puts arr[word].blue()
	when 4
		puts arr[word].magenta()
	when 5
		puts arr[word].cyan()
	end

end


def singleColor()

	#while time not expired


end

def singleWord ()

end

def wordThenColor()

end

def colorThenWord ()

end

def firstWordSecondColor()

end

def firstColorSecondWord()

end

def complementColor()

end

def complementWord()

end




def playLevel (n)
	
	lvl = n % NUM_LEVELS

	case lvl
	when 0
		puts "Write the color, not the word"
		singleColor()
	when 1
		puts "Write the word, not the color"
		singleWord()
	when 2
		puts "Write the color, followed by the word"
		colorThenWord()
	when 3
		puts "Write the word, followed by the color"
		wordThenColor()
	when 4
		puts "Write the first color, then the second word"
		firstColorSecondWord()
	when 5
		puts "Write the first word, then the second color"
		firstWordSecondColor()
	when 6
		puts "Write the complement color"
		complementColor()
	when 7
		puts "Write the complement word"
		complementWord()
	end

	time = 0 #FIXME
	while (time != 0)
		#stuff here
	end
	
	puts "Level over".cyan()

end


while (continue)

	puts "Please enter 's' to begin or 'q' to quit".red()
	
	c = gets.chomp

	if c == "s"
		puts "Starting level"
		playLevel(currLevel)
		currLevel += 1
	elsif c == "q"
		continue = false 
	elsif c == "HELLO"
		puts "Hello to you!"
	elsif c == "t"
		puts "TESTING, first enter a numer 6..11, then 0..5"
		x = gets.chomp
		y = gets.chomp

		x = x.to_i
		y = y.to_i

		printJumble(x,y)
	else
		puts c
	end


end 	

	


puts ("Congrats! You got to level #{currLevel}")
