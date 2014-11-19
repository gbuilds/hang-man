class Game
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  def load_dictionary
    f = File.open("5desk.txt", "r")
    dictionary_array = f.readlines
    f.close
    dictionary_array
  end
  def get_random_word(dictionary)
    random_word = dictionary_array[rand(0..dictionary_array.length - 1)]
  end
  def play
    dictionary = load_dictionary
    get_random_word(dictionary)
  end
  
  
end

# start new Game
# generate random word
# display blanks
# prompt for guess
# compare guess with word
# if miss remove a life
# if hit, add letters to word

mygame = Game.new("Gordie")

