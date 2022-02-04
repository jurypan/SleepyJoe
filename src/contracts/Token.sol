// SPDX-License-Identifier: MIT

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

pragma solidity ^0.5.16;

contract Token {
    using SafeMath for uint;

    // Variables
    string public name = "Sleepy Joe";
    string public symbol = "JPX";
    uint256 public decimals = 18;
    uint256 public totalSupply;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor
    constructor() public {
        totalSupply = 1000000 * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    // Track balance
    mapping(address => uint256) public balanceOf;

    // Transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Condition checks
        require(balanceOf[msg.sender] >= _value);
        
        // Logic
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // Allowance
    mapping(address => mapping(address => uint256)) public allowance;

    // Approve
    function approve(address _spender, uint256 _value) public returns (bool success) {
        // Condition checks
        require(_spender != address(0));

        // Logic
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
 

    // Transfer from
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // Condition checks
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        // Logic
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

    // Private Transfer from
    function _transfer(address _from, address _to, uint256 _value) internal {
        // Condition checks
        require(_to != address(0));

        // Logic
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }
}

