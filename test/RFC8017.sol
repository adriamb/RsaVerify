// SPDX-License-Identifier: UNLICENSED

/*
    According to RFC4055, pg.5 and RFC8017, pg. 64, for SHA-1, and the SHA-2 family,
    the algorithm parameter has to be NULL and both explicit NULL parameter and implicit
    NULL parameter (ie, absent NULL parameter) are considered to be legal and equivalent.

    Reported by @yahyazadeh Daniel Yahyazadeh
*/

pragma solidity ^0.8.13;

import "./Suite.sol";

contract RFC8017 is Suite {
    function suite() public pure returns (VectorTest[] memory) {
        VectorTest[] memory vt = new VectorTest[](1);
        uint256 i = 0;
        vt[i++] = test_rfc8017_implicit_null_parameter();
        return vt;
    }

    function test_rfc8017_implicit_null_parameter() internal pure returns (VectorTest memory) {
        return VectorTest({
            n: hex"E932AC92252F585B3A80A4DD76A897C8B7652952FE788F6EC8DD640587A1EE56"
                hex"47670A8AD4C2BE0F9FA6E49C605ADF77B5174230AF7BD50E5D6D6D6D28CCF0A8"
                hex"86A514CC72E51D209CC772A52EF419F6A953F3135929588EBE9B351FCA61CED7"
                hex"8F346FE00DBB6306E5C2A4C6DFC3779AF85AB417371CF34D8387B9B30AE46D7A"
                hex"5FF5A655B8D8455F1B94AE736989D60A6F2FD5CADBFFBD504C5A756A2E6BB5CE"
                hex"CC13BCA7503F6DF8B52ACE5C410997E98809DB4DC30D943DE4E812A47553DCE5"
                hex"4844A78E36401D13F77DC650619FED88D8B3926E3D8E319C80C744779AC5D6AB"
                hex"E252896950917476ECE5E8FC27D5F053D6018D91B502C4787558A002B9283DA7",
            e: hex"03",
            Msg: "hello world!",
            S: hex"a0073057133ff3758e7e111b4d7441f1d8cbe4b2dd5ee4316a14264290dee5ed"
                hex"7f175716639bd9bb43a14e4f9fcb9e84dedd35e2205caac04828b2c053f68176"
                hex"d971ea88534dd2eeec903043c3469fc69c206b2a8694fd262488441ed8852280"
                hex"c3d4994e9d42bd1d575c7024095f1a20665925c2175e089c0d731471f6cc1454"
                hex"04edf5559fd2276e45e448086f71c78d0cc6628fad394a34e51e8c10bc39bfe0"
                hex"9ed2f5f742cc68bee899d0a41e4c75b7b80afd1c321d89ccd9fe8197c44624d9"
                hex"1cc935dfa48de3c201099b5b417be748aef29248527e8bbb173cab76b48478d4"
                hex"177b338fe1f1244e64d7d23f07add560d5ad50b68d6649a49d7bc3db686daaa7",
            pass: true
        });
    }
}
