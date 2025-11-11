# ELIA OS API Documentation

Complete API reference for ELIA OS backend server.

Base URL: `http://localhost:3000/api`

---

## Authentication

Currently, authentication is handled through Solana wallet addresses. Future versions will implement JWT tokens.

---

## Endpoints

### Wallet Management

#### Register Wallet

Register a new Solana wallet and receive unique agent ID.

```http
POST /api/wallet/register
```

**Request Body:**
```json
{
  "walletAddress": "string (required)",
  "browserFingerprint": "string (required)",
  "walletType": "string (required: phantom|backpack|solflare)"
}
```

**Success Response:**
```json
{
  "success": true,
  "uniqueUserId": "ELIA-A3F2-B871-C9D4",
  "registered": true,
  "conflict": false,
  "message": "Agent authenticated successfully"
}
```

**Error Response (Duplicate Wallet):**
```json
{
  "success": false,
  "error": "DISQUALIFICATION: Wallet registered with different browser",
  "disqualified": true
}
```

**Status Codes:**
- `200` - Success
- `400` - Bad request (missing fields)
- `403` - Forbidden (disqualified)

---

#### Get Wallet Status

Retrieve wallet information and statistics.

```http
GET /api/wallet/:address
```

**Parameters:**
- `address` (string) - Solana wallet address

**Success Response:**
```json
{
  "success": true,
  "data": {
    "uniqueUserId": "ELIA-A3F2-B871-C9D4",
    "walletType": "phantom",
    "registeredAt": "2025-01-15T10:30:00.000Z",
    "operations": 5,
    "intelExtracted": 3
  }
}
```

**Status Codes:**
- `200` - Success
- `404` - Wallet not registered

---

### Intelligence Operations

#### Extract Intelligence

Perform intelligence extraction from target.

```http
POST /api/intelligence/extract
```

**Request Body:**
```json
{
  "walletAddress": "string (required)",
  "targetId": "string (required)",
  "targetName": "string (optional)"
}
```

**Success Response:**
```json
{
  "success": true,
  "extraction": {
    "extractionId": "EXTR-B4C9-E7F3-D2A1",
    "walletAddress": "7xKXtP9RYq...",
    "uniqueUserId": "ELIA-A3F2-B871-C9D4",
    "targetId": "TARGET-001",
    "targetName": "TechCorp Alpha",
    "dataSize": "247GB",
    "timestamp": "2025-01-15T12:45:00.000Z",
    "status": "COMPLETED",
    "detectionProbability": "3%"
  },
  "message": "Intelligence extracted successfully"
}
```

**Status Codes:**
- `200` - Success
- `400` - Bad request
- `403` - Wallet not registered

---

#### Get Extraction History

Retrieve all extractions for a wallet.

```http
GET /api/intelligence/history/:address
```

**Parameters:**
- `address` (string) - Solana wallet address

**Success Response:**
```json
{
  "success": true,
  "count": 3,
  "extractions": [
    {
      "extractionId": "EXTR-B4C9-E7F3-D2A1",
      "targetId": "TARGET-001",
      "targetName": "TechCorp Alpha",
      "dataSize": "247GB",
      "timestamp": "2025-01-15T12:45:00.000Z",
      "status": "COMPLETED"
    }
  ]
}
```

**Status Codes:**
- `200` - Success
- `404` - Wallet not registered

---

### Operations

#### Get Active Operations

Retrieve currently active surveillance operations.

```http
GET /api/operations/active
```

**Success Response:**
```json
{
  "success": true,
  "count": 3,
  "operations": [
    {
      "id": "OPS-001",
      "target": "TechCorp Alpha",
      "status": "MONITORING",
      "progress": 45,
      "eta": "2h 15m"
    },
    {
      "id": "OPS-002",
      "target": "PharmaCo Beta",
      "status": "INFILTRATED",
      "progress": 87,
      "eta": "45m"
    }
  ]
}
```

**Status Codes:**
- `200` - Success

---

### Marketplace

#### Get Products

Retrieve all intelligence tools from marketplace.

```http
GET /api/market/products
```

**Success Response:**
```json
{
  "success": true,
  "count": 6,
  "products": [
    {
      "id": 1,
      "name": "Zero-Knowledge Proof SDK v3.0",
      "category": "CRYPTOGRAPHIC",
      "price": 50000,
      "currency": "USD",
      "status": "AVAILABLE"
    }
  ]
}
```

**Status Codes:**
- `200` - Success

---

### System

#### Get System Status

Retrieve server and system information.

```http
GET /api/system/status
```

**Success Response:**
```json
{
  "success": true,
  "status": "OPERATIONAL",
  "version": "2.0.0",
  "uptime": 3600.5,
  "stats": {
    "totalAgents": 42,
    "activeOperations": 3,
    "intelExtracted": 127
  },
  "encryption": "AES-256-GCM",
  "network": "TOR CASCADE (7 nodes)",
  "anonymity": "MAXIMUM"
}
```

**Status Codes:**
- `200` - Success

---

#### Health Check

Simple endpoint to check if server is running.

```http
GET /api/health
```

**Success Response:**
```json
{
  "success": true,
  "status": "healthy",
  "timestamp": "2025-01-15T12:00:00.000Z"
}
```

**Status Codes:**
- `200` - Success

---

## Error Responses

All error responses follow this format:

```json
{
  "success": false,
  "error": "Error message here"
}
```

Common error codes:
- `400` - Bad Request (missing/invalid parameters)
- `403` - Forbidden (disqualified/unauthorized)
- `404` - Not Found (resource doesn't exist)
- `500` - Internal Server Error

---

## Rate Limiting

Currently no rate limiting. Production deployment should implement:
- 100 requests per minute per IP
- 1000 requests per hour per wallet

---

## CORS

CORS is enabled for all origins in development. Production should restrict to specific domains.

---

## Examples

### JavaScript (Fetch API)

```javascript
// Register wallet
const response = await fetch('http://localhost:3000/api/wallet/register', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({
        walletAddress: '7xKXtP9RYq...',
        browserFingerprint: 'Mozilla/5.0...',
        walletType: 'phantom'
    })
});

const data = await response.json();
console.log(data.uniqueUserId); // ELIA-A3F2-B871-C9D4
```

### cURL

```bash
# Register wallet
curl -X POST http://localhost:3000/api/wallet/register \
  -H "Content-Type: application/json" \
  -d '{
    "walletAddress": "7xKXtP9RYq...",
    "browserFingerprint": "Mozilla/5.0...",
    "walletType": "phantom"
  }'

# Get wallet status
curl http://localhost:3000/api/wallet/7xKXtP9RYq...

# Extract intelligence
curl -X POST http://localhost:3000/api/intelligence/extract \
  -H "Content-Type: application/json" \
  -d '{
    "walletAddress": "7xKXtP9RYq...",
    "targetId": "TARGET-001",
    "targetName": "TechCorp Alpha"
  }'
```

---

## Webhooks (Future)

Future versions will support webhooks for real-time notifications:
- Extraction completed
- Operation status changed
- Security alert triggered

---

## SDK (Future)

Official JavaScript SDK coming soon:

```javascript
import { EliaOS } from '@elia-os/sdk';

const elia = new EliaOS({
    apiKey: 'your-api-key'
});

await elia.wallet.register({
    address: '7xKXtP9RYq...',
    type: 'phantom'
});
```

---

## Support

For API support:
- GitHub Issues: https://github.com/biiiiymeister/elia-os/issues
- Documentation: https://github.com/biiiiymeister/elia-os/docs
- Contact: @biiiiymeister on X (Twitter)
