// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//INTERNAL IMPORT FOR NFT OPENZIPLINE

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFTMarketplace is ERC721URIStorage{
   using Counters for Counters.Counter;
   Counters.Counter private _tokenIds;
   Counters.Counter private _itmesSold;

   uint256 listingPrice =  0.0025 ether;
   address payable owner;

   mapping (uint256 => MarketItem) private idMarketItem;

   struct MarketItem {
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold; 
   }

   event MarketItemCreated (
    uint256 indexed _tokenIds,
    address seller,
    address owner,
    uint256 price,
    bool sold
   );
   modifier onlyOwner() {
    require(msg.sender == owner, 'only owner of the marketplace can change the listing price');
    _;
   }
   constructor() ERC721("NFT Metavarse Token", "MYNFT"){
    owner == payable(msg.sender);
   }

   function updateListingPrice(uint256 _ListingPrice) public payable onlyOwner{
    listingPrice = _ListingPrice;
   }

   function getListingPrice() public view returns(uint256){
    return listingPrice;
   }
   // Let create nft token function

   function createToken(string memory tokenURI,uint256 price ) public payable returns(uint256){
    _tokenIds.increment();
    uint256 newTokenId = _tokenIds.current();
    _mint(msg.sender , newTokenId);
    _setTokenURI(newTokenId, tokenURI)

   }
}