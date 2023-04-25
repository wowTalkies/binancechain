const Web3 = require('web3');
const jsonInterface = require('../abi/WowTQuiz.json');

// exports.handler = async (event, context) => {
const createQuiz = async (quizName, question, description, imageUrl) => {
  const privateKey = process.env.privateKey;
  const provider = process.env.provider;

  // set provider for all later instances to use
  const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
  web3.eth.accounts.wallet.add(privateKey);

  const account = web3.eth.accounts.wallet[0].address;
  console.log('account ', account);
  const contractAddress = '0xa2Aac22Fd0A0146a8d70eD86674D56872c733Da9';

  const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

  const gasPrice = await web3.eth.getGasPrice();
  const gasEstimate = await contract.methods
    .createQuiz(quizName, question, description, imageUrl)
    .estimateGas({ from: account });

  console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

  try {
    // const createQuiz = await contract.methods
    //   .createQuiz(quizName, question, description, imageUrl)
    //   .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
    // console.log('createQuiz txHash ', createQuiz.transactionHash);
    return 'Quiz created successfully';
  } catch (err) {
    console.log(err);
    return 'Something went wrong';
  }
};

module.exports.createQuiz = createQuiz;
