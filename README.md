# ErrorHandling
This Solidity contract, ErrorHandling, showcases the implementation of error-handling mechanisms such as require, assert, and revert in the context of a token management system. Designed with security and integrity in mind, this contract enables controlled token minting, burning, and transfer functionalities.

## Description
The ErrorHandling contract is a demonstration of how to manage tokens securely on the Ethereum blockchain using Solidity. It incorporates error-handling mechanisms to ensure the safety and correctness of token operations. Key features include:

Token minting: Allows the admin to create new tokens and distribute them to specified addresses.
Token burning: Enables the admin to remove tokens from circulation, reducing the total token supply.
Token transfer: Facilitates the transfer of tokens between addresses while enforcing predefined constraints.

## Getting Started
This program contains straightforward functions and variables designed for mapping data, minting tokens, and burning resources as necessary using require(), assert(), revert().

### Executing program
To run this program, you can utilize Remix, an online Solidity IDE. Begin by navigating to the Remix website at Remix Ethereum.

Once you're on the Remix website, initiate a new file by selecting the "+" icon in the left-hand sidebar. Save the file with a .sol extension (for instance, MyToken.sol). Then, copy and paste the provided code into the file.

javascript
solidity
Copy code
```
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

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

```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile MyToken.sol" (or whatever the file name is) button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "MyToken" contract from the dropdown menu, and then click on the "Deploy" button.

After deployment, you can interact with the contract using the default addresses provided. You can mint new tokens to an address and burn tokens from an address. Each address acts as a different user, allowing you to perform various operations on it.

## Authors

Aditi Rajput
[@Chandigarh University](https://www.linkedin.com/in/aditi-rajput-b9360720b/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
