const chai = require('chai');
const expect = require('chai').expect;
const lambdaTester = require('lambda-tester');

// Import lambda funcion
const lambda = require('../index');

describe('handler', function () {
  describe('if missing some events', function () {
    it(`if method doesn't exist`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'someMethod',
        })
        .expectResult((body, response) => {
          expect(body).to.equal(`someMethod method doesn't exist`);
        });
    });
    it(`if some event missing in addActivePoints method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addActiveUserPoints',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
    it(`if some event missing in addReferralPoints method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addReferralPoints',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
    it(`if some event missing in createCommunity method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'createCommunity',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
    it(`if some event missing in addMember method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addMember',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
    it(`if some event missing in createQuiz method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'createQuiz',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
    it(`if some event missing in quizEval method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'quizEval',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Some event missing');
        });
    });
  });
  describe('if transaction failed', function () {
    it(`if transaction fail in addActivePoints method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addActiveUserPoints',
          userAddress: '0x6be93e52Eca21A8470C3d4b8411E1A9f4b68685d',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in addReferralPoints method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addReferralPoints',
          userAddress: '0x311DA7a926B9865b70cFE18A2BBC6B86eD9524B4',
          referralAddress: '0x6be93e52Eca21A8470C3d4b8411E1A9f4b68685d',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in createCommunity method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'createCommunity',
          communityName: 'wowt sample community',
          communityDescription: 'wowt sample description',
          communityImage: 'ipfs://test.png',
          communityQuizes: ['wowt sample quiz'],
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in addMember method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'addMember',
          communityName: 'wowt sample community',
          userAddress: '0x6be93e52Eca21A8470C3d4b8411E1A9f4b68685d',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in createQuiz method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'createQuiz',
          quizName: 'wowt sample quiz',
          question: [
            'Fan Engagement',
            'Sports Engagement',
            'Education',
            'Tech',
          ],
          description: 'wowt sample description',
          imageUrl: 'ipfs://test.png',
          userAddress: '0x6be93e52Eca21A8470C3d4b8411E1A9f4b68685d',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in quizEval method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'quizEval',
          quizName: 'wowt sample quiz',
          choice: 'Education',
          userAddress: '0x6be93e52Eca21A8470C3d4b8411E1A9f4b68685d',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
    it(`if transaction fail in updateBadge method`, async function () {
      await lambdaTester(lambda.handler)
        .event({
          method: 'updateBadge',
        })
        .expectResult((body, response) => {
          expect(body.error).to.equal('Something went wrong');
        });
    });
  });
});
