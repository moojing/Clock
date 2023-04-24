// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import { Test } from "forge-std/Test.sol";
import { Clock } from "../src/Clock.sol";
import { BasicProxy } from "../src/BasicProxy.sol";

contract ProxyTest is Test {

  Clock public clock;
  BasicProxy public proxy;
  uint256 public alarm1Time;

  function setUp() public {
    // 1. set up clock with custom time
    // alarm1Time = 
    // clock = new Clock();
    
  }

  function testProxy() public {

  }
}