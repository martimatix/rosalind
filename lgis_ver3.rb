require 'pp'

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
    first_element = @permutation.shift
    increasing_subsequences = [[first_element]]
    decreasing_subsequences = [[first_element]]

    @permutation.each do |n|
      increasing_subsequences <<
        increasing_subsequences
          .select { |x| x.last < n }
          .max_by { |x| x.length }
          .to_a
          .dup
          .push(n)

      decreasing_subsequences <<
        decreasing_subsequences
          .select { |x| x.last > n }
          .max_by { |x| x.length }
          .to_a
          .dup
          .push(n)
    end
    @increasing_longest = increasing_subsequences.max_by { |x| x.length }
    @decreasing_longest = decreasing_subsequences.max_by { |x| x.length }
  end

  def print_results
    puts @increasing_longest.join(' ')
    puts @decreasing_longest.join(' ')
  end
end

LongestSubsequence.new('rosalind_lgis.txt').perform
