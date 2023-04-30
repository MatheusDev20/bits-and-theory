/* 
    A Pure function, is a function that is computed using only their argument
    given the same argument, a pure function should return always the same value (No side effects)
*/
// Not pure
function isIndexPage () {
    return window.location.pathname === "/";
}
// Pure, because uses the argument to compute.
function isIndexPagePure(pathname: string) {
    return pathname === '/'
}

/* Referential Transparency 
    When its safe to replace a function for his return evaluation
    in other words, when the function is pure
*/

// Referential transparent function
const add = (v1, v2) => v1 + v2

let counter = 0
const incremenetTwo = (x: number) => counter += x
/* Not referential, neither pure cause mutates external state
   Called "referential opaque"
*/

/* Stateless vs Statefull Code 
    A function its stateless when its result does not depend on previos events
    No matter how many times we called a function, the result does not rely on the previos calls.

    (Contrast with OOP ? => Given the example below)
*/

// Stateless ( Referential transparent function )
const concatenate = (s1: string, s2: string) => `${s1} -> ${s2}`

// Statefull
class Concat {

    public char: string
    constructor(firstChar) {
        this.char = firstChar
    }
    concatenate(newChar: string) {
        this.char = this.char.concat(' ', newChar)
        return this.char
    }
}
const instance = new Concat('A')

const firstConcat = instance.concatenate('B')
const secondConcat = instance.concatenate('C')

/* Calls of the concatenate() method rely on the internal object state "char" so its not referential transparent, neither stateless 
    Each call, mutates the "char" state
*/

/* High order functions
    Functions that receives one or more function as argument, or return a function
    Its possible because in J.S functions are treated as values (can be assigned and returned just like values)

    Functions like "map" "reduce" and "filter" are HOF
*/
const executeFnAfterDelay = (fn: () => void, delay: number) => {
    setTimeout(() => {
        fn()
    }, delay)
}

const sayHello = () => console.log('Hello')
executeFnAfterDelay(sayHello, 5000)

/* Interesting tecninque because allow us to abstract the solutions of a problem by separating them in another function 
    This is common like perfom some operation in a list datastructure using .map() HOF.
*/




