n = 90
m = 17

# Create a list of the number of rabbits of each age group.
# For example rabbits[3] will indicate the number of rabbits that were born
# in the fourth month

# In the beginning, we only have one rabbit pair that is one month old
rabbits = [1]

for i in xrange(n-1):
    # Births for month i
    rabbits.append(sum(rabbits[0:-1]))
    # Deaths for month i
    if i + 1 >= m:
        del rabbits[0]
        
print sum(rabbits)
        
    
        