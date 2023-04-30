/* Typing Functions */

/* As we already know, we can declare function types in T.S */
let addType: (v1: number, v2: number) => number
addType = (v1, v2) => v1 + v2

/* Can also do it in the same line  */
const addTypeSameLine: (v1: number, v2: number) => number = function (v1, v2) { return v1 + v2 }

/* Using Arrow function syntax */
const addTypeArrowFunction: (v1: number, v2: number) => number = (v1, v2) => v1 + v2


/* Name and Unnamed functions */

// Named function
function concatenateX(x: string) {
    return 'Something' + x
}
// Unnamed function (Also can use the arrow sintax => instead the return statement )
const concatenate = function (x: string) { 'Something' + x }
