# ELIA OS - Snapshot API Guide

## 📌 Overview
New API endpoints to get current snapshots of registered holders and traders.

## 🔗 New Endpoints

### 1. Registered Holders Snapshot
**GET** `/api/snapshot/registered-holders`

Returns top 100 token holders who have registered their Zcash address.

**Response:**
```json
{
  "timestamp": "2024-01-20T10:30:00.000Z",
  "totalRegistered": 25,
  "totalHolders": 100,
  "registeredHolders": [
    {
      "rank": 1,
      "solanaAddress": "ABC...XYZ",
      "zcashAddress": "zs1...",
      "balance": "1000000",
      "linkedAt": "2024-01-15T08:00:00.000Z"
    }
  ]
}
```

### 2. Registered Traders Snapshot
**GET** `/api/snapshot/registered-traders`

Returns top 50 traders who have registered their Zcash address.

**Response:**
```json
{
  "timestamp": "2024-01-20T10:30:00.000Z",
  "totalRegistered": 15,
  "totalTraders": 50,
  "traderEarningsZec": 1000,
  "traderEarningsUsdc": 50000,
  "zecPrice": 50,
  "registeredTraders": [
    {
      "rank": 1,
      "solanaAddress": "DEF...ABC",
      "zcashAddress": "zs1...",
      "totalPoints": 5000,
      "nickname": "Trader1",
      "linkedAt": "2024-01-10T12:00:00.000Z"
    }
  ]
}
```

### 3. Combined Snapshot
**GET** `/api/snapshot/all-registered`

Returns both holders and traders in one response.

**Response:**
```json
{
  "timestamp": "2024-01-20T10:30:00.000Z",
  "holders": {
    "totalRegistered": 25,
    "totalHolders": 100,
    "list": [...]
  },
  "traders": {
    "totalRegistered": 15,
    "totalTraders": 50,
    "list": [...]
  },
  "summary": {
    "totalRegisteredHolders": 25,
    "totalRegisteredTraders": 15,
    "totalRegistered": 40
  }
}
```

### 4. Zcash Addresses Only (Airdrop List)
**GET** `/api/snapshot/zcash-addresses`

Returns ONLY the list of Zcash addresses (deduplicated).

**Response:**
```json
{
  "timestamp": "2024-01-20T10:30:00.000Z",
  "totalAddresses": 35,
  "holders": 25,
  "traders": 15,
  "addresses": [
    "zs1abc...",
    "zs1def...",
    "zs1ghi..."
  ],
  "plainText": "zs1abc...\nzs1def...\nzs1ghi..."
}
```

## 🚀 Usage

### Option 1: Add to server.js
Copy the code from `server-snapshot-endpoints.js` and paste it into your `server.js` file (before the server.listen() call).

### Option 2: Test with script
```bash
node test-snapshot.js
```

This will create:
- `snapshot-holders.json` - Registered holders
- `snapshot-traders.json` - Registered traders
- `snapshot-combined.json` - Combined data
- `snapshot-addresses.json` - All Zcash addresses
- `zcash-addresses.txt` - Plain text list (one address per line)

### Option 3: Direct API calls

**Using curl:**
```bash
curl http://localhost:3001/api/snapshot/registered-holders
curl http://localhost:3001/api/snapshot/registered-traders
curl http://localhost:3001/api/snapshot/all-registered
curl http://localhost:3001/api/snapshot/zcash-addresses
```

**Using browser:**
Just visit the URLs directly:
- http://localhost:3001/api/snapshot/registered-holders
- http://localhost:3001/api/snapshot/registered-traders
- http://localhost:3001/api/snapshot/all-registered
- http://localhost:3001/api/snapshot/zcash-addresses

## 📋 Use Cases

1. **Airdrop Distribution**
   - Use `/api/snapshot/zcash-addresses` to get the final list
   - Copy the `plainText` field for your airdrop tool

2. **Analytics Dashboard**
   - Use `/api/snapshot/all-registered` for overview statistics
   - Track registration progress over time

3. **Verification**
   - Check who's registered: holders vs traders
   - Verify addresses before distribution

4. **Export for Reports**
   - Get full details with `/api/snapshot/combined`
   - Export to CSV/Excel for analysis

## ⚠️ Important Notes

- These endpoints fetch LIVE data from Jupiter and Zcoinpad APIs
- Only includes users who:
  1. Are in current top 100 holders OR top 50 traders
  2. Have linked their Zcash address in your database
- Addresses are automatically deduplicated in the combined list
- No authentication required (add if needed for production)

## 🔧 Troubleshooting

**Empty list returned?**
- Check if anyone has linked their Zcash address
- Verify database tables: `linked_wallets` and `linked_traders`

**API errors?**
- Check Jupiter API status: https://datapi.jup.ag/v1/holders/DQSmLyJgGyw83J3WhuVBzaFBRT2xaqF4mwkC9QD4o2AU
- Check Zcoinpad API: https://zcoinpad.onrender.com/api/leaderboard?page=1&limit=50

**Rate limiting?**
- The endpoints include built-in caching
- Wait a few seconds between requests
