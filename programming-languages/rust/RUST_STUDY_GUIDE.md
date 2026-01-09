# Rust Study Guide for Beginners

A comprehensive guide to learning Rust fundamentals, designed for developers with prior programming experience.

---

## Table of Contents
1. [Getting Started](#1-getting-started)
2. [Basic Syntax and Data Types](#2-basic-syntax-and-data-types)
3. [Ownership and Borrowing](#3-ownership-and-borrowing)
4. [Structs and Enums](#4-structs-and-enums)
5. [Error Handling](#5-error-handling)
6. [Collections](#6-collections)
7. [Pattern Matching](#7-pattern-matching)
8. [Traits and Generics](#8-traits-and-generics)
9. [Modules and Crates](#9-modules-and-crates)
10. [Iterators and Closures](#10-iterators-and-closures)
11. [Lifetimes](#11-lifetimes)
12. [Concurrency](#12-concurrency)

---

## 1. Getting Started

### Key Concepts
- Setting up Rust toolchain (rustup, cargo)
- Creating and running a Rust project
- Understanding Cargo.toml
- Basic println! macro

### Resources
- [Official Rust Installation Guide](https://www.rust-lang.org/tools/install)
- [The Rust Book - Chapter 1: Getting Started](https://doc.rust-lang.org/book/ch01-00-getting-started.html)
- [Cargo Book](https://doc.rust-lang.org/cargo/)

### Exercises
1. Install Rust and verify with `rustc --version`
2. Create a new project with `cargo new hello_world`
3. Modify the project to print "Hello, [Your Name]!"
4. Add the `ferris-says` crate and make Ferris say something
5. Use `cargo build --release` and compare binary sizes

---

## 2. Basic Syntax and Data Types

### Key Concepts
- Variables and mutability (`let` vs `let mut`)
- Scalar types: integers, floats, booleans, characters
- Compound types: tuples, arrays
- Functions and return values
- Comments and documentation
- Type inference vs explicit typing

### Resources
- [The Rust Book - Chapter 3: Common Programming Concepts](https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html)
- [Rust by Example - Primitives](https://doc.rust-lang.org/rust-by-example/primitives.html)
- [Rustlings - Variables & Functions](https://github.com/rust-lang/rustlings)

### Exercises
1. Create variables of different types (i32, f64, bool, char)
2. Demonstrate the difference between mutable and immutable variables
3. Write a function that takes two integers and returns their sum
4. Create a tuple with mixed types and destructure it
5. Write a function that converts Fahrenheit to Celsius
6. Create an array of 5 numbers and print each element
7. Experiment with shadowing variables
8. Write a function with multiple return values using tuples

---

## 3. Ownership and Borrowing

### Key Concepts
- **THE MOST IMPORTANT CONCEPT IN RUST**
- Ownership rules (each value has an owner, one owner at a time, drop when out of scope)
- Move semantics vs Copy semantics
- References and borrowing (`&` and `&mut`)
- The borrowing rules (multiple immutable OR one mutable)
- Slices

### Resources
- [The Rust Book - Chapter 4: Understanding Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
- [Visualizing Memory Layout](https://www.youtube.com/watch?v=rAl-9HwD858) (YouTube)
- [Too Many Linked Lists](https://rust-unofficial.github.io/too-many-lists/) (Advanced, but great for understanding ownership)
- [Rust Ownership Explained](https://www.youtube.com/watch?v=VFIOSWy93H0) (YouTube)

### Exercises
1. Create a String and observe ownership transfer
2. Fix compilation errors related to moved values
3. Write a function that borrows a String immutably
4. Write a function that borrows a String mutably and modifies it
5. Demonstrate that you can have multiple immutable references
6. Try to create multiple mutable references (observe the error)
7. Work with string slices (`&str`)
8. Write a function that returns the first word of a string using slices
9. Create a function that takes ownership vs one that borrows

---

## 4. Structs and Enums

### Key Concepts
- Defining and instantiating structs
- Tuple structs and unit-like structs
- Methods and associated functions (impl blocks)
- Enums and variants
- The Option<T> enum
- Using structs with ownership

### Resources
- [The Rust Book - Chapter 5: Structs](https://doc.rust-lang.org/book/ch05-00-structs.html)
- [The Rust Book - Chapter 6: Enums](https://doc.rust-lang.org/book/ch06-00-enums.html)
- [Rust by Example - Structs](https://doc.rust-lang.org/rust-by-example/custom_types/structs.html)
- [Rust by Example - Enums](https://doc.rust-lang.org/rust-by-example/custom_types/enum.html)

### Exercises
1. Create a `Person` struct with name, age, and email fields
2. Implement a method to print person details
3. Create a `Rectangle` struct and implement area() and perimeter() methods
4. Create a tuple struct for RGB color values
5. Define an enum for `TrafficLight` with Red, Yellow, Green variants
6. Create an enum `Shape` with Circle(radius), Rectangle(width, height), Triangle(base, height)
7. Write a function that returns `Option<i32>` (Some if positive, None if negative)
8. Create a struct that contains another struct
9. Implement an associated function (like `new()`) for a struct

---

## 5. Error Handling

### Key Concepts
- Unrecoverable errors with `panic!`
- Recoverable errors with `Result<T, E>`
- `unwrap()`, `expect()`, and `?` operator
- Custom error types
- When to panic vs return Result

### Resources
- [The Rust Book - Chapter 9: Error Handling](https://doc.rust-lang.org/book/ch09-00-error-handling.html)
- [Error Handling in Rust](https://blog.burntsushi.net/rust-error-handling/)
- [Rust by Example - Error Handling](https://doc.rust-lang.org/rust-by-example/error.html)

### Exercises
1. Write a function that panics when given a negative number
2. Create a function that returns `Result<i32, String>` for division (handle divide by zero)
3. Use the `?` operator to propagate errors
4. Read a file and handle potential errors using `Result`
5. Chain multiple operations that return `Result`
6. Use `match` to handle both Ok and Err cases
7. Convert between `Option` and `Result`
8. Create a custom error enum for a simple application

---

## 6. Collections

### Key Concepts
- Vectors (`Vec<T>`)
- Strings (`String` vs `&str`)
- Hash Maps (`HashMap<K, V>`)
- Growing and shrinking collections
- Iterating over collections

### Resources
- [The Rust Book - Chapter 8: Common Collections](https://doc.rust-lang.org/book/ch08-00-common-collections.html)
- [Rust by Example - Vec](https://doc.rust-lang.org/rust-by-example/std/vec.html)
- [Rust by Example - HashMap](https://doc.rust-lang.org/rust-by-example/std/hash.html)

### Exercises
1. Create a vector, push elements, and iterate over it
2. Access vector elements safely (avoiding panics)
3. Create a String and append to it
4. Split a string into words and collect into a Vec
5. Create a HashMap to store student names and grades
6. Update values in a HashMap
7. Count word frequency in a text using HashMap
8. Store a list of structs in a Vector
9. Filter and map a vector of numbers

---

## 7. Pattern Matching

### Key Concepts
- `match` expressions
- Patterns and destructuring
- `if let` and `while let`
- Match guards
- The `_` wildcard
- Exhaustiveness checking

### Resources
- [The Rust Book - Chapter 6.2: Match](https://doc.rust-lang.org/book/ch06-02-match.html)
- [The Rust Book - Chapter 18: Patterns](https://doc.rust-lang.org/book/ch18-00-patterns.html)
- [Rust by Example - Match](https://doc.rust-lang.org/rust-by-example/flow_control/match.html)

### Exercises
1. Use match to handle different enum variants
2. Match on numeric ranges
3. Destructure a tuple in a match
4. Use match guards to add conditions
5. Convert a match to `if let` when appropriate
6. Match on multiple values
7. Create a simple calculator using match on an Operation enum
8. Use `@` bindings in patterns

---

## 8. Traits and Generics

### Key Concepts
- Defining and implementing traits
- Generic functions and structs
- Trait bounds
- Default implementations
- Deriving common traits (Debug, Clone, etc.)
- Trait objects and dynamic dispatch

### Resources
- [The Rust Book - Chapter 10: Generics & Traits](https://doc.rust-lang.org/book/ch10-00-generics.html)
- [Rust by Example - Generics](https://doc.rust-lang.org/rust-by-example/generics.html)
- [Rust by Example - Traits](https://doc.rust-lang.org/rust-by-example/trait.html)

### Exercises
1. Create a generic function that works with any type implementing Display
2. Define a `Printable` trait and implement it for different types
3. Create a generic `Point<T>` struct
4. Implement a trait for a custom struct
5. Use `derive` to automatically implement Debug and Clone
6. Write a function with multiple generic type parameters
7. Create a trait with a default implementation
8. Use trait bounds to constrain generic types
9. Implement the `From` trait for type conversion

---

## 9. Modules and Crates

### Key Concepts
- Module system (`mod`, `use`)
- Public vs private (`pub`)
- File structure and module hierarchy
- External crates and dependencies
- Using `crates.io`
- Workspaces

### Resources
- [The Rust Book - Chapter 7: Packages, Crates, and Modules](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html)
- [Rust by Example - Modules](https://doc.rust-lang.org/rust-by-example/mod.html)
- [Crates.io](https://crates.io/)

### Exercises
1. Create a module in the same file
2. Move a module to its own file
3. Create a nested module structure
4. Use `pub` to expose functionality
5. Import functions with `use`
6. Add an external crate (like `rand`) to your project
7. Create a binary and library in the same project
8. Use `super` and `self` in module paths

---

## 10. Iterators and Closures

### Key Concepts
- Closure syntax and capture modes
- Iterator trait and adapters
- `map`, `filter`, `fold`, `collect`
- Lazy evaluation
- `iter()`, `iter_mut()`, `into_iter()`
- Consuming adapters vs iterator adapters

### Resources
- [The Rust Book - Chapter 13: Closures and Iterators](https://doc.rust-lang.org/book/ch13-00-functional-features.html)
- [Rust by Example - Closures](https://doc.rust-lang.org/rust-by-example/fn/closures.html)
- [Rust Iterator Cheat Sheet](https://danielkeep.github.io/itercheat_baked.html)

### Exercises
1. Create a closure that captures a variable
2. Use `map` to transform a vector of numbers
3. Chain `filter` and `map` operations
4. Use `fold` to sum a vector
5. Implement a custom iterator for a struct
6. Compare `iter()`, `iter_mut()`, and `into_iter()`
7. Use `collect()` to transform an iterator into a collection
8. Solve a problem using iterator adapters instead of loops
9. Use closures as function parameters

---

## 11. Lifetimes

### Key Concepts
- Lifetime annotations (`'a`)
- Generic lifetimes in functions
- Lifetime elision rules
- Lifetimes in structs
- `'static` lifetime
- Understanding the borrow checker's needs

### Resources
- [The Rust Book - Chapter 10.3: Lifetimes](https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html)
- [Common Rust Lifetime Misconceptions](https://github.com/pretzelhammer/rust-blog/blob/master/posts/common-rust-lifetime-misconceptions.md)
- [Visualizing Rust Lifetimes](https://www.youtube.com/watch?v=gRAVZv7V91Q) (YouTube)

### Exercises
1. Write a function that returns the longer of two string slices
2. Create a struct that holds a reference with a lifetime annotation
3. Fix lifetime errors in functions returning references
4. Understand when lifetime annotations are required vs elided
5. Create a function with multiple lifetime parameters
6. Work with the `'static` lifetime
7. Debug common lifetime errors

---

## 12. Concurrency

### Key Concepts
- Threads with `std::thread`
- Message passing with channels (`mpsc`)
- Shared state with `Mutex<T>` and `Arc<T>`
- `Send` and `Sync` traits
- Fearless concurrency (the Rust guarantee)

### Resources
- [The Rust Book - Chapter 16: Concurrency](https://doc.rust-lang.org/book/ch16-00-concurrency.html)
- [Rust by Example - Threads](https://doc.rust-lang.org/rust-by-example/std_misc/threads.html)
- [Async Book](https://rust-lang.github.io/async-book/) (Advanced)

### Exercises
1. Spawn a thread and wait for it to finish
2. Use channels to send data between threads
3. Share data between threads using `Arc<Mutex<T>>`
4. Create a simple thread pool
5. Solve a problem using parallel processing
6. Demonstrate the compiler preventing data races

---

## Additional Resources

### Interactive Learning
- [Rustlings](https://github.com/rust-lang/rustlings) - Small exercises to get you used to reading and writing Rust code
- [Exercism Rust Track](https://exercism.org/tracks/rust) - Code practice and mentorship
- [Rust Playground](https://play.rust-lang.org/) - Try Rust in your browser

### Books and Documentation
- [The Rust Programming Language](https://doc.rust-lang.org/book/) - The official book (must-read)
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/) - Learn by running examples
- [The Rustonomicon](https://doc.rust-lang.org/nomicon/) - Unsafe Rust (advanced)
- [Rust Cookbook](https://rust-lang-nursery.github.io/rust-cookbook/) - Practical examples

### Video Courses
- [Rust Programming Course - FreeCodeCamp](https://www.youtube.com/watch?v=MsocPEZBd-M)
- [Crust of Rust](https://www.youtube.com/playlist?list=PLqbS7AVVErFiWDOAVrPt7aYmnuuOLYvOa) by Jon Gjengset
- [Let's Get Rusty](https://www.youtube.com/c/LetsGetRusty) - YouTube channel

### Community
- [Rust Users Forum](https://users.rust-lang.org/)
- [Rust Discord](https://discord.gg/rust-lang)
- [r/rust](https://www.reddit.com/r/rust/)
- [This Week in Rust](https://this-week-in-rust.org/)

### Practice Projects
1. **CLI Tool**: Build a command-line todo list manager
2. **File Parser**: Create a CSV or JSON parser
3. **Web Scraper**: Scrape data from websites
4. **Web Server**: Build a simple HTTP server using frameworks like Actix or Rocket
5. **Game**: Make a text-based adventure or simple game
6. **Systems Tool**: Create a file search utility or log analyzer

---

## Recommended Learning Path

### Week 1-2: Foundations
- Complete chapters 1-4 of The Rust Book
- Focus heavily on ownership and borrowing
- Do Rustlings exercises for variables, functions, and ownership

### Week 3-4: Core Concepts
- Chapters 5-9 (Structs, Enums, Collections, Error Handling)
- Build small programs using these concepts
- Practice on Exercism

### Week 5-6: Advanced Basics
- Chapters 10-13 (Generics, Traits, Testing, Iterators, Closures)
- Start a small project (CLI tool)

### Week 7-8: Real-World Rust
- Chapters 14-16 (Cargo, Smart Pointers, Concurrency)
- Build a more complex project
- Contribute to open source

---

## Tips for Success

1. **Fight the Borrow Checker**: Don't get discouraged. Everyone struggles with it at first.
2. **Read Error Messages**: Rust's compiler errors are extremely helpful. Read them carefully.
3. **Practice Daily**: Even 30 minutes a day is better than cramming.
4. **Build Projects**: Theory is important, but building solidifies learning.
5. **Join the Community**: The Rust community is welcoming and helpful.
6. **Read Others' Code**: Explore popular Rust projects on GitHub.
7. **Use `cargo clippy`**: Learn idiomatic Rust from the linter.
8. **Test Your Code**: Write tests from the beginning.

---

## Quick Reference Commands

```bash
# Create new project
cargo new project_name

# Build project
cargo build

# Build and run
cargo run

# Check code without building
cargo check

# Run tests
cargo test

# Format code
cargo fmt

# Lint code
cargo clippy

# Update dependencies
cargo update

# Generate documentation
cargo doc --open
```

---

Happy Learning! Remember: Rust has a steep learning curve, but the concepts you learn will make you a better programmer in any language.
