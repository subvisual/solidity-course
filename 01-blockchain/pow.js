const sha256 = require("crypto").createHash("sha256");

const [, , nonce] = process.argv;

block = {
  previousBlockHash: 0x123123123,
  blockNumber: NONCE,
  nonce: nonce,
  transactions: [
    {
      from: "alice",
      to: "bob",
      amount: 1,
    },
    {
      from: "bob",
      to: "charlie",
      amount: 0.5,
    },
  ],
};

const hash = sha256.update(JSON.stringify(block)).digest("hex");

console.log(hash);
