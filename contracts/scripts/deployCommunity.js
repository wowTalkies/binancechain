const { upgrades } = require('hardhat');
const hre = require('hardhat');

async function main() {
  const factory = await hre.ethers.getContractFactory('WowTCommunity');

  // const contract = await upgrades.deployProxy(factory, [
  //   '0x39abC2Ef96408dba4532cdD9405eD6FB1A8533a6',
  //   10,
  // ]);

  const contract = await upgrades.upgradeProxy(
    '0x5aB333BCa2eba08529b83f26C7F1012Eff8949A4', // 0x10e8C8FB6Ccf12fFb388Ce527a2F69FCE5c74bF9
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

  // const getCommunities = await contract.getCommunities();
  // console.log('getCommunities ', getCommunities);

  // const addMember = await contract.addMembers(
  //   'Jackie chan community',
  //   '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
  // );
  // await addMember.wait();
  // console.log(`Initialized transaction hash is ${addMember.hash}`);

  // const checkMembership = await contract.checkMembership(
  //   'Jackie chan community',
  //   '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
  // );
  // console.log('checkMembership ', checkMembership);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
