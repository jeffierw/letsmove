
/// Module: my_nft
module my_nft::my_nft;
use std::string;
use std::string::String;
use sui::object;
use sui::transfer::transfer;
use sui::tx_context::sender;

use sui::display;
use sui::package;

public struct MyNFT has key,store {
    id:UID,
    name:String,
    image_url:String,
}

public struct MY_NFT has drop {}

fun init(otw: MY_NFT, ctx: &mut TxContext){

    let keys = vector[
        b"name".to_string(),
        b"link".to_string(),
        b"image_url".to_string(),
        b"description".to_string(),
        b"project_url".to_string(),
        b"creator".to_string(),
    ];

    let values = vector[
        // For `name` one can use the `Hero.name` property
        b"{name}".to_string(),
        // For `link` one can build a URL using an `id` property
        b"https://query.by.id/{id}".to_string(),
        // For `image_url` use an IPFS template + `image_url` property.
        b"{image_url}".to_string(),
        // Description is static for all `Hero` objects.
        b"A nft by zhtkeepup on Sui!".to_string(),
        // Project URL is usually static
        b"https://zhtkeepup.io".to_string(),
        // Creator field can be any
        b"Unknown Sui Fan".to_string(),
    ];


    // Claim the `Publisher` for the package!
    let publisher = package::claim(otw, ctx);

    // Get a new `Display` object for the `Hero` type.
    let mut display = display::new_with_fields<MyNFT>(
        &publisher, keys, values, ctx
    );

    // Commit first version of `Display` to apply changes.
    display.update_version();

    transfer::public_transfer(publisher, ctx.sender());
    transfer::public_transfer(display, ctx.sender());


    let nft = MyNFT{
        id: object::new(ctx),
        name : string::utf8(b"zhtkeepup ntf"),
        image_url:string::utf8(b"https://avatars.githubusercontent.com/u/166729445?v=4&size=64"),
    };
    transfer(nft, sender(ctx));
}


public entry fun mint(name:String, ctx: &mut TxContext){
    let my_nft = MyNFT{
        id:object::new(ctx),
        name:name,
        image_url:b"https://avatars.githubusercontent.com/u/166729445?v=4&size=64".to_string(),
    };
    transfer(my_nft, sender(ctx));
}

public entry fun mint2(name:String, recipient:address, ctx: &mut TxContext){
    let my_nft = MyNFT{
        id:object::new(ctx),
        name:name,
        image_url:b"https://avatars.githubusercontent.com/u/166729445?v=4&size=64".to_string(),
    };
    transfer(my_nft, recipient);
}