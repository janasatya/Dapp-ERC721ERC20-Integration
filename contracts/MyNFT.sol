// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";



contract MyNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor()ERC721("My NFT","MNFT"){}

    function mint(string memory tokenUri)public {
        _tokenIds.increment();
        uint nid=_tokenIds.current();
        _mint(msg.sender, nid);
        _setTokenURI(nid, tokenUri);
    }

    function exists(uint256 tokenId)external view returns(bool){
        return _exists(tokenId);
    } 
    
}