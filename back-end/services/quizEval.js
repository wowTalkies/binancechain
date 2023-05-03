const Web3 = require('web3');
const jsonInterface = require('../abi/WowTQuiz.json');

const quizEval = async (userAddress, quizName, choice) => {
  if (
    userAddress &&
    userAddress.trim() != '' &&
    quizName &&
    quizName.trim() != '' &&
    choice &&
    choice.trim() != ''
  ) {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);
    const contractAddress = '0xa2Aac22Fd0A0146a8d70eD86674D56872c733Da9'; // WowTQuiz contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .quizEval(userAddress, quizName, choice)
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const quizEval = await contract.methods
        .quizEval(userAddress, quizName, choice)
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

      console.log('quizEval txHash ', quizEval.transactionHash);

      return { body: 'Quiz evaluated successfully' }; // Need changes for eval quiz via contract
    } catch (err) {
      // console.log(err);
      return { error: 'Something went wrong' };
    }
  } else {
    return { error: 'Some event missing' };
  }
};

module.exports.quizEval = quizEval;
