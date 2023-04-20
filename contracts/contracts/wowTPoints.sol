// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

/// @title The points contract for managing points
contract WowTPoints is OwnableUpgradeable, AccessControlUpgradeable {
    /// @notice The points for first level
    uint16 public levelOnePoints;
    /// @notice The points for second level
    uint16 public levelTwoPoints;
    /// @notice The points for daily active user
    uint16 public activeUserPoints;
    /// @notice The minimum required points for token conversion
    uint256 public minimumPointsForConvertion;
    /// @notice The array for top 10 address who having highest points
    address[10] private topLeaderBoardAddress;

    /// @notice The points of each account
    mapping(address => uint256) private points;

    /// @notice Hashing value for admin role
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    /// @dev Throws if called by any account other than admins.
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

    /// @notice Add points by contract owner which address want to add points
    /// @param account Which address want to add points
    /// @param _points The number of points
    function addPoints(address account, uint256 _points) public adminOnly {
        uint totalPoints = points[account] + _points;
        points[account] = totalPoints;
        updateLeaderBoard(account, _points);
    }

    function addActiveUserPoints(address account) external onlyOwner {
        addPoints(account, activeUserPoints);
    }

    /// @notice Reduce points by contract owner which address want to reduce points
    /// @param account Which address want to reduce points
    /// @param _points The number of points
    /// @dev Requires that the _points are greater than zero and _points must be less than available points
    function reducePoints(address account, uint256 _points) public adminOnly {
        require(_points > 0, "points must be greater than zero");
        uint totalPoints = points[account] - _points;
        require(totalPoints >= 0, "points are too low to reduce");
        points[account] = totalPoints;
    }

    /// @notice Update points by contract owner which address want to update points
    /// @param account Which address need to reduce points
    /// @param _points The number of points need to update
    function updateLeaderBoard(address account, uint256 _points) private {
        uint i = 0;
        for (i; i < topLeaderBoardAddress.length; i++) {
            if (getPoints(topLeaderBoardAddress[i]) < _points) {
                break;
            }
        }
        for (uint j = topLeaderBoardAddress.length - 1; j > i; j--) {
            topLeaderBoardAddress[j] = topLeaderBoardAddress[j - 1];
        }
        topLeaderBoardAddress[i] = account;
    }

    /// @dev Get how many points having for address
    /// @param account which account want to check points
    /// @return points for address
    function getPoints(address account) public view returns (uint256) {
        return points[account];
    }

    /// @dev Get the address who having highest points
    /// @return address the highest points
    function getLeaderBoard() public view returns (address) {
        return topLeaderBoardAddress[0];
    }

    /// @dev Get the top 10 addresses who having highest points
    /// @return addresses the top 10 highest points
    function getTopLeaderBoards() public view returns (address[10] memory) {
        return topLeaderBoardAddress;
    }

    /// @param newLevelOnePoints the new value for level one points
    /// @dev stores the points in the state variable `levelOnePoints`
    function setLevelOnePoints(uint16 newLevelOnePoints) external onlyOwner {
        levelOnePoints = newLevelOnePoints;
    }

    /// @param newLevelTwoPoints the new value for level two points
    /// @dev stores the points in the state variable `levelTwoPoints`
    function setLevelTwoPoints(uint16 newLevelTwoPoints) external onlyOwner {
        levelTwoPoints = newLevelTwoPoints;
    }

    /// @param newActiveUserPoints the new value for active user points
    /// @dev stores the points in the state variable `activeUserPoints`
    function setActiveUserPoints(
        uint16 newActiveUserPoints
    ) external onlyOwner {
        activeUserPoints = newActiveUserPoints;
    }

    /// @param newMinimumPointsForConvertion the new value for minimum points for token Convertion
    /// @dev stores the points in the state variable `minimumPointsForConvertion`
    function setMinimumPointsForConvertion(
        uint16 newMinimumPointsForConvertion
    ) external onlyOwner {
        minimumPointsForConvertion = newMinimumPointsForConvertion;
    }
}
