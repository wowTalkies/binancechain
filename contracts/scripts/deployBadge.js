const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTBadge');

  // const contract = await upgrades.deployProxy(factory, [
  //   'https://wowtalkiestestbucket.s3.ap-south-1.amazonaws.com/binancechain/badge/Gold.png',
  //   '0xB192bb107DffaB91F8e6EB4D86f31567dC92Afc6',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0xBA73EA1a276B25a237D455a8682AA3c991AAC4C8', // 0x36ecE8a451A211670d27f20D700b7C5D547F556b
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  // const tx = await contract.updateBadgeForWeek('2023-10');

  // await tx.wait();

  // console.log(`Initialized transaction hash is ${tx.hash}`);

  // const badgeAddress = await contract.badge('2023-10');
  // console.log('badgeAddress ', badgeAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
