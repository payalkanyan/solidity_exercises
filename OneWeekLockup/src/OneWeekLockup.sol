// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    mapping(address=>uint256) private balances;
     mapping(address => uint256) private lastDepositTimestamps;

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

    uint256 public depositedOn;

    function depositEther() external payable {
        balances[msg.sender] += msg.value;
        
        lastDepositTimestamps[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(block.timestamp > depositedOn + 1 weeks, "It's not a week yet!");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
