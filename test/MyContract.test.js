const { expect } = require("chai");
const { ethers } = require("hardhat");
const imageToBase64 = require('image-to-base64');

// describe("MyContract", () => {
//     it("should return its name", async () => {
//         const MyContract = await ethers.getContractFactory("MyContract");
//         const myContract = await MyContract.deploy("My Contract");

//         await myContract.deployed();
//         expect(await myContract.getName()).to.equal("My Contract");
//     });

//     it("should change its name when requested", async () => {
//         const MyContract = await ethers.getContractFactory("MyContract");
//         const myContract = await MyContract.deploy("My Contract");

//         await myContract.changeName("Another Contract");
//         expect(await myContract.getName()).to.equal("Another Contract");
//     })
// })

const img_base = imageToBase64("scripts/1.png");
img_base.then(function(result) {
    console.log(result) // "Some User token"
 })
describe("Tuktukfactory", () => {
    it("Create car", async () => {
        const Tuktukfactory = await ethers.getContractFactory("Tuktukfactory");
        const tuktukfactory = await Tuktukfactory.deploy();

        // await tuktukfactory.deployed()
        await tuktukfactory.createRandomCar(img_base, "jone", "common", "s2-101", 1, 2, 15, 253, 31, 18);
        a = await tuktukfactory.getCar()
        console.log(a['name']);

    })
})