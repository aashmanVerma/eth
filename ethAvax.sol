// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ethAvax {
    struct Car {
        string name;
        uint year;
    }
    uint public totalCars = 0;
    Car[] warehouse;
    mapping (address => Car) rented;

    modifier paramCheck(uint year) {
        require(year >= 2000, "Year should be greater than 2000");
        _;
    }

    function storeInWareHouse(string memory n, uint y) public paramCheck(y) {
        Car memory newCar = Car(n, y);
        warehouse.push(newCar);
        totalCars++;
    }

    function rentCar(address a, uint amount) public {
        assert(amount > 0);

        Car memory lastCar = warehouse[warehouse.length - 1];
        rented[a] = lastCar;
        warehouse.pop();
        totalCars--;
        
        if (totalCars < 1) {
            revert("We can't rent out the last car");
        }
    }

    function getCar(address a) public view returns (Car memory) {
        return rented[a];
    }

}