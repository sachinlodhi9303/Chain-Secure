// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainSecure {

    // State variables
    address public owner;
    mapping(address => uint256) public balances;

    // Events
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed recipient, uint256 amount);
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);

    // Modifier to restrict certain functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this.");
        _;
    }

    // Constructor: Set the owner when deploying the contract
    constructor() {
        owner = msg.sender;
    }

    // Deposit function: Allows a user to deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "You must deposit a non-zero amount.");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw function: Allows a user to withdraw their balance
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
        emit Withdraw(msg.sender, amount);
    }

    // Transfer function: Allows one user to transfer ETH to another user
    function transfer(address recipient, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }

    // Get balance of a user
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}

