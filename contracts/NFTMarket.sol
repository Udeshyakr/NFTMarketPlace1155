// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarket is ERC1155Holder, Ownable, ReentrancyGuard{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _nftSold;
    IERC1155 private nftContract;
    uint256 private SILVER = 0;

    constructor(address nftContractAddress){
        nftContract = IERC1155(nftContractAddress);
    }

    struct NFTItems{
        address payable previousOwner;
        address payable owner;
        uint256 tokenId;
        uint256 price;
        uint256 amount; //shows copies of nft
        uint256 royality;
        bool sold;
        bool isListed;
    }
    mapping(uint256 => NFTItems) private marketItems;

    event NFT_Created(
        address indexed by,
        uint256 indexed tokenId,
        uint256 price
    );

    event NFT_Sold(
        address indexed by,
        address indexed to,
        uint256 tokenId
    );

    function listNFT(uint256 _tokenId, uint256 _price, uint256 _amount, uint256 _royality) external onlyOwner{
        //create new nft 
        listingValidation(_tokenId, _price, _royality);

        _tokenIds.increment();
        uint256 newItem = _tokenIds.current();
        marketItems[newItem] = NFTItems(
            marketItems[_tokenId].previousOwner,
            payable(msg.sender),
            _tokenId,
            _price,
            _amount,
            _royality,
            false,
            true   
        );
        IERC1155(nftContract).safeTransferFrom(msg.sender, address(this), _tokenId, _amount, "");
        emit NFT_Created(msg.sender, _tokenId, _price);
    }

    function buyNFT(uint256 _tokenId, uint256 amount) public payable {
        saleValidations(_tokenId);
        address payable ownerBeforeSale = marketItems[_tokenId].owner;
        uint256 nftPrice = marketItems[_tokenId].price;
        payments(_tokenId, nftPrice);
        // transfer nft to buyer
        IERC1155(nftContract).safeTransferFrom(marketItems[_tokenId].owner, msg.sender, _tokenId, amount, "");
        marketItems[_tokenId].isListed = false;
        marketItems[_tokenId].sold = true;

        
        marketItems[_tokenId].previousOwner = ownerBeforeSale;
        marketItems[_tokenId].owner = payable(msg.sender);

        emit NFT_Sold(marketItems[_tokenId].owner, msg.sender, _tokenId);
    }

    function payments(uint _tokenId, uint256 _nftPrice) private nonReentrant{
        uint256 platformFee = (25 * _nftPrice)/1000;
        uint256 royalites = (marketItems[_tokenId].royality)/ 1000;

        //uint256 updatedPrice = _nftPrice - platformFee;

        // transfering amount to NFT owner
        IERC1155(nftContract).safeTransferFrom(msg.sender, marketItems[_tokenId].owner, 0, _nftPrice, "");
        // transfering royality to the previous owner.
        address payable previousOwner = marketItems[_tokenId].previousOwner;
        if(previousOwner != address(0)){
        IERC1155(nftContract).safeTransferFrom(msg.sender,previousOwner , 0, royalites, "");
        }

        // trabsfering platform fee to deployer
        IERC1155(nftContract).safeTransferFrom(msg.sender, address(this), 0, platformFee, "");
    }

    function listingValidation(uint256 _tokenId, uint256 price, uint256 _royality) private view{
        require(marketItems[_tokenId].isListed == false, "ERC1155: TokenId already exists");
        require(price > 0, "ERC1155: price must be grater than zero");
        require(_tokenId != 0, "Token Id cannot be null");
        require(_royality>0 && _royality<30, "ERC1155 Marketplace: Royality percentage should be less than 30");
        require(marketItems[_tokenId].owner != msg.sender,"Only owner can list the nft");
    }

    function saleValidations(uint256 _tokenId) private view{
        require(marketItems[_tokenId].isListed == true, "ERC1155: TokenId doesn't exists");
        require(marketItems[_tokenId].owner != msg.sender, "ERC1155: cannot buy your own NFT");
    }

}