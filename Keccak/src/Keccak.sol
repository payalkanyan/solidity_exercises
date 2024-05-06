// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Keccak {
    /**
     * In this exercise, the task is to return the correct keccak256 of any value passed into the keccak function
     */

    function keccak(uint256 x) external pure returns (bytes32) {
        bytes memory inputBytes = abi.encodePacked(x);
        return keccak256(inputBytes);
    }
}
