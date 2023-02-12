// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IRacksLogic {
    event ethStacked(address indexed senderAddress, uint256 senderAmount);
    event tokenStacked(address indexed senderAddress, address tokenAddress, uint256 tokenAmount);
    event nftStaked(address indexed nftOwner, address indexed nftAddress, uint256 indexed tokenId);

    function getEth() external payable returns (bool isSuccessful);

    struct GetTokenParams {
        address tokenAddress;
        uint256 amountOfToken;
    }

    function getTokens(GetTokenParams calldata params) external returns (bool isSuccessful);

    struct GetNftParams {
        address NftAddress;
        uint256 tokenId;
    }

    function getNft(GetNftParams calldata params) external returns (bool isSuccessful);
}
