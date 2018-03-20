require 'highline'

class SquareCreator
  def initialize(width, height)
    @width = width.to_i
    @height = height.to_i
  end

  # when generate method called above it generates a new array based on height and width
  def create_square_array
    original_array = (0...@height).map { Array.new(@width," ") }
    in_ascii_characters(original_array)
  end

  private

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

  def in_ascii_characters(array, acc = [], counter = 0)
    if array.empty?
      acc
    else
      row = array.shift
      if counter == 0
        acc << first_row(row)
      elsif counter == @height-1
        acc << last_row(row)
      else
        acc << middle_row(row)
      end

      in_ascii_characters(array, acc, counter + 1)
    end
  end
end

# highline gem to get answer for width and height. then with that answer generate the SquareCreator class
cli = HighLine.new
answer = cli.ask "Please say your desired width and height seperated by a space e.g 5 5"
width, height = answer.split

array = SquareCreator.new(width,height).create_square_array

array.each do |row|
  puts row.join
end

# RSpec tests

require 'rspec/autorun'

RSpec.describe SquareCreator, :type => :model do
  describe "square generation" do

    it "returns a 10 x 10 ascii array" do
      expected = [
        ["┌", "-", "-", "-", "-", "-", "-", "-", "-", "┐"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["|", " ", " ", " ", " ", " ", " ", " ", " ", "|"],
        ["└", "-", "-", "-", "-", "-", "-", "-", "-", "┘"]
      ]

      expect(SquareCreator.new(10,10).create_square_array).to eq(expected)
    end

    it "returns a 5 x 5 ascii array" do
      expected = [
        ["┌", "-", "-", "-", "┐"],
        ["|", " ", " ", " ", "|"],
        ["|", " ", " ", " ", "|"],
        ["|", " ", " ", " ", "|"],
        ["└", "-", "-", "-", "┘"]
      ]

      expect(SquareCreator.new(5,5).create_square_array).to eq(expected)
    end

    it "returns a 4 x 5 ascii array" do
      expected = [
        ["┌", "-", "-", "┐"],
        ["|", " ", " ", "|"],
        ["|", " ", " ", "|"],
        ["|", " ", " ", "|"],
        ["└", "-", "-", "┘"]
      ]

      expect(SquareCreator.new(4,5).create_square_array).to eq(expected)
    end

    it "returns a 5 x 6 ascii array" do
      expected = [
        ["┌", "-", "-", "-", "┐"],
        ["|", " ", " ", " ", "|"],
        ["|", " ", " ", " ", "|"],
        ["|", " ", " ", " ", "|"],
        ["|", " ", " ", " ", "|"],
        ["└", "-", "-", "-", "┘"]
      ]

      expect(SquareCreator.new(5,6).create_square_array).to eq(expected)
    end

    it "returns a 3 x 3 square of arrays" do
      expected = [
        ["┌", "-", "┐"],
        ["|", " ", "|"],
        ["└", "-", "┘"]
      ]

      expect(SquareCreator.new(3,3).create_square_array).to eq(expected)
    end

    it "returns a 10 x 10 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(10,10).create_square_array).to eq(expected)
    end

    it "returns a 10 x 13 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(10,13).create_square_array).to eq(expected)
    end

    it "returns a 10 x 15 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(10,15).create_square_array).to eq(expected)
    end

    it "returns a 15 x 15 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-"," -","-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," "  "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," "  "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(15,15).create_square_array).to eq(expected)
    end

    it "returns a 15 x 5 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-","-","-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(15,5).create_square_array).to eq(expected)
    end

    it "returns a 15 x 3 square of arrays" do
      expected = [
        ["┌", "-", "-", "-","-","-","-","-","-","-","-","-","-","-", "┐"],
        ["|", " ", " ", " "," "," "," "," "," "," "," "," "," "," ", "|"],
        ["└", "-", "-", "-","-","-","-","-","-","-","-","-","-","-", "┘"]
      ]

      expect(SquareCreator.new(15,3).create_square_array).to eq(expected)
    end
  end
end
