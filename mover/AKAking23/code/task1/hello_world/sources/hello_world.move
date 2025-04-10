module hello_world::hello_world;

use std::ascii::{String, string};
use sui::object::{Self, UID};
use sui::transfer::transfer;
use sui::tx_context::TxContext;

public struct Hello has key {
    id: UID,
    say: String,
}

fun init(ctx: &mut TxContext) {
    let hello_world = Hello {
        id: object::new(ctx),
        say: string(b"AKAking23"),
    };
    transfer(hello_world, ctx.sender());
}
