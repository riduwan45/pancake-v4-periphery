// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {IV4Router} from "../../interfaces/IV4Router.sol";
import {CalldataDecoder} from "../../libraries/CalldataDecoder.sol";
import {PoolKey} from "pancake-v4-core/src/types/PoolKey.sol";

/// @title Library for abi decoding in cl pool calldata
library CLCalldataDecoder {
    using CalldataDecoder for bytes;

    /// @dev equivalent to: abi.decode(params, (IV4Router.CLExactInputParams))
    function decodeCLSwapExactInParams(bytes calldata params)
        internal
        pure
        returns (IV4Router.CLSwapExactInputParams calldata swapParams)
    {
        // CLExactInputParams is a variable length struct so we just have to look up its location
        assembly ("memory-safe") {
            swapParams := add(params.offset, calldataload(params.offset))
        }
    }

    /// @dev equivalent to: abi.decode(params, (IV4Router.CLExactInputSingleParams))
    function decodeCLSwapExactInSingleParams(bytes calldata params)
        internal
        pure
        returns (IV4Router.CLSwapExactInputSingleParams calldata swapParams)
    {
        // CLExactInputSingleParams is a variable length struct so we just have to look up its location
        assembly ("memory-safe") {
            swapParams := add(params.offset, calldataload(params.offset))
        }
    }

    /// @dev equivalent to: abi.decode(params, (IV4Router.CLExactOutputParams))
    function decodeCLSwapExactOutParams(bytes calldata params)
        internal
        pure
        returns (IV4Router.CLSwapExactOutputParams calldata swapParams)
    {
        // CLExactOutputParams is a variable length struct so we just have to look up its location
        assembly ("memory-safe") {
            swapParams := add(params.offset, calldataload(params.offset))
        }
    }

    /// @dev equivalent to: abi.decode(params, (IV4Router.CLExactOutputSingleParams))
    function decodeCLSwapExactOutSingleParams(bytes calldata params)
        internal
        pure
        returns (IV4Router.CLSwapExactOutputSingleParams calldata swapParams)
    {
        // CLExactOutputSingleParams is a variable length struct so we just have to look up its location
        assembly ("memory-safe") {
            swapParams := add(params.offset, calldataload(params.offset))
        }
    }

    /// @dev equivalent to: abi.decode(params, (uint256, uint256, uint128, uint128, bytes)) in calldata
    function decodeCLModifyLiquidityParams(bytes calldata params)
        internal
        pure
        returns (uint256 tokenId, uint256 liquidity, uint128 amount0, uint128 amount1, bytes calldata hookData)
    {
        assembly ("memory-safe") {
            tokenId := calldataload(params.offset)
            liquidity := calldataload(add(params.offset, 0x20))
            amount0 := calldataload(add(params.offset, 0x40))
            amount1 := calldataload(add(params.offset, 0x60))
        }
        hookData = params.toBytes(4);
    }

    /// @dev equivalent to: abi.decode(params, (PoolKey, int24, int24, uint256, uint128, uint128, address, bytes)) in calldata
    function decodeCLMintParams(bytes calldata params)
        internal
        pure
        returns (
            PoolKey calldata poolKey,
            int24 tickLower,
            int24 tickUpper,
            uint256 liquidity,
            uint128 amount0Max,
            uint128 amount1Max,
            address owner,
            bytes calldata hookData
        )
    {
        assembly ("memory-safe") {
            poolKey := params.offset
            tickLower := calldataload(add(params.offset, 0xc0))
            tickUpper := calldataload(add(params.offset, 0xe0))
            liquidity := calldataload(add(params.offset, 0x100))
            amount0Max := calldataload(add(params.offset, 0x120))
            amount1Max := calldataload(add(params.offset, 0x140))
            owner := calldataload(add(params.offset, 0x160))
        }
        hookData = params.toBytes(12);
    }

    /// @dev equivalent to: abi.decode(params, (uint256, uint128, uint128, bytes)) in calldata
    function decodeCLBurnParams(bytes calldata params)
        internal
        pure
        returns (uint256 tokenId, uint128 amount0Min, uint128 amount1Min, bytes calldata hookData)
    {
        assembly ("memory-safe") {
            tokenId := calldataload(params.offset)
            amount0Min := calldataload(add(params.offset, 0x20))
            amount1Min := calldataload(add(params.offset, 0x40))
        }
        hookData = params.toBytes(3);
    }
}
