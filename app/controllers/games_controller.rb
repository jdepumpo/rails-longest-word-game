require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(10)
  end

  def score
    @user_input = params[:word]
    @result = params[:grid]
    @english = check_if_word(@user_input)
    @onthegrid = on_the_grid(@user_input, @result)
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    chars = ('a'..'z').to_a
    grid_size.times.map { chars.sample }.join
  end

  def check_if_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.open(url).read
    parse = JSON.parse(serialized)
    parse["found"]
  end

  def on_the_grid(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end

# def run_game(attempt)
#     input_array = attempt.chars
#     grid_array = params[:grid].split("")
#     valid_letters = input_array.uniq.sort.include?(grid_array.uniq.sort)
#     valid_word = check_if_word(attempt)
#     if valid_letters && valid_word
#       { message: "well done", score: score }
#     elsif valid_letters && !valid_word
#       { message: "not an english word", score: score }
#     else
#       { message: "not in the grid", score: score }
#     end
