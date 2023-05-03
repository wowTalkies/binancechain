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
        string calldata _imageUri,
        address _pointsContract
    ) external initializer {
        __Ownable_init();
        imageUri = _imageUri;
        pointsContract = _pointsContract;
        points = WowTPoints(pointsContract);
    }

    function updateBadgeForWeek(string calldata yearWeek) external onlyOwner {
        // WowTPoints points = WowTPoints(pointsContract);
        address leaderBoardAddress = points.getLeaderBoard();
        badge[yearWeek] = leaderBoardAddress;
    }

    function setImageUri(string calldata _imageUrl) external onlyOwner {
        imageUri = _imageUrl;
    }
}
