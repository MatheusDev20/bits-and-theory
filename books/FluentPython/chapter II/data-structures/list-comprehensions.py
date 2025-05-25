#listcomps

# Without listcomp
symbols = '$¢£¥€¤'
codes = []

for symbol in symbols:
    codes.append(ord(symbol))

print(codes)

# With listcomp

symbols = '$¢£¥€¤'
codes = [ord(symbol) for symbol in symbols]

print(codes)

colors = ['black', 'white']
sizes = ['S', 'M', 'L']

tshirts = [(color, size) for color in colors for size in sizes]
# Generates a list of tuples

newTuple = ('ABC', 123)
print(type(newTuple))
