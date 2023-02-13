// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library TransferHelper {
    function safeTransferEth(address _to, uint256 _amount) external returns (bool success) {
        (success, ) = payable(_to).call{value: _amount}("");
        require(success, "TF");
    }

    function safeTransferEth(address token, address to, uint256 value) internal {
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(IERC20.transfer.selector, to, value)
        );
        require(success && (data.length == 0 || abi.decode(data, (bool))), "TF");
    }
}
