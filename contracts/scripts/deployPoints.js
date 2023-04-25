const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const levelOnePoints = 5;
  const levelTwoPoints = 2;
  const activeUserPoints = 2;
  const minimumPointsForConvertion = 20;
  const factory = await hre.ethers.getContractFactory('WowTPoints');

  // const contract = await upgrades.deployProxy(factory, [
  //   levelOnePoints,
  //   levelTwoPoints,
  //   activeUserPoints,
  //   minimumPointsForConvertion,
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x7faf3239A9bE79072a1FaA43A3acb664F2af78f9',
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  // const tx = await contract.addPoints(
  //   '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  //   10
  // );

  // await tx.wait();

  // console.log(`Initialized transaction hash is ${tx.hash}`);

  // const getPoints = await contract.getPoints(
  //   '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65'
  // );
  // console.log('getPoints ', getPoints);

  // const grantRole = await contract.grantRole(
  //   '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
  //   '0x86A2EE8FAf9A840F7a2c64CA3d51209F9A02081D'
  // );

  // await grantRole.wait();

  // console.log(`Initialized transaction hash is ${grantRole.hash}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
