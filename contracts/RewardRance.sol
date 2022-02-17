//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "./Tuktukfactory.sol";

contract RewardRance is Tuktukfactory {
    event NewReward(
        uint256 _rewardsId,
        uint256 _productId,
        bool _type_play,
        uint256 _coin,
        uint256 _exp,
        uint256 _position,
        uint256 _create_at
    );

    struct Reward {
        uint256 productId;
        bool isAutoPlay;
        uint256 coin;
        uint256 exp;
        uint256 position;
        uint256 create_at;
        bool isClaim;
    }

    Reward[] public rewards;

    mapping(uint256 => address) public rewardToOwner;
    mapping(address => uint256) ownerRewardCount;
    uint256  rewardsId;

    function _createReward(
        uint256 _productId,
        bool _isAutoPlay,
        uint256 _coin,
        uint256 _exp,
        uint256 _position,
        uint256 _create_at
    ) internal {
        rewards.push(
            Reward(
                _productId,
                _isAutoPlay,
                _coin,
                _exp,
                _position,
                _create_at,
                false
            )
        );
        rewardsId = rewards.length;
        rewardToOwner[rewardsId - 1] = msg.sender;
        ownerRewardCount[msg.sender]++;
        emit NewReward(
            rewardsId,
            _productId,
            _isAutoPlay,
            _coin,
            _exp,
            _position,
            _create_at
        );
    }

    function getRewardCoinByOwner(address _owner)
        external
        view
        returns (uint256)
    {
        uint256 coins = 0;
        for (uint256 i = 0; i < rewards.length; i++) {
            if (rewardToOwner[i] == _owner) {
                coins +=  rewards[i].coin;
            }
        }
        return coins;
    }
}
