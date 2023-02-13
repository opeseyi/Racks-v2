// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./interfaces/racks/IRacksFactory.sol";
import "./interfaces/racks/IRacksLogic.sol";

contract RacksFactory is IRacksFactory {
    struct Stakes {
        address owner;
        uint256 amountOfEth;
        address tokenAddress;
        uint256 amountOfToken;
        address nftAddress;
        uint256 tokenId;
    }

    mapping(uint256 => Stakes) stakesPosition;

    function stakes(StakesParams calldata params) external payable returns (uint256) {
        require(msg.value != 0, "PF");

        (bool isSuccessful, ) = payable(address(this)).call{value: msg.value}("");
        require(isSuccessful, "TF");

        // emit ethStacked(msg.sender, msg.value);

        // GetTokenParams({tokenAddress: params.tokenAddress, amountOfToken: params.tokenAmount});

        (bool success, ) = IRacksLogic.delegatecall(
            abi.encodeWithSelector(
                IRacksLogic.getTokens.selector,
                params.tokenAdress,
                params.tokenAmount
            )
        );
    }
}
