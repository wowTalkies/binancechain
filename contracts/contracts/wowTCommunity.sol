// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTCommunity is OwnableUpgradeable, AccessControlUpgradeable {
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

    struct CommunityPosts {
        string message;
        string imageUrl;
        address createrAddress;
    }

    // struct UserPosts {
    //     string communityName;
    //     string message;
    //     string imageUrl;
    // }

    mapping(string => CommunityDetails) public communityMap;
    mapping(string => CommunityPosts[]) private communityPostsMap;

    // mapping(address => UserPosts[]) private userPostMap;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE"); // Admin role for authorization

    /// @dev Modifier to restrict function access to only those with the admin role.
    modifier adminOnly() {
        require(hasRole(ADMIN_ROLE, _msgSender()), "Must have admin role");
        _;
    }

    function initialize(
        address _pointsContract,
        uint16 _communityEntryPoints
    ) external initializer {
        __Ownable_init();
        _grantRole(ADMIN_ROLE, _msgSender());
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        communityEntryPoints = _communityEntryPoints;
        points = WowTPoints(_pointsContract);
    }

    // function updatePointsContract(address _pointsContract) external onlyOwner {

    //    pointsContract = _pointsContract;

    // }

    function createCommunity(
        string memory _communityName,
        string memory _description,
        string memory _imageUrl
    )
        external
        // string[] memory _quizesforEntry
        onlyOwner
    {
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
        // communityMap[_communityName].quizesforEntry = _quizesforEntry;
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

    function createPost(
        string memory _communityName,
        string memory _message,
        string memory _imageUrl,
        address _createrAddress
    ) external onlyOwner {
        // Check if community exists
        require(communityMap[_communityName].exists, "Community doesn't exist");
        // check if the _userAddress is available in community
        require(
            checkMembership(_communityName, _createrAddress),
            "You are not member in this community"
        );

        CommunityPosts memory newCommunityPosts = CommunityPosts({
            message: _message,
            imageUrl: _imageUrl,
            createrAddress: _createrAddress
        });
        communityPostsMap[_communityName].push(newCommunityPosts);

        // UserPosts memory newUserPosts = UserPosts({
        //      communityName: _communityName,
        //      message: _message,
        //      imageUrl: _imageUrl
        // });
        // userPostMap[_createrAddress].push(newUserPosts);
    }

    function setCommunityEntryPoints(
        uint16 _newCommunityEntryPoints
    ) external onlyOwner {
        communityEntryPoints = _newCommunityEntryPoints;
    }

    function getCommunityDetails(
        string memory _communityName
    )
        public
        view
        returns (string memory, string memory, string[] memory, uint256)
    {
        return (
            communityMap[_communityName].description,
            communityMap[_communityName].imageUrl,
            communityMap[_communityName].quizesforEntry,
            communityMap[_communityName].totalMembers
        );
    }

    function updateCommunityQuizes(
        string memory _communityName,
        string memory _quizName
    ) public adminOnly {
        communityMap[_communityName].quizesforEntry.push(_quizName);
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

    function checkCommunityExists(
        string memory _communityName
    ) public view returns (bool) {
        return communityMap[_communityName].exists;
    }

    function getPosts(
        string memory _communityName
    ) public view returns (CommunityPosts[] memory) {
        return communityPostsMap[_communityName];
    }

    // development 

    function removeCommunityMember(string memory _communityName, address _communityParticipant) external onlyOwner {
        communityMap[_communityName].members[_communityParticipant] = false;
        communityMap[_communityName].totalMembers -= 1;
    }

    function getCommunityPostMsg(string memory _communityName, uint _index) public view returns (string memory){
         return communityPostsMap[_communityName][_index].message;
    }

    function getCommunityPostImage(string memory _communityName, uint _index) public view returns (string memory){
         return communityPostsMap[_communityName][_index].imageUrl;
    }

    function setCommunityPostMsg(string memory _communityName, uint _index, string memory _newMsg) external onlyOwner {
        communityPostsMap[_communityName][_index].message = _newMsg;
    }

    function setCommunityPostImage(string memory _communityName, uint _index, string memory _newImageUrl) external onlyOwner {
        communityPostsMap[_communityName][_index].imageUrl = _newImageUrl;
    }
}
