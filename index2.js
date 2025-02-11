const core = require('@actions/core');

// Read inputs via environment variables (Docker run passes them as ENV)
const input1 = process.env.INPUT1; 
const input2 = process.env.INPUT2;

console.log(`Environment variable Input 1: ${input1}`);
console.log(`Environment variable Input 2: ${input2}`);

// Optionally, you can still use GitHub Actions' core API for inputs
const actionInput1 = core.getInput('input1');
const actionInput2 = core.getInput('input2');

console.log(`GitHub Action Input 1: ${actionInput1}`);
console.log(`GitHub Action Input 2: ${actionInput2}`);
