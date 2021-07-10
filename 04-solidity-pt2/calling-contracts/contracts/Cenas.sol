// SPDX-License-Identifier: MIT

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

interface IMyERC20 {
  function mintMany(address to, uint256 value) external;
  function burnMany(address to, uint256 value) external;
}

contract MyERC20 is ERC20, Ownable, IMyERC20 {
  constructor() ERC20("Cesium Coin", "CEC") {}

  function mintMany(address to, uint256 value) external override {
    // todo
  }
  function burnMany(address to, uint256 value) external override {
    // todo
  }
}

contract Trader {
  ERC20 erc20;

  constructor(address _erc20) {
    erc20 = IERC20(_erc20);
    // erc20 = new ERC20("Cesium Coin", "CMC");
  }

  // recebe ERC20, devolve ETH
  function sell(uint256 amount) public {
    erc20.transferFrom(msg.sender, address(this), amount);

    msg.sender.transfer(calculateSellAmount(amount));
  }

  // recebe ETH, devolve ERC20
  function buy() public payable {

  }

  function calculateSellAmount(uint256 amount) returns (uint256) {
    return amount;
  }

  receive() external payable {
    balances[msg.sender] += msg.value;

    require(1 == 2);
  }

  fallback() external payable {
    balances[msg.sender] += msg.value;
  }
}
