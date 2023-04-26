const Web3 = require('web3');
const jsonInterface = require('../abi/WowTPoints.json');

const addActiveUserPoints = async (userAddress) => {
  if (userAddress && userAddress.trim() != '') {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);

    const contractAddress = '0x7faf3239A9bE79072a1FaA43A3acb664F2af78f9'; // WowTPoints contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .addActiveUserPoints(userAddress)
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const addActiveUserPoints = await contract.methods
        .addActiveUserPoints(userAddress)
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
      console.log(
        'addActiveUserPoints txHash ',
        addActiveUserPoints.transactionHash
      );
      return { body: 'Daily active points added successfully' };
    } catch (err) {
      // console.log(err);
      return { error: 'Something went wrong' };
    }
  } else {
    return { error: 'Some event missing' };
  }
};

module.exports.addActiveUserPoints = addActiveUserPoints;
