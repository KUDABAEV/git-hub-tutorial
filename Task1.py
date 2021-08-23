filename = 'names.txt'
names = sorted(open(filename).readline().replace('"', '').split(','))
total_alpha_sum = 0
for index, name in enumerate(names):
    alpha_sum = sum(map(lambda c: ord(c) - 64, list(name)))
    total_alpha_sum += alpha_sum * index
print(total_alpha_sum)
