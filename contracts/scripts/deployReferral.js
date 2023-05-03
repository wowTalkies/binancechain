const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const pointContract = '0xbAf59D95709F960a047130D3f9721887B9Db3E10';

  const factory = await hre.ethers.getContractFactory('WowTReferral');

  // const contract = await upgrades.deployProxy(factory, [pointContract]);

  const contract = await upgrades.upgradeProxy(
    '0x8267D49a6E55A459428F820e4FecDF50BD89a139', // 0x1BA50c0Db827d687E3e7687beE9d8EaF11b9798C
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  // const tx = await contract.addReferralPoints(
  //   '0x809d550fca64d94Bd9F66E60752A544199cfAC3D',
  //   '0x90F79bf6EB2c4f870365E785982E1f101E93b906',
  //   '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65'
  // );

  // await tx.wait();

  // console.log(`Initialized transaction hash is ${tx.hash}`);

  // const getReferrals = await contract.getReferrals(
  //   '0x70997970C51812dc3A010C7d01b50e0d17dc79C8'
  // );
  // console.log('getReferrals ', getReferrals);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
