// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

contract WowTReferral is OwnableUpgradeable {
    struct ReferralUser {
        address referralAddress;
        bool referralExists;
    }

    mapping(address => ReferralUser) private referral;

    function initialize() external initializer {
        __Ownable_init();
    }

    function addReferralPoints(
        address _pointsContractAddress,
        address _installAddress,
        address _referralAddress
    ) public onlyOwner {
        WowTPoints points = WowTPoints(_pointsContractAddress);
        points.addPoints(_referralAddress, points.levelOnePoints());
        referral[_installAddress].referralAddress = _referralAddress;
        referral[_installAddress].referralExists = true;
        if (referral[_referralAddress].referralExists) {
            points.addPoints(referral[_referralAddress].referralAddress, points.levelTwoPoints());
        }
    }

    function getReferrals(
        address _user
    ) public view returns (ReferralUser memory) {
        return referral[_user];
    }
}
