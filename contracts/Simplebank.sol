// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
// "pragma" means which version the solidity is
 
contract Simplebank {
//   uint public funds = 500;
//   // uint = unsigned integer
  
  uint public numberOfFunders;
  mapping(address => bool) private funders;
  mapping(uint => address) private lutFunders;
  mapping(address => uint) private lastFundAmount;
  address public owner;

  constructor (){
    owner = msg.sender;  
  }

  modifier onlyOwner(){
    require(msg.sender == owner, "Only the owner can do that");
    _;
  }

  function transferOwnership(address newOwner) external onlyOwner{
    owner = newOwner;
  }

  function addFunds() external payable{
    address funder = msg.sender;
    if(!funders[funder]){
      uint index = numberOfFunders++;
      funders[funder] = true;
      lutFunders[index] = funder;
    }
      lastFundAmount[funder] += msg.value;
  }

  function getAllFunders() external view returns(address[] memory) {
    address[] memory _funders = new address[](numberOfFunders);
    for(uint i=0; i<numberOfFunders; i++){
      _funders[i] = lutFunders[i];
    }
    return _funders;
  }

  function withdraw(uint withdrawAmount) external {
    // require(withdrawAmount < 1000000000000000000 || msg.sender == owner, "You can't withdraw more than 1 ether");
    payable (msg.sender).transfer(withdrawAmount);

  }
}


// const instance = await Simplebank.deployed()
// instance.addFunds({value:"500000000000000000", from: accounts[0]})
// instance.addFunds({value:"500000000000000000", from: accounts[1]})
// const funds = instance.funds()
// instance.getAllFunders()
// instance.getAllFunds()
// instance.withdraw("1000000000000000000", {from: accounts[1]})
// instance.transferOwnership("0x357D23Fd460c020F8a45E96d46494051E84EFdC7")