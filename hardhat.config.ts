import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const { PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.6.4",
      },
      {
        version: "0.8.4",
        settings: {},
      },
    ],
  },

  networks: {
    goerliOptimism: {
      url: "https://goerli.optimism.io",
      accounts: [PRIVATE_KEY as string],
      gasPrice: 1000000000,
    },
  },
};

export default config;
