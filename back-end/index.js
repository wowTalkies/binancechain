const Web3 = require('web3');
const { addActiveUserPoints } = require('./services/addActiveUserPoints');
const { addMember } = require('./services/addMember');
const { addReferralPoints } = require('./services/addReferralPoints');
const { createQuiz } = require('./services/createQuiz');
const { createCommunity } = require('./services/createCommunity');
const { quizEval } = require('./services/quizEval');
const { updateBadge } = require('./services/updateBadge');
require('dotenv').config();

exports.handler = async (event) => {
  const method = event.method;

  switch (method) {
    case 'addActiveUserPoints':
      return await addActiveUserPoints(event.userAddress);

    case 'addReferralPoints':
      return await addReferralPoints(event.userAddress, event.referralAddress);

    case 'createCommunity':
      return await createCommunity(
        event.communityName,
        event.communityDescription,
        event.communityImage,
        event.communityQuizes
      );

    case 'addMember':
      return await addMember(event.communityName, event.userAddress);

    case 'createQuiz': {
      const correctAnswer = await Web3.utils.keccak256(
        event.answer + process.env.secretKey
      );
      const question = [
        event.questionName,
        [event.option1, event.option2, event.option3, event.option4],
        correctAnswer,
      ];
      return await createQuiz(
        event.quizName,
        question,
        event.description,
        event.imageUrl,
        event.userAddress
      );
    }
    case 'quizEval': {
      const hashedAnswer = await Web3.utils.keccak256(
        event.choice + process.env.secretKey
      );
      return await quizEval(event.userAddress, event.quizName, hashedAnswer);
    }

    case 'updateBadge':
      return await updateBadge();
    default:
      console.log(`${method} method doesn't exist`);
      return `${method} method doesn't exist`;
  }
};
