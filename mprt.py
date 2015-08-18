import urllib2
import re

f = open('rosalind_mprt.txt', 'r')
data = [i.rstrip() for i in f.readlines()]

for protein in data:
    # Fetch protein sequence fasta
    f = urllib2.urlopen('http://www.uniprot.org/uniprot/%s.fasta' %protein) 
    # sequence = fasta.read_seq(f)
    
    buf = f.readline().rstrip()
        
    sequence = ''
    
    # See top solution by hascool in mprt for a better method
    while buf:
        seq = ''
        if buf.startswith('>'):
            buf = f.readline().rstrip()
        while not buf.startswith('>') and buf:
            seq = seq + buf
            buf = f.readline().rstrip()
        sequence += seq
        
    pattern = re.compile('N[^P][ST][^P]')
    # Indices of matches stored in match
    match = ''
    
    for i in range((len(seq) - 4)):
        if pattern.findall(seq[i:i+4]):
            match += str(i+1) + ' '
        
    if match:
        print protein
        # There is a white space at the end of match
        print match[:-1]
            

    
    