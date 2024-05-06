// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Typecast {
    /**
     * the goal of this exercise is to pass if msg.value is equal to the address of this contract or revert otherwise
     */

    function typeCast() external payable {
        if(msg.value == uint160(address(this))){}
    else{
        revert("msg.value does not match the contract address");
    }
    }
}
