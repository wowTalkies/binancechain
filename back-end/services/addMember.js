const Web3 = require('web3');
const jsonInterface = require('../abi/WowTCommunity.json');

// exports.handler = async (event, context) => {
const addMember = async (CommunityName, userAddress) => {
  const privateKey = process.env.privateKey;
  const provider = process.env.provider;

  // set provider for all later instances to use
  const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
  web3.eth.accounts.wallet.add(privateKey);

  const account = web3.eth.accounts.wallet[0].address;
  console.log('account ', account);
  const contractAddress = '0x75849A2035267a8c72410bc4ed8d458177CF1FAc';

  const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

  const gasPrice = await web3.eth.getGasPrice();
  const gasEstimate = await contract.methods
    .addMembers(CommunityName, userAddress)
    .estimateGas({ from: account });

  console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

  try {
    // const addMember = await contract.methods
    //   .addMembers(CommunityName, userAddress)
    //   .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
    // console.log('addMember txHash ', addMember.transactionHash);
    return 'member added successfully';
  } catch (err) {
    console.log(err);
    return 'Something went wrong';
  }
};

module.exports.addMember = addMember;
