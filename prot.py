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
    
# Note: Top solution from ORF has a much more elegant solution
    
f2 = open('rosalind_prot.txt', 'r')
rna_string = f2.readline()
protein_string = ""

# Main loop of the program that takes three letter chunks of rna and looks them
# up in the codon dictionary.
while len(rna_string) >= 3:
    buff = rna_string[0:3]
    rna_string = rna_string[3::]
    val = codon[buff]
    if val == 'Stop':
        break
    else:
        protein_string += val
        
print protein_string
    
    
    
    

    
    
