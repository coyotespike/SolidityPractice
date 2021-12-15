pragma solidity ^0.8.0;
// "SPDX-License-Identifier: UNLICENSED

import "hardhat/console.sol";

import "./Greeter.sol";

contract MoreExamples is SolidityByExample {
    function changeMyNumber(uint _number) public returns (uint) {
        setMyNumber(_number);

        // Will be `0` if the sender hasn't called `setMyNumber` yet
        return favoriteNumber[msg.sender];
    }

    struct DanceMove {
        string name;
        uint energyLevel;
    }

    DanceMove[] public danceMoves;

    function addDanceMoves() public {
        danceMoves.push(DanceMove("twist", 5));
        danceMoves.push(DanceMove("shuffle", 10));
    }

    function changeOneDanceMove(uint _length) public {
        require(danceMoves.length == _length);

        DanceMove storage twistMove = danceMoves[0];
        // increment by 1
        twistMove.energyLevel = 6;

        DanceMove memory shuffleMove = danceMoves[1];
        shuffleMove.energyLevel = 25;
    }

    function getDanceMove (uint _index) public view returns (DanceMove memory) {
        require(danceMoves.length > 0);
        return danceMoves[_index];
    }
}
