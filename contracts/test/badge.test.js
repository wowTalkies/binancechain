const { expect } = require('chai');
const { upgrades } = require('hardhat');
const hre = require('hardhat');
const { SignerWithAddress } = require('@nomiclabs/hardhat-ethers/signers.js');
const { Contract } = require('ethers');

describe('WowTReferrals', function () {
  const levelOnePoints = 5;
  const levelTwoPoints = 2;
  const activeUserPoints = 2;
  const minimumPointsForConvertion = 20;

  let points = Contract;
  let badge = Contract;
  let owner = SignerWithAddress;
  let otherUser = SignerWithAddress;

  beforeEach(async function () {
    const Points = await hre.ethers.getContractFactory('WowTPoints');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    points = await upgrades.deployProxy(Points, [
      levelOnePoints,
      levelTwoPoints,
      activeUserPoints,
      minimumPointsForConvertion,
    ]);
    await points.deployed();
  });

  beforeEach(async function () {
    const Badge = await hre.ethers.getContractFactory('WowTBadge');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    badge = await upgrades.deployProxy(Badge, ['ipfs://uri.png']);
    await badge.deployed();
  });

  describe('setters', function () {
    describe('owner', function () {
      it('should successfully give admin role', async () => {
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x8A791620dd6260079BF849Dc5567aDC3F2FdC318'
        );
        await expect(
          await points.hasRole(
            '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
            '0x8A791620dd6260079BF849Dc5567aDC3F2FdC318'
          )
        ).to.equal(true);
      });
      it('should successfully set and retrieve image', async () => {
        const newImageUri = 'ipfs://newUri.png';
        await badge.setImageUri(newImageUri);
        await expect(await badge.imageUri()).to.equal(newImageUri);
      });
      it('should successfully update badge if the caller is owner', async () => {
        await badge.updateBadgeForWeek(points.address, '2023-10');
        const getBadge = await badge.badge('2023-10');
        await expect(getBadge).to.equal(
          '0x0000000000000000000000000000000000000000'
        );
      });
    });
    describe('non-owner', function () {
      it('should be able to update badge if the caller is non-owner', async () => {
        await expect(
          badge.connect(otherUser).updateBadgeForWeek(points.address, '2023-11')
        ).to.revertedWith('Ownable: caller is not the owner');
      });
      it('should not be able to set minimumPointsForConvertion', async () => {
        const newImageUri = 'ipfs://newUri.png';
        await expect(
          badge.connect(otherUser).setImageUri(newImageUri)
        ).to.be.revertedWith('Ownable: caller is not the owner');
      });
    });
  });
});
