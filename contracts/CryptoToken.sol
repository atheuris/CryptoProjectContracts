// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TaxedToken is ERC20, Ownable {
    using SafeMath for uint256;

    uint256 public taxRate = 0; // Initially set to 0% transfer tax

    constructor() ERC20("Taxed Token", "TAX") {
        _mint(msg.sender, 1000000 * 10**18); // Mint 1,000,000 tokens to the deployer
    }

    function setTaxRate(uint256 newTaxRate) external onlyOwner {
        require(newTaxRate <= 100, "Tax rate should not exceed 100%");
        taxRate = newTaxRate;
    }

    function renounceOwnership() public override onlyOwner {
        super.renounceOwnership();
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal override {
        uint256 taxAmount = amount.mul(taxRate).div(100);
        uint256 netAmount = amount.sub(taxAmount);

        // Transfer the net amount to the recipient
        super._transfer(sender, recipient, netAmount);

        // Transfer the tax amount to the contract owner
        super._transfer(sender, owner(), taxAmount);
    }
}