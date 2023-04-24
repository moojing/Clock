// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Clock} from "../src/Clock.sol";
import {BasicProxy} from "../src/BasicProxy.sol";
import {BasicProxyV2} from "../src/BasicProxyV2.sol";

contract ProxyTest is Test {
    Clock public clock;
    BasicProxy public proxy;
    BasicProxyV2 public proxyV2;
    uint256 public alarm1Time;

    function setUp() public {
        address user1 = vm.addr(3);
        // 1. set up clock with custom time
        // alarm1Time =
        clock = new Clock();
    }

    function testProxy() public {
        // 2. set up proxy with clock
        proxy = new BasicProxy(address(clock));

        (bool success, ) = address(proxy).call(
            abi.encodeWithSignature("getTimestamp()")
        );
        assertTrue(success);
    }

    function testProxyWithTimeStamp() public {
        // 2. set up proxy with clock
        proxy = new BasicProxy(address(clock));

        // method(with clock interface)  -> proxy -> delegate call -> Clock

        Clock proxyClock = Clock(address(proxy));
        proxyClock.getTimestamp();
        assertEq(block.timestamp, proxyClock.getTimestamp());
    }

    function testProxyWithAlarm1() public {
        proxy = new BasicProxy(address(clock));
        Clock proxyClock = Clock(address(proxy));
        proxyClock.setAlarm1(1234567890);
        assertEq(1234567890, proxyClock.alarm1());
    }

    function testProxyWithUpgrade() public {
        proxyV2 = new BasicProxyV2(address(clock));
        Clock proxyClock = Clock(address(proxyV2));

        // Clock clock2 = new Clock();
        // proxyV2.upgradeTo(address(clock2));

        Clock clock3 = new Clock();
        proxyV2.upgradeToAndCall(
            address(clock3),
            abi.encodeWithSignature("initialize(uint256)", 1234567890)
        );
        console.logUint(proxyClock.alarm1());
        //assertEq(1234567890, proxyClock.alarm1());
    }
}
