require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = URI.parse(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def letter_in_grid
    @answer.chars.all? { |letter| @grid.gsub(/\s+/, '').chars.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, '' }
    if letter_in_grid == false
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end
end
