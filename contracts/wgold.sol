// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

// "Scarcity Game website: https://scarcity.game"

interface scarcity_interface {
    function next_summoner() external returns (uint);
    function summon(uint _class) external;
}
interface scarcity_gold_interface {
    function transfer(uint from, uint to, uint amount) external returns (bool);
    function transferFrom(uint executor, uint from, uint to, uint amount) external returns (bool);
}

/// @title Wrapped Scarcity Gold. Scarcity Game website: https://scarcity.game
/// @dev Make Scarcity Gold ERC-20 compatible with ERC20 to make it usable with existing DeFi tools such as Uniswap-like DEXes.
/// @author swit.eth / https://twitter.com/nomorebear
contract wrapped_scarcity_gold is ERC20('Wrapped Scarcity Gold', 'WSGOLD') {
    uint public immutable SUMMMONER_ID;
    scarcity_interface public immutable scarcity;
    scarcity_gold_interface public immutable gold;

    constructor(scarcity_interface _scarcity, scarcity_gold_interface _gold) {
        SUMMMONER_ID = _scarcity.next_summoner();
        _scarcity.summon(11);

        scarcity = _scarcity;
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