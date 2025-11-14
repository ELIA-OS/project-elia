# Migration Market Cap Formula (SOL-Denominated)

## Overview

This document explains the market cap migration formula used in Meteora's Dynamic Bonding Curve SDK for creating Pump.fun-style token launches with SOL-denominated pricing.

## Key Concept: SOL-Denominated Market Caps

Unlike traditional USD-pegged market caps, this approach denominates both the initial and migration market caps in **SOL**. This means:

- Market cap floats with SOL's USD price
- No need for oracle price feeds during configuration
- Simpler on-chain computation
- Natural alignment with Solana's native token economics

## Formula Components

### 1. Basic Market Cap Definition

```
Market Cap = Token Supply × Token Price
```

For a bonding curve with quote token (wSOL):

```
Market Cap (SOL) = Total Supply × Price per Token (in SOL)
```

### 2. Target Configuration

The configuration uses two key market cap targets:

| Parameter | Description | Example Value |
|-----------|-------------|---------------|
| `INITIAL_FDV_SOL` | Starting market cap in SOL | 28 SOL |
| `MIGRATION_FDV_SOL` | Migration threshold in SOL | 228 SOL |
| `TOTAL_SUPPLY` | Total token supply | 1,000,000,000 |

### 3. Price Calculation at Key Points

#### Initial Price (Launch)

```
Initial Price (SOL per token) = INITIAL_FDV_SOL / TOTAL_SUPPLY
```

**Example:**
```
Initial Price = 28 SOL / 1,000,000,000 tokens
             = 0.000000028 SOL per token
             = 28 lamports per token (since 1 SOL = 10^9 lamports)
```

#### Migration Price (Graduation to DAMM)

```
Migration Price (SOL per token) = MIGRATION_FDV_SOL / TOTAL_SUPPLY
```

**Example:**
```
Migration Price = 228 SOL / 1,000,000,000 tokens
               = 0.000000228 SOL per token
               = 228 lamports per token
```

### 4. Price Multiplier

The migration represents a price increase factor:

```
Price Multiplier = MIGRATION_FDV_SOL / INITIAL_FDV_SOL
```

**Example:**
```
Price Multiplier = 228 / 28 = 8.14×
```

This means the token price must increase **8.14 times** from launch to trigger migration.

## SDK Implementation

### Using `buildCurveWithMarketCap`

The Meteora SDK's `buildCurveWithMarketCap` function handles the complex mathematics:

```javascript
const curveConfig = buildCurveWithMarketCap({
  totalTokenSupply: TOTAL_SUPPLY,           // 1,000,000,000
  initialMarketCap: INITIAL_FDV_SOL,        // 28 SOL
  migrationMarketCap: MIGRATION_FDV_SOL,    // 228 SOL
  tokenBaseDecimal: TokenDecimal.NINE,      // Token decimals
  tokenQuoteDecimal: TokenDecimal.NINE,     // wSOL decimals
  // ... other parameters
});
```

### What the SDK Calculates

The SDK internally computes:

1. **Square Root Start Price** (`sqrtStartPrice`):
   ```
   sqrtStartPrice = sqrt(initialPrice × 2^64)
   ```
   Where `initialPrice = INITIAL_FDV_SOL / TOTAL_SUPPLY`

2. **Bonding Curve Parameters**: Multiple segments that create a smooth price curve from initial to migration price

3. **Reserve Ratios**: How many tokens vs SOL are held in the curve at each point

## USD Value (Informational Only)

While the configuration is SOL-denominated, you can calculate USD equivalents:

```
Market Cap (USD) = Market Cap (SOL) × SOL/USD Price
```

**Example** (if SOL = $150):
```
Initial FDV (USD) = 28 SOL × $150 = $4,200
Migration FDV (USD) = 228 SOL × $150 = $34,200
```

**Important:** These USD values fluctuate with SOL's price. The on-chain configuration only knows about SOL amounts.

## Complete Formula Summary

### For Any Point on the Curve

At any bonding curve progress `p` (where 0 ≤ p ≤ 1):

```
Current Market Cap (SOL) = INITIAL_FDV_SOL + (MIGRATION_FDV_SOL - INITIAL_FDV_SOL) × curve_function(p)
```

Where `curve_function(p)` depends on the curve shape (typically exponential or logarithmic for smooth price discovery).

### Migration Trigger Condition

Migration occurs when:

```
Total SOL Deposited ≥ Threshold
```

Where the threshold is calculated to correspond with `MIGRATION_FDV_SOL`.

## Example Configuration

```javascript
const TOTAL_SUPPLY = 1_000_000_000;      // 1B tokens
const INITIAL_FDV_SOL = 28;              // ~$4.2K at SOL=$150
const MIGRATION_FDV_SOL = 228;           // ~$34.2K at SOL=$150

// Results in:
// - Initial Price: 0.000000028 SOL/token
// - Migration Price: 0.000000228 SOL/token
// - Price Increase: 8.14x
```

## Advantages of SOL Denomination

1. **Simplicity**: No oracle dependencies or price feed complexity
2. **Consistency**: All calculations in native Solana denominations
3. **Predictability**: Migration threshold is fixed in SOL terms
4. **Gas Efficiency**: Fewer on-chain computations required
5. **Alignment**: Natural fit for Solana ecosystem economics

## Migration Options

The configuration supports multiple post-migration options:

```javascript
MigrationOption.MET_DAMM_V2  // Migrate to Meteora DAMM V2 pool
```

After migration:
- Liquidity moves to a DAMM (Dynamic AMM) pool
- Continued trading with deeper liquidity
- Creator/partner LP tokens distributed per configuration

## Fee Structure

Fees are also denominated in the curve's terms:

- **Base Fee**: `baseFeeMode: FeeSchedulerLinear` with BPS (basis points)
  - Example: 100 BPS = 1%
- **Migration Fee**: `MigrationFeeOption.FixedBps100` = 1% post-migration

## References

- [Meteora Dynamic Bonding Curve SDK](https://github.com/MeteoraAg/dynamic-bonding-curve-sdk)
- [Solana Web3.js Documentation](https://solana-labs.github.io/solana-web3.js/)
- Pump.fun bonding curve mechanics

---

**Note**: This document describes the mathematical formula and configuration approach. Actual SDK implementation handles all complex calculations including square root pricing, curve segments, and on-chain state management.
