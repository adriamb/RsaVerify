// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

struct VectorTest {
    bytes e;
    bytes Msg;
    bytes S;
    bytes n;
    bool pass;
}

interface Suite {
    function suite() external returns (VectorTest[] memory);
}
