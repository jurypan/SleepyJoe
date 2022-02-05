// SPDX-License-Identifier: MIT

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

pragma solidity ^0.5.16;

// Deposit & widraw funds
// Manage orders - make or cancel
// Handle trades - charge fees

// TODO :
// - Set the fee
// - Deposit Ether
// - Withdraw Ether
// - Deposit tokens
// - Withdraw tokens
// - Check balances
// - Make order
// - Cancel order
// - Fill order
// - Charge fees

contract Exchange {
    using SafeMath for uint;
    address public feeAccount;

    // Constructor
    constructor(address _feeAccount) public {
        feeAccount = _feeAccount;
    }
}