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


