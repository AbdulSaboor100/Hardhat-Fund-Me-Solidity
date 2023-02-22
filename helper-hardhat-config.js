const networkConfig = {
  5: {
    name: "goerli",
    ethUsdPriceFeed: "0x694AA1769357215DE4FAC081bf1f309aDC325306",
  },
  11155111: {
    name: "sepolia",
    ethUsdPriceFeed: "0x694AA1769357215DE4FAC081bf1f309aDC325306",
  },
  //   31337
};

const deploymentChains = ["localhost", "hardhat"];

const DECIMALS = 8;
const INITIAL_ANSWER = 300000000000;

module.exports = {
  networkConfig,
  deploymentChains,
  INITIAL_ANSWER,
  DECIMALS,
};
