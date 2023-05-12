// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {WowTPoints} from "./wowTPoints.sol";

/**
 * @title WowTReferral
 * @dev A smart contract that manages referral points for the WowTPoints token.
 * Users can earn referral points by referring new users to the platform. Referrals can earn additional
 * points by referring their own network of users.
 */
contract WowTReferral is OwnableUpgradeable {
    /**
     * @dev A struct to represent a referral user.
     * @param referralAddress The Ethereum address of the referred user.
     * @param referralExists A boolean indicating whether the referral exists.
     */
    struct ReferralUser {
        address referralAddress;
        bool referralExists;
    }

    /**
     * @dev A mapping to store referral data for each user.
     */
    mapping(address => ReferralUser) private referrer;

    mapping(address => address[]) private referrals;

    /// @dev The WowTPoints contract to which referral points are added.
    WowTPoints private points;

    /**
     * @dev Initializes the contract and sets the WowTPoints contract.
     * @param _pointsContract The address of the WowTPoints contract.
     */
    function initialize(address _pointsContract) external initializer {
        __Ownable_init();
        points = WowTPoints(_pointsContract);
    }

    /**
     * @dev Adds referral points to a user's account and records the referral relationship between the installer and the referrer.
     * @param _installAddress The address of the user who installed the application and triggered the referral.
     * @param _referralAddress The address of the user who referred the installer to the application.
     */
    function addReferralPoints(
        address _installAddress,
        address _referralAddress
    ) public onlyOwner {
        require(
            !referrer[_installAddress].referralExists,
            "Already have referrar"
        );
        require(referrer[_referralAddress].referralAddress != _installAddress, "You are refferer");
        points.addPoints(_referralAddress, points.levelOnePoints());
        referrer[_installAddress].referralAddress = _referralAddress;
        referrer[_installAddress].referralExists = true;
        referrals[_referralAddress].push(_installAddress);
        points.addReferralPoints(_referralAddress, points.levelOnePoints());
        if (referrer[_referralAddress].referralExists) {
            address secondLevelAddress = referrer[_referralAddress]
                .referralAddress;
            points.addPoints(secondLevelAddress, points.levelTwoPoints());
            points.addReferralPoints(
                secondLevelAddress,
                points.levelTwoPoints()
            );
        }
    }

    /**
     * @dev Gets the referral data for a given user.
     * @param _account The Ethereum address of the user.
     * @return ReferralUser The referral data for the user.
     */
    function getReferrer(
        address _account
    ) public view returns (ReferralUser memory) {
        return referrer[_account];
    }

    /**
     * @dev Gets the list of referrals for a given user.
     * @param _account The Ethereum address of the user.
     * @return address[] The list of referrals for the user.
     */
    function getReferrals(
        address _account
    ) public view returns (address[] memory) {
        return referrals[_account];
    }

    // // development 
    // function changeReferrerStatus(address _account) public onlyOwner {
    //     delete referrer[_account];
    // }

    // function changeReferralStatus(address _account) public onlyOwner {
    //     delete referrals[_account];
    // }
}
