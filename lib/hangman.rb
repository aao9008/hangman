require 'csv'

# This class handles game control flow and logic
class Hangman
  
  # Initialize the game object 
  def initialize
    # Variable stores word user must guess
    @word = "cat"

    # Counter keeps track of how many guesses user has made (User gets 6 max guesses)
    @counter = 0 

    # Array to hold previous user guesses
    @past_guesses = []

    # Array will hold "blank" spaces and be updated with users correct guesses 
    @displayed_word = Array.new(@word.length, "_ ")

    check_for_match("cat")
    
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

  # Get user guess in form of letter or word 
  def get_guess
    puts ("Pick a guess or try to guess the word: ")
    guess = gets.chomp.downcase

    # Keep prompting for input unless user provides a letter or  provides a word that is same length as secret word 
    until /^[a-z]{1}$/.match(guess).to_s == guess || /^[a-z]{#{@word.length}}$/.match(guess).to_s == guess
      puts "Please enter a valid guess or a valid guess (The secret word is #{@word.length} guesss long)"

      guess = gets.chomp.downcase
    end 
  end 

  def check_for_match(guess)
    # If guess is a word and does not match secret word, increase counter 
    if guess.length > 1 && guess != @word
      @counter += 1
      past_guesses.push(guess)
      return 
    elsif guess.length > 1 && guess == word
      @displayed_word = guess
      return 
    end 

    # If guess is a letter, check if it matches any letters in the secret word
    right_letter = (0..word.length).select do |index|
      # If letter is a match return index(s) that are a match 
      @word[index] == letter
    end  

    if right_letter.length == 0
      @counter += 1
      past_guesses.push(guess)
    end 

    right_letter.each do |index|
      @displayed_word[index] = "#{gues} "
    end 
  end 


end 

