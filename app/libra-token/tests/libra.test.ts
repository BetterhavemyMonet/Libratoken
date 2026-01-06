import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import { Libra } from "../target/types/libra";
import { expect } from "chai";

describe("libra", () => {
  const provider = anchor.AnchorProvider.local();
  anchor.setProvider(provider);

  const program = anchor.workspace.Libra as Program<Libra>;

  it("Initializes Libra token program!", async () => {
    const tx = await program.methods.initialize().rpc();
    console.log("Transaction signature", tx);
    expect(tx).to.be.a("string");
  });
});
