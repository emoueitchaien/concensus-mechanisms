// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HashCalculator {
    function calculateHash(string memory input) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(input));
    }
}