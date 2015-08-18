codon = {'F': 2,
         'L': 6,
         'S': 6,
         'Y': 2,
         'C': 2,
         'W': 1,
         'P': 4,
         'H': 2,
         'Q': 2,
         'R': 6,
         'I': 3,
         'M': 1,
         'T': 4,
         'N': 2,
         'K': 2,
         'V': 4,
         'A': 4,
         'D': 2,
         'E': 2,
         'G': 4
         }
         
f = open('rosalind_mrna.txt', 'r')
mrna = f.readline()

total = 1

for i in mrna:
    total = total * codon[i] % 10000000
    
print total * 3 %mr 1000000