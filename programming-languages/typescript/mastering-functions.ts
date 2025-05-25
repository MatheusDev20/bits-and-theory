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
function concatenateX1(x: string) {
    return 'Something' + x
}
// Unnamed function (Also can use the arrow sintax => instead the return statement )
const concatenateX2 = function (x: string) { 'Something' + x }

/* Functions Declarations vs Functions Expressions  */
function fnDeclaration() {
    return 'HI'
}
const fnExpression = function () { return 'HI'}
/* 
    The fn expression is only evaluates when the assignemnt happen (Affectet by Hoisting)
*/

/* Functions with optional parameters  */
function optional(p1, p2) {
    return p1 + p2
}
// optional(1) // Throw a compile error cause the numbers of params did not match de function signature

function optional2(p1, p2, p3?) {
    if(p3) return p1 + p2 - p3 // Can cause runtime errors if p3 not checked, thats why we check
    return p1 + p2 
}
optional(3, 5) // Did not throw an error cause "?" after the p3 param make it optional

/* Function with default parameters */
function defaultParameters(p1, p2, p3 = 5) {
    return p1 + p2 + p3 // Prevent runtime errors, if 5 not passed assume the value "5"
}


