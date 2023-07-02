// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface MNFT{
    function exists(uint256 _tokenId)external view returns(bool);
    function ownerOf(uint256 _tokenId) external view returns(address);
}

contract INRToken is ERC20 {
    MNFT mnft;
    constructor(address erc721) ERC20("Indian Rupee", "INRT") {
        mnft=MNFT(erc721);
    }
    /*
        For a tokenId inital balaceOfId is 0. But it should be 10000 INRT. 
        So, checkId mapping is used to check this.
    */
    mapping(uint256=>uint8) private checkId; //bool is expensive than uint
    mapping(uint256=>uint256) private balanceOfId; // tokenId --> INRT amount

    event ClaimToken(uint8 from,address indexed to,uint256 amount);
    event SendToken(address indexed from,uint8 to,uint256 amount); 

    function balanceOfTokenId(uint256 _tokenId)public view returns(uint256){
        require(msg.sender!=address(0));
        require(mnft.exists(_tokenId),"Token Id does not exist");
        require(mnft.ownerOf(_tokenId)==msg.sender,"You are not the owner");
        if(checkId[_tokenId]==0)return 1e21;
        return balanceOfId[_tokenId];
    }

    function claimMNFTsINRT(uint256 _tokenId,uint256 _amount)public {
        address msgSender=msg.sender;
        require(msgSender!=address(0));
        require(mnft.exists(_tokenId),"Token Id does not exist");
        require(mnft.ownerOf(_tokenId)==msgSender,"You are not the owner");
        if(checkId[_tokenId]==0){
            balanceOfId[_tokenId]=1e21;
            checkId[_tokenId]=1;
        }
        uint256 balance=balanceOfId[_tokenId];
        require(balance>=_amount,"Not much INRT availabe for this id");
        balanceOfId[_tokenId]-=_amount;
        _mint(msgSender,_amount);
        emit ClaimToken(0,msgSender,_amount);
    }

    function sendINRTToMNFT(uint256 _tokenId,uint256 _amount)public{
        address msgSender=msg.sender;
        require(msgSender!=address(0));
        require(mnft.exists(_tokenId),"Token Id does not exist");
        if(checkId[_tokenId]==0){
            balanceOfId[_tokenId]=1e21;
            checkId[_tokenId]=1;
        }
        balanceOfId[_tokenId]+=_amount;
        _burn(msgSender,_amount);
        emit SendToken(msgSender,0,_amount);
    }
}