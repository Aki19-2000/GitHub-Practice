const core = require('@actions/core');

try {
  // Retrieve inputs
  const input1 = core.getInput('input1');
  const input2 = core.getInput('input2');
  
  // Print inputs to the console
  console.log(`Input 1: ${input1}`);
  console.log(`Input 2: ${input2}`);
  
  // Custom action logic: Example of additional computation or logic
  const result = `Processed result: ${input1} + ${input2}`;
  console.log(result);

  
  core.setOutput("combinedResult", result);

} catch (error) {
  // Log any errors and mark the action as failed
  core.setFailed(error.message);
}
