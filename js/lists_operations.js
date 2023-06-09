const sumList = (xs) => {
    if(xs.length === 0) return 0
    const [head, ...tail] = xs
    return head + sumList(tail)
}


