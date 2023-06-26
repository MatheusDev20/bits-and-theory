Lesson L 19, L20 -  https://youtu.be/Y9ZYTTetURs - 31:45

Objects State: objects keep local state, this local state are NOT shared between the instances and we can mutate them.

Instance Vars or Class Variables - They are set with the same value every time an object is instantiate.

Instantiate Vars: Their values comes from a call to instantiate method ( Constructor ) and are diferent from each instance (Object)


```python
class Dog:
    def bark(self):
        return "Woof!"

# create a Dog object
my_dog = Dog()

# send the 'bark' message to the dog (call the bark method)
print(my_dog.bark())  # prints "Woof!"

```

```racket
(define (make-dog)
  (let ((bark (lambda () "Woof!")))
    (lambda (msg)
      (cond ((eq? msg 'bark) (bark))
            (else "Unknown message")))))

(define my-dog (make-dog))

(display ((my-dog 'bark)))
```

Inheritance.
  When we create an instance of an object that inherits from a parent, the methods of the same name of that object overrides the parent methods.

  That happens because "self" points to the "Children class" and therefore calls the method of this class not the parent.


