import os
os.chdir('D:\\Python для веб разработки')
filename = 'hits.txt'
show_item = 5
unique_ip_address_count = {}
with open(filename) as f:
    ip_addresses = [line.split('\t')[1] for line in f.readlines()]
    for ip in ip_addresses:
        try:
            unique_ip_address_count[ip] += 1
        except KeyError:
            unique_ip_address_count[ip] = 1

unique_ip_address_count = sorted(unique_ip_address_count.items(), key=lambda x: x[1], reverse=True)[:show_item]

print([ip[0] for ip in unique_ip_address_count])
