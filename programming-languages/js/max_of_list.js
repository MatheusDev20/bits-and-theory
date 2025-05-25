// Recursevly call a function to find the max of a given list

// const max = (xs) => {
//     if(xs.length == 0) return 0

//     if(xs.length == 1) return xs.pop()

//     const [head, ...tail] = xs
//     console.log('HEAD', head)
//     console.log('Tail', tail)

//     if(head > max(tail)) {
//         return head
//    } else {
//     return max(tail)
//    }
// }

let l = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

// const result = max(l)
// console.log('Final result', result)

const findMax = arr => {
    if (!Array.isArray(arr)) throw 'Not an array'
    if (arr.length === 0) return undefined
    const [head, ...tail] = arr
    if (arr.length === 1) return head
    return head > findMax(tail) 
      ? head
      : findMax(tail)
  }

true.name = 'Matheus';
console.log(true.name);