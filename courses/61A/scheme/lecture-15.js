class Environment {
  constructor(parent = null) {
      this.bindings = {};
      this.parent = parent;
  }

  lookup(name) {
      if (name in this.bindings) {
          return this.bindings[name];
      } else if (this.parent) {
          return this.parent.lookup(name);
      } else {
          throw new Error(`Unbound variable: ${name}`);
      }
  }

  define(name, value) {
      this.bindings[name] = value;
  }
}

function evaluate(exp, env) {
  if (typeof exp === 'number' || typeof exp === 'string') {
      return exp;
  }

  if (typeof exp === 'string') {
      return env.lookup(exp);
  }

  switch (exp[0]) {
      case 'define':
          const [_, name, valueExp] = exp;
          const value = evaluate(valueExp, env);
          env.define(name, value);
          return value;
      case 'lambda':
          const [__, params, body] = exp;
          return function(...args) {
              const localEnv = new Environment(env);
              for (let i = 0; i < params.length; i++) {
                  localEnv.define(params[i], args[i]);
              }
              return evaluate(body, localEnv);
          };
      default:
          const func = evaluate(exp[0], env);
          const args = exp.slice(1).map(arg => evaluate(arg, env));
          return func(...args);
  }
}

// Example usage
const globalEnv = new Environment();
globalEnv.define('+', (a, b) => a + b);
globalEnv.define('*', (a, b) => a * b);

const program = ['define', 'square', ['lambda', ['x'], ['*', 'x', 'x']]];
evaluate(program, globalEnv);

const result = evaluate(['square', 5], globalEnv);
console.log(result);  // Output: 25
