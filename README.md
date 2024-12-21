# Proof of Work (PoW) and Proof of Stake (PoS) Consensus Mechanisms

This repository contains Solidity smart contracts implementing and comparing Proof of Work (PoW) and Proof of Stake (PoS) consensus mechanisms. These implementations are designed for testing and educational purposes, showcasing the differences in performance, energy consumption, and scalability between the two mechanisms.

---

## Features

### Proof of Work (PoW)
- **Dynamic Difficulty Adjustment**: Difficulty changes based on the time taken to find valid solutions.
- **Miner Rewards**: Rewards are distributed to miners who successfully solve the PoW challenge.
- **Real-Time Metrics**: Tracks metrics such as total solutions, solution rate, and current difficulty.
- **Fault Tolerance**: Handles invalid submissions and prevents double submissions.

### Proof of Stake (PoS)
- **Staking**: Validators stake tokens to participate in the consensus mechanism.
- **Validator Selection**: Validators are selected randomly based on their stake proportion.
- **Rewards**: Rewards are distributed to the selected validator.
- **Fault Tolerance**: Handles cases with no validators or insufficient stakes.

---

## Project Structure

- **`ProofOfWorkMetrics.sol`**: Contains the PoW implementation with dynamic difficulty and reward mechanisms.
- **`ProofOfStake.sol`**: Contains the PoS implementation with staking and validator selection logic.

