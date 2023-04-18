const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTPoints');

  const contract = await upgrades.deployProxy(factory, [10, 5, 2, 20]);

  //   const contract = await upgrades.upgradeProxy(
  //     "0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e",
  //     factory
  //   );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
