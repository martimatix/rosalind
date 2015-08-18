n = 84
m = 19

# List of the age of the rabbit pairs in months
# In the beginning, we only have one rabbit pair that is one month old
rabbits = [1]

for i in xrange(n-1):
    print i
    print len(rabbits)
    next_gen = []
    for pair in rabbits:
        # Rabbit pairs that are older than a month give birth
        if pair > 1:
            next_gen.append(1)
        # Rabbits pairs younger than m months will survive to the next month
        if pair < m:
            next_gen.append(pair + 1)
    rabbits = next_gen
            
print len(rabbits)
        