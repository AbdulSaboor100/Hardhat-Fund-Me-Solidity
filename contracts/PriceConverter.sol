//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(
        uint256 ethAmmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmmountInUSD = (ethPrice * ethAmmount) / 1e10;
        return ethAmmountInUSD;
    }
}
