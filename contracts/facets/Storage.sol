pragma solidity ^0.8.0;

import {LibDate} from "../libraries/LibDate.sol";

contract Storage {
    struct MonthStorage {
        bytes32 monthName;
        uint8 monthNum;
        uint256 sumPrices;
        uint8 counter;
        uint256[31] daysPrice;
    }

    uint256[31] public monthType;
    MonthStorage[] public monthStorages;
    mapping(uint256 => uint256) public Prices;

    function getMonthData() public view returns (MonthStorage[] memory) {
        return monthStorages;
    }

    function setMonthData(
        bytes32 _monthName,
        uint8 _monthNum,
        uint256 _sumPrices,
        uint8 _counter,
        uint256[31] memory _daysPrice
    ) public {
        MonthStorage memory monthStorageItem = MonthStorage(_monthName, _monthNum, _sumPrices, _counter, _daysPrice);
        monthStorages.push(monthStorageItem);
    }

    function updateSumPricesOfMonth(
        uint8 _index,
        uint256 _price,
        uint256 _timestamp
    ) public {
        uint256 indexDay = LibDate.getDaysInMonth(_timestamp);

        if (monthStorages[_index].daysPrice[indexDay - 1] > 0) {
            monthStorages[_index].sumPrices -= monthStorages[_index].daysPrice[indexDay - 1];
            monthStorages[_index].counter -= 1;
        }

        monthStorages[_index].daysPrice[indexDay - 1] = _price;
        monthStorages[_index].sumPrices += _price;
        monthStorages[_index].counter += 1;
    }

    function getMonthNumFromName(bytes32 monthName) public view returns (uint8) {
        uint8 index = 12;

        if (monthStorages[0].monthName == monthName) {
            index = 0;
        } else if (monthStorages[1].monthName == monthName) {
            index = 1;
        } else if (monthStorages[2].monthName == monthName) {
            index = 2;
        } else if (monthStorages[3].monthName == monthName) {
            index = 3;
        } else if (monthStorages[4].monthName == monthName) {
            index = 4;
        } else if (monthStorages[5].monthName == monthName) {
            index = 5;
        } else if (monthStorages[6].monthName == monthName) {
            index = 6;
        } else if (monthStorages[7].monthName == monthName) {
            index = 7;
        } else if (monthStorages[8].monthName == monthName) {
            index = 8;
        } else if (monthStorages[9].monthName == monthName) {
            index = 9;
        } else if (monthStorages[10].monthName == monthName) {
            index = 10;
        } else if (monthStorages[11].monthName == monthName) {
            index = 11;
        }
        return index;
    }
}
