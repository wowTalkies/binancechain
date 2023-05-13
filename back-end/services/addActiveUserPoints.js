const Web3 = require('web3');
const jsonInterface = require('../abi/WowTPoints.json');

const addActiveUserPoints = async (userAddress) => {
  if (userAddress.trim() != '') {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);

    const contractAddress = '0x39abC2Ef96408dba4532cdD9405eD6FB1A8533a6'; // WowTPoints contract address

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
      console.log('addActiveUserPoints ', err);
      return { error: 'Something went wrong' };
    }
  } else {
    console.log('Some event missing');
    return { error: 'Some event missing' };
  }
};

module.exports.addActiveUserPoints = addActiveUserPoints;
