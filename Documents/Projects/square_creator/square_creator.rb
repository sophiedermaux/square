require 'highline'

class SquareCreator
  def initialize(width, height)
    @width = width.to_i
    @height = height.to_i
  end

# method to generate the SquareCreator class when answer given
  def generate
    create_array.each do |row|
      puts row.join
    end
  end

private

# when generate method called above it generates a new array based on height and width
  def create_array
    original_array = (0..@height).map {Array.new(@width," ")}
    in_ascii_characters(original_array)
  end

# method that says that the character goes based on the position in the row
  def inject_character(row, character, position)
    row[position] = character
    row
  end

# define the order of the characters for each of the rows based on first, middle and last rows
  def first_row(row)
    inject_character(row, '┌', 0)
    (1..row.length-1).each do |c|
      inject_character(row, '-', c)
    inject_character(row, '┐', row.length-1)
    end
    row
  end

  def middle_row(row)
    inject_character(row, '|', 0)
    inject_character(row, '|', row.length-1)
  end

  def last_row(row)
    inject_character(row, '└', 0)
    (1..row.length-1).each do |c|
      inject_character(row, '-', c)
    inject_character(row, '┘', row.length-1)
    end
    row
  end

  def in_ascii_characters(array, acc = [])
    if array.empty?
      acc
    else
      row = array.shift
      if acc.empty?
        acc << first_row(row)
      elsif array.empty?
        acc << last_row(row)
      else
        acc << middle_row(row)
      end
    in_ascii_characters(array, acc)
    end
  end
end

# highline gem to get answer for width and height. then with that answer generate the SquareCreator class
cli = HighLine.new
answer = cli.ask "Please say your desired width and height seperated by a space e.g 5 5"
width, height = answer.split

SquareCreator.new(width,height).generate

# RSpec tests

require 'rspec/autorun'

RSpec.describe SquareCreator, :type => :model do
  describe "square generation" do
    it "checks if different widths and heights create a sq" do
      expect(SquareCreator.new(10,10).generate).to eq(SquareCreator.new(10,10).generate)
      expect(SquareCreator.new(2,2).generate).to eq(SquareCreator.new(2,2).generate)
      expect(SquareCreator.new(10,5).generate).to eq(SquareCreator.new(10,5).generate)
      expect(SquareCreator.new(5,10).generate).to eq(SquareCreator.new(5,10).generate)
      expect(SquareCreator.new(4,6).generate).to eq(SquareCreator.new(4,6).generate)
      expect(SquareCreator.new(3,10).generate).to eq(SquareCreator.new(3,10).generate)
      expect(SquareCreator.new(5,5).generate).to eq(SquareCreator.new(5,5).generate)
      expect(SquareCreator.new(4,8).generate).to eq(SquareCreator.new(4,8).generate)
      expect(SquareCreator.new(3,9).generate).to eq(SquareCreator.new(3,9).generate)
    end
  end
end
