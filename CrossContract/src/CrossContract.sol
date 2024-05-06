// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;


interface PriceOracle {
    function price() external view returns (uint256);
}

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external view returns (uint256) {
        PriceOracle priceOracle1 = PriceOracle(_priceOracle1);
        PriceOracle priceOracle2 = PriceOracle(_priceOracle2);

        uint256 price1 = priceOracle1.price();
        uint256 price2 = priceOracle2.price();

        return (price1 < price2) ? price1 : price2;
    
    }
}

contract PriceOracle1 {
    uint256 public _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 public _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
