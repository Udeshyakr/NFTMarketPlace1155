# NFT MarketPlace using ERC1155

an NFT marketplace is your gateway to participating in the purchase and sale of these digital assets

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

```
    RINKEBY_API_URL = "https://eth-rinkeby.alchemyapi.io/v2/YOUR_API_KEY"
    PRIVATE_KEY = "YOUR-METAMASK-PRIVATE_KEY"
    ETHERSCAN_API_KEY = "YOUR-ETHERSCAN_API_KEY"
```

## NPM Packages:

 - [Openzeppelin](https://docs.openzeppelin.com/contracts/4.x/erc1155)
 - [Hardhat Ethers](https://www.npmjs.com/package/hardhat-ethers)
 - [Chai](https://www.npmjs.com/package/chai)
 - [Ethers](https://www.npmjs.com/package/ethers)
 - [ethereum-waffle](https://www.npmjs.com/package/ethereum-waffle)
 - [dotenv](https://www.npmjs.com/package/dotenv)
 - [Hardhat-Etherscan](https://www.npmjs.com/package/hardhat-etherscan)

## Tech Stack:
 - [Node](https://nodejs.org/en/)
 - [Hardhat](https://hardhat.org/tutorial/)
 - [Solidity](https://docs.soliditylang.org/en/v0.8.13)

 
## Run Locally:

Clone the github repo:
```
https://github.com/Udeshyakr/NFTMarketPlace1155.git
```

Install Node Modules
```
npm install
```
```
npm install --save-dev hardhat
```

```
npx hardhat
```
## Plugins:
 @dev- After installing hardhat, Most of the time the way to use a given tool is by consuming a plugin that integrates it into Hardhat.
 we are going to use the Ethers.js and Waffle plugins
 ```
 npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai
 ```

Compile
```
npx hardhat compile
```

Test
```
npx hardhat test
```

Deploy
```
node scripts/deploy.js
```

Deploy on Rinkey
```
npx hardhat run scripts/deploy.js --network rinkeby
```
Help
```
npx hardhat help
```

## Check at Rinkeby Testnet:
 - [SilverToken](https://rinkeby.etherscan.io/address/0xBFF768b7E7E99B152C33ea42c95E965a8e1C45e4)
 - [NFTMarketPlace](https://rinkeby.etherscan.io/address/0x9aECF5fC534359D72fC2A45B40e487df9bb12Bd2)
 
