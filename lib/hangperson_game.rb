class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess guess
    
    # if guess is contained in the alphabet
    if guess =~ /[[:alpha:]]/
      guess.downcase!
      if @word.include? guess and !@guesses.include? guess
        @guesses.concat guess
      elsif !@wrong_guesses.include? guess and !@word.include? guess
        @wrong_guesses.concat guess
        return true
      else
        return false
      end
    else
      guess = :invalid
      raise ArgumentError
    end
  end
  
 def word_with_guesses
    result = ""
    @word.each_char do |l|
      if @guesses.include? l
        result.concat l
      else
        result.concat '-'
      end
    end
   result
 end
 
 def check_win_or_lose
    counter = 0
    # if number of wrong guesses is greater then or equal 7,lose game
    return :lose if @wrong_guesses.length >= 7
    # if word inclused giess then increase counter
    @word.each_char do |letter|
      counter += 1 if @guesses.include? letter
    end
    # if counter = word.lenth then player wins
    if counter == @word.length then :win
    else :play end
 end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
