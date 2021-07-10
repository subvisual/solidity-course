import chai from "chai";
import { ethers, network, waffle } from "hardhat";
import { solidity } from "ethereum-waffle";

chai.use(solidity);
const { BigNumber: BN } = ethers;
const { parseEther } = ethers.utils;
const { expect } = chai;
const { deployContract: deploy } = waffle;

import { VulnerableBank } from "../../typechain/VulnerableBank";
import { Attacker } from "../../typechain/Attacker";
import VulnerableBankArtifact from "../../artifacts/contracts/Reentrancy.sol/VulnerableBank.json";
import AttackerArtifact from "../../artifacts/contracts/Reentrancy.sol/Attacker.json";

let signers;
let owner: any;
let alice: any;
let bob: any;
let charlie: any;
let bank: VulnerableBank;
let attacker: Attacker;

describe("Reentrancy", () => {
  beforeEach(async () => {
    signers = await ethers.getSigners();
    owner = signers[0];
    alice = signers[1];
    bob = signers[1];
    charlie = signers[1];

    bank = (await deploy(owner, VulnerableBankArtifact, [])) as VulnerableBank;
  });

  it("is vulnerable to a re-entrancy attack", async () => {
    attacker = (await deploy(alice, AttackerArtifact, [
      bank.address,
    ])) as Attacker;

    await bank.connect(bob).deposit({ value: parseEther("1") });
    await bank.connect(charlie).deposit({ value: parseEther("1") });

    const attackerBalanceBefore = await ethers.provider.getBalance(
      attacker.address
    );
    const bankBalanceBefore = await ethers.provider.getBalance(bank.address);

    await attacker.attack({ value: parseEther("1") });

    const attackerBalanceAfter = await ethers.provider.getBalance(
      attacker.address
    );
    const bankBalanceAfter = await ethers.provider.getBalance(bank.address);

    console.log(
      "attacker",
      attackerBalanceBefore.toString(),
      attackerBalanceAfter.toString()
    );
    console.log(
      "bank",
      bankBalanceBefore.toString(),
      bankBalanceAfter.toString()
    );
  });
});
