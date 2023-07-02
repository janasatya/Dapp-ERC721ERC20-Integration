# Dapp-ERC721ERC20-Integration
The given condition is a each ERC721 token is associated with 1000 ERC20 tokens.So two smart is provided to fulfill the condition.

1. MyNFT.sol -> Here anyone can mint NFTs or ERC721 tokens.
2. INRTERC20.sol -> The logic is if anyone mint a NFT, the associated ERC20 token (INRT) can be claimed by "claimMNFTsINRT" funtion. Here the user have to give as input his owned nft's tokenId and amount that he/she want to claim. And as a result the associated ERC20 token of the nft will decrease by the claimed amount. Also if a User has INRT , he/she can send it to any minted NFT by "sendINRTToMNFT" function and also the associated ERC20 token of the nft will increase by sent amount.
