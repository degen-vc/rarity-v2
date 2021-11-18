const hardhat = require('hardhat');
const { constants, utils } = require('ethers');
require('dotenv').config();

const { PAYMENT_TOKEN, NAME_BUY_PRICE_WEI } = process.env;

async function main() {
  console.log('NOTHIN TO VERIFY, get console output from the deploy step');
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });