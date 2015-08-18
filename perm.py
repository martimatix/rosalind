from itertools import permutations
n = 5

f = open('perm_results.txt', 'w')
f.truncate()

perm = list(permutations(range(1,n + 1)))

f.write (str(len(perm)) + '\n')
for i in perm:
    f.write(str(i).translate(None,'(),')+ '\n')
    
f.close()