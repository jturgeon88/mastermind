class Code
  PEGS = {
    "b" => :blue,
    "r" => :red,
    "g" => :green,
    "y" => :yellow,
    "o" => :orange,
    "p" => :purple
  }
  attr_reader :pegs

  def self.parse(code_string)
    pegs = []
    code_string.chars.each do |letter|
      raise ArgumentError unless PEGS.has_key?(letter.downcase)
      pegs << PEGS[letter.downcase]
    end

    Code.new(pegs)
  end

  def self.random
    random_pegs = []
    until random_pegs.length == 4
      random_pegs << PEGS.values.sample
    end
    Code.new(random_pegs)
  end

  def initialize(pegs)
    unless pegs.is_a?(Array)
      raise ArgumentError
    end
    @pegs = pegs
  end

  def [](index)
    @pegs[index]
  end

  def exact_matches(guess)
    matches = 0
    @pegs.each_index do |idx|
      if @pegs[idx] == guess.pegs[idx]
        matches += 1
      end
    end

    matches
  end

  def near_matches(guess)
    # n_matches = 0
    # @pegs.each_index do |idx1|
    #   (0...@pegs.length).each do |idx2|
    #     next if idx1 == idx2
    #     if @pegs[idx1] == guess.pegs[idx2]
    #

  end

  def ==(other_code)
    return false unless other_code.is_a?(Code)
    @pegs == other_code.pegs
  end

end

class Game
  attr_reader :secret_code

  def initialize(secret_code = Code.random)
    @secret_code = secret_code
  end

  def get_guess
    puts "Input a code:"
    input = gets.chomp
    Code.parse(input)
  end

  def display_matches(code)
    exact = @secret_code.exact_matches(code)
    near = @secret_code.near_matches(code)
    puts "You got #{exact} exact matches"
    puts "You got #{near} near matches"
  end
end
