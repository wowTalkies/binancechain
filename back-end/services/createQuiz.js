const Web3 = require('web3');
const jsonInterface = require('../abi/WowTQuiz.json');

const createQuiz = async (
  communityName,
  quizName,
  description,
  imageUrl,
  question,
  options,
  correctAnswer,
  userAddress
) => {
  if (
    quizName.trim() != '' &&
    communityName.trim() != '' &&
    options.length == 4 &&
    description.trim() != '' &&
    imageUrl.trim() != '' &&
    question.trim() != '' &&
    correctAnswer.trim() != '' &&
    userAddress.trim() != ''
  ) {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);
    const contractAddress = '0x582436D3C1232d1126Dbb9B4AC67Af37766d5713'; // WowTQuiz contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .createQuiz(
          communityName,
          quizName,
          description,
          imageUrl,
          question,
          options,
          correctAnswer,
          userAddress
        )
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const createQuiz = await contract.methods
        .createQuiz(
          communityName,
          quizName,
          description,
          imageUrl,
          question,
          options,
          correctAnswer,
          userAddress
        )
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

      console.log('createQuiz txHash ', createQuiz.transactionHash);

      return { body: 'Quiz created successfully' };
    } catch (err) {
      console.log('createQuiz ', err);
      return { error: 'Something went wrong' };
    }
  } else {
    console.log('Some event missing');
    return { error: 'Some event missing' };
  }
};

module.exports.createQuiz = createQuiz;
