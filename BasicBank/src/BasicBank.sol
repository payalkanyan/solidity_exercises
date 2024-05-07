// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times

    
    function addEther() external payable {
        uint256 amount = address(this).balance;
        amount += 0.01 ether;
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
        uint256 accountBalance = address(this).balance; 
        if (amount > accountBalance) {
            revert("Insufficient balance");
        }
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed to send Ether");
    }
}