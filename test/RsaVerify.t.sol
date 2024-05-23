// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/RsaVerify.sol";
import "../src/RsaVerifyOptimized.sol";

import "./FIPS186_2.sol";
import "./FIPS186_4.sol";
import "./OpenSSL.sol";
import "./RFC8017.sol";

contract RsaVerifyTest is Test {
    function test_suites(function(bytes memory, bytes memory, bytes memory, bytes memory) returns (bool) _verifier)
        internal
    {
        {
            VectorTest[] memory vt = new FIPS186_2().suite();
            for (uint256 i = 0; i < vt.length; i++) {
                assertEq(_verifier(vt[i].Msg, vt[i].S, vt[i].e, vt[i].n), vt[i].pass);
            }
        }
        {
            VectorTest[] memory vt = new FIPS186_4().suite();
            for (uint256 i = 0; i < vt.length; i++) {
                assertEq(_verifier(vt[i].Msg, vt[i].S, vt[i].e, vt[i].n), vt[i].pass);
            }
        }
        {
            VectorTest[] memory vt = new OpenSSL().suite();
            for (uint256 i = 0; i < vt.length; i++) {
                assertEq(_verifier(vt[i].Msg, vt[i].S, vt[i].e, vt[i].n), vt[i].pass);
            }
        }
        {
            VectorTest[] memory vt = new RFC8017().suite();
            for (uint256 i = 0; i < vt.length; i++) {
                assertEq(_verifier(vt[i].Msg, vt[i].S, vt[i].e, vt[i].n), vt[i].pass);
            }
        }
    }

    function pkcs1Sha256Raw_original(bytes memory Msg, bytes memory S, bytes memory e, bytes memory n)
        internal
        view
        returns (bool)
    {
        return RsaVerify.pkcs1Sha256Raw(Msg, S, e, n);
    }

    function pkcs1Sha256Raw_optimized(bytes memory Msg, bytes memory S, bytes memory e, bytes memory n)
        internal
        view
        returns (bool)
    {
        return RsaVerifyOptimized.pkcs1Sha256Raw(Msg, S, e, n);
    }

    function test_suites_original() public {
        test_suites(pkcs1Sha256Raw_original);
    }

    function test_suites_optimized() public {
        test_suites(pkcs1Sha256Raw_optimized);
    }

    function test_gas_original() public {
        bytes memory e = hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000010001";

        bytes memory Msg = bytes("hello world");

        bytes memory S = hex"079bed733b48d69bdb03076cb17d9809072a5a765460bc72072d687dba492afe"
            hex"951d75b814f561f253ee5cc0f3d703b6eab5b5df635b03a5437c0a5c17930981"
            hex"2f5b5c97650361c645bc99f806054de21eb187bc0a704ed38d3d4c2871a117c1"
            hex"9b6da7e9a3d808481c46b22652d15b899ad3792da5419e50ee38759560002388";

        bytes memory n = hex"DF3EDDE009B96BC5B03B48BD73FE70A3AD20EAF624D0DC1BA121A45CC7398937"
            hex"41B7CF82ACF1C91573EC8266538997C6699760148DE57E54983191ECA0176F51"
            hex"8E547B85FE0BB7D9E150DF19EEE734CF5338219C7F8F7B13B39F5384179F62C1"
            hex"35E544CB70BE7505751F34568E06981095AEEC4F3A887639718A3E11D48C240D";

        assertEq(RsaVerify.pkcs1Sha256Raw(Msg, S, e, n), true);
    }

    function test_gas_optimized() public {
        bytes memory e = hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000000000"
            hex"0000000000000000000000000000000000000000000000000000000000010001";

        bytes memory Msg = bytes("hello world");

        bytes memory S = hex"079bed733b48d69bdb03076cb17d9809072a5a765460bc72072d687dba492afe"
            hex"951d75b814f561f253ee5cc0f3d703b6eab5b5df635b03a5437c0a5c17930981"
            hex"2f5b5c97650361c645bc99f806054de21eb187bc0a704ed38d3d4c2871a117c1"
            hex"9b6da7e9a3d808481c46b22652d15b899ad3792da5419e50ee38759560002388";

        bytes memory n = hex"DF3EDDE009B96BC5B03B48BD73FE70A3AD20EAF624D0DC1BA121A45CC7398937"
            hex"41B7CF82ACF1C91573EC8266538997C6699760148DE57E54983191ECA0176F51"
            hex"8E547B85FE0BB7D9E150DF19EEE734CF5338219C7F8F7B13B39F5384179F62C1"
            hex"35E544CB70BE7505751F34568E06981095AEEC4F3A887639718A3E11D48C240D";

        assertEq(RsaVerifyOptimized.pkcs1Sha256Raw(Msg, S, e, n), true);
    }
}
