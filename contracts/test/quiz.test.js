const { expect } = require('chai');
const { upgrades } = require('hardhat');
const hre = require('hardhat');
const { SignerWithAddress } = require('@nomiclabs/hardhat-ethers/signers.js');
const { Contract } = require('ethers');

describe('WowTQuiz', function () {
  let points = Contract;
  let quiz = Contract;
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
    const quizePoints = 5;
    const createEligibility = 20;
    const pointsToAnswer = 2;
    const secret = 'hash@123';
    const pointsContract = points.address;
    const Quiz = await hre.ethers.getContractFactory('WowTQuiz');

    const [_owner, _otherUser] = await hre.ethers.getSigners();
    owner = _owner;
    otherUser = _otherUser;

    quiz = await upgrades.deployProxy(Quiz, [
      quizePoints,
      createEligibility,
      pointsToAnswer,
      secret,
      pointsContract,
    ]);
    await quiz.deployed();
  });

  describe('setters', function () {
    describe('owner', function () {
      it('should successfully give admin role', async () => {
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x1fA02b2d6A771842690194Cf62D91bdd92BfE28d'
        );
        await expect(
          await points.hasRole(
            '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
            '0x1fA02b2d6A771842690194Cf62D91bdd92BfE28d'
          )
        ).to.equal(true);
      });
      it('should successfully create and get quiz details', async () => {
        const quizName = 'wowt sample quiz';
        const question = [
          'what is wowTalkies',
          ['Fan Engagement', 'Sports Engagement', 'Education', 'Tech'],
          '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044',
        ];
        const description = 'wowt sample description';
        const imageUrl = 'ipfs://test.png';
        await quiz.createQuiz(quizName, question, description, imageUrl);
        const quizDetails = await quiz.getQuizdetails(quizName);
        await expect(quizDetails.question[0]).to.equal(question[0]);
        await expect(quizDetails.description).to.equal(description);
        await expect(quizDetails.imageUrl).to.equal(imageUrl);
        await expect(quizDetails.creatorAddress).to.equal(owner.address);
      });
      it('should successfully create and evaluate quiz', async () => {
        const quizName = 'wowt sample quiz';
        const question = [
          'what is wowTalkies',
          ['Fan Engagement', 'Sports Engagement', 'Education', 'Tech'],
          '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044',
        ];
        const description = 'wowt sample description';
        const imageUrl = 'ipfs://test.png';
        await quiz.createQuiz(quizName, question, description, imageUrl);
        await points.grantRole(
          '0xa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c21775',
          '0x1fA02b2d6A771842690194Cf62D91bdd92BfE28d'
        );
        await quiz.quizEval(
          owner.address,
          quizName,
          '0x5dfcdcc84ba4d7a5b52dd94b10d0342b003460b20c98febb976358f254401044'
        );
      });
      it('should successfully set and retrieve quizePoints', async () => {
        const newQuizePoints = 4;
        await quiz.setQuizePoints(newQuizePoints);
        await expect(await quiz.quizePoints()).to.equal(newQuizePoints);
      });
      it('should successfully set and retrieve createEligibility', async () => {
        const newCreateEligibility = 4;
        await quiz.setCreateEligibility(newCreateEligibility);
        await expect(await quiz.createEligibility()).to.equal(
          newCreateEligibility
        );
      });
      it('should successfully set and retrieve pointsToAnswer', async () => {
        const newPointsToAnswer = 4;
        await quiz.setPointsToAnswer(newPointsToAnswer);
        await expect(await quiz.pointsToAnswer()).to.equal(newPointsToAnswer);
      });
    });

    describe('non-owner', function () {
      it('should not able to createEligibility', async () => {
        const newCreateEligibility = 10;
        await expect(
          quiz.connect(otherUser).setCreateEligibility(newCreateEligibility)
        ).to.be.revertedWith('Ownable: caller is not the owner');
      });
      it('should not able to set pointsToAnswer', async () => {
        const newPointsToAnswer = 6;
        await expect(
          quiz.connect(otherUser).setPointsToAnswer(newPointsToAnswer)
        ).to.be.revertedWith('Ownable: caller is not the owner');
      });
    });
  });
});
