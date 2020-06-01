pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    // @TODO: Inherit the crowdsale contracts 

    constructor(
        uint rate,
        address payable wallet,
        PupperCoin token,
        uint coinCap,
        uint targetGoal,
        uint openingSalesTime,
        uint closingSalesTime
        
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        
        Crowdsale(rate, wallet, token) 
        MintedCrowdsale()
        CappedCrowdsale(coinCap)
        RefundableCrowdsale(targetGoal)
        TimedCrowdsale(openingSalesTime, closingSalesTime)
        
        
        public 
        {
            // LEAVE EMPTY ON PURPOSE
        }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;
    
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
        // @TODO: Fill in the constructor parameters!
    )
        public
    {
           // @TODO: create the PupperCoin and keep its address handy
        PupperCoin token = new PupperCoin(name, symbol, 1);
        token_address = address(token);

             // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
			 
			 // 999000000000000000000 == 999 TOKENS (Cap)
			 // 10000000000000000000 == 10 Tokens ( Goal )
			 
        PupperCoinSale pup_sale = new PupperCoinSale(1, wallet, token, 999000000000000000000, 10000000000000000000 ,now, now + 24 weeks);
        token_sale_address = address(pup_sale);
            // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}