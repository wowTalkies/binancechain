// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.9;
import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Points} from "./Points.sol";
//import "hardhat/console.sol";
contract WowTQuiz is  OwnableUpgradeable {
     
    //Ponts to quize creator
    uint16 public quizePoints=2;
    //Get User Points for checking
    // uint256 public userPoints;
   //For Creating the Quizes
    uint16 public createEligibility =20;
    //Correct Answering Quize will get 5 points
    uint16 public pointsToAnswer =5;
    //Secret key to encript Answer set
    string private secret = "hash@123" ;
    //bool isReveal;
    address private pointsContract = 0xd9145CCE52D386f254917e481eB44e9943F39138;
   //Points conracts
   Points private points = Points(pointsContract);
    //Structure to hold Questions and answers. correct index needs to be encripted
    struct Question{
     string question;
     string[4] options;
     bytes32 answer;     
   }  

   //Quiz structure
    struct Quiz{
        string description;
        string imageUrl;
        address[] quizattenders;
        Question question;
        address creatorAddress;

    }   
   // Quiz[] public quizes;    
     // Community --> Quiz
     mapping(string => Quiz) public quizmap;

   function initialize() external initializer{
       __Ownable_init();
   }
    //Create Quiz 
   function createQuiz(string memory _quizName,  Question memory _question, string memory _description, string memory _imageUrl) public {
        uint256 userPoints=25;
        require (userPoints > 20 || _msgSender() == owner(), "Not enough point to create Quiz");
        quizmap[_quizName].description = _description;
        quizmap[_quizName].question = _question;
        quizmap[_quizName].imageUrl = _imageUrl;      
         quizmap[_quizName].creatorAddress =  _msgSender(); 
   }

function getQuizdetails(string memory _quizName) public view returns (Quiz memory){

    return quizmap[_quizName];
      
   }

function getstringQuizdetails(string memory _quizName) public view returns (string memory, string memory, string memory, string[4] memory){
   // function getstringQuizdetails(string memory _quizName) public view returns ( string memory, string memory, string memory, string memory, string memory, string memory){
     Quiz memory qtemp = getQuizdetails(_quizName);
     string memory tempDescription = qtemp.description;
     string memory tempImageUrl = qtemp.imageUrl;
     Question memory tempQuestion = qtemp.question;

     string memory tQuestion = tempQuestion.question;
     string[4] memory options= tempQuestion.options;
    
    return (tempDescription,  tempImageUrl, tQuestion,options);
      
   }
   
function quizEval(address _userAddress, string memory _quizName, bytes32 choice) public onlyOwner returns (string memory) {
   Quiz memory qtemp = getQuizdetails(_quizName);
   Question memory tempQuestion = qtemp.question;
   bytes32  answer = tempQuestion.answer;
  // if (keccak256(bytes(answer)) == keccak256(bytes(choice))){
       if (answer == choice){
      points.addPoints(_userAddress, pointsToAnswer);
      points.addPoints(qtemp.creatorAddress, quizePoints);

       return "Correct Answer,  Points Added"; 
   }else{
     return "Wrong Answer"; 
   }
    //return _userAddress; //Need implementation

      
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

   function encodeAnswer(string memory _input) public pure returns(bytes32){
       bytes32 answerHash = keccak256(abi.encodePacked(_input));
       return answerHash;
   } 

    function setQuizePoints(uint16 _quizePoints) external onlyOwner {
        quizePoints = _quizePoints;
    }

     function setCreateEligibility(uint16 _createEligibility) external onlyOwner {
        createEligibility = _createEligibility;
    }

    function setPointsToAnswer(uint16 _pointsToAnswer) external onlyOwner {
        pointsToAnswer = _pointsToAnswer;
    }   


}