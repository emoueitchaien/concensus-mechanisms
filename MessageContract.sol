// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageContract {
    string public message;

    // Constructor to initialize the message
    constructor(string memory initialMessage) {
        message = initialMessage;
    }

    // Function to update the message
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    // Function to retrieve the message
    function getMessage() public view returns (string memory) {
        return message;
    }
}
