//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Tuktukfactory is Ownable {
    event NewCar(
        uint256 carId,
        string _img,
        string _name,
        string _cartype,
        string _license,
        uint8 _level,
        uint256 _exp,
        uint8 _fuel,
        uint8 _power,
        uint8 _speed,
        uint8 _drift,
        uint256 _dna
    );

    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    struct Car {
        string _img;
        string name;
        string cartype;
        string license;
        uint8 level;
        uint256 exp;
        uint8 fuel;
        uint8 power;
        uint8 speed;
        uint8 drift;
        uint256 dna;
    }

    Car[] public cars;

    mapping(uint256 => address) public carToOwner;
    mapping(address => uint256) ownerCarCount;

    function _createCar(
        string memory _img,
        string memory _name,
        string memory _cartype,
        string memory _license,
        uint8 _level,
        uint256 _exp,
        uint8 _fuel,
        uint8 _power,
        uint8 _speed,
        uint8 _drift,
        uint256 _dna
    ) internal {
        cars.push(
            Car(
                _img,
                _name,
                _cartype,
                _license,
                _level,
                _exp,
                _fuel,
                _power,
                _speed,
                _drift,
                _dna
            )
        );
        uint256 id = cars.length - 1;
        carToOwner[id] = msg.sender;
        ownerCarCount[msg.sender]++;
        emit NewCar(
            id,
            _img,
            _name,
            _cartype,
            _license,
            _level,
            _exp,
            _fuel,
            _power,
            _speed,
            _drift,
            _dna
        );
    }

    function _generateRandomDna(string memory _img)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_img)));
        return rand % dnaModulus;
    }

    function createRandomCar(
        string memory _img,
        string memory _name,
        string memory _cartype,
        string memory _license,
        uint8 _level,
        uint256 _exp,
        uint8 _fuel,
        uint8 _power,
        uint8 _speed,
        uint8 _drift
    ) public {
        uint256 randDna = _generateRandomDna(_img);
        randDna = randDna - (randDna % 100);
        _createCar(
            _img,
            _name,
            _cartype,
            _license,
            _level,
            _exp,
            _fuel,
            _power,
            _speed,
            _drift,
            randDna
        );
    }
}
