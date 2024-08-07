export PACKAGE_ID=0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373
export MYCOIN_PACKAGE_ID=0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40
export FAUCET_PACKAGE_ID=0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c

export Alice=0x80229589c222b7b5bc233aaa6be39f139e55a6d55cfc9992cca799417679cfac
export Jason=0x8b10d8e3df15d246ba3249c233d057c0f32147dc600dc3336ece224cc8c193f8

# 创建pool
sui client call --function createPool --package $PACKAGE_ID --module simple_swap --type-args 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin::GUANGE2015COIN 0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c::guange2015FaucetCoin::GUANGE2015FAUCETCOIN

#得到PooL_ID
export POOL_ID=0x04bb64ebd8fa38cccee4ad9a19d0bdd4aec256f2ae9b77f9322e72ee67578c64

# 先mint token
sui client call --package $MYCOIN_PACKAGE_ID --module guange2015Coin --function mint --args 0xd46365397d455c362e129d72af5ccb788d457142ebd0bd4e53feb34ddac9d6ab $Jason 10000 --type-args 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin::GUANGE2015COIN
# object 0xb6132d4b7e99be249643127fff4b4dfecca0eceeff3e242259638c56b4d317b1
sui client call --package $MYCOIN_PACKAGE_ID --module guange2015Coin --function mint --args 0xd46365397d455c362e129d72af5ccb788d457142ebd0bd4e53feb34ddac9d6ab $Alice 100 --type-args 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin::GUANGE2015COIN
# object 0x1a9b54d07ee5196f7a0b4bce5949c915abb95d3686ca38ecdc2a068d63fd3e85

sui client call --package $FAUCET_PACKAGE_ID --module guange2015FaucetCoin --function mint --args 0xbf66cdee06dd4cd03aaab51d3370302d64d1e997f48775f770bdb84223ca6f97 10000 --type-args 0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c::guange2015FaucetCoin::GUANGE2015FAUCETCOIN
# 0x3996b8954a58c483a1f59c3f288e110e819f438308b0917ccf637423ff864eb9

# 添加流动性
sui client call --function addLiq --package $PACKAGE_ID --module simple_swap --type-args 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin::GUANGE2015COIN 0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c::guange2015FaucetCoin::GUANGE2015FAUCETCOIN \
--args $POOL_ID 0xb6132d4b7e99be249643127fff4b4dfecca0eceeff3e242259638c56b4d317b1 0x3996b8954a58c483a1f59c3f288e110e819f438308b0917ccf637423ff864eb9


# 兑换

sui client switch --address $Alice
sui client call --function x_to_y --package $PACKAGE_ID --module simple_swap --type-args 0x2d58fc2549c7ed28392d1e663f700829a103efb9655ec8a0a133e4d699616d40::guange2015Coin::GUANGE2015COIN 0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c::guange2015FaucetCoin::GUANGE2015FAUCETCOIN \
--args $POOL_ID 0x1a9b54d07ee5196f7a0b4bce5949c915abb95d3686ca38ecdc2a068d63fd3e85

# 验证结果
# Alice下面多出了100个GUANGE2015FAUCETCOIN