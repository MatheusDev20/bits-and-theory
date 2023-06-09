function outterFunction() {
    let a = 'Closured' 

    function displayVar() {
        console.log(a)
    }

    return displayVar
}

const myClosure = outterFunction()

myClosure() // Still prints 'a' even after the outterFunction terminate its execution, the variable got "closured"

function counterFn() {
    let counter = 0;

    function innerFn() {
        counter ++
        console.log('Closured counter', counter)
    }

    return innerFn
}

const closure = counterFn() // The value of counter is closured by the innerFunction even after the execution of stop

closure() // logs 1
closure() // logs 2
closure() // logs 3

const greaterThanX = x => y => y > x

const arr = [12,5,6,4,2,7,8,5,2,1,24,2,15,27]

const filtered = arr.filter(greaterThanX(6), arr)

// X binding to 6 it is on a closure that the function greaterThanX creates


const externalFunction = () => {
    let myName = 'Matheus'
    let mySecondName = 'De Paula'

    function fn() {
        return myName + ' ' + mySecondName
    }
    // fn is a closure
    return fn
}

const myClosureExample = externalFunction()
console.log(myClosureExample())



