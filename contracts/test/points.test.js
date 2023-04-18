const { expect } = require('chai');
const { upgrades } = require('hardhat');
const hre = require('hardhat');
const { SignerWithAddress } = require('@nomiclabs/hardhat-ethers/signers.js');
const { Contract } = require('ethers');

describe('WowTPoints', function () {
  const levelOnePoints = 5;
  const levelTwoPoints = 2;
  const activeUserPoints = 2;
  const minimumPointsForConvertion = 20;

  let contract = Contract;
  let owner = SignerWithAddress;
  let otherUser = SignerWithAddress;

  beforeEach(async function () {
    const Contract = await hre.ethers.getContractFactory('WowTPoints');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    contract = await upgrades.deployProxy(Contract, [
      levelOnePoints,
      levelTwoPoints,
      activeUserPoints,
      minimumPointsForConvertion,
    ]);
    await contract.deployed();
  });

  describe('setters', function () {
    describe('owner', function () {
      it('should successfully set and retrieve levelOnePoints', async () => {
        const newLevelOnePoints = 10;
        await contract.setLevelOnePoints(newLevelOnePoints);
        await expect(await contract.levelOnePoints()).to.equal(
          newLevelOnePoints
        );
      });

      it('should successfully set and retrieve levelTwoPoints', async () => {
        const newLevelTwoPoints = 6;
        await contract.setLevelTwoPoints(newLevelTwoPoints);
        await expect(await contract.levelTwoPoints()).to.equal(
          newLevelTwoPoints
        );
      });
      it('should successfully set and retrieve activeUserPoints', async () => {
        const newActiveUserPoints = 3;
        await contract.setActiveUserPoints(newActiveUserPoints);
        await expect(await contract.activeUserPoints()).to.equal(
          newActiveUserPoints
        );
      });
      it('should successfully set and retrieve minimumPointsForConvertion', async () => {
        const newMinimumPointsForConvertion = 25;
        await contract.setMinimumPointsForConvertion(
          newMinimumPointsForConvertion
        );
        await expect(await contract.minimumPointsForConvertion()).to.equal(
          newMinimumPointsForConvertion
        );
      });
      it('should successfully give admin role', async () => {
        await contract.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0'
        );
        await expect(
          await contract.hasRole(
            '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
            '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0'
          )
        ).to.equal(true);
      });
    });
  });

  describe('non-owner', function () {
    it('should not be able to set levelOnePoints', async () => {
      const newLevelOnePoints = 10;
      await expect(
        contract.connect(otherUser).setLevelOnePoints(newLevelOnePoints)
      ).to.be.revertedWith('Ownable: caller is not the owner');
    });

    it('should not be able to set levelTwoPoints', async () => {
      const newLevelTwoPoints = 10;
      await expect(
        contract.connect(otherUser).setLevelTwoPoints(newLevelTwoPoints)
      ).to.be.revertedWith('Ownable: caller is not the owner');
    });
    it('should not be able to set activeUserPoints', async () => {
      const newActiveUserPoints = 4;
      await expect(
        contract.connect(otherUser).setActiveUserPoints(newActiveUserPoints)
      ).to.be.revertedWith('Ownable: caller is not the owner');
    });
    it('should not be able to set minimumPointsForConvertion', async () => {
      const newMinimumPointsForConvertion = 10;
      await expect(
        contract
          .connect(otherUser)
          .setMinimumPointsForConvertion(newMinimumPointsForConvertion)
      ).to.be.revertedWith('Ownable: caller is not the owner');
    });
  });

  describe('points', function () {
    describe('admin', function () {
      it('should successfully add and get points', async () => {
        const points = 28;
        await contract.addPoints(otherUser.address, points);
        await expect(await contract.getPoints(otherUser.address)).to.equal(
          points
        );
        await expect(await contract.getLeaderBoard()).to.equal(
          otherUser.address
        );
        const topLeaderBoards = await contract.getTopLeaderBoards();
        await expect(topLeaderBoards[0]).to.equal(
          '0x70997970C51812dc3A010C7d01b50e0d17dc79C8'
        );
      });
      it('should successfully add activeUser points', async () => {
        await contract.addActiveUserPoints(otherUser.address);
        await expect(await contract.getPoints(otherUser.address)).to.equal(
          activeUserPoints
        );
      });
      it('should successfully reduce points', async () => {
        const addPoints = 35;
        await contract.addPoints(otherUser.address, addPoints);
        const reducePoints = 10;
        await contract.reducePoints(otherUser.address, reducePoints);
        await expect(await contract.getPoints(otherUser.address)).to.equal(
          addPoints - reducePoints
        );
      });
    });
    describe('non-admin', function () {
      it('should not be able to add points', async () => {
        const points = 28;
        await expect(
          contract.connect(otherUser).addPoints(otherUser.address, points)
        ).to.be.revertedWith('Must have admin role');
      });
      it('should not be able to add activeUser points', async () => {
        await expect(
          contract.connect(otherUser).addActiveUserPoints(otherUser.address)
        ).to.be.revertedWith('Ownable: caller is not the owner');
      });
      it('should not be able to reduce points', async () => {
        const addPoints = 35;
        await contract.addPoints(otherUser.address, addPoints);
        const reducePoints = 10;
        await expect(
          contract
            .connect(otherUser)
            .reducePoints(otherUser.address, reducePoints)
        ).to.be.revertedWith('Must have admin role');
      });
    });
  });
});
