# I did get this working but then undid all the changes

# Basically, the reason why the ruby version works and this one doesn't is because #max_by can potentially return nil. However, Crystal can't cast nil to an empty array because it needs to know what sort of empty array you're trying to cast it to.
# So to get this to work, you need to create a temporary variable

class LongestSubsequence
  @permutation : Array(Int32)
  @increasing_longest : Array(Int32)
  @decreasing_longest : Array(Int32)

  def initialize(file_name : String)
    @permutation = parse_file(file_name)[:permutation]
    @increasing_longest = [] of Int32
    @decreasing_longest = [] of Int32
  end

  def perform
    find_longest_subsequences
    print_results
  end

  private def parse_file(file_name)
    File.open(file_name) do |f|
      n = f.gets.to_s.strip.to_i
      permutation =
        f.gets.to_s.strip.split(' ').map(&.to_i)
      return { n: n, permutation: permutation}
    end
  end

  private def find_longest_subsequences
    first_element = @permutation.shift
    increasing_subsequences = [[first_element]]
    decreasing_subsequences = [[first_element]]

    @permutation.each do |n|
      usable_previous_increasing_subsequences =
        increasing_subsequences.select { |x| x.last < n }

      increasing_subsequences <<
        longest_subsequence_for_position(usable_previous_increasing_subsequences, n)

      usable_previous_decreasing_subsequences =
        decreasing_subsequences.select { |x| x.last > n }

      decreasing_subsequences <<
        longest_subsequence_for_position(usable_previous_decreasing_subsequences, n)
    end
    
    @increasing_longest = increasing_subsequences.max_by { |x| x.size }
    @decreasing_longest = decreasing_subsequences.max_by { |x| x.size }
  end

  private def longest_subsequence_for_position(usable_previous_subsequences, n)
    if usable_previous_subsequences.any?
      usable_previous_subsequences
        .max_by { |x| x.size }
        .dup
        .push(n)
    else
      [n]
    end
  end

  def print_results
    puts @increasing_longest.join(' ')
    puts @decreasing_longest.join(' ')
  end
end

puts "Starting lgis program"
LongestSubsequence.new("rosalind_lgis.txt").perform
