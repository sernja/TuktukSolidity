async function main() {
    const NFT = await ethers.getContractFactory("Racers");
    const nft = await MyContract.deploy("Racers");

    console.log("My Contract deployed to:", myContract.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });