pragma solidity ^0.8.0;

library LibDate {
    uint256 constant SECONDS_PER_DAY = 24 * 60 * 60;
    int256 constant OFFSET19700101 = 2440588;

    function _daysToDate(uint256 _days)
        internal
        pure
        returns (
            uint256 year,
            uint256 month,
            uint256 day
        )
    {
        int256 __days = int256(_days);

        int256 L = __days + 68569 + OFFSET19700101;
        int256 N = (4 * L) / 146097;
        L = L - (146097 * N + 3) / 4;
        int256 _year = (4000 * (L + 1)) / 1461001;
        L = L - (1461 * _year) / 4 + 31;
        int256 _month = (80 * L) / 2447;
        int256 _day = L - (2447 * _month) / 80;
        L = _month / 11;
        _month = _month + 2 - 12 * L;
        _year = 100 * (N - 49) + _year + L;

        year = uint256(_year);
        month = uint256(_month);
        day = uint256(_day);
    }

    function getMonth(uint256 timestamp) internal pure returns (uint256 month) {
        (, month, ) = _daysToDate(timestamp / SECONDS_PER_DAY);
    }

    function getYear(uint256 timestamp) internal pure returns (uint256 year) {
        (year, , ) = _daysToDate(timestamp / SECONDS_PER_DAY);
    }

    function _isLeapYear(uint256 year) internal pure returns (bool leapYear) {
        leapYear = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
    }

    function getDaysInYear(uint256 timestamp) internal pure returns (uint256 daysInYear) {
        (uint256 year, uint256 month, uint256 day) = _daysToDate(timestamp / SECONDS_PER_DAY);
        daysInYear = _getDaysInYear(year, month, day);
    }

    function _getDaysInYear(
        uint256 year,
        uint256 month,
        uint256 day
    ) internal pure returns (uint256 daysInYear) {
        daysInYear += day;
        if (month > 1) {
            daysInYear += 31;
        }
        if (month > 2) {
            daysInYear += _isLeapYear(year) ? 29 : 28;
        }
        if (month > 3) {
            daysInYear += 31;
        }
        if (month > 4) {
            daysInYear += 30;
        }
        if (month > 5) {
            daysInYear += 31;
        }
        if (month > 6) {
            daysInYear += 30;
        }
        if (month > 7) {
            daysInYear += 31;
        }
        if (month > 8) {
            daysInYear += 31;
        }
        if (month > 9) {
            daysInYear += 30;
        }
        if (month > 10) {
            daysInYear += 31;
        }
        if (month > 11) {
            daysInYear += 30;
        }
        if (month > 12) {
            daysInYear += 31;
        }
    }

    function getDaysInMonth(uint timestamp) internal pure returns (uint daysInMonth) {
        (uint year, uint month,) = _daysToDate(timestamp / SECONDS_PER_DAY);
        daysInMonth = _getDaysInMonth(year, month);
    }
    
    function _getDaysInMonth(uint year, uint month) internal pure returns (uint daysInMonth) {
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            daysInMonth = 31;
        } else if (month != 2) {
            daysInMonth = 30;
        } else {
            daysInMonth = _isLeapYear(year) ? 29 : 28;
        }
    }
}
