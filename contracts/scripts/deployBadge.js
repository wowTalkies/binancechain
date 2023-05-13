const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTBadge');

  // const contract = await upgrades.deployProxy(factory, [
  //   'https://wowtalkiestestbucket.s3.ap-south-1.amazonaws.com/binancechain/badge/Gold.png',
  //   '0x39abC2Ef96408dba4532cdD9405eD6FB1A8533a6',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x02E4b8cbd97303111471d53DC602434Ed151df6e', // 0xBA73EA1a276B25a237D455a8682AA3c991AAC4C8
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
