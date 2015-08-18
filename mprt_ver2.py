import rosalind
import urllib2

f = open('rosalind_mprt.txt', 'r')
data = [i.rstrip() for i in f.readlines()]

for protein in data:
    # Fetch protein sequence fasta
    f = urllib2.urlopen('http://www.uniprot.org/uniprot/%s.fasta' %protein) 
    sequence = rosalind.read_seq(f)
    
    
    print sequence