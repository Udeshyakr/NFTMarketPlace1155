const hre = require('hardhat');
const { BigNumber } = require('ethers');

async function main(){
    // Deploy of erc20 token
    const _initialSupply = 10 **8; 
    const Silver = await ethers.getContractFactory("Silver");
    const silver = await Silver.deploy(_initialSupply);
    await silver.deployed();
    const silverTokenAddress = silver.address;
    console.log("This is silver Token Address: ",silverTokenAddress);

    // deploy of market place contract
    const NFTMarket = await ethers.getContractFactory("NFTMarket");
    const nftMarket = await NFTMarket.deploy(silverTokenAddress);
    await nftMarket.deployed();
    const nftMarketAddress = nftMarket.address;
    console.log("This is nftMarketPlaceAddress: ",nftMarketAddress);
  
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.log(error);
        process.exit(1);
    })
