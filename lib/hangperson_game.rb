class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri, {}).body
  end

  def guess(letter)
    if (letter.nil?) || (letter.empty?) || (letter =~ /[^:alpha:]/)
      raise ArgumentError
    end
    letter.downcase!
    if @word.include?(letter)
      if @guesses.include?(letter)
        return false
      else
        @guesses << letter
      end
    else
      if @wrong_guesses.include?(letter)
        return false
      else
        @wrong_guesses << letter
      end
    end
  end
end
