const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const pointContract = '0x7faf3239A9bE79072a1FaA43A3acb664F2af78f9';

  const factory = await hre.ethers.getContractFactory('WowTReferral');

  // const contract = await upgrades.deployProxy(factory, [pointContract]);

  const contract = await upgrades.upgradeProxy(
    '0x8267D49a6E55A459428F820e4FecDF50BD89a139',
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
