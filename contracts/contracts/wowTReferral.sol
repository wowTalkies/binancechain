// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTReferral is OwnableUpgradeable {
    struct ReferralUser {
        address referralAddress;
        bool referralExists;
    }

    WowTPoints private points;

    mapping(address => ReferralUser) private referral;

    function initialize(address _pointsContract) external initializer {
        __Ownable_init();
        points = WowTPoints(_pointsContract);
    }

    function addReferralPoints(
        address _installAddress,
        address _referralAddress
    ) public onlyOwner {
        points.addPoints(_referralAddress, points.levelOnePoints());
        referral[_installAddress].referralAddress = _referralAddress;
        referral[_installAddress].referralExists = true;
        if (referral[_referralAddress].referralExists) {
            points.addPoints(
                referral[_referralAddress].referralAddress,
                points.levelTwoPoints()
            );
        }
    }

    function getReferrals(
        address _user
    ) public view returns (ReferralUser memory) {
        return referral[_user];
    }
}
