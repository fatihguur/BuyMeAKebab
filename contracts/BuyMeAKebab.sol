//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Contract address on Goerli Testnet: 0x703E0A66D4690D399DD4020764f51f27CcF4A6a7


contract BuyMeAKebab {
    // Event to emit when a Memo is created.
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );
    
    // Message Struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    
    // Contract deployer address
    address payable owner;

    // List of messages
    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

   
    // Receive all stored memos   
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    // Tips 0.001 ETH to Deployer's address with name and message
    function buyKebab(string memory _name, string memory _message) public payable {
        // Must accept more than 0 ETH for a Kebab.
        require(msg.value > 0, "can't buy Kebab for free!");

        // Add message sender's information to array
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a NewMemo event with details about the memo.
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    // Sends total ETH to Deployer's address
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}