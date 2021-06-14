// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

contract Integer {
  uint256 public value;

  function set(uint v) public {
      value = v;
  }

  function get() public view returns (uint) {
      return value;
  }
}
