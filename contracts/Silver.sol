// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract Silver is ERC1155, Ownable{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint public SILVER = 0;

    // Fungible
    constructor(uint initialSupply) ERC1155("") {
        _mint(msg.sender, SILVER, initialSupply, "");
    }

    // NON-Fungible        
    function mint(uint256 amount) external{
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _mint(msg.sender, newTokenId,amount, "");
    }

}