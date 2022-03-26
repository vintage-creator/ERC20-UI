// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vintagecrypto is ERC20, Ownable {

    uint public tokenBuyPrice = 1*10**17;
    uint public numberofTokensStaked;
    mapping (address => bool) public hasStaked;
    mapping (address => uint) stakingBalance;
    mapping (address => uint) public rewards;
    event Transfer (address indexed owner, address indexed staker, uint amount, uint timestamp);

    struct stakedToken {
        address owner;
        address staker;
        uint amount;
        uint timestamp;
    }
    stakedToken[] vintageTokens;

    constructor() ERC20("Vintage-crypto", "$VIT") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function buyToken(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }


    function stakeToken (address staker, uint amount) public {
        //if (balanceOf[staker] >= tokenBuyPrice) {
        transferFrom (staker, address(this), amount);
        hasStaked[staker] = true;
        vintageTokens.push (stakedToken(msg.sender, staker, amount, block.timestamp));
        emit Transfer (msg.sender, staker, amount);
    }

    function claimReward (address payable staker, uint amountStaked) public {
        require (block.timestamp == 24 * 7);
        uint reward = rewards[staker];
        rewards[staker] = amountStaked/100;
            transfer(staker, reward);

    }

    function getAllTransactions () public view returns (stakedToken[] memory) {
        return vintageTokens;
    }

    function _numberofTokensStaked () public view returns (uint) {
        return numberofTokensStaked;
    }

    function viewTokenBalance (address staker) public view returns (uint) {
        return stakingBalance[staker];
    }


}

