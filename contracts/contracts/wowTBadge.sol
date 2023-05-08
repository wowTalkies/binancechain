// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

/**
 * @title WowTBadge
 * @dev The WowTBadge contract allows users to earn and display badges for their performance on the WowTPoints leaderboard.
 */
contract WowTBadge is OwnableUpgradeable {
    /**
     * @dev A struct to represent a badge earned by a user.
     * @param yearWeek The year and week number (in YYYY-WW format) during which the user earned the badge.
     * @param image The URI of the image associated with the badge.
     */
    struct Badge {
        string yearWeek;
        string image;
    }

    string public imageUri; // The URI of the default badge image.
    address private pointsContract; // The address of the WowTPoints contract.
    WowTPoints private points; // The WowTPoints contract instance.

    mapping(address => Badge[]) private badges; // A mapping to store badges earned by each user.

    /**
     * @dev Initializes the contract and sets the URI for the badge images.
     * @param _imageUri The URI for the badge images.
     * @param _pointsContract The address of the WowTPoints contract.
     */
    function initialize(
        string memory _imageUri,
        address _pointsContract
    ) external initializer {
        __Ownable_init();
        imageUri = _imageUri;
        pointsContract = _pointsContract;
        points = WowTPoints(pointsContract);
    }

    /**
     * @dev Adds a badge to the list of badges earned by the user who is at the top of the leaderboard for the given week.
     * @param yearWeek The year and week number (in YYYY-WW format) during which the user earned the badge.
     */
    function updateBadgeForWeek(string memory yearWeek) external onlyOwner {
        // WowTPoints points = WowTPoints(pointsContract);
        address leaderBoardAddress = points.getLeaderBoard();
        Badge memory newBadge = Badge(yearWeek, imageUri);
        badges[leaderBoardAddress].push(newBadge);
    }

    /**
     * @dev Sets the URI for the badge images.
     * @param _imageUrl The new URI for the default badge image.
     */
    function setImageUri(string memory _imageUrl) external onlyOwner {
        imageUri = _imageUrl;
    }

    /**
     * @dev Gets the list of badges earned by a given user.
     * @param account The address of the user whose badges to retrieve.
     * @return An array of Badge structs representing the user's badges.
     */
    function getBadges(address account) public view returns (Badge[] memory) {
        return badges[account];
    }
}
