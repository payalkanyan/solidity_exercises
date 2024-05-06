// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    // State variables
    uint256 public highestDeposit;
    address public winner;
    uint256 public endTime;

    // Function to place a bet
    function bet() public payable {
        // Check if the current deposit is higher than the highest deposit
        require(msg.value > highestDeposit, "Deposit must be higher than the current highest deposit");

        // Update the highest deposit and the winner
        highestDeposit = msg.value;
        winner = msg.sender;

        // Update the end time to be 1 hour from now
        endTime = block.timestamp + 1 hours;
    }

    // Function to claim the prize
    function claimPrize() public {
        // Check if the current time is past the end time
        require(block.timestamp > endTime, "Betting period has not ended yet");

        // Check if the caller is the winner
        require(msg.sender == winner, "Only the winner can claim the prize");

        // Transfer the entire balance of the contract to the winner
        payable(winner).transfer(address(this).balance);
    }
}