f = open('rosalind_lcsm.txt', 'r')
data = []
buf = f.readline().rstrip()
    
dna_strings = []
    
while buf:
    seq = ''
    if buf.startswith('>'):
        buf = f.readline().rstrip()
    while not buf.startswith('>') and buf:
        seq = seq + buf
        buf = f.readline().rstrip()
    dna_strings.append(seq)

# An assumption is made that all of the dna strings are about the same length.
# Else, it would be efficient to find the shortest string.

longest_substring = ''
# Arbitrarily use the first item in dna_strings as the reference string
ref_string = dna_strings[0]
# i is the position of the beginning of the substring in the reference string
i = 0

while i + len(longest_substring) < len(ref_string):
    substring_length = len(longest_substring) + 1
    substring = ref_string[i:i+substring_length]
    
    # Check to see if this substring exists in all the dna strings
    common_substring = True
    for j in dna_strings[1:]:
        if substring not in j:
            common_substring = False
            break
                
    if common_substring:
        longest_substring = substring
    else:
        i += 1
        
print longest_substring