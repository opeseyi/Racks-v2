// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./interfaces/racks/IRacksLogic.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract RacksLogic is IRacksLogic {
    constructor() {}

    receive() external payable {
        (bool success, ) = payable(msg.sender).call{value: msg.value}("");
        require(success, "TF");
    }

    function getEth() external payable returns (bool isSuccessful) {
        require(msg.value != 0, "PF");

        (isSuccessful, ) = payable(address(this)).call{value: msg.value}("");
        require(isSuccessful, "TF");

        emit ethStacked(msg.sender, msg.value);
    }

    function getTokens(GetTokenParams calldata params) external returns (bool isSuccessful) {
        require(params.tokenAddress != address(0), "!Address");
        require(params.amountOfToken != 0, "!Amount");

        isSuccessful = IERC20(params.tokenAddress).transferFrom(
            msg.sender,
            address(this),
            params.amountOfToken
        );
        require(isSuccessful, "TF");

        emit tokenStacked(msg.sender, params.tokenAddress, params.amountOfToken);
    }

    function getNft(GetNftParams calldata params) external returns (bool isSuccessful) {
        require(params.NftAddress != address(0), "!Address");
        require(params.tokenId != 0, "!TokenId");

        IERC721(params.NftAddress).safeTransferFrom(msg.sender, address(this), params.tokenId);
        isSuccessful = true;
        emit nftStaked(msg.sender, params.NftAddress, params.tokenId);
    }
}
