// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProofOfWork {
    struct Miner {
        address minerAddress;
        uint reward;
    }

    Miner[] public miners;
    bytes32 public targetHash;
    uint public rewardPool;
    uint public difficulty; // Dynamic difficulty level
    uint public lastSolutionTime; // Timestamp of the last solution

    constructor() {
        // Initialize target hash and reward pool
        targetHash = keccak256(abi.encodePacked("initial_target"));
        rewardPool = 100; // Total reward pool
        difficulty = 2; // Start with difficulty 2 (example)
        lastSolutionTime = block.timestamp; // Initialize the timestamp
    }

    // Function to submit a solution
    function submitSolution(bytes32 solution) public {
        require(rewardPool > 0, "No rewards left");

        // Check if the solution is valid (matches the target hash)
        if (solution == targetHash) {
            miners.push(Miner(msg.sender, 10)); // Reward the miner
            rewardPool -= 10;

            // Adjust difficulty dynamically
            adjustDifficulty();

            // Generate a new target hash
            targetHash = keccak256(abi.encodePacked(block.timestamp, block.difficulty));
        }
    }

    // Function to adjust difficulty dynamically
    function adjustDifficulty() internal {
        uint timeTaken = block.timestamp - lastSolutionTime;

        if (timeTaken < 100 seconds) {
            // If solutions are too fast, increase difficulty
            difficulty += 1;
        } else if (timeTaken > 30 seconds && difficulty > 1) {
            // If solutions are too slow, decrease difficulty
            difficulty -= 1;
        }

        lastSolutionTime = block.timestamp; // Update the last solution time
    }

    // Function to retrieve the list of miners
    function getMiners() public view returns (Miner[] memory) {
        return miners;
    }

    // Function to get the current difficulty
    function getDifficulty() public view returns (uint) {
        return difficulty;
    }
}
