const Web3 = require('web3');
const moment = require('moment');
const jsonInterface = require('../abi/WowTBadge.json');

// exports.handler = async (event, context) => {
const updateBadge = async () => {
  const privateKey = process.env.privateKey;
  const provider = process.env.provider;

  // set provider for all later instances to use
  const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
  web3.eth.accounts.wallet.add(privateKey);

  const account = web3.eth.accounts.wallet[0].address;
  console.log('account ', account);
  const contractAddress = '0x8D311f53c9970941B9507f31A20A4C9C122334db';

  const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

  const year = new Date().getFullYear();
  console.log('year ', year);
  const week = moment(moment().toDate(), 'MM-DD-YYYY').week();
  console.log('week ', week);

  const gasPrice = await web3.eth.getGasPrice();
  const gasEstimate = await contract.methods
    .updateBadgeForWeek(`${year}-${week}`)
    .estimateGas({ from: account });

  console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

  try {
    // const updateBadge = await contract.methods
    //   .updateBadgeForWeek(`${year}-${week}`)
    //   .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });
    // console.log('updateBadge txHash ', updateBadge.transactionHash);
    return 'Badge updated successfully';
  } catch (err) {
    console.log(err);
    return 'Something went wrong';
  }
};

module.exports.updateBadge = updateBadge;
