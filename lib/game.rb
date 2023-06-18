# This class handles game control flow and logic
class Game
  
  # Initialize the game object 
  def initialize (player, cpu)
    @player = player.new(self)
    @cpu = cpu.new(self)

    intro_text
  end 
  attr_accessor :human, :cpu

  def intro_text
    puts <<-INTRO
      Welcome to Hangman!

      Hangmand is a word guessing game for one player. 

      In this version of hangman you will be playing against the computer. The computer will pick a 5-12 character word and you will have to guess it. 

      You have a total of 6 guesses. Each guess can be a single character or you can try to guess the whole word. 

      Good luck!
    INTRO
  end 
end 

