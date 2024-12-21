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
    uint public difficulty; // Difficulty level
    uint public lastSolutionTime; // Timestamp of the last solution
    uint public solutionCount; // Total solutions submitted
    uint public trackingStartTime; // Metrics tracking start time
    uint public solutionRate; // Solutions per minute

    // Event declaration
    event SolutionSubmitted(address indexed miner, bytes32 solution, uint timestamp);
    event SolutionReverted(string message, address indexed miner);

    constructor() {
        // Initialize the target hash and reward pool
        targetHash = keccak256(abi.encodePacked("initial_target"));
        rewardPool = 1000000;
        difficulty = 2;
        lastSolutionTime = block.timestamp;

        // Initialize tracking
        trackingStartTime = block.timestamp;
    }

    mapping(address => bool) public hasSubmitted;

    // Submit a solution
    function submitSolution(bytes32 solution) public {
        require(rewardPool > 0, "No rewards left");
        // require(!hasSubmitted[msg.sender], "You have already submitted a solution");

        // Increment solution count for tracking
        solutionCount++;

        // Check if the solution is correct
        if (solution == targetHash) {
            Miner memory newMiner = Miner(msg.sender, 10);
            miners.push(newMiner);
            rewardPool -= 10;
            // hasSubmitted[msg.sender] = true;
            
            // Adjust difficulty
            adjustDifficulty();

            // Generate new target hash
            targetHash = keccak256(abi.encodePacked(block.timestamp, block.difficulty));

            // Update metrics
            updateMetrics();

            emit SolutionSubmitted(msg.sender, solution, block.timestamp);
        }else {
            emit SolutionReverted("Invalid solution", msg.sender);  // Debug message
            revert("Invalid solution");
        }
    }

    // Adjust difficulty dynamically
    function adjustDifficulty() internal {
        uint timeTaken = block.timestamp - lastSolutionTime;

        if (timeTaken < 15 seconds) {
            difficulty += 1;
        } else if (timeTaken > 30 seconds && difficulty > 1) {
            difficulty -= 1;
        }

        lastSolutionTime = block.timestamp;
    }

    // Update real-time metrics
    function updateMetrics() internal {
        uint elapsedTime = block.timestamp - trackingStartTime;

        if (elapsedTime > 0) {
            solutionRate = (solutionCount * 60) / elapsedTime; // Solutions per minute
        }
    }

    // Get current metrics
    function getMetrics() public view returns (uint, uint, uint) {
        return (solutionCount, solutionRate, difficulty);
    }

     // Function to retrieve the list of miners
    function getMiners() public view returns (Miner[] memory) {
        return miners;
    }
}
