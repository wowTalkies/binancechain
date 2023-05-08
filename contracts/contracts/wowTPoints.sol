// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

/**
 * @title WowTPoints
 * @dev A smart contract that implements a points system for users. Users can earn points, which can be used to determine their ranking on a leaderboard.
 */
contract WowTPoints is OwnableUpgradeable, AccessControlUpgradeable {
    uint16 public levelOnePoints; // Point threshold for Level 1
    uint16 public levelTwoPoints; // Point threshold for Level 2
    uint16 public activeUserPoints; // Points earned by active users
    uint256 public minimumPointsForConvertion; // Minimum points required to convert to erc20 token
    address[10] public topLeaderBoardAddress; // Array to store top 10 leaderboard positions

    mapping(address => uint256) private points; // Mapping to store points earned by each user
    mapping(address => uint256) private referralPoints; // Mapping to store referral points earned by each user

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE"); // Admin role for authorization

    /// @dev Modifier to restrict function access to only those with the admin role.
    modifier adminOnly() {
        require(hasRole(ADMIN_ROLE, _msgSender()), "Must have admin role");
        _;
    }

    /**
     * @dev Initializes the contract by setting the initial points values and granting the admin role to the sender.
     * @param _levelOnePoints The number of points awarded for level one users.
     * @param _levelTwoPoints The number of points awarded for level two users.
     * @param _activeUserPoints The number of points awarded for active users.
     * @param _minimumPointsForConvertion The minimum number of points required for a user to convert points to another token.
     */
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

    /**
     * @dev Adds points to a user's account.
     * @param account The address of the user's account to add points to.
     * @param _points The number of points to add.
     */
    function addPoints(address account, uint256 _points) public adminOnly {
        uint totalPoints = points[account] + _points;
        points[account] = totalPoints;
        updateLeaderBoard(account, totalPoints);
    }

    /**
     * @dev Adds active user points to a user's account.
     * @param account The address of the user's account to add points to.
     */
    function addActiveUserPoints(address account) external onlyOwner {
        addPoints(account, activeUserPoints);
    }

    /**
     * @dev Adds referral points to a user's account.
     * @param _account The address of the user's account to add referral points to.
     * @param _points The number of referral points to add.
     */
    function addReferralPoints(
        address _account,
        uint256 _points
    ) public adminOnly {
        referralPoints[_account] += _points;
    }

    /**
     * @dev Reduces points from a user's account.
     * @param account The address of the user's account to reduce points from.
     * @param _points The number of points to reduce.
     */
    function reducePoints(address account, uint256 _points) public adminOnly {
        require(_points > 0, "points must be greater than zero");
        uint totalPoints = points[account] - _points;
        require(totalPoints >= 0, "points are too low to reduce");
        points[account] = totalPoints;
    }

    /**
     * @dev Internal function to update the leaderboard based on a user's points.
     * @param account Address of the user to update leaderboard for
     * @param _points Amount of points earned by the user
     */
    function updateLeaderBoard(address account, uint256 _points) private {
        for (uint i = 0; i < topLeaderBoardAddress.length; i++) {
            if (topLeaderBoardAddress[i] == account) {
                delete topLeaderBoardAddress[i];
                for (uint l = i; l < topLeaderBoardAddress.length - 1; l++) {
                    topLeaderBoardAddress[l] = topLeaderBoardAddress[l + 1];
                }
            }
        }
        uint j = 0;
        for (j; j < topLeaderBoardAddress.length; j++) {
            if (getPoints(topLeaderBoardAddress[j]) < _points) {
                break;
            }
        }
        for (uint k = topLeaderBoardAddress.length - 1; k > j; k--) {
            topLeaderBoardAddress[k] = topLeaderBoardAddress[k - 1];
        }
        topLeaderBoardAddress[j] = account;
    }

    /**
     * @dev Returns the number of points earned by the specified account.
     * @param account The address of the account to check the number of points for.
     * @return The number of points earned by the specified account.
     */
    function getPoints(address account) public view returns (uint256) {
        return points[account];
    }

    /**
     * @dev Gets the referral points earned by a user.
     * @param account The address of the user's account.
     * @return The number of referral points earned.
     */
    function getReferralPoints(address account) public view returns (uint256) {
        return referralPoints[account];
    }

    /**
     * @dev Returns the address of the top user on the leaderboard.
     * @return The address of the top user.
     */
    function getLeaderBoard() public view returns (address) {
        return topLeaderBoardAddress[0];
    }

    /**
     * @dev Returns an array of the top 10 addresses on the leaderboard.
     * @return An array of the top 10 addresses on the leaderboard.
     */
    function getTopLeaderBoards() public view returns (address[10] memory) {
        return topLeaderBoardAddress;
    }

    /**
     * @dev Sets the point threshold for Level 1.
     * @param newLevelOnePoints The new point threshold for Level 1.
     */
    function setLevelOnePoints(uint16 newLevelOnePoints) external onlyOwner {
        levelOnePoints = newLevelOnePoints;
    }

    /**
     * @dev Sets the point threshold for Level 2.
     * @param newLevelTwoPoints The new point threshold for Level 2.
     */
    function setLevelTwoPoints(uint16 newLevelTwoPoints) external onlyOwner {
        levelTwoPoints = newLevelTwoPoints;
    }

    /**
     * @dev Sets the number of points earned by active users.
     * @param newActiveUserPoints The new number of points earned by active users.
     */
    function setActiveUserPoints(
        uint16 newActiveUserPoints
    ) external onlyOwner {
        activeUserPoints = newActiveUserPoints;
    }

    /**
     * @dev Sets the minimum number of points required to convert to the ERC20 token.
     * @param newMinimumPointsForConvertion The new minimum number of points required to convert to the ERC20 token.
     */
    function setMinimumPointsForConvertion(
        uint16 newMinimumPointsForConvertion
    ) external onlyOwner {
        minimumPointsForConvertion = newMinimumPointsForConvertion;
    }
}
