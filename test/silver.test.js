const { expect } = require("chai");
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat");

describe("Silver", ()=>{
    let owner;
    let addr1;
    let addr2;
    const _initialSupply = 10**8;
    
    it("Should deploy Silver token to Owner",async ()=>{
      const [owner] = await ethers.getSigners();
      const Silver = await ethers.getContractFactory("Silver");
      const silver = await Silver.deploy(_initialSupply);
      await silver.deployed();
      console.log("Contract Deployed Successfully");
      const ownerBalance = await silver.balanceOf(owner.address, 0);
        console.log(ownerBalance);
        expect(await ownerBalance).to.equal(_initialSupply);
        console.log("Owner balance is equal to initialSupply, :)");
    });

    

    it("Should mint Non-Fungible token", async()=>{
      const [addr1] = await ethers.getSigners();
      const Silver = await ethers.getContractFactory("Silver");
      const silver = await Silver.deploy(_initialSupply);
      await silver.deployed();
      console.log("Contract Deployed Successfully");
        const Addr1 = await silver.connect(addr1).mint(200);
        const AddrBal = await silver.balanceOf(addr1.address, 1);
        expect(await silver.balanceOf(addr1.address, 1)).to.equal(200);
        console.log(AddrBal);
    })

    

});