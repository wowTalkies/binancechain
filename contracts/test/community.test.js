const { expect } = require('chai');
const { upgrades } = require('hardhat');
const hre = require('hardhat');
const { SignerWithAddress } = require('@nomiclabs/hardhat-ethers/signers.js');
const { Contract } = require('ethers');

describe('WowTCommunity', function () {
  let points = Contract;
  let community = Contract;
  let owner = SignerWithAddress;
  let otherUser = SignerWithAddress;

  beforeEach(async function () {
    const levelOnePoints = 5;
    const levelTwoPoints = 2;
    const activeUserPoints = 2;
    const minimumPointsForConvertion = 20;
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
    const communityEntryPoints = 10;
    const pointsContract = points.address;
    const Community = await hre.ethers.getContractFactory('WowTCommunity');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    community = await upgrades.deployProxy(Community, [
      pointsContract,
      communityEntryPoints,
    ]);
    await community.deployed();
  });

  describe('setters', function () {
    describe('owner', function () {
      it('should successfully give admin role', async () => {
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x68B1D87F95878fE05B998F19b66F4baba5De1aed'
        );
        await expect(
          await points.hasRole(
            '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
            '0x68B1D87F95878fE05B998F19b66F4baba5De1aed'
          )
        ).to.equal(true);
      });
      it('should successfully create and retrieve community', async () => {
        const communityName = 'Jackie chan community';
        const description = 'Jackie chan community for jackie chan fans';
        const imageUrl = 'ipfs//new.png';
        const quizesforEntry = ['what is wowTalkies'];
        await community.createCommunity(
          communityName,
          description,
          imageUrl,
          quizesforEntry
        );
        const getCommunities = await community.getCommunities();
        await expect(getCommunities[0]).to.equal(communityName);
        const communityValues = await community.communityMap(communityName);
        await expect(communityValues.description).to.equal(description);
        await expect(communityValues.imageUrl).to.equal(imageUrl);
        await expect(communityValues.exists).to.equal(true);
        const QuizCommuinty = await community.checkQuizesforCommunity(
          communityName
        );
        await expect(QuizCommuinty[0]).to.be.equal(quizesforEntry[0]);
      });
      it('should successfully add and retrieve members', async () => {
        const communityName = 'marvel cinematic universe community';
        const description =
          'marvel cinematic universe community for marvel fans';
        const imageUrl = 'ipfs//new.png';
        const quizesforEntry = ['what is wowTalkies'];
        await community.createCommunity(
          communityName,
          description,
          imageUrl,
          quizesforEntry
        );
        await points.addPoints(owner.address, 30);
        await community.addMembers(communityName, owner.address);
        await expect(
          await community.checkMembership(communityName, owner.address)
        ).to.equal(true);
      });
      it('should successfully set and retrieve communityEntryPoints', async () => {
        const newCommunityEntryPoints = 4;
        await community.setCommunityEntryPoints(newCommunityEntryPoints);
        await expect(await community.communityEntryPoints()).to.equal(
          newCommunityEntryPoints
        );
      });
    });

    describe('non-owner', function () {
      it('should be able to set communityEntryPoints if the caller is non-owner', async () => {
        const newCommunityEntryPoints = 5;
        await expect(
          community
            .connect(otherUser)
            .setCommunityEntryPoints(newCommunityEntryPoints)
        ).to.be.revertedWith('Ownable: caller is not the owner');
      });
    });
  });
});
