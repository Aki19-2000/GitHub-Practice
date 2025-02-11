const core = require('@actions/core');

try {
  
  const input1 = core.getInput('input1');
  const input2 = core.getInput('input2');
  

  console.log(`Input 1: ${input1}`);
  console.log(`Input 2: ${input2}`);
  
  
  const result = `Processed result: ${input1} + ${input2}`;
  console.log(result); 
  core.setOutput("combinedResult", result);

} catch (error) {
  
  core.setFailed(error.message);
}
