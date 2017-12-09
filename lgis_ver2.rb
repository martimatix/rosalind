require 'pp'

class Subsequences
  def initialize(seed:, direction:)
    @direction = direction
    @array = [[seed]]
  end

  def apply(n)
    # pp @array
    if within_bounds_of_last_subsequence(n)
      apply_elem_to_existing_subsequence(n, @array.last)
    else
      @array.each do |subsequence|
        subsequence << n if number_can_be_appended(n, subsequence)
      end
    end
    trim_redundant
  end

  def longest
    @array.max_by { |x| x.length }
  end

  private

  def within_bounds_of_last_subsequence(n)
    logic_based_on_direction(n < @array.last.last)
  end

  def number_can_be_appended(n, subsequence)
    logic_based_on_direction(n > subsequence.last)
  end

  def numbers_before(n, x)
    logic_based_on_direction(x < n)
  end

  def logic_based_on_direction(increasing_case)
    case @direction
    when :increasing
      increasing_case
    when :decreasing
      !increasing_case
    end
  end

  def apply_elem_to_existing_subsequence(n, subsequence)
    return if subsequence.include?(n)
    @array << subsequence.select { |x| numbers_before(n, x) }.push(n)
  end

  def trim_redundant
    keepers = []
    @array.each_with_index do |subsequence, i|
      keepers << subsequence unless redundant?(subsequence, i)
    end
    @array = keepers
  end

  def last_digit_comparison(subsequence_last_digit, other_last_digit)
    logic_based_on_direction(subsequence_last_digit > other_last_digit)
  end

  def redundant?(subsequence, subsequence_index)
    @array.drop(subsequence_index + 1).any? do |other_subsequence|
      subsequence.length < other_subsequence.length or
        (subsequence.length == other_subsequence.length and
          last_digit_comparison(subsequence.last, other_subsequence.last))
    end
  end
end

class LongestSubsequence
  def initialize(file_name)
    @file_name = file_name
  end

  def perform
    _, @permutation = parse_file.values_at(:n, :permutation)
    find_longest_subsequences
    print_results
  end

  private

  def parse_file
    File.open(@file_name, 'r') do |f|
      n = f.gets.strip.to_i
      permutation = f.gets.strip.split(' ').map(&:to_i)
      return { n: n, permutation: permutation}
    end
  end

  def find_longest_subsequences
    first_number = @permutation.shift
    @increasing_longest = [first_number]
    @decreasing_longest = [first_number]
    while @permutation.any?
      # pp @increasing_longest
      # pp @decreasing_longest

      seed = @permutation.shift

      increasing_subsequences = Subsequences.new(seed: seed, direction: :increasing)
      decreasing_subsequences = Subsequences.new(seed: seed, direction: :decreasing)

      if @increasing_longest.first > seed
        @permutation.select { |n| n > seed }.each do |n|
          increasing_subsequences.apply(n)
        end

        if increasing_subsequences.longest.length > @increasing_longest.length
          @increasing_longest = increasing_subsequences.longest
        end
      end

      if @decreasing_longest.first < seed
        @permutation.select { |n| n < seed }.each do |n|
          decreasing_subsequences.apply(n)
        end

        if decreasing_subsequences.longest.length > @increasing_longest.length
          @decreasing_longest = decreasing_subsequences.longest
        end
      end
    end
  end

  def print_results
    puts @increasing_longest.join(' ')
    puts @decreasing_longest.join(' ')
  end
end

puts LongestSubsequence.new('rosalind_lgis.txt').perform
