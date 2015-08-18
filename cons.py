from pandas import DataFrame
from collections import Counter
import pandas as pd

f = open('rosalind_cons.txt', 'r')
dna_strings = []

# Extract data from file
buf = f.readline().rstrip()
while buf:
    seq = ''
    buf = f.readline().rstrip()
    while not buf.startswith('>') and buf:
        seq = seq + buf
        buf = f.readline().rstrip()
    dna_strings.append(list(seq))

# Use frame from Pandas so that we can easily access columns
frame = DataFrame(dna_strings)

# Generate the consensus string and profile matrix
consensus = ''
a, c, g, t = [], [], [], []
for i in frame:
    cntr = Counter(frame[i])
    consensus += cntr.most_common(1)[0][0]
    a.append(cntr['A'])
    c.append(cntr['C'])
    g.append(cntr['G'])
    t.append(cntr['T'])
    
def print_row(title, counts):
    print title + ':',
    for i in counts:
        print "%d " %i,
    print ''
    
# Output info
print consensus
print_row('A', a)
print_row('C', c)
print_row('G', g)
print_row('T', t)


