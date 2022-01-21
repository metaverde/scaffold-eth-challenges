pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

//import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor {

  YourToken yourToken;

  

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  uint256 public constant tokensPerEth = 100;
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
 

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable returns(uint tokenAmount) {
    require(msg.value > 0, "Takes money to make money!");
    uint256 amountToBuy = msg.value * tokensPerEth;
    uint256 vendorBalance = yourToken.balanceOf(address(this));
    require(vendorBalance >= amountToBuy, "Too many tokens! Don't be greedy.");
    (bool sent) = yourToken.transfer(msg.sender, amountToBuy);
    require(sent, "Failed to transfer tokens");

    emit BuyTokens(msg.sender, msg.value, amountToBuy);

    return amountToBuy;

  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH


  // ToDo: create a sellTokens() function:
  function sellTokens(uint amountToSell) public payable returns(uint ethAmount) {
    require(msg.value > 0, "Tokens needed to get the eth!");
    uint ethAmount = msg.value/100;
    uint256 sellerBalance = yourToken.balanceOf(msg.sender);
    require(sellerBalance >= amountToSell, "Your balance is lower than the amount of tokens you want to sell");
  }


}
