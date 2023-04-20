// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FeeToken is ERC20, Ownable {
    uint256 public constant FEE_RATE = 10; // 10% fee

    constructor() ERC20("Fee Token", "FEE") {
        _mint(msg.sender, 1000000 * 10**18); // Mint 1,000,000 tokens to the deployer
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        uint256 feeAmount = (amount * FEE_RATE) / 100;
        uint256 netAmount = amount - feeAmount;

        // Transfer the net amount to the recipient
        super._transfer(sender, recipient, netAmount);

        // Transfer the fee amount to the contract owner
        if (feeAmount > 0) {
            super._transfer(sender, owner(), feeAmount);
        }
    }
}
