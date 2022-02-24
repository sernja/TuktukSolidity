//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract ProductDetails {
    //  Initial Product Details
    uint256[] probability = [0, 0, 0, 0, 0, 0, 1, 1, 1, 2]; //0:common, 1:rare, 2:epic
    string[] productTypeProbability = ["common", "rare", "epic"];
    uint256 randNonce = 0;

    function _compareStrings(string memory a, string memory b)
        internal
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    function _randomNumber() internal returns (uint256) {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(block.timestamp, randNonce))
        );
        randNonce++;
        return rand;
    }

    function _createType() internal returns (string memory) {
        uint256 rand = _randomNumber() % 10;
        return productTypeProbability[probability[rand]];
    }

    function _createName(string memory productType)
        internal
        pure
        returns (string memory)
    {
        if (_compareStrings(productType, "common")) {
            return "common_fast";
        } else if (_compareStrings(productType, "rare")) {
            return "rare_sern";
        } else {
            return "epic_fs";
        }
    }

    function _createLicense() internal returns (string memory) {
        bytes
            memory alpahbet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        bytes memory number = "0123456789";
        bytes memory n = new bytes(3);
        bytes1 alb1 = alpahbet[_randomNumber() % 52];
        bytes1 alb2 = alpahbet[_randomNumber() % 52];
        n[0] = number[_randomNumber() % 10];
        n[1] = number[_randomNumber() % 10];
        n[2] = number[_randomNumber() % 10];
        return string(abi.encodePacked(alb1, alb2, "-", n));
    }

    function _createFuel(string memory productType)
        internal
        pure
        returns (uint8)
    {
        if (_compareStrings(productType, "common")) {
            return uint8(15);
        } else if (_compareStrings(productType, "rare")) {
            return uint8(30);
        } else {
            return uint8(45);
        }
    }

    function _createPower(string memory productType) internal returns (uint16) {
        uint _pw = _randomNumber() % 101;
        if (_compareStrings(productType, "common")) {
            return uint16(_pw + 200);
        } else if (_compareStrings(productType, "rare")) {
            return uint16(_pw + 350);
        } else {
            return uint16(_pw + 500);
        }
    }

    function _createSpeed(string memory productType) internal returns (uint8) {
        uint _pw = _randomNumber() % 11;
        if (_compareStrings(productType, "common")) {
            return uint8(_pw + 30);
        } else if (_compareStrings(productType, "rare")) {
            return uint8(_pw + 50);
        } else {
            return uint8(_pw + 70);
        }
    }

    function _createDrift(string memory productType) internal returns (uint8) {
        uint _pw = _randomNumber() % 11;
        if (_compareStrings(productType, "common")) {
            return uint8(_pw + 15);
        } else if (_compareStrings(productType, "rare")) {
            return uint8(_pw + 30);
        } else {
            return uint8(_pw + 50);
        }
    }
}
