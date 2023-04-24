// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTBadge is OwnableUpgradeable {
    string public imageUri;
    address private pointsContract;
    WowTPoints private points;

    mapping(string => address) public badge;

    function initialize(
        string memory _imageUri,
        address _pointsContract
    ) external initializer {
        __Ownable_init();
        imageUri = _imageUri;
        pointsContract = _pointsContract;
        points = WowTPoints(pointsContract);
    }

    function updateBadgeForWeek(string memory yearWeek) external onlyOwner {
        // WowTPoints points = WowTPoints(pointsContract);
        address leaderBoardAddress = points.getLeaderBoard();
        badge[yearWeek] = leaderBoardAddress;
    }

    function setImageUri(string memory _imageUrl) external onlyOwner {
        imageUri = _imageUrl;
    }
}
