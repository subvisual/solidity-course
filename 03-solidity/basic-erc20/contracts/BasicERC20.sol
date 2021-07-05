// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// cria um token
// 10 milhoes de tokens, com 18 casas decimais
// transferir para outro endereco
// consultar o meu balanco
// approvals

// msg.sender -> address que fez a chamada
// msg.caller
// msg.value -> ether adicionado a transaccao
// block.number
// block.hash
// block.timestamp

// Alice -> Foo // msg.sender = Alice
// Alice -> Foo -> Bar // msg.sender = Foo; msg.caller = Alice

// modifiers:
// public/external
// private/internal
// pure/view
// payable
// custom modifiers

contract BasicERC20 {
  string public name;   // Cesium Coin
  string public symbol; // CEC
  uint8 public decimals;
  address admin;

  // string / bytes

  mapping (address => uint256) public balanceOf; // 10**(7 + 18)
  uint256 public totalSupply;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Mint(address indexed _to, uint256 _value);

  constructor(string memory _name, string memory _symbol) {
    name = _name;
    symbol = _symbol;
    decimals = 18;
    admin = msg.sender;

    totalSupply = 10**(7 + 18);
    balanceOf[msg.sender] = totalSupply;
    emit Mint(msg.sender, totalSupply);
  }

  function transfer(address to, uint256 value) public returns (bool success) {
    require(balanceOf[msg.sender] >= value, "Not enough funds");

    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;

    emit Transfer(msg.sender, to, value);

    return true;
  }

  function mint() public payable returns (bool success) {
    require(msg.value > 0, "needs some ETH");

    uint256 amount = msg.value * 10;
    balanceOf[msg.sender] += amount;

    totalSupply += amount;

    emit Mint(msg.sender, amount);

    return true;
  }

  function burn(address from, uint256 value) public onlyOwner returns (bool success) {
    balanceOf[from] -= value;
    totalSupply -= value;

    // emit Burn(...)
  }

  modifier onlyOwner {
    require(msg.sender == admin, "[BasicERC20] not authorized");
    _;
  }

}
