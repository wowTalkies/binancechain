const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTQuiz');

  // const contract = await upgrades.deployProxy(factory, [
  //   5,
  //   20,
  //   2,
  //   'hash@123',
  //   '0x809d550fca64d94Bd9F66E60752A544199cfAC3D',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x86A2EE8FAf9A840F7a2c64CA3d51209F9A02081D',
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  // const tx = await contract.createQuiz(
  //   'test1',
  //   [
  //     'what is wowTalkies',
  //     ['Fan Engagement', 'Sports Engagement', 'Education', 'Tech'],
  //     '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044',
  //   ],
  //   'test1',
  //   'http://test.png'
  // );

  // await tx.wait();

  // console.log(`Initialized transaction hash is ${tx.hash}`);

  const evelQuiz = await contract.quizEval(
    '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199',
    'test1',
    '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044'
  );

  await evelQuiz.wait();

  console.log(`Initialized transaction hash is ${evelQuiz.hash}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
