// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenSale {
    address public owner;
    mapping(address => uint256) public balances;
    uint256 public tokenPrice = 0.01 ether;
    uint256 public totalTokens = 1000;

    constructor() {
        owner = msg.sender;
    }

    function buyTokens(uint256 amount) external payable {
        require(amount > 0, "Amount must be > 0");
        require(totalTokens >= amount, "Not enough tokens");
        require(msg.value == amount * tokenPrice, "Incorrect ETH sent");
        totalTokens -= amount;
        balances[msg.sender] += amount;
    }

    function withdrawAll() external {
        require(msg.sender == owner, "Not owner");
        owner.call{value: address(this).balance}("");
    }

    function refund(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount * tokenPrice}("");
        require(success, "Transfer failed");
        
    }

    function setPrice(uint256 newPrice) external {
        require(msg.sender == owner, "Not owner");
        tokenPrice = newPrice;
    }
}
