import random

k, m, n = 29, 28, 18


# Let Y be dominant and y be recessive

population = []
population += [['Y', 'Y']] * k
population += [['Y', 'y']] * m
population += [['y', 'y']] * n

homo_recessive = 0
trials = 3000000
    
# Conduct trials
for i in xrange(trials):
    parents = random.sample(population, 2)
    if [random.choice(parents[0]),random.choice(parents[1])] == ['y', 'y']:
        homo_recessive += 1
        
# To return the probablity of an individual posseing a dominant allele, return
# the complement of an individual being homo_recessive

print (trials - homo_recessive)/float(trials)
