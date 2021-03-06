pragma solidity ^0.4.11;

import "./tokens/EIP621OraclizedToken.sol";

contract ETH20 {

  EIP621OraclizedToken public token;

  function ETH20(
    uint256 _initialAmount,
    string _tokenName,
    uint8 _decimalUnits,
    string _tokenSymbol
  ) public {
    token = new EIP621OraclizedToken(
      _initialAmount,
      _tokenName,
      _decimalUnits,
      _tokenSymbol,
      this
    );
  }

  function etherToToken() public payable {
    token.increaseSupply(msg.value, msg.sender);
  }

  function tokenToEther(uint _amount) public {
    require(token.balanceOf(msg.sender) >= _amount);
    token.decreaseSupply(_amount, msg.sender);

    msg.sender.transfer(_amount);
  }

  function tokenAddress() public view returns (address) {
    return address(token);
  }
}
