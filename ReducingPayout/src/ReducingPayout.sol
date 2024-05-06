// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        require(msg.value == 1 ether, "Initial deposit must be 1 ether");
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        uint256 amount;
        uint256 timeAtWithdraw = block.timestamp;
        uint256 timePassed = depositedTime - timeAtWithdraw; 
         uint256 reductionRate = (timePassed * 11574) / 1000000000;
        uint256 remainingPercentage = 10000 - reductionRate;

        amount = (address(this).balance * remainingPercentage) / 10000;

        payable(msg.sender).transfer(amount);
}
}