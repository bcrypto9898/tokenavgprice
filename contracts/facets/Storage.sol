pragma solidity ^0.8.0;

contract Storage {
    struct MonthStorage {
        string monthName;
        uint8 monthNum;
        uint32 sumPrices;
        uint8 counter;
    }

    MonthStorage[] public monthStorages;

    function getMonthData() public view returns (MonthStorage[] memory) {
        return monthStorages;
    }

    function setMonthData(
        string memory _monthName,
        uint8 _monthNum,
        uint32 _sumPrices,
        uint8 _counter
    ) public {
        MonthStorage memory monthStorageItem =MonthStorage(_monthName, _monthNum, _sumPrices, _counter);
        monthStorages.push(monthStorageItem);
    }

    function updateCounterOfMonth(uint8 _index) public {
        monthStorages[_index].counter += 1;
    }

    function updateSumPricesOfMonth(uint8 _index, uint32 _sumPrices) public {
        monthStorages[_index].sumPrices += _sumPrices;
    }
}
