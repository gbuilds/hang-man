require 'pstore'

class Game
  attr_accessor :name, :playing, :lives
  
  def initialize(name)
    @name = name
    @playing = true
    @lives = 9
    dictionary = load_dictionary
    @word = get_random_word(dictionary)
    @letters = @word.split("")
    @matched_letters = Array.new(@word.length, "_")
    @guessed = []
  end
  
  def load_dictionary
    f = File.open("5desk.txt", "r")
    dictionary_array = f.read.split.select { |word| word.length.between?(5,12)}
    f.close
    dictionary_array
  end
  
  def get_random_word(dictionary)
    random_word = dictionary[rand(0..dictionary.length - 1)]
    random_word = random_word.downcase
  end
  
  def start   
    puts "Starting Pirate Hangman. All letters are lowercase."
    puts "Enter 'save' to save and exit the game."
    puts "Do you want to start from your pre-existing game? Choose no to start new game. y/n"
    answer = gets.chomp
    load_game if answer == "y"
    play
  end
  
  def play
    while @playing == true
      puts "Guessed: " + @guessed.join(", ") unless @guessed.empty?
      puts @matched_letters.join(" ")
      puts "#{lives} lives. What is your guess?"
      guess = gets.chomp
      save_game if guess == "save"
      @guessed << guess unless guess == "save"
      hit = false
      @letters.each_with_index do |letter, index|
        if letter == guess
          @matched_letters[index] = letter
          puts "ARRRRRR Matey!!!" if letter == "r"
          hit = true
        end
      end
      @lives -= 1 if hit == false
      if @matched_letters == @letters
        @playing = false 
        puts "Nice job guessing the word. The King grants you a pardon. The crowd goes wild."
        puts "You live on while dazzling your pirate crew with words like #{@word}."
      elsif @lives == 0
        @playing = false 
        puts "After one final chance you couldn't solve the word, so you were hanged."
        puts "By the way, it was #{@word}. You'll have great vocabulary in the afterlife!"
      end
    end

  end
  
  def save_game
    saved_game = PStore.new("saved_game.pstore")
    saved_game.transaction do
      saved_game[:name] = @name
      saved_game[:playing] = @playing
      saved_game[:lives] = @lives
      saved_game[:word] = @word
      saved_game[:letters] = @letters
      saved_game[:matched_letters] = @matched_letters
      saved_game[:guessed] = @guessed
    end
    @playing = false
  end
  
  def load_game
    game = PStore.new("saved_game.pstore")
    game.transaction do
      @name = game[:name]
      @playing = game[:playing]
      @lives = game[:lives]
      @word = game[:word]
      @letters = game[:letters]
      @matched_letters = game[:matched_letters]
      @guessed = game[:guessed]
    end
  end
  
end

# start new Game
# generate random word
# display blanks 
# prompt for guess
# compare guess with word
# if miss remove a life
# if hit, add letters to word
# check if all letters are matched
# loop until dead or until all letters are matched and declare winner
# when you elect to save game you need to save: name, random_word, guesses, matched_letters, lives_remaining

mygame = Game.new("Gordie")
mygame.start

