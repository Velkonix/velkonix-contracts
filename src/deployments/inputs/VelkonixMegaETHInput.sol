// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './MarketInput.sol';

contract VelkonixMegaETHInput is MarketInput {
  address private constant MEGAETH_WETH = 0x4200000000000000000000000000000000000006;

  address private constant MEGAETH_ETH_USD_PRICE_FEED = 0xcA4e254D95637DE95E2a2F79244b03380d697feD;

  address private constant MEGAETH_SEQUENCER_UPTIME_FEED = 0x78B2195A21B8BBe82acaB43F90F9180E9513FD0C;

  uint256 private constant GRACE_PERIOD = 3600;

  function _getMarketInput(
    address deployer
  )
    internal
    pure
    override
    returns (
      Roles memory roles,
      MarketConfig memory config,
      DeployFlags memory flags,
      MarketReport memory deployedContracts
    )
  {
    roles.marketOwner = deployer;
    roles.emergencyAdmin = deployer;
    roles.poolAdmin = deployer;

    config.marketId = 'Velkonix';
    config.providerId = 4326;
    config.oracleDecimals = 8;
    config.flashLoanPremium = 0.0005e4;

    config.wrappedNativeToken = MEGAETH_WETH;
    config.networkBaseTokenPriceInUsdProxyAggregator = MEGAETH_ETH_USD_PRICE_FEED;
    config.marketReferenceCurrencyPriceInUsdProxyAggregator = MEGAETH_ETH_USD_PRICE_FEED;

    config.l2SequencerUptimeFeed = MEGAETH_SEQUENCER_UPTIME_FEED;
    config.l2PriceOracleSentinelGracePeriod = GRACE_PERIOD;

    flags.l2 = true;

    return (roles, config, flags, deployedContracts);
  }
}
