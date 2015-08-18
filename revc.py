data = open('rosalind_revc.txt').readline()

data = data[::-1]
data2 = ""

revc_dict = {'A': 'T',
             'T': 'A',
             'C': 'G',
             'G': 'C'
             }

for c in data:
    data2 += revc_dict[c]
    
print data2