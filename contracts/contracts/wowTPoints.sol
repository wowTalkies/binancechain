// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract WowTPoints is OwnableUpgradeable, AccessControlUpgradeable {
    uint16 public levelOnePoints;
    uint16 public levelTwoPoints;
    uint16 public activeUserPoints;
    uint256 public minimumPointsForConvertion;
    address[10] private topLeaderBoardAddress;

    mapping(address => uint256) private points;
    mapping(address => uint256) private leaderBoard;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    /**
     * @dev Throws if called by any account other than admins.
     */
    modifier adminOnly() {
        require(hasRole(ADMIN_ROLE, _msgSender()), "Must have admin role");
        _;
    }

    function initialize(
        uint16 _levelOnePoints,
        uint16 _levelTwoPoints,
        uint16 _activeUserPoints,
        uint16 _minimumPointsForConvertion
    ) external initializer {
        __Ownable_init();
        _grantRole(ADMIN_ROLE, _msgSender());
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        levelOnePoints = _levelOnePoints;
        levelTwoPoints = _levelTwoPoints;
        activeUserPoints = _activeUserPoints;
        minimumPointsForConvertion = _minimumPointsForConvertion;
    }

    function addPoints(address account, uint256 _points) public adminOnly {
        uint totalPoints = points[account] + _points;
        points[account] = totalPoints;
        updateLeaderBoard(account, _points);
    }

    function addActiveUserPoints(address account) external onlyOwner {
        addPoints(account, activeUserPoints);
    }

    function reducePoints(address account, uint256 _points) public adminOnly {
        require(_points > 0, "points must be greater than zero");
        uint totalPoints = points[account] - _points;
        require(totalPoints >= 0, "points are too low to reduce");
        points[account] = totalPoints;
    }

    function updateLeaderBoard(address account, uint256 currentPoints) private {
        uint i = 0;
        /** get the index of the current max element **/
        for (i; i < topLeaderBoardAddress.length; i++) {
            if (getPoints(topLeaderBoardAddress[i]) < currentPoints) {
                break;
            }
        }
        /** shift the array of position (getting rid of the last element) **/
        for (uint j = topLeaderBoardAddress.length - 1; j > i; j--) {
            topLeaderBoardAddress[j] = topLeaderBoardAddress[j - 1];
        }
        /** update the new max element **/
        topLeaderBoardAddress[i] = account;
    }

    function getPoints(address account) public view returns (uint256) {
        return points[account];
    }

    function getLeaderBoard() public view returns (address) {
        return topLeaderBoardAddress[0];
    }

    function getTopLeaderBoards() public view returns (address[10] memory) {
        // address[] memory topLeaderBoards;
        // uint i = 0;
        // for (i; i < topLeaderBoardAddress.length; i++) {
        //     topLeaderBoards[i] = topLeaderBoardAddress[i];
        // }
        return topLeaderBoardAddress;
    }

    function setLevelOnePoints(uint16 newLevelOnePoints) external onlyOwner {
        levelOnePoints = newLevelOnePoints;
    }

    function setLevelTwoPoints(uint16 newLevelTwoPoints) external onlyOwner {
        levelTwoPoints = newLevelTwoPoints;
    }

    function setActiveUserPoints(
        uint16 newActiveUserPoints
    ) external onlyOwner {
        activeUserPoints = newActiveUserPoints;
    }

    function setMinimumPointsForConvertion(
        uint16 newMinimumPointsForConvertion
    ) external onlyOwner {
        minimumPointsForConvertion = newMinimumPointsForConvertion;
    }
}
