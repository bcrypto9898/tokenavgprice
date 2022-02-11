pragma solidity ^0.8.0;

import "./OwnershipFacet.sol";

contract TokenAVGPriceFacet is OwnershipFacet {

    uint256 price;
    
    /// @param _price set price token
    function setPrice(uint256 _price) onlyOwner public {
        price = _price;    
    }

    function getPrice() public returns(uint256) {
        return price;
    }
}