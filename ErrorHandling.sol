// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandling {
    address public admin; //gatekeeper address
    uint256 public totalSupply;
    string public tokenName = "MyToken";
    string public tokenAbbrv = "MTK";

    mapping(address => uint256) public balances;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function mint(address _address, uint256 _value) public onlyAdmin {
        require(_value > 0, "Mint value must be greater than zero");
        totalSupply += _value;
        balances[_address] += _value;
        assert(balances[_address] >= _value);
    }

    function burn(address _address, uint256 _value) public onlyAdmin {
        require(_value > 0, "Burn value must be greater than zero");
        require(balances[_address] >= _value, "Insufficient balance to burn");
        totalSupply -= _value;
        balances[_address] -= _value;
        assert(totalSupply >= 0);
        assert(balances[_address] >= 0);
    }

    function transfer(address _to, uint256 _value) public {
        require(_value <= 10000, "Transfer amount exceeds maximum limit");
        if (balances[msg.sender] < _value) {
            revert("Insufficient balance for transfer");
        }
        balances[msg.sender] -= _value;
        balances[_to] += _value;
    }
}
