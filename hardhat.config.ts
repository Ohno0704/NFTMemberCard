import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-chai-matchers";

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  typechain: {
    outDir: "frontend/types",
    target: "ethers-v6",
    alwaysGenerateOverloads: false,
    // コントラクトにおける関数のオーバーロードがない場合でも"deposit(uint256)のようなシグネチャを生成するか
    // externalArtifacts: ["externalArtifacts/*.json"],
    // Typeファイルの生成に追加したい外部のArtifactsがある場合は指定する
  }
};

export default config;
