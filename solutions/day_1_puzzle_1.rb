class CalorieCounter
  SET_DELIMITER = "\n".freeze
  attr_reader :input_file_name

  def initialize(input_file_name:)
    @input_file_name = input_file_name
  end

  def maximum_calories(n = 1)
    all_calorie_totals.max(n).sum
  end

  def all_calorie_totals
    sets_of_rows.map(&:sum)
  end

  def sets_of_rows
    # This is the real crux of this puzzle. Taking a set of rows from a file and grouping
    # them together based on a delimiter (a newline in this case).
    # This method also transforms each item to an integer via :to_i method.
    sets = []
    arr = rows.dup

    while (idx = arr.index(SET_DELIMITER))
      new_set = arr.shift(idx).map(&:to_i)
      sets << new_set
      arr.shift
    end
    # When we exit the block, we add the last set since the total set of rows might not
    # end with a delimiter.
    sets << arr.map(&:to_i)
  end

  def rows
    File.readlines(file_path)
  end

  def file_path
    File.join(File.expand_path("."), "inputs/#{input_file_name}")
  end
end


test = CalorieCounter.new(input_file_name: "day_1_puzzle_1_sample.txt")
test.maximum_calories # 24000

for_real = CalorieCounter.new(input_file_name: "day_1_puzzle_1.txt")
puts "Answer for part 1: #{for_real.maximum_calories}" # 68292 answer to part 1
puts "Answer for part 1: #{for_real.maximum_calories(3)}" # 203203 answer to part 2

# Run this in a terminal to see the answers:
# ruby solutions/day_1_puzzle_1.rb
