const Web3 = require('web3');
const jsonInterface = require('../abi/WowTReferral.json');

// exports.handler = async (event, context) => {
const addReferralPoints = async (userAddress, referralAddress) => {
  const privateKey = process.env.privateKey;
  const provider = process.env.provider;

  // set provider for all later instances to use
  const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
  web3.eth.accounts.wallet.add(privateKey);

  const account = web3.eth.accounts.wallet[0].address;
  console.log('account ', account);
  const contractAddress = '0x8267D49a6E55A459428F820e4FecDF50BD89a139';

  const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

  const gasPrice = await web3.eth.getGasPrice();
  const gasEstimate = await contract.methods
    .addReferralPoints(userAddress, referralAddress)
    .estimateGas({ from: account });

  console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

  try {
    // const addReferralPoints = await contract.methods
    //   .addReferralPoints(userAddress, referralAddress)
    //   .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
    // console.log('addReferralPoints txHash ', addReferralPoints.transactionHash);
    return 'Referral points added successfully';
  } catch (err) {
    console.log(err);
    return 'Something went wrong';
  }
};

module.exports.addReferralPoints = addReferralPoints;
