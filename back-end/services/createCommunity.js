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
    communityImage.trim() != ''
  ) {
    const privateKey = process.env.privateKey;
    const provider = process.env.provider;

    // set provider for all later instances to use
    const web3 = await new Web3(new Web3.providers.HttpProvider(provider));
    web3.eth.accounts.wallet.add(privateKey);

    const account = web3.eth.accounts.wallet[0].address;
    // console.log('account ', account);
    const contractAddress = '0x5aB333BCa2eba08529b83f26C7F1012Eff8949A4'; // WowTCommunity contract address

    const contract = new web3.eth.Contract(jsonInterface.abi, contractAddress);

    try {
      const gasPrice = await web3.eth.getGasPrice();
      const gasEstimate = await contract.methods
        .createCommunity(communityName, communityDescription, communityImage)
        .estimateGas({ from: account });

      console.log('gasPrice ', gasPrice, 'gasEstimate ', gasEstimate);

      const createCommunity = await contract.methods
        .createCommunity(communityName, communityDescription, communityImage)
        .send({ from: account, gasPrice: gasPrice, gas: gasEstimate });

      console.log('createCommunity txHash ', createCommunity.transactionHash);

      return { body: 'Community created successfully' };
    } catch (err) {
      console.log('createCommunity ', err);
      return { error: 'Something went wrong' };
    }
  } else {
    console.log('Some event missing');
    return { error: 'Some event missing' };
  }
};

module.exports.createCommunity = createCommunity;
