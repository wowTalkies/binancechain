require('@nomicfoundation/hardhat-toolbox');
require('@openzeppelin/hardhat-upgrades');
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: '0.8.17',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },

  networks: {
    bscTestnet: {
      url: process.env.BSC_TESTNET_URL || '',
      accounts:
        process.env.TEST_PRIVATE_KEY !== undefined
          ? [process.env.TEST_PRIVATE_KEY]
          : [],
    },
  },
  etherscan: {
    apiKey: 'DGNTHUJYZED8S2VE25GF3QRQ8T7AJHI1RQ',
  },
};
