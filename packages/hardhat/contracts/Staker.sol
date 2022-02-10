pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) public {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  mapping ( address => uint256 ) public balances;
  uint256 public constant threshold = 1 ether;
  event Stake(address, uint256);
  bool public openForWithdraw = false;

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )

  function stake() public payable {
      balances[msg.sender] += msg.value;
      emit Stake(msg.sender, msg.value);

  }
  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value
  // if the `threshold` was not met, allow everyone to call a `withdraw()` function
  function execute() public {
    if(address(this).balance >= threshold)
    {(exampleExternalContract.complete){value: address(this).balance}();}
    else {openForWithdraw = true;}

  }

  // Add a `withdraw(address payable)` function lets users withdraw their balance
  function withdraw(address payable user) public payable {
    uint256 withdrawAmount = balances[user];
    balances[user] = 0;
    user.transfer(withdrawAmount);

  }


  


  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend


  // Add the `receive()` special function that receives eth and calls stake()


}
