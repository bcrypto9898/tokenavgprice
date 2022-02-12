// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Nick Mudge <nick@perfectabstractions.com> (https://twitter.com/mudgen)
* EIP-2535 Diamonds: https://eips.ethereum.org/EIPS/eip-2535
*
* Implementation of a diamond.
/******************************************************************************/

import { LibDiamond } from "./libraries/LibDiamond.sol";
import { IDiamondCut } from "./interfaces/IDiamondCut.sol";

import "./facets/OwnershipFacet.sol";
import "./facets/Storage.sol";

contract Diamond is OwnershipFacet,Storage{    

    constructor(address _contractOwner, address _diamondCutFacet) payable {        
        LibDiamond.setContractOwner(_contractOwner);

        // Add the diamondCut external function from the diamondCutFacet
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IDiamondCut.diamondCut.selector;
        cut[0] = IDiamondCut.FacetCut({
            facetAddress: _diamondCutFacet, 
            action: IDiamondCut.FacetCutAction.Add, 
            functionSelectors: functionSelectors
        });
        LibDiamond.diamondCut(cut, address(0), "");        
    }

    function setStorage() onlyOwner public {
        Storage.setMonthData(keccak256(bytes('_Jan_')),1,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Feb_')),2,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Mar_')),3,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Apr_')),4,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_May_')),5,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Jun_')),6,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Jul_')),7,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Aug_')),8,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Sep_')),9,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Oct_')),10,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Nov_')),11,0,0,Storage.monthType);
        Storage.setMonthData(keccak256(bytes('_Dec_')),12,0,0,Storage.monthType);
    }

    // Find facet for function that is called and execute the
    // function if a facet is found and return any value.
    fallback() external payable {
        LibDiamond.DiamondStorage storage ds;
        bytes32 position = LibDiamond.DIAMOND_STORAGE_POSITION;
        // get diamond storage
        assembly {
            ds.slot := position
        }
        // get facet from function selector
        address facet = address(bytes20(ds.facets[msg.sig]));
        require(facet != address(0), "Diamond: Function does not exist");
        // Execute external function from facet using delegatecall and return any value.
        assembly {
            // copy function selector and any arguments
            calldatacopy(0, 0, calldatasize())
            // execute function call using the facet
            let result := delegatecall(gas(), facet, 0, calldatasize(), 0, 0)
            // get any return value
            returndatacopy(0, 0, returndatasize())
            // return any return value or error back to the caller
            switch result
                case 0 {
                    revert(0, returndatasize())
                }
                default {
                    return(0, returndatasize())
                }
        }
    }

    receive() external payable {}
}
