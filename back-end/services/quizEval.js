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
    const contractAddress = '0x582436D3C1232d1126Dbb9B4AC67Af37766d5713'; // WowTQuiz contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const evalStatus = await contract.methods
        .getEvalStatus(quizName, userAddress)
        .call();
      console.log('evalStatus ', evalStatus);

      if (!evalStatus) {
        const gasPrice = await web3.eth.getGasPrice();
        const gasEstimate = await contract.methods
          .quizEval(userAddress, quizName, choice)
          .estimateGas({ from: account });

        console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

        const quizEval = await contract.methods
          .quizEval(userAddress, quizName, choice)
          .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

        console.log('quizEval txHash ', quizEval.transactionHash);
        // console.log('quizEval ', JSON.stringify(quizEval));
        // console.log('quizEval-1 ', await quizEval.wait());
        const answer = quizEval.events.Answer.raw.topics[1];
        if (parseInt(answer)) {
          console.log('Correct answer');
          return { body: 'Correct answer' };
        } else {
          console.log('Wrong answer');
          return { body: 'Wrong answer' };
        }
      } else {
        console.log('Already tired');
        return { error: 'Already tried' };
      }
    } catch (err) {
      console.log('quizEval ', err);
      return { error: 'Something went wrong' };
    }
  } else {
    console.log('Some event missing ');
    return { error: 'Some event missing' };
  }
};

module.exports.quizEval = quizEval;
