# Generator Expressions
symbols = '$¢£¥€¤'
tuple(ord(symbol) for symbol in symbols)

import array

array.array('I', (ord(symbol) for symbol in symbols))

colors = ['black', 'white']
sizes = ['S', 'M', 'L']

for tshirt in (f'{c} {s}' for c in colors for s in sizes):
    print(tshirt)
    print(type(tshirt))