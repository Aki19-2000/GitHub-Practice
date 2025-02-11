const core = require('@actions/core');


const input1 = process.argv[2]; // First argument passed to the container
const input2 = process.argv[3]; // Second argument passed to the container

console.log(`Command-line argument Input 1: ${input1}`);
console.log(`Command-line argument Input 2: ${input2}`);


console.log(`GitHub Action Input 1: ${actionInput1}`);
console.log(`GitHub Action Input 2: ${actionInput2}`);


