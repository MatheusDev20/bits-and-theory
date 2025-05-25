/* As we already know, we can declare function types in T.S */
// let addType: (v1: number, v2: number) => number
// addType = (v1, v2) => v1 + v2
/* Can also do it in the same line  */
var addTypeSameLine = function (v1, v2) { return v1 + v2; };
console.log(addTypeSameLine(1, 3));
var greetUnnamed = function (name) {
    return 'Hi! ${name}';
};
