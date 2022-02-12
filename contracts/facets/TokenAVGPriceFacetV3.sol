pragma solidity ^0.8.0;

import "./OwnershipFacet.sol";
import "./Storage.sol";
import {LibDate} from "../libraries/LibDate.sol";

contract TokenAVGPriceFacetV3 is OwnershipFacet, Storage {  
    function setPrice(uint256 _price) public {
        Storage.Prices[LibDate.getDaysInYear(block.timestamp)] = _price;
        Storage.updateSumPricesOfMonth(uint8(LibDate.getMonth(block.timestamp) - 1), _price, block.timestamp);
    }

    function getAvgPrices(string memory _fromMonth, string memory _toMonth) public view returns (uint256) {
        MonthStorage[] memory data = Storage.getMonthData();

        uint8 fromMonthIndex = Storage.getMonthNumFromName(keccak256(bytes(_fromMonth)));
        uint8 toMonthIndex = Storage.getMonthNumFromName(keccak256(bytes(_toMonth)));

        require(fromMonthIndex < 12, "The Month Name is Incorrect");
        require(toMonthIndex < 12, "The Month Name is Incorrect");
        require(fromMonthIndex <= toMonthIndex, "The Month Name is Incorrect");

        return (data[fromMonthIndex].sumPrices + data[toMonthIndex].sumPrices) / (data[fromMonthIndex].counter + data[toMonthIndex].counter);
    }

    function getPrice(uint256 _date) public view returns (uint256 price) {
        price = Storage.monthStorages[LibDate.getMonth(_date) - 1].daysPrice[LibDate.getDaysInMonth(_date) - 1];
    }
}