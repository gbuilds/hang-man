class Game
  attr_accessor :name, :playing, :lives
  
  def initialize(name)
    @name = name
    @playing = true
    @lives = 9
  end
  
  def load_dictionary
    f = File.open("5desk.txt", "r")
    dictionary_array = f.read.split.select { |word| word.length.between?(5,12)}
    f.close
    dictionary_array
  end
  
  def get_random_word(dictionary)
    random_word = dictionary[rand(0..dictionary.length - 1)]
    p random_word
    random_word = random_word.downcase
  end
  
  def play
    dictionary = load_dictionary
    word = get_random_word(dictionary)
    letters = word.split("")
    matched_letters = Array.new(word.length, "_")
    guessed = []
    
    while @playing == true
      puts guessed.join(", ") unless guessed.empty?
      puts matched_letters.join(" ")
      puts "#{lives} lives. What is your guess?"
      guess = gets.chomp
      guessed << guess
      hit = false
      letters.each_with_index do |letter, index|
        if letter == guess
          matched_letters[index] = letter
          hit = true
        end
      end
      @lives -= 1 if hit == false
      @playing = false if matched_letters == letters
      @playing = false if @lives == 0
    end
    puts word
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

mygame = Game.new("Gordie")
mygame.play
