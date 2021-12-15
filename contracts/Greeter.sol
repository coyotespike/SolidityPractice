pragma solidity ^0.8.0;

// if you don't have this then hardhat or its compiler will complain at you
// "SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";

contract Greeter {
    // this gonna be a state variable, written to the blockchain
    // because it is not inside a function
    string private greeting;

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }

}

contract SolidityByExample {
    string[] strings;

    constructor(){
        console.log("The examples have now deployed");
    }
    function pushIntoString() public {
        strings.push("hi");
        strings.push("bye");
    }

    function bar() public view returns(string memory) {
        return strings[1];
    }

    mapping (address => uint) favoriteNumber;

    function setMyNumber(uint _myNumber) public {
        // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
        favoriteNumber[msg.sender] = _myNumber;
        // ^ The syntax for storing data in a mapping is just like with arrays
        console.log("Who am I? ", msg.sender);
    }

    function whatIsMyNumber() public view returns (uint) {
        // random demo of require()
        // no triple equals ===, and can't compare strings
        require(keccak256('hello') == keccak256('hello'));

        // Will be `0` if the sender hasn't called `setMyNumber` yet
        return favoriteNumber[msg.sender];
    }
}
