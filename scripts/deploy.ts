import { ethers } from "hardhat";

async function main() {
  const MyERC20 = await ethers.deployContract("MyERC20");
  MyERC20.waitForDeployment();

  console.log(`NFT_Member_Card deployed to: ${MyERC20.target}`);

  // NFT Contractをデプロイする
  const myERC721 = await ethers.deployContract("MyERC721", ['MyERC721', 'MYERC721']);
  await myERC721.waitForDeployment();

  console.log(`myERC721 deployed to: ${myERC721.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});