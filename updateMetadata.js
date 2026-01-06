import { Connection, Keypair, PublicKey } from "@solana/web3.js";
import { programs, actions } from "@metaplex-foundation/js";
import fs from "fs";

const connection = new Connection("https://api.mainnet-beta.solana.com");
const walletKeypair = Keypair.fromSecretKey(
  Uint8Array.from(JSON.parse(fs.readFileSync("wallet-keypair.json")))
);
const mintPubkey = new PublicKey("BYqHJvvtJSgXQi9iuL6PcXmVNADqBDxNGkyAhY8zwTWR");
const metadataUri = "https://raw.githubusercontent.com/BetterhavemyMonet/Libratoken/main/metadata.json";

(async () => {
  try {
    const { metadata: { Metadata } } = programs;
    const metadataPDA = await Metadata.getPDA(mintPubkey);
    await actions.updateMetadata(
      { connection, wallet: walletKeypair },
      {
        metadata: metadataPDA,
        updateAuthority: walletKeypair.publicKey,
        data: {
          name: "Libra",
          symbol: "LIBRA",
          uri: metadataUri,
          sellerFeeBasisPoints: 0
        }
      }
    );
    console.log("✅ Metadata updated on-chain!");
  } catch (err) {
    console.error("❌ Error updating metadata:", err);
  }
})();
