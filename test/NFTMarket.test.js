const { expect } = require("chai");
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat");

describe("NFTMarket", ()=>{
    let owner;
    let addr1;
    let Silver;
    let silver;
    let NFTMarket;
    let nftMarket;
    let _initialSupply = 10**8;

    it("Should deploy Silver token to Owner",async ()=>{
      const [owner, addr1] = await ethers.getSigners();
      const Silver = await ethers.getContractFactory("Silver");
      const silver = await Silver.deploy(_initialSupply);
      await silver.deployed();
      const silverTokenAddress = silver.address;
      console.log("This is silver Token Address: ",silverTokenAddress);

      // deploy marketPlace Contract
       const NFTMarket = await ethers.getContractFactory("NFTMarket");
       const nftMarket = await NFTMarket.deploy(silverTokenAddress);
        await nftMarket.deployed();
        const nftMarketAddress = nftMarket.address;
        console.log("This is nftMarketPlaceAddress: ",nftMarketAddress);

       await silver.connect(owner).mint(200);

       await silver.setApprovalForAll(nftMarketAddress, true);

       await nftMarket.connect(owner).listNFT(1,500, 100, 1);   
       await silver.connect(owner).safeTransferFrom(owner.address, addr1.address, 0, 10000, '0x');
       console.log("Amount of silver token credited to Address1:", await silver.balanceOf(addr1.address, 0));
       await silver.connect(addr1).setApprovalForAll(nftMarketAddress, true);
       await nftMarket.connect(addr1).buyNFT(1, 50);
        const balanceNFT = await silver.balanceOf(addr1.address,1);
        console.log(balanceNFT); 
    })



});
