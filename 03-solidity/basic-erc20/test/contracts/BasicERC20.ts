import chai from "chai";
import { ethers, network, waffle } from "hardhat";
import { solidity } from "ethereum-waffle";

chai.use(solidity);
const { BigNumber: BN } = ethers;
const { parseEther } = ethers.utils;
const { expect } = chai;
const { deployContract: deploy } = waffle;

import { BasicErc20 } from "../../typechain/BasicErc20";
import BasicERC20Artifact from "../../artifacts/contracts/BasicERC20.sol/BasicERC20.json";

let signers;
let owner: any;
let alice: any;
let bob: any;
let token: BasicErc20;

describe("BasicERC20", () => {
  it("works", async () => {
    signers = await ethers.getSigners();
    owner = signers[0];

    token = (await deploy(owner, BasicERC20Artifact, [
      "Cesium Coin",
      "CSC",
    ])) as BasicErc20;

    expect(await token.name()).to.eq("Cesium Coin");
    expect(await token.symbol()).to.eq("CSC");
    expect(await token.balanceOf(await owner.getAddress())).to.eq(
      parseEther("10000000")
    );
  });

  describe("functions", () => {
    beforeEach(async () => {
      signers = await ethers.getSigners();
      owner = signers[0];
      alice = signers[1];
      bob = signers[2];

      token = (await deploy(owner, BasicERC20Artifact, [
        "Cesium Coin",
        "CSC",
      ])) as BasicErc20;
    });

    it("can transfer", async () => {
      await token.transfer(await alice.getAddress(), 1);

      const aliceBalance = await token.balanceOf(await alice.getAddress());
      expect(aliceBalance).to.eq(1);

      await token.connect(alice).transfer(await bob.getAddress(), 1);

      const newAliceBalance = await token.balanceOf(await alice.getAddress());
      expect(newAliceBalance).to.eq(0);

      const bobBalance = await token.balanceOf(await bob.getAddress());
      expect(bobBalance).to.eq(1);
    });

    it("only owner can burn", async () => {
      await token.connect(owner).burn(await owner.getAddress(), 1);

      await token.connect(alice).burn(await owner.getAddress(), 1);
    });
  });
});
