pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  mapping ( address => uint256 ) public balances;
  uint256 public tokensPerEth = 777;
  uint256 tokenBalance = yourToken.balanceOf(address(this));
  //need to keep track of the balance of yourToken?

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    require(msg.value > 0, "RGP: INSUFFICIENT INPUT BALANCE, YOU NEED TO SEND SOME CAKE");
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public payable {

  }

  // ToDo: create a sellTokens() function:
  //need to make sure there's enough eth in the contract?
  function sellTokens() public payable {

  }

}
