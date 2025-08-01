module coin::davidxm; // Declare the module named davidxm in the coin package

use sui::coin::{Self, TreasuryCap}; // Import the sui::coin module and TreasuryCap type

public struct DAVIDXM has drop {} // Define a public struct DAVIDXM with the drop ability

fun init(witness: DAVIDXM, ctx: &mut TxContext) { // Module initializer, called on publish
    let multiplier = 100000000; // Set a multiplier for initial supply (10^8 for 8 decimals)
    let (mut treasury, metadata) = coin::create_currency( // Create a new currency, get treasury and metadata
        witness, // One-time witness for DAVIDXM
        8, // Number of decimals for the coin
        b"DXM", // Symbol for the coin
        b"davidxm", // Name of the coin
        b"davidxm on Sui", // Description of the coin
        option::none(), // No icon URL provided
        ctx // Transaction context
    );

    let initial_coins = coin::mint(&mut treasury, 300 * multiplier, ctx); // Mint 300 * 10^8 coins to treasury
    transfer::public_transfer(initial_coins, tx_context::sender(ctx)); // Transfer initial coins to publisher

    transfer::public_freeze_object(metadata); // Freeze metadata to make it immutable
    transfer::public_transfer(treasury, tx_context::sender(ctx)); // Transfer treasury cap to publisher
}



public fun mint( // Public function to mint new coins
    treasury_cap: &mut TreasuryCap<DAVIDXM>, // Mutable reference to the treasury cap
    amount: u64, // Amount to mint
    recipient: address, // Address to receive the minted coins
    ctx: &mut TxContext // Transaction context
) {
    let coin = coin::mint(treasury_cap, amount, ctx); // Mint the specified amount of coins
    transfer::public_transfer(coin, recipient); // Transfer minted coins to the recipient
}

