// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DonationPool {
    address public owner;
    uint256 public totalDonations;

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    // Initialize the owner when the contract is deployed
    function initialize() public {
        require(owner == address(0), "Contract already initialized.");
        owner = msg.sender;
    }

    // Function to accept donations
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0.");
        totalDonations += msg.value;
    }

    // Function for the owner to withdraw funds for charity
    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance in the contract.");
        payable(owner).transfer(amount);
    }

    // Fallback function to accept Ether
    receive() external payable {
        donate();
    }
}