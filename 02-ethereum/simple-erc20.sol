// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

contract SimpleERC20 {
  string public name;
  string public symbol;
  uint256 public totalSupply;
  mapping (address => uint) balances;

  uint constant public decimals = 18;

  event Transfer(address indexed from, address indexed to, uint256 value);

  constructor(string memory _name, string memory _symbol, uint256 _supply) {
    name = _name;
    symbol = _symbol;
    totalSupply = _supply;
    balances[msg.sender] = totalSupply * 10 ** decimals;
  }

  function balanceOf(address account) external view returns (uint256) {
    return balances[account];
  }

  function transfer(address recipient, uint256 amount) external returns (bool) {
    require(recipient != address(0), "ERC20: transfer to the zero address");

    uint256 senderBalance = balances[msg.sender];
    require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");

    balances[msg.sender] = senderBalance - amount;
    balances[recipient] += amount;

    emit Transfer(msg.sender, recipient, amount);
  }
}
