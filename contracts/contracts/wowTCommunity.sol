// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTCommunity is OwnableUpgradeable {
    uint16 public communityEntryPoints;
    address public pointsContract;
    string[] private communities;
    WowTPoints private points;

    struct CommunityDetails {
        string description;
        string imageUrl;
        mapping(address => bool) members;
        string[] quizesforEntry;
        uint256 totalMembers;
        bool exists;
    }

    mapping(string => CommunityDetails) public communityMap;

    function initialize(
        address _pointsContract,
        uint16 _communityEntryPoints
    ) external initializer {
        __Ownable_init();
        communityEntryPoints = _communityEntryPoints;
        points = WowTPoints(_pointsContract);
    }

    // function updatePointsContract(address _pointsContract) external onlyOwner {

    //    pointsContract = _pointsContract;

    // }

    function setCommunityEntryPoints(
        uint16 _newCommunityEntryPoints
    ) external onlyOwner {
        communityEntryPoints = _newCommunityEntryPoints;
    }

    function addMembers(
        string memory _communityName,
        address _communityParticipant
    ) external onlyOwner {
        // Check if community exists
        require(communityMap[_communityName].exists, "Community doesn't exist");

        // Check if user is already part of community
        require(
            !communityMap[_communityName].members[_communityParticipant],
            "Already a member of community"
        );

        // Check if user has sufficient points to join groups
        // WowTPoints points = WowTPoints(pointsContract);

        require(
            points.getPoints(_communityParticipant) > communityEntryPoints,
            "Insufficient points"
        );
        communityMap[_communityName].members[_communityParticipant] = true;
        communityMap[_communityName].totalMembers += 1;
    }

    function createCommunity(
        string memory _communityName,
        string memory _description,
        string memory _imageUrl,
        string[] memory _quizesforEntry
    ) external onlyOwner {
        // Check if community exists
        require(
            !communityMap[_communityName].exists,
            "Community is already created"
        );
        communities.push(_communityName);
        //  CommunityDetails storage commStructwithDetails = communityDetails[numCommunity++];
        communityMap[_communityName].description = _description;
        communityMap[_communityName].exists = true;
        communityMap[_communityName].imageUrl = _imageUrl;
        communityMap[_communityName].quizesforEntry = _quizesforEntry;
    }

    function checkMembership(
        string memory _communityName,
        address _communityParticipant
    ) public view returns (bool) {
        return communityMap[_communityName].members[_communityParticipant];
    }

    function checkQuizesforCommunity(
        string memory _communityName
    ) public view returns (string[] memory quizesforCommunity) {
        return communityMap[_communityName].quizesforEntry;
    }

    function getCommunities() public view returns (string[] memory) {
        return communities;
    }
}
