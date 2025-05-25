const greaterThanX = x => y => y > x

const arr = [12,5,6,4,2,7,8,5,2,1,24,2,15,27]

const filtered = arr.filter(greaterThanX(6), arr)
console.log(filtered)

// X binding to 6 it is on a closure that the function greaterThanX creates


// X esta na Closure criada no momento da definição da função inner, por isso pode ser acessada mesmo quando
// a execução de outter já acabou

function outter() {
    const x = 3  
    function inner() {
        console.log('The value of x is', x)
    }
    console.log('The execution of outter is finished')
    return inner
}

const fn = outter()
fn()