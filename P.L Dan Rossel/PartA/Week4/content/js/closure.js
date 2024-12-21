function outterFunction () {

    let v = "Im variable"
    function innerFunction() {
        console.log(v)
    }

    return innerFunction
}

let closure = outterFunction()
closure()

function createCounter() {
    let count = 0;
  
    return {
      increment: function() {
        count++;
      },
      getCount: function() {
        return count;
      }
    };
  }
  
  let counter = createCounter();
  
  counter.increment(); // count is now 1
  counter.increment(); // count is now 2
  
  console.log(counter.getCount()); // outputs 2