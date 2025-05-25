class MyList:
    def __init__(self):
        self._mylist = [1,2,3,4,5]
    
    def __len__(self):
        return len(self._mylist)

    def __getitem__(self, index):
        return self._mylist[index]

myinstance = MyList()
print(type(myinstance))
print(len(myinstance)) # This will call implicity len method

for element in myinstance:
    print(element)

myinstance[3] # This will call implicity __getitem__ special method
