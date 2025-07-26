#[test_only] // This module is only compiled for tests
module coin::davidxm_tests; // Define the test module for davidxm

use coin::davidxm::{Self, DAVIDXM}; // Import the davidxm module and DAVIDXM struct
use sui::coin::{TreasuryCap}; // Import TreasuryCap from sui::coin
use sui::test_scenario::{Self, next_tx, ctx}; // Import test scenario utilities

#[test] // Mark this function as a test
fun init_and_mint() { // Test function to initialize and mint DAVIDXM coins
    let addr1 = @0xA; // Mock sender address

    let mut scenario = test_scenario::begin(addr1); // Start a new test scenario with addr1

  
    next_tx(&mut scenario, addr1); // Advance to the next transaction in the scenario
    {
        let mut treasurycap = test_scenario::take_from_sender<TreasuryCap<DAVIDXM>>(&scenario); // Retrieve TreasuryCap<DAVIDXM> from sender
        davidxm::mint(&mut treasurycap, 1000000_00000000, addr1, ctx(&mut scenario)); // Mint 1,000,000 DAVIDXM (with 8 decimals) to addr1

        test_scenario::return_to_address<TreasuryCap<DAVIDXM>>(addr1, treasurycap); // Return TreasuryCap to sender
    };

    test_scenario::end(scenario); // End and clean up the scenario
}
