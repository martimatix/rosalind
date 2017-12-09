require 'pp'

class Subsequences
  def initialize(first_number:)
    @array = [[first_number]]
    @global_min = first_number
  end

  def apply(n)
    pp @array
    if n < @global_min
      @array << [n]
      @global_min = n
      trim_redundant
    else
      generate_next_increasing_subsequences(n)
    end
  end

  def longest
    @array.max_by { |x| x.length }
  end

  def count
    @array.count
  end

  private

  def generate_next_increasing_subsequences(n)
    initial_array_length = @array.length
    @array.each do | subsequence |
      if n > subsequence.last
        subsequence << n
      elsif n > subsequence.first && n < subsequence.last
        apply_elem_to_existing_subsequence(n, subsequence)
      end
    end
    trim_redundant if initial_array_length != @array.length
  end

  def apply_elem_to_existing_subsequence(n, subsequence)
    return if subsequence.include?(n)
    @array << subsequence.select { |x| x < n }.push(n)
  end

  def trim_redundant
    @array =
      @array
        .group_by(&:length)
        .map do |_length, subsequences|
          next_subsequences = select_min_last_number(subsequences)
          next_subsequences = select_min_first_number(next_subsequences)
          next_subsequences.uniq
        end
        .flatten(1)
  end

  def select_min_last_number(subsequences)
    min_last_number = subsequences.map(&:last).min
    subsequences.select do |subsequence|
      subsequence.last == min_last_number
    end
  end

  def select_min_first_number(subsequences)
    min_last_number = subsequences.map(&:first).min
    subsequences.select do |subsequence|
      subsequence.first == min_last_number
    end
  end
end

class LongestSubsequence
  def initialize(file_name)
    @file_name = file_name
  end

  def perform
    _, permutation = parse_file.values_at(:n, :permutation)
    permutation.freeze
    # longest_increasing = find_longest_increasing_subsequence(permutation.dup)
    longest_decreasing = find_longest_decreasing_subsequence(permutation.dup)
    # puts longest_increasing.join(' ')
    puts longest_decreasing.join(' ')
  end

  private

  def parse_file
    File.open(@file_name, 'r') do |f|
      n = f.gets.strip.to_i
      permutation = f.gets.strip.split(' ').map(&:to_i)
      return { n: n, permutation: permutation}
    end
  end

  def find_longest_increasing_subsequence(permutation)
    first_number = permutation.shift
    increasing_subsequences = Subsequences.new(first_number: first_number)
    permutation.each do |n|
      increasing_subsequences.apply(n)
    end
    increasing_subsequences.longest
  end

  def find_longest_decreasing_subsequence(permutation)
    first_number = permutation.pop
    increasing_subsequences = Subsequences.new(first_number: first_number)
    permutation.reverse!
    permutation.each do |n|
      increasing_subsequences.apply(n)
    end
    increasing_subsequences.longest.reverse
  end
end

LongestSubsequence.new('rosalind_lgis.txt').perform
