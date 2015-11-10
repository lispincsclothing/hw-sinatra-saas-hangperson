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
    if (letter.nil?) || (letter.empty?) || (letter =~ /[^[:alpha:]]/)
      fail ArgumentError
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

  def word_with_guesses
    printword = ''
    length = @word.length
    i = 0
    while i < length
      if @guesses.include? @word[i]
        printword << @word[i]
      else
        printword << '-'
      end
      i += 1
    end
    printword
  end

  def check_win_or_lose
    return :lose if wrong_guesses.length > 6
    i = 0
    length = @word.length
    while i < length
      return :play unless @guesses.include? @word[i]
      i += 1
    end
    :win
  end
end
