// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

// "Rarity 2 Game website: https://rarity.game"

interface rarity_interface {
    function next_summoner() external returns (uint);
    function summon(uint _class) external;
}
interface rarity_gold_interface {
    function transfer(uint from, uint to, uint amount) external returns (bool);
    function transferFrom(uint executor, uint from, uint to, uint amount) external returns (bool);
}

/// @title Wrapped Rarity 2 Gold. Rarity 2 Game website: https://rarity.game
/// @dev Make Rarity 2 Gold ERC-20 compatible with ERC20 to make it usable with existing DeFi tools such as Uniswap-like DEXes.
/// @author swit.eth / https://twitter.com/nomorebear
contract wrapped_rarity_gold is ERC20('Wrapped Rarity 2 Gold', 'WRGGOLD') {
    uint public immutable SUMMMONER_ID;
    rarity_interface public immutable rarity;
    rarity_gold_interface public immutable gold;

    constructor(rarity_interface _rarity, rarity_gold_interface _gold) {
        SUMMMONER_ID = _rarity.next_summoner();
        _rarity.summon(11);

        rarity = _rarity;
        gold = _gold;
    }

    function deposit(uint from, uint amount) external {
        require(from != SUMMMONER_ID, '!from');
        require(gold.transferFrom(SUMMMONER_ID, from, SUMMMONER_ID, amount), '!transferFrom');
        _mint(msg.sender, amount);
    }

    function withdraw(uint to, uint amount) external {
        require(to != SUMMMONER_ID, '!to');
        _burn(msg.sender, amount);
        require(gold.transfer(SUMMMONER_ID, to, amount), '!transfer');
    }
}