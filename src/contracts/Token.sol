// SPDX-License-Identifier: MIT

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

pragma solidity ^0.5.16;

contract Token {
    using SafeMath for uint;

    string public name = "Sleepy Joe";
    string public symbol = "JPX";
    uint256 public decimals = 18;
    uint256 public totalSupply;

    constructor() public {
        totalSupply = 1000000 * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    // Track balance
    mapping(address => uint256) public balanceOf;

    // Transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        return true;
    }
}

