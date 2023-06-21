// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Script } from"../lib/forge-std/src/Script.sol";
import { SimpleStorage } from "../src/SimpleStorage.sol";


contract DeploySimplestorage is Script {

    function run() external returns(SimpleStorage) {

        //Everything between start and stop broadcast qill be send to the RPC for BC transaction
        vm.startBroadcast();
        SimpleStorage simpleStorage = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}