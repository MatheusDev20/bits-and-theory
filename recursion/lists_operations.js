const sumList = (xs) => {
    if(xs.length === 0) return 0

    const [head, ...tail] = xs
    return head + sumList(tail)
}

console.log(sumList([1,2,3,4,5]))

