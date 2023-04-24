const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTBadge');

  // const contract = await upgrades.deployProxy(factory, [
  //   'http://test.png',
  //   '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9',
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  const tx = await contract.updateBadgeForWeek('2023-10');

  await tx.wait();

  console.log(`Initialized transaction hash is ${tx.hash}`);

  const badgeAddress = await contract.badge('2023-10');
  console.log('badgeAddress ', badgeAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
