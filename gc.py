data = [line.strip() for line in open('rosalind_gc.txt')]

temp_dna = ""
data2 = []

#probably not the best way to code this!

for d in data:
    if d[0] is '>':
        data2.append(temp_dna)
        data2.append(d)
        temp_dna = ""
    else:
        temp_dna += d
        
data2.pop(0)
data2.append(temp_dna)

# turn data into list of tuples and remove '>'
data3 = []

for i in xrange(len(data2)):
    if i % 2 == 0:
        data3.append((data2[i][1::], data2[i+1]))
        
max_gc = 0
max_label = ""
        
for d in data3:
    dna = d[1]
    gc_content = (dna.count('G') + dna.count('C'))/(len(dna)/100.0)
    if gc_content > max_gc:
        max_gc = gc_content
        max_label = d[0]
        
print max_label
print round(max_gc, 5)