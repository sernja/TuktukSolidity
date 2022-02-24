async function main() {
    const NFT = await ethers.getContractFactory("NFT");
    const nft = await MyContract.deploy("NFT");

    // console.log("My Contract deployed to:", myContract.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });