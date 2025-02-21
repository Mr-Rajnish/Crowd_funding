# Crowd_funding

This is A Crowd Funding Application in which needy person can list his funding and any one can do charity and owner can withdraw the amount . And i will also implement many feature further .



A simple and secure Solidity smart contract for managing a donation pool. This contract allows anyone to donate Ether, and only the owner (deployer) can withdraw funds for charity. The contract is deployed on the **Edu Chain** blockchain.

## Features

1. **Donations**: Anyone can donate Ether to the pool by sending Ether to the contract address or calling the `donate()` function.
2. **Transparency**: The total amount of donations is publicly accessible via the `totalDonations` variable.
3. **Secure Withdrawals**: Only the contract owner can withdraw funds for charity, ensuring that donations are used responsibly.
4. **No Constructor**: The contract uses an `initialize()` function to set the owner, making it compatible with certain deployment patterns.
5. **Fallback Function**: The contract includes a `receive()` function to accept Ether directly without requiring a specific function call.

## Contract Details

- **Solidity Version**: `0.8.0`
- **Deployed Address on Edu Chain**: [`0x8469a3DCF16C22F3c4d12c848A9112e68012731D`](https://educhain-explorer.example.com/address/0x8469a3DCF16C22F3c4d12c848A9112e68012731D) (Replace with actual explorer link if available)

## How It Works

1. **Deploy the Contract**: Deploy the smart contract to the Edu Chain network.
2. **Initialize**: Call the `initialize()` function to set the contract owner.
3. **Donate**: Users can donate Ether by sending it to the contract address or calling the `donate()` function.
4. **Withdraw**: The owner can withdraw funds for charity by calling the `withdraw()` function.

## Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationPool {
    address public owner;
    uint256 public totalDonations;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    function initialize() public {
        require(owner == address(0), "Contract already initialized.");
        owner = msg.sender;
    }

    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0.");
        totalDonations += msg.value;
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance in the contract.");
        payable(owner).transfer(amount);
    }

    receive() external payable {
        donate();
    }
}