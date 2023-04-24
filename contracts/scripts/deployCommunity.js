const { ethers, upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTCommunity');

  // const contract = await upgrades.deployProxy(factory, [
  //   '0x809d550fca64d94Bd9F66E60752A544199cfAC3D',
  //   20,
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x367761085BF3C12e5DA2Df99AC6E1a824612b8fb',
    factory
  );

  const [owner] = await hre.ethers.getSigners();

  await contract.deployed();
  console.log('Contract deployed to: ', contract.address);
  console.log('Contract deployed by (Owner): ', owner.address, '\n');

  // const tx = await contract.createCommunity(
  //   'Jackie chan community',
  //   'Jackie chan community for jackie chan fans',
  //   'http://test.png',
  //   ['test1']
  // );

  // await tx.wait();

  // console.log(`Initialized transaction hash is ${tx.hash}`);

  const getCommunities = await contract.getCommunities();
  console.log('getCommunities ', getCommunities);

  // const addMember = await contract.addMembers(
  //   'Jackie chan community',
  //   '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
  // );
  // await addMember.wait();
  // console.log(`Initialized transaction hash is ${addMember.hash}`);

  const checkMembership = await contract.checkMembership(
    'Jackie chan community',
    '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
  );
  console.log('checkMembership ', checkMembership);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
