const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTBadge');

  // const contract = await upgrades.deployProxy(factory, [
  //   'https://wowtalkiesdevbucket.s3.ap-south-1.amazonaws.com/logo1.png',
  //   '0x7faf3239A9bE79072a1FaA43A3acb664F2af78f9',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x8D311f53c9970941B9507f31A20A4C9C122334db',
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
