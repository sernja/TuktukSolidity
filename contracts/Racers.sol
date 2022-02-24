//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "./RewardRance.sol";

contract Racers is RewardRance {
    uint8[] private victoryProbabilityCM = [1, 2, 2, 3, 3, 3, 3, 4, 4, 4]; //1:10%, 2:20%, 3:40%, 4:30%
    uint8[] private victoryProbabilityRare = [1, 2, 2, 2, 3, 3, 3, 3, 4, 4];
    uint8[] private victoryProbabilityEpic = [1, 1, 2, 2, 3, 3, 3, 3, 4, 4];

    modifier ownerOf(uint256 _productId) {
        require(msg.sender == carToOwner[_productId]);
        _;
    }

    function tukracers(uint256 _productId) public ownerOf(_productId) {
        Car storage mycar = cars[_productId];
        uint256 rand = _randomNumber() % 10;
        uint256 rankCm = victoryProbabilityCM[rand];
        uint256 rankRare = victoryProbabilityRare[rand];
        uint256 rankEpic = victoryProbabilityEpic[rand];
        if (_compareStrings(mycar.cartype, "common")) {
            _createReward(
                _productId,
                true,
                5 + rankCm,
                100,
                rankCm,
                block.timestamp
            ); //pd_id, _isAuto, coin, exp, rank
        } else if (_compareStrings(mycar.cartype, "rare")) {
            _createReward(
                _productId,
                true,
                7 + rankRare,
                100,
                rankRare,
                block.timestamp
            );
        } else {
            //epic
            _createReward(
                _productId,
                true,
                9 + rankEpic,
                100,
                rankEpic,
                block.timestamp
            );
        }
    }

    function getCarByOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](ownerCarCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < cars.length; i++) {
            if (carToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }
}
