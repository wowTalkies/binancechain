const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTQuiz');

  // const contract = await upgrades.deployProxy(factory, [
  //   2,
  //   20,
  //   2,
  //   '0xB192bb107DffaB91F8e6EB4D86f31567dC92Afc6',
  //   '0x10e8C8FB6Ccf12fFb388Ce527a2F69FCE5c74bF9',
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x203B9d8B1EB14BfD8C298ff2ea030F6f2217E786', // 0xC9809Cb6Cdb99b883798fDdb1EDAbe863Ef5f0F1
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

  // const evelQuiz = await contract.quizEval(
  //   '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199',
  //   'test1',
  //   '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044'
  // );

  // await evelQuiz.wait();

  // console.log(`Initialized transaction hash is ${evelQuiz.hash}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
