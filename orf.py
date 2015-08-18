# Make a dictioary based on the data from the Codon Table info from Rosalind
f = open('codon.txt', 'r')

codon_data = []
for line in f.readlines():
    codon_data += line.split()

codon = {}
while codon_data:
    value = codon_data.pop()    
    key = codon_data.pop()
    codon[key] = value

# Import DNA string
f = open('rosalind_orf.txt', 'r')
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

dna_string = "".join(dna_strings[0])

# Find reverse complement of DNA string
data = dna_string[::-1]
dna_string_rc = ""

revc_dict = {'A': 'T',
             'T': 'A',
             'C': 'G',
             'G': 'C'
             }

for c in data:
    dna_string_rc += revc_dict[c]

# Convert DNA into RNA
def dna_to_rna(dna_string):
    s = list(dna_string)
    for i in range(len(s)):
        if s[i] == 'T':
            s[i] = 'U'
    return "".join(s)
    
rna1 = dna_to_rna(dna_string)
rna2 = dna_to_rna(dna_string_rc)

# rna to protein transcription method
def rna_to_protein(rna_string):
    protein_string = ""
    while len(rna_string) >= 3:
        buff = rna_string[0:3]
        rna_string = rna_string[3::]
        val = codon[buff]
        if val == 'Stop':
            return protein_string
        else:
            protein_string += val

# Find every distinct candidate protein string

def protein_search(rna):
    search_set = set()
    for i in range(len(rna)-3):
        start = rna[i:i+3]
        if codon[start] == 'M':
            rna_string = rna_to_protein(rna[i::])
            if rna_string:
                search_set.add(rna_string)
    return search_set
        
search_set = (protein_search(rna1) | protein_search(rna2))

for result in search_set:
    print result


