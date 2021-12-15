const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter and Examples \n", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });

  it("Should run the examples", async function () {
    const Examples = await ethers.getContractFactory("SolidityByExample");
    const example = await Examples.deploy();
    await example.deployed();

    const pushStringsTx = await example.pushIntoString();
    const setNumber = await example.setMyNumber(42);

    await pushStringsTx.wait();
    await setNumber.wait();

    expect(await example.bar()).to.equal("bye");
    expect(await example.whatIsMyNumber()).to.equal(42);
  });
});

describe("More Examples \n", function () {
  it("Should create a contract that inherits", async function () {
    const MoreExamples = await ethers.getContractFactory("MoreExamples");
    const example = await MoreExamples.deploy();
    await example.deployed();

    const setNumber = await example.changeMyNumber(42);

    await setNumber.wait();

    expect(await example.whatIsMyNumber()).to.equal(42);
  });

  it("Should use require and change an array once", async function () {
    const MoreExamples = await ethers.getContractFactory("MoreExamples");
    const example = await MoreExamples.deploy();
    await example.deployed();

    const addDanceMoves = await example.addDanceMoves();

    await addDanceMoves.wait();

    const struct = await example.danceMoves(0);
    expect(struct[0]).to.equal("twist");

    // if you don't put the await outside, then the revert catching won't work
    await expect(example.changeOneDanceMove(3)).to.be.reverted;

    await example.changeOneDanceMove(2);

    const twist = await example.getDanceMove(0);
    const shuffle = await example.getDanceMove(1);
    // changed because function initializes with storage
    expect(Number(twist[1])).to.equal(6);
    // not changed because function initializes with memory
    expect(Number(shuffle[1])).to.equal(10);
  });
});
