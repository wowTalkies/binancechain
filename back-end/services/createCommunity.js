const Web3 = require('web3');
const jsonInterface = require('../abi/WowTCommunity.json');

const createCommunity = async (
  communityName,
  communityDescription,
  communityImage,
  communityQuizes
) => {
  if (
    communityName.trim() != '' &&
    communityDescription.trim() != '' &&
    communityImage.trim() != '' &&
    communityQuizes.length != 0
  ) {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);
    const contractAddress = '0x1A60169D778f060dd8c063ef5CB4839CBf67507a'; // WowTCommunity contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .createCommunity(
          communityName,
          communityDescription,
          communityImage,
          communityQuizes
        )
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const createCommunity = await contract.methods
        .createCommunity(
          communityName,
          communityDescription,
          communityImage,
          communityQuizes
        )
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

      console.log('createCommunity txHash ', createCommunity.transactionHash);

      return { body: 'Community created successfully' };
    } catch (err) {
      // console.log(err);
      return { error: 'Something went wrong' };
    }
  } else {
    return { error: 'Some event missing' };
  }
};

module.exports.createCommunity = createCommunity;
