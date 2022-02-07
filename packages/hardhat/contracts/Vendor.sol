
pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }


  uint256 public constant tokensPerEth = 1000;
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint amountOfTokens, uint amountOfEth);

  

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable returns(uint tokenAmount) {
    require(msg.value > 0, "Takes money to make money!");
    uint256 vendorBalance = yourToken.balanceOf(address(this));
    require(vendorBalance >= msg.value * tokensPerEth, "Too many tokens! Don't be greedy.");
    (bool sent) = yourToken.transfer(msg.sender, (msg.value * tokensPerEth));
    require(sent, "Failed to transfer tokens");

    emit BuyTokens(msg.sender, msg.value, (msg.value * tokensPerEth));

    return (msg.value * tokensPerEth);

  }



  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    uint256 amount = address(this).balance;
    (bool success, ) = owner().call{value: amount}("");
    require(success, "Are you the owner?");

  }
  // ToDo: create a sellTokens() function:

  function sellTokens(uint256 amountOfTokens) public payable {
    yourToken.transferFrom(msg.sender, address(this), amountOfTokens);
  
    uint256 sellerBalance = yourToken.balanceOf(msg.sender);
    require(sellerBalance >= msg.value, "Too many tokens! Don't be greedy.");
    
    (bool success, ) = msg.sender.call{value: amountOfTokens/tokensPerEth}("");
    require(success, "ETH withdrawal failed!");

    emit SellTokens(msg.sender, amountOfTokens, amountOfTokens/tokensPerEth);
  }


}