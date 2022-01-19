pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20
//https://docs.openzeppelin.com/contracts/4.x/api/token/erc20#ERC20
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol

contract YourToken is ERC20 {
    // ToDo: add constructor and mint tokens for deployer,
    //       you can use the above import for ERC20.sol. Read the docs ^^^

    constructor() ERC20("Gold", "GLD") {
        _mint(msg.sender, 1000 * (10 ** 18));
        
    }
}