const { network } = require("hardhat");
const {
  deploymentChains,
  DECIMALS,
  INITIAL_ANSWER,
} = require("../helper-hardhat-config");

module.exports = async ({ deployments, getNamedAccounts }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();

  if (deploymentChains.includes(network.name)) {
    log("Local network detected! Deploying Mocks .........");
    await deploy("MockV3Aggregator", {
      contract: "MockV3Aggregator",
      from: deployer,
      log: true,
      args: [DECIMALS, INITIAL_ANSWER],
    });
    log("Mocks Deployed!");
    log("-----------------------------------");
  }
};

// module.exports.default = deployFunc;

module.exports.tags = ["all", "mocks"];
