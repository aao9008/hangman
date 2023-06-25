require 'csv'
require 'json'

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
  end 

  def intro_text
    puts <<~INTRO
      Welcome to Hangman!

      Hangman is a word guessing game for one player. 

      In this version of hangman you will be playing against the computer. 
      The computer will pick a 5-12 character word and you will have to guess it. 

      You have a total of 6 guesses. Each guess can be a single character or you can try to guess the whole word. 

      At any point in the game, you can press "0" to save your game and cointinue it later. 

      Good luck!
    INTRO
  end 

  def play
    # Display game rules 
    intro_text

    puts "\n", @displayed_word.join, "\n"

    # Continue game until word has been guessed 
    until @displayed_word.none?("_ ")
      # IF counter reaches 6, user has no reamaining guesses and it is game over 
      if @counter >= 6
        puts "You lost!"
        exit 
      end 

      # Get user guess
      guess = get_guess

      # Check user guess for a match to secret word or part of the secret word. 
      check_for_match(guess)
      # Print list of previous guesses and print current status of gameboard to the terminal 
      display_gameboard
    end 

    # Loop has sucessfuly met end conditions and user has won 
    puts "You win!"
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
    puts "Pick a letter or try to guess the word! (0 to save game)"
    guess = gets.chomp.downcase

    # Keep prompting for input unless user provides a letter or  provides a word that is same length as secret word 
    until /^[a-z]{1}$/.match(guess).to_s == guess || /^[a-z]{#{@word.length}}$/.match(guess).to_s == guess
      puts "Please enter a valid letter or a valid guess (The secret word is #{@word.length} guesss long)"

      guess = gets.chomp.downcase
    end 

    # Return user input
    guess
  end 

  def check_for_match(guess)
    # If guess is a word and does not match secret word, increase counter 
    if guess.length > 1 && guess != @word
      @counter += 1
      past_guesses.push(guess)
      return 
    elsif guess.length > 1 && guess == @word
      @displayed_word = [guess]
      return 
    end 

    # If guess is a letter, check if it matches any letters in the secret word
    right_letter = (0..@word.length).select do |index|
      # If letter is a match return index(s) that are a match 
      @word[index] == guess
    end  

    # There were no right letters, increase counter 
    if right_letter.length == 0
      @counter += 1
      @past_guesses.push(guess)
    end 

    # 
    right_letter.each do |index|
      @displayed_word[index] = "#{guess} "
    end 
  end 

  def display_gameboard
    puts "\n", "Past guesses: #{@past_guesses.join(", ")}"
    puts @displayed_word.join
  end 

  def save_game
    data = {"word": @word, "displayed_word": @displayed_word, "counter": @counter, "past_guesses": @past_guesses}

    file = file.open('savegame.json', 'w')

    file.write(data.json)

    file.close
  end 
  
end 
