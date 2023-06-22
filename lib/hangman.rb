require 'csv'

# This class handles game control flow and logic
class Hangman
  
  # Initialize the game object 
  def initialize
    @word = choose_word

    puts @word.length

    @displayed_word = Array.new(@word.length, "_ ")

    get_letter_or_guess
    
   #intro_text
  end 

  def intro_text
    puts <<-INTRO
      Welcome to Hangman!

      Hangmand is a word guessing game for one player. 

      In this version of hangman you will be playing against the computer. The computer will pick a 5-12 character word and you will have to guess it. 

      You have a total of 6 guesses. Each guess can be a single character or you can try to guess the whole word. 

      Good luck!
    INTRO
  end 

  private

  def choose_word
    # Read file line by line and save words into array. 
    dictionary = CSV.open('google-10000-english-no-swears.txt').read

    # Generate random number to access random word in dictionary array
    word = ""

    # Keep randomly accessing word from dictionary array until it meets the character length requirements 
    until word.length >= 5 && word.length <= 12
      word = dictionary[rand(dictionary.length)][0].downcase
    end 

    # Return selected word
    word 
  end

  def get_letter_or_guess
    puts ("Pick a letter: ")
    letter = gets.chomp.downcase

    until /^[a-z]{1}$/.match(letter).to_s == letter || /^[a-z]{#{@word.length}}$/.match(letter).to_s == letter
      puts "Please enter a valid letter or a valid guess (The secret word is #{@word.length} letters long)"

      letter = gets.chomp.downcase
    end 
  end 

end 

