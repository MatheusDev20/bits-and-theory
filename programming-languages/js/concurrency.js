const fs = require('fs');
const path = require('path');

// Array of file names to read concurrently.
const files = ['file1.txt', 'file2.txt', 'file3.txt'];

// Function that wraps fs.readFile in a Promise.
function readFileAsync(filePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, 'utf8', (err, data) => {
      if (err) return reject(err);
      resolve(data);
    });
  });
}

// Map each file name to its read promise.
const readPromises = files.map(file => readFileAsync(path.join(__dirname, file)));

// Use Promise.all to run all file reads concurrently.
Promise.all(readPromises)
  .then(results => {
    results.forEach((data, index) => {
      console.log(`Contents of ${files[index]}:\n${data}\n`);
    });
  })
  .catch(err => {
    console.error('Error reading files:', err);
  });
