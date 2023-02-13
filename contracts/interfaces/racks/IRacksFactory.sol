// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IRacksFactory {
    struct StakesParams {
        address tokenAdress;
        uint256 tokenAmount;
        address nftAddress;
        uint256 tokenId;
    }

    function stakes(StakesParams calldata params) external payable returns (uint256);

    function createGame() external returns (address);
}
