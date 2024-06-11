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
      {
        version: "0.8.9",
        settings: {},
      },
    ],
  },

  networks: {
    OP_sepolia: {
      url: "https://sepolia.optimism.io",
      accounts: [PRIVATE_KEY as string],
    },
  },
};

export default config;
