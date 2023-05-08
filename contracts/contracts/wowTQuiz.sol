// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.9;
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";
import {WowTCommunity} from "./wowTCommunity.sol";

//import "hardhat/console.sol";
contract WowTQuiz is OwnableUpgradeable {
    //Ponts to quize creator
    uint16 public quizePoints;
    //Get User Points for checking
    // uint256 public userPoints;
    //For Creating the Quizes
    uint16 public createEligibility;
    //Correct Answering Quize will get 5 points
    uint16 public pointsToAnswer;
    //Secret key to encript Answer set
    // string private secret;
    //Points conracts
    WowTPoints private points;
    WowTCommunity private community;
    //Structure to hold Questions and answers. correct index needs to be encripted
    // struct Question {
    //     string question;
    //     string[4] options;
    //     bytes32 answer;
    // }

    //Quiz structure
    struct Quiz {
        string description;
        string imageUrl;
        string question;
        string[4] options;
        bytes32 answer;
        address creatorAddress;
    }
    // Quiz[] public quizes;
    // Community --> Quiz
    mapping(string => Quiz) public quizmap;

    // for checking answer
    event Answer(bool indexed);

    function initialize(
        uint16 _quizePoints,
        uint16 _createEligibility,
        uint16 _pointsToAnswer,
        //string memory _secret,
        address _pointsContract,
        address _communityContract
    ) external initializer {
        __Ownable_init();
        quizePoints = _quizePoints;
        createEligibility = _createEligibility;
        pointsToAnswer = _pointsToAnswer;
        //secret = _secret;
        points = WowTPoints(_pointsContract);
        community = WowTCommunity(_communityContract);
    }

    //Create Quiz
    function createQuiz(
        string memory _communityName,
        string memory _quizName,
        // Question memory _question,
        string memory _description,
        string memory _imageUrl,
        string memory _question,
        string[4] memory _options,
        bytes32 _answer,
        address _creatorAddress
    ) external onlyOwner {
        uint256 userPoints = points.getPoints(_creatorAddress);
        require(
            userPoints > 20 || _creatorAddress == owner(),
            "Not enough point to create Quiz"
        );
        require(
            community.checkCommunityExists(_communityName),
            "Community doesn't exist"
        );
        quizmap[_quizName] = Quiz(
            _description,
            _imageUrl,
            _question,
            _options,
            _answer,
            _creatorAddress
        );
        community.updateCommunityQuizes(_communityName, _quizName);

        // quizmap[_quizName].description = _description;
        // quizmap[_quizName].question = _question;
        // quizmap[_quizName].options = _options;
        // quizmap[_quizName].answer = _answer;
        // quizmap[_quizName].imageUrl = _imageUrl;
        // quizmap[_quizName].creatorAddress = _creatorAddress;
    }

    function getQuizdetails(
        string memory _quizName
    ) public view returns (Quiz memory) {
        return quizmap[_quizName];
    }

    function getstringQuizdetails(
        string memory _quizName
    )
        public
        view
        returns (string memory, string memory, string memory, string[4] memory)
    {
        Quiz memory qtemp = getQuizdetails(_quizName);
        string memory tempDescription = qtemp.description;
        string memory tempImageUrl = qtemp.imageUrl;
        // Question memory tempQuestion = qtemp.question;

        string memory tQuestion = qtemp.question;
        string[4] memory options = qtemp.options;

        return (tempDescription, tempImageUrl, tQuestion, options);
    }

    function quizEval(
        address _userAddress,
        string memory _quizName,
        bytes32 choice
    ) public onlyOwner {
        Quiz memory qtemp = getQuizdetails(_quizName);
        // Question memory tempQuestion = qtemp.question;
        bytes32 answer = qtemp.answer;
        // if (keccak256(bytes(answer)) == keccak256(bytes(choice))){
        quizeEvaluatePoints(answer, choice, _userAddress, qtemp.creatorAddress);
        //return _userAddress; //Need implementation
    }

    function checkAnswer(
        string memory _quizName,
        bytes32 choice
    ) public view returns (bool) {
        Quiz memory qtemp = getQuizdetails(_quizName);
        // Question memory tempQuestion = qtemp.question;
        bytes32 answer = qtemp.answer;
        if (answer == choice) {
            return true;
        } else {
            return false;
        }
    }

    function quizeEvaluatePoints(
        bytes32 answer,
        bytes32 choice,
        address _userAddress,
        address _creatorAddress
    ) private {
        if (answer == choice) {
            points.addPoints(_userAddress, pointsToAnswer);
            emit Answer(true);
        } else {
            emit Answer(false);
        }
        points.addPoints(_creatorAddress, quizePoints);
    }

    /*
    function addQuizePoints( address _userAddress,  uint16 _quizePoints) public onlyOwner{
        //addPoints(userAddress, quizePoints)
        points.addPoints(_userAddress, _quizePoints);

    }

    function addPointsToAnswer(address _userAddress, uint16 _pointsToAnswer) public onlyOwner{
        //addPoints(userAddress, pointsToAnswer)
            points.addPoints(_userAddress, _pointsToAnswer);

    }  */

    // function encodeAnswer(string memory _input) public pure returns (bytes32) {
    //     bytes32 answerHash = keccak256(abi.encodePacked(_input));
    //     return answerHash;
    // }

    function setQuizePoints(uint16 _quizePoints) external onlyOwner {
        quizePoints = _quizePoints;
    }

    function setCreateEligibility(
        uint16 _createEligibility
    ) external onlyOwner {
        createEligibility = _createEligibility;
    }

    function setPointsToAnswer(uint16 _pointsToAnswer) external onlyOwner {
        pointsToAnswer = _pointsToAnswer;
    }
}
