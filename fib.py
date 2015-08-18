n = 35
k = 3

rabbits = [1, 0]

for i in xrange(n - 1):
    rabbits_x = rabbits[0]
    rabbits_y = rabbits[1]
    rabbits[0] = k * rabbits_y
    rabbits[1] = rabbits_x + rabbits_y
    
print sum(rabbits)