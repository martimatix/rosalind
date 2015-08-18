class ReversePalindrome
  COMPLEMENT = { 'G' => 'C',
                 'C' => 'G',
                 'A' => 'T',
                 'T' => 'A' }

  def initialize(file_name)
    @dna = ''
    File.open(file_name, 'r') do |f|
      f.gets # Discard first line of fasta
      while line = f.gets
        @dna << line.strip
      end
    end
    find_palindromes
  end

  private

  def find_palindromes
    (@dna.length - 3).times do |i|
      # step 2 because slice_length must be even
      (4..12).step(2) do |slice_length|
        slice = @dna[i, slice_length]
        # Second check is to avoid duplicates towards end of DNA string
        if slice == reverse_palindrome(slice) && slice.length == slice_length
          puts "#{i + 1} #{slice_length}"
        end
      end
    end
  end

  # Finds the reverse palindrome of a dna string
  def reverse_palindrome(dna)
    dna.chars.map { |e| COMPLEMENT[e] }.reverse.join('')
  end
end

revp = ReversePalindrome.new('rosalind_revp.txt')
