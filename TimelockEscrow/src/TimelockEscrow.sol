// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint256) public buyerDeposits;
    mapping(address => bool) public escrowActive;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        require(!escrowActive[msg.sender], "An active escrow already exists");
        buyerDeposits[msg.sender] += msg.value;
        escrowActive[msg.sender] = true;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(escrowActive[buyer], "No active escrow found for this buyer");
        require(block.timestamp >= buyerDeposits[buyer] + 3 days, "Less than 3 days have passed since the escrow");
        escrowActive[buyer] = false;
        payable(seller).transfer(buyerDeposits[buyer]);
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(escrowActive[msg.sender], "No active escrow found for this buyer");
        uint256 amount = buyerDeposits[msg.sender];
        escrowActive[msg.sender] = false;
        payable(msg.sender).transfer(amount);
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return buyerDeposits[buyer];
    }
}
