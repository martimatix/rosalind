data = "19435 17717 17246 17372 16476 19548".split()
parents = [int(datum) for datum in data if datum != ' ']

expected_vals = [2, 2, 2, 1.5, 1, 0]

answer = sum([a*b for a,b in zip(parents,expected_vals)])
print answer