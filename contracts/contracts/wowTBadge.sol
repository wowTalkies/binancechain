// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTBadge is OwnableUpgradeable {
    string public imageUri;
    mapping(string => address) public badge;

    function initialize(string memory _imageUri) external initializer {
        __Ownable_init();
        imageUri = _imageUri;
    }

    function updateBadgeForWeek(
        address pointsContract,
        string memory yearWeek
    ) external onlyOwner {
        WowTPoints points = WowTPoints(pointsContract);
        address leaderBoardAddress = points.getLeaderBoard();
        badge[yearWeek] = leaderBoardAddress;
    }

    function setImageUri(string memory _imageUrl) external onlyOwner {
        imageUri = _imageUrl;
    }
}
