// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 constant minimunUSDToSend = 50 * 1e10;
    address aggregatorAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address[] public funders;
    mapping(address => uint256) public addressToAmmount;

    address public immutable owner;

    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(priceFeed) >= minimunUSDToSend,
            "Didn't Send Enough Eth"
        );
        funders.push(msg.sender);
        addressToAmmount[msg.sender] = msg.value;
    }

    function withDraw() public onlyOwner {
        for (uint256 i; i > funders.length; i++) {
            address funder = funders[i];
            addressToAmmount[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        // require(msg.sender == owner, "Sender is not owner");
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
