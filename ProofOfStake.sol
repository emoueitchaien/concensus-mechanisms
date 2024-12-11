// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProofOfStake {
    struct Validator {
        address validatorAddress;
        uint stake;
    }

    Validator[] public validators;
    mapping(address => uint) public stakes;
    uint public totalStaked;

    event ValidatorSelected(address indexed validator, uint reward);

    // Stake tokens to become a validator
    function stakeTokens() public payable {
        require(msg.value > 0, "Must stake a positive amount");

        // Add to the sender's stake
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;

        // Check if validator already exists
        bool isExistingValidator = false;
        for (uint i = 0; i < validators.length; i++) {
            if (validators[i].validatorAddress == msg.sender) {
                validators[i].stake = stakes[msg.sender]; // Update stake
                isExistingValidator = true;
                break;
            }
        }

        // Add new validator if not existing
        if (!isExistingValidator) {
            validators.push(Validator(msg.sender, msg.value));
        }
    }

    // Randomly select a validator based on their stake proportion
    function selectValidator() public returns (address) {
        require(validators.length > 0, "No validators available");
        require(totalStaked > 0, "No stakes available");

        uint random = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % totalStaked;
        uint cumulativeStake = 0;

        for (uint i = 0; i < validators.length; i++) {
            cumulativeStake += validators[i].stake;
            if (random < cumulativeStake) {
                // Reward the selected validator (example: 1 Ether)
                payable(validators[i].validatorAddress).transfer(1 ether);

                emit ValidatorSelected(validators[i].validatorAddress, 1 ether);
                return validators[i].validatorAddress;
            }
        }

        revert("Validator selection failed");
    }

    // Retrieve all validators
    function getValidators() public view returns (Validator[] memory) {
        return validators;
    }

    // Retrieve total staked amount
    function getTotalStaked() public view returns (uint) {
        return totalStaked;
    }
}
