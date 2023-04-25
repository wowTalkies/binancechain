const Web3 = require('web3');
const jsonInterface = require('../abi/WowTQuiz.json');

const createQuiz = async (
  quizName,
  question,
  description,
  imageUrl,
  userAddress
) => {
  if (
    quizName &&
    quizName.trim() != '' &&
    question &&
    question.trim() != '' &&
    description &&
    description.trim() != '' &&
    imageUrl &&
    imageUrl.trim() != '' &&
    userAddress &&
    userAddress.trim() != ''
  ) {
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
      .createQuiz(quizName, question, description, imageUrl, userAddress)
      .estimateGas({ from: account });

    console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

    try {
      const createQuiz = await contract.methods
        .createQuiz(quizName, question, description, imageUrl, userAddress)
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
      console.log('createQuiz txHash ', createQuiz.transactionHash);
      return { body: 'Quiz created successfully' };
    } catch (err) {
      console.log(err);
      return { error: 'Something went wrong' };
    }
  } else {
    return { error: 'Some event missing' };
  }
};

module.exports.createQuiz = createQuiz;
