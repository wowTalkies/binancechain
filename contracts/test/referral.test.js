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
  let referral = Contract;
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
    const Referral = await hre.ethers.getContractFactory('WowTReferral');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    referral = await upgrades.deployProxy(Referral, [points.address]);
    await referral.deployed();
  });

  describe('setters', function () {
    describe('owner', function () {
      it('should successfully give admin role', async () => {
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x1c85638e118b37167e9298c2268758e058DdfDA0'
        );
        await expect(
          await points.hasRole(
            '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
            '0x1c85638e118b37167e9298c2268758e058DdfDA0'
          )
        ).to.equal(true);
      });
      it('should successfully add referrals if the caller is owner', async () => {
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          referral.address
        );
        await referral.addReferralPoints(owner.address, otherUser.address);
        const getReferral = await referral.getReferrals(owner.address);
        await expect(getReferral[0]).to.equal(otherUser.address);
        await expect(getReferral[1]).to.equal(true);
        await referral.addReferralPoints(otherUser.address, owner.address);
        const getReferrals = await referral.getReferrals(otherUser.address);
        await expect(getReferrals[0]).to.equal(owner.address);
        await expect(getReferrals[1]).to.equal(true);
      });
    });
    describe('non-owner', function () {
      it('should be able to add referrals if the caller is non-owner', async () => {
        await expect(
          referral
            .connect(otherUser)
            .addReferralPoints(owner.address, otherUser.address)
        ).to.revertedWith('Ownable: caller is not the owner');
      });
    });
  });
});
