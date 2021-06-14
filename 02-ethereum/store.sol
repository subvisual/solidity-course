// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

contract KeyValueStore {
  mapping (address => uint) values;

  function set(address a, uint v) public {
      values[a] = v;
  }

  function setOwn(uint v) public {
    address a = msg.sender;

    values[a] = v;
  }

  function setNew(address a, uint v) public {
    if (values[a] == 0) {
      values[a] = v;
    }
  }

  function get(uint k) public view returns (uint) {
      return values[k];
  }
}
