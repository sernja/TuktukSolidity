// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract StakingRewards {
    uint256[] private victoryProbabilityCM = [1, 2, 2, 3, 3, 3, 3, 4, 4, 4]; //1:10%, 2:20%, 3:40%, 4:30%
    uint256[] private victoryProbabilityRare = [1, 2, 2, 2, 3, 3, 3, 3, 4, 4];
    uint256[] private victoryProbabilityEpic = [1, 1, 2, 2, 3, 3, 3, 3, 4, 4];

    uint256 randNonce = 0;

    function randMod(uint256 _modulus) internal returns (uint256) {
        randNonce++;
        return
            uint256(keccak256(abi.encodePacked(randNonce, block.timestamp))) %
            _modulus;
    }

    function _compareStrings(string memory a, string memory b)
        internal
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    function getRewards(string memory str) public returns (uint256) {
        uint256 rand = randMod(10);
        if (_compareStrings(str, "common")) {
            return 5 + victoryProbabilityCM[rand];
        } else if (_compareStrings(str, "rare")) {
            return 7 + victoryProbabilityRare[rand];
        } else {
            //epic
            return 10 + victoryProbabilityEpic[rand];
        }
    }
}
