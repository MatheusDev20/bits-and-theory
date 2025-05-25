lax_coordinates = ('33.9425', '-118.408056')

traveler_ids = [('USA', '31195855'), ('BRA', 'CE342567'),  
('ESP', 'XDA205856')]

# Iterate over a list of tuples
# for passport in sorted(traveler_ids):  
#     print('%s/%s' % passport)   

# Unpacking the tuple items and using "_" as dummy to ignore code
for country, _ in traveler_ids:
    print(country)

# Tuple unpacking - assign multiple variables using a tuple
city, year, pop, chg, area = ('Tokyo', 2003, 32_450, 0.66, 8014)

# Tuples are immutable lists, their lenght will never change once declared
# Tuples are also more fast (uses less memory) than a list of the same lenght

a = (10, 'alpha', [1,2])
b = (10, 'alpha', [1,2])
# >>> a == b -> True

a[-1].append(150)
# >>> b -> (10, 'alpha', [1, 2, 150])
# The references that the objects point on a tuplle cannot change, but if this
# references points to a muttable object like a list, this could change


# tuples supports all list methods that do not add or remove items
    #obs: the __reversed__ method is an exception
    
