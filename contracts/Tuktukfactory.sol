//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


import "./ProductDetails.sol";
// import "./Productownership.sol";

contract Tuktukfactory is ProductDetails, ERC721 {
    event NewCar(
        uint256 carId,
        string _img,
        string _name,
        string _cartype,
        string _license,
        uint8 _level,
        uint256 _exp,
        uint8 _fuel,
        uint16 _power,
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
        uint16 power;
        uint8 speed;
        uint8 drift;
        uint256 dna;
    }

    Car[] public cars;

    mapping(uint256 => address) public carToOwner;
    mapping(address => uint256) ownerCarCount;

    constructor() ERC721("TUKTUK", "TUK") {}

    function _createNFT(uint256 tokenId) internal {
        _safeMint(msg.sender, tokenId);
    }

    function _createCar(
        string memory _img,
        string memory _name,
        string memory _cartype,
        string memory _license,
        uint8 _level,
        uint256 _exp,
        uint8 _fuel,
        uint16 _power,
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
        _createNFT(id);
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

    function createRandomCar(string memory _img) public {
        string memory _cartype = _createType();
        uint256 randDna = _randomNumber() % dnaModulus;
        randDna = randDna - (randDna % 100);
        _createCar(
            _img,
            _createName(_cartype),
            _cartype,
            _createLicense(),
            1,
            0,
            _createFuel(_cartype),
            _createPower(_cartype),
            _createSpeed(_cartype),
            _createDrift(_cartype),
            randDna
        );
    }
}
