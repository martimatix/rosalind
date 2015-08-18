f = open('rosalind_grph.txt', 'r')

data = []

buf = f.readline().rstrip()
    
# Dictionary of fasta label and dna
grph_dict = {}
    
while buf:
    fasta_label = ''
    seq = ''
    if buf.startswith('>'):
        fasta_label = buf[1:]
        buf = f.readline().rstrip()
    while not buf.startswith('>') and buf:
        seq = seq + buf
        buf = f.readline().rstrip()
    grph_dict[fasta_label] = seq

for i in grph_dict.keys():
    for j in grph_dict.keys():
        head_tail = grph_dict[i][-3:] == grph_dict[j][:3]
        not_same = grph_dict[i] != grph_dict[j]
        if head_tail and not_same:
            print "%s %s" %(i,j)
