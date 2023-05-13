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
    '0x39abC2Ef96408dba4532cdD9405eD6FB1A8533a6', // 0xB192bb107DffaB91F8e6EB4D86f31567dC92Afc6
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

  // const getTopLeaderBoards = await contract.getTopLeaderBoards();
  // console.log('getTopLeaderBoards ', getTopLeaderBoards);

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
