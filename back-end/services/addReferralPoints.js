const Web3 = require('web3');
const jsonInterface = require('../abi/WowTReferral.json');

const addReferralPoints = async (userAddress, referralAddress) => {
  if (userAddress.trim() != '' && referralAddress.trim() != '') {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);
    const contractAddress = '0x1BA50c0Db827d687E3e7687beE9d8EaF11b9798C'; // WowTReferral contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .addReferralPoints(userAddress, referralAddress)
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const addReferralPoints = await contract.methods
        .addReferralPoints(userAddress, referralAddress)
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

      console.log(
        'addReferralPoints txHash ',
        addReferralPoints.transactionHash
      );

      return { body: 'Referral points added successfully' };
    } catch (err) {
      // console.log(err);
      return { error: 'Something went wrong' };
    }
  } else {
    return { error: 'Some event missing' };
  }
};

module.exports.addReferralPoints = addReferralPoints;
