require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
require("hardhat-gas-reporter");

const {PRIVATE_KEY, POLYGONSCAN_API_KEY, MORALIS_FTM} = process.env;

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    matic: {
      url: `https://rpc-mainnet.maticvigil.com/`,
      accounts: [PRIVATE_KEY]
    },
    mumbai: {
      url: `https://rpc-mumbai.maticvigil.com/`,
      accounts: [PRIVATE_KEY]
    },
    ftm_Testnet: {
      url: `https://rpc.testnet.fantom.network/`,
      accounts: [PRIVATE_KEY]
    },
    ftm_Mainnet: {
      url: `https://speedy-nodes-nyc.moralis.io/${MORALIS_FTM}/fantom/mainnet`,
      accounts: [PRIVATE_KEY]
    }
  },
  solidity: {
    version: "0.8.7",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  gasPrice: "10000000000",
  gas: "auto",
  gasReporter: {
    gasPrice: 1,
    enabled: false,
    showTimeSpent: true
  },

  etherscan: {
    apiKey: POLYGONSCAN_API_KEY
  }
};

