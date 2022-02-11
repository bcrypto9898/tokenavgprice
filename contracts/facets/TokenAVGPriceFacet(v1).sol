pragma solidity ^0.8.0;

import "./OwnershipFacet.sol";
import "./Storage.sol";
import {LibDate} from "../libraries/LibDate.sol";

contract TokenAVGPriceFacet is OwnershipFacet, Storage {
    /// @param _price set price token
    function setPrice(uint32 _price) public onlyOwner {
        MonthStorage[] memory data = Storage.getMonthData();

        if (LibDate.getMonth(block.timestamp) == data[0].monthNum) {
            Storage.updateSumPricesOfMonth(0, _price);
            Storage.updateCounterOfMonth(0);
        } else if (LibDate.getMonth(block.timestamp) == data[1].monthNum) {
            Storage.updateSumPricesOfMonth(1, _price);
            Storage.updateCounterOfMonth(1);
        } else if (LibDate.getMonth(block.timestamp) == data[2].monthNum) {
            Storage.updateSumPricesOfMonth(2, _price);
            Storage.updateCounterOfMonth(2);
        } else if (LibDate.getMonth(block.timestamp) == data[3].monthNum) {
            Storage.updateSumPricesOfMonth(3, _price);
            Storage.updateCounterOfMonth(3);
        } else if (LibDate.getMonth(block.timestamp) == data[4].monthNum) {
            Storage.updateSumPricesOfMonth(4, _price);
            Storage.updateCounterOfMonth(4);
        } else if (LibDate.getMonth(block.timestamp) == data[5].monthNum) {
            Storage.updateSumPricesOfMonth(5, _price);
            Storage.updateCounterOfMonth(5);
        } else if (LibDate.getMonth(block.timestamp) == data[6].monthNum) {
            Storage.updateSumPricesOfMonth(6, _price);
            Storage.updateCounterOfMonth(6);
        } else if (LibDate.getMonth(block.timestamp) == data[7].monthNum) {
            Storage.updateSumPricesOfMonth(7, _price);
            Storage.updateCounterOfMonth(7);
        } else if (LibDate.getMonth(block.timestamp) == data[8].monthNum) {
            Storage.updateSumPricesOfMonth(8, _price);
            Storage.updateCounterOfMonth(8);
        } else if (LibDate.getMonth(block.timestamp) == data[9].monthNum) {
            Storage.updateSumPricesOfMonth(9, _price);
            Storage.updateCounterOfMonth(9);
        } else if (LibDate.getMonth(block.timestamp) == data[10].monthNum) {
            Storage.updateSumPricesOfMonth(10, _price);
            Storage.updateCounterOfMonth(10);
        } else if (LibDate.getMonth(block.timestamp) == data[11].monthNum) {
            Storage.updateSumPricesOfMonth(11, _price);
            Storage.updateCounterOfMonth(11);
        }
    }
}
