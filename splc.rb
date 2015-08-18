require_relative 'rna_to_protein.rb'

class RnaSplicing
  def initialize(main_file_name, introns_file_name)
    @rna = ''
    @introns = []
    read_main_file(main_file_name)
    read_introns_file(introns_file_name)
    remove_introns
    protein_string = RnaToProtein.translate(@rna.gsub('T', 'U')).gsub('-', '')
    puts protein_string
  end

  private

  def remove_introns
    @introns.each { |intron| @rna.gsub!(intron, '') }
  end

  def read_main_file(file_name)
    File.open(file_name, 'r') do |f|
      f.gets # Discard first line of fasta
      while line = f.gets
        @rna << line.strip
      end
    end
  end

  def read_introns_file(file_name)
    File.open(file_name, 'r') do |f|
      while line = f.gets
        @introns << line.strip unless line.match(/>Rosalind.*/)
      end
    end
  end

end

RnaSplicing.new('rosalind_splc_main.txt', 'rosalind_splc_introns.txt')
