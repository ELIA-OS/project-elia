
<div align="center">

# 🚀 ELIA Launchpad

### *Decentralized Token Launchpad on Solana*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js Version](https://img.shields.io/badge/node-%3E%3D16.0.0-brightgreen)](https://nodejs.org)
[![Solana](https://img.shields.io/badge/Solana-Mainnet-blueviolet)](https://solana.com)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

[Live Demo](https://zec.eliaos.io) • [Documentation](#-documentation) • [Contributing](CONTRIBUTING.md) • [Twitter](https://x.com/ELIAosvm)

![ELIA Banner](banner.png)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#️-tech-stack)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [API Reference](#-api-reference)
- [Tokenomics](#-tokenomics)
- [Quest System](#-quest-system)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

**ELIA Launchpad** is a fully decentralized token creation and trading platform built on Solana. Launch your own SPL tokens with automated bonding curves, integrated DEX trading, real-time analytics, and a gamified quest system that rewards active community members.

### Why ELIA?

- ⚡ **Instant Deployment** - Launch tokens in under 2 minutes
- 💧 **Auto-Liquidity** - Meteora bonding curves handle liquidity automatically
- 📊 **Live Analytics** - Real-time price charts and holder tracking
- 🎮 **Gamification** - 30+ quests with weekly SOL/USDC rewards
- 🔄 **Auto-Migration** - Graduates to full DEX pools at 100% curve completion
- 💰 **Earn Fees** - Deployers receive 50% of all trading fees

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🚀 **Launch Tokens**
- Custom SPL token creation
- IPFS metadata storage
- Multiple quote assets (SOL, USDC, USD1)
- Optional initial buy
- $0 platform fees (only Solana network fees)

### 📈 **Trading & Analytics**
- Integrated Jupiter aggregator
- Real-time candlestick charts
- Live price feeds
- Transaction history
- Holder distribution
- Volume tracking

</td>
<td width="50%">

### 🎮 **Gamification**
- 30+ achievement quests
- Points & leaderboard system
- Weekly reward distributions
- Custom user nicknames
- Social features & comments

### 💎 **Rewards**
- **Top 50 Traders**: Equal share of 42.5% community pool
- **Top 100 Holders**: Proportional share of 57.5% community pool
- **Deployers**: 50% of all trading fees from your token
- **Weekly Payouts**: Automatic USDC distributions

</td>
</tr>
</table>

---

## 🛠️ Tech Stack

<div align="center">

| **Frontend** | **Backend** | **Blockchain** | **Infrastructure** |
|:------------:|:-----------:|:--------------:|:------------------:|
| Vanilla JS | Node.js | Solana Web3.js | Render.com |
| HTML5/CSS3 | Express.js | Meteora SDK | Pinata IPFS |
| WebSockets | LowDB | Jupiter API | Docker |
| Lightweight Charts | - | @solana/spl-token | GitHub Actions |

</div>

---

## 📦 Installation

### Prerequisites
```bash
Node.js >= 16.0.0
npm or yarn
Solana wallet with SOL
```

### Quick Start
```bash
# Clone the repository
git clone https://github.com/ELIA-OS/elia-launchpad.git
cd elia-launchpad

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env with your credentials

# Initialize database
npm run init-db

# Start development server
npm run dev
```

### Environment Variables

Create a `.env` file in the root directory:
```env
# Solana Wallet (Base58 encoded)
WALLET_SECRET=your_base58_keypair_here

# Pinata IPFS
PINATA_JWT=your_pinata_jwt_token

# Server Configuration
PORT=3000
NODE_ENV=development

# Optional: Render Deployment
RENDER=false
```

---

## 🎮 Usage

### 1️⃣ Create a Token
```javascript
// Navigate to the "Create" tab
1. Connect your Solana wallet
2. Fill in token details:
   - Name: "My Cool Token"
   - Symbol: "COOL"
   - Description: "The coolest token on Solana"
   - Image: Upload 256x256px PNG
   - Quote Asset: Select SOL/USDC/USD1
3. (Optional) Add initial buy amount
4. Sign transaction
5. Wait for confirmation ✅
```

### 2️⃣ Trade Tokens
```javascript
// Quick buy from card
- Click ⚡ icon on any token card
- Enter SOL amount
- Approve transaction

// Advanced trading
- Navigate to "Markets" tab
- Use Jupiter integration for best rates
```

### 3️⃣ Earn Rewards
```javascript
// For Traders
✅ Complete quests to earn points
✅ Rank in top 50 for weekly rewards
✅ Trade volume increases earnings

// For Holders
✅ Hold $ELIA in top 100 wallets
✅ Receive proportional weekly distributions
✅ Early supporter bonuses
```

---

## 📁 Project Structure
```
elia-launchpad/
│
├── 📄 server.js                 # Express API server
├── 📄 package.json              # Dependencies
├── 📄 .env.example              # Environment template
│
├── 📂 public/                   # Frontend files
│   ├── index.html               # Main application
│   ├── style.css                # Global styles
│   ├── script.js                # Client logic
│   └── assets/                  # Images & media
│
├── 📂 vanity/                   # Pre-generated keypairs
│   └── used/                    # Archived keypairs
│
├── 📄 db.json                   # Application database
├── 📄 quests5.json              # Quest definitions
├── 📄 configs.json              # Bonding curve configs
│
└── 📂 docs/                     # Documentation
    ├── API.md                   # API reference
    ├── CONTRIBUTING.md          # Contribution guide
    └── CHANGELOG.md             # Version history
```

---

## 🔌 API Reference

### Public Endpoints
```bash
GET  /all-tokens              # Fetch all launched tokens
GET  /platform-stats           # Platform-wide statistics
GET  /api/top-tokens          # Top 10 tokens by volume
GET  /api/leaderboard         # Trader rankings (paginated)
GET  /api/top-holders/:mint   # Token holder distribution
GET  /api/quests              # Available quests
```

### Authenticated Endpoints
```bash
POST /create                  # Create new token
POST /confirm-creation        # Finalize token launch
POST /claim-fees             # Claim deployer fees
POST /api/comments           # Post comment
POST /api/nickname           # Update user nickname
```

### Example Request
```javascript
// Create a new token
const response = await fetch('/create', {
  method: 'POST',
  body: formData // Contains name, symbol, image, etc.
});

const { transaction, baseMint } = await response.json();

// Sign with wallet
const signedTx = await wallet.signTransaction(transaction);

// Confirm creation
await fetch('/confirm-creation', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ signature, baseMint, ...metadata })
});
```

Full API documentation: [API.md](docs/API.md)

---

## 💰 Tokenomics

<div align="center">

### $ELIA Token Distribution



</div>

| Allocation | Percentage | Amount | Details |
|:-----------|:----------:|-------:|:--------|
| **Public Sale** | 90% | 976,000,000 | Via bonding curve |
| **Team** | 2.4% | 24,000,000 | burnt |

### Fee Structure
```
Every Trade = 100%
│
├── 48% → Meteora LP Providers
├── 50% → Token Deployers
└── 1.88% → Platform
    │
    ├── 75% Community Rewards
    │   ├── 57.5% → Top 100 Holders
    │   └── 42.5% → Top 50 Traders
    │
    └── 25% Platform Development
```

### Reward Calculation Examples

**Scenario: $10,000 weekly trading volume**

| Role | Share | Weekly Reward |
|:-----|:-----:|:-------------:|
| Top 50 Trader | Equal split | ~$6 USDC |
| Top 100 Holder | Proportional | ~$8 USDC |
| Token Deployer | 50% of pool fees | ~$5,000 |

---

## 🏆 Quest System

### Quest Categories

<table>
<tr>
<td width="50%">

#### 🎯 Trading Quests
- **First Steps** (10 pts) - Make your first trade
- **Apprentice Trader** (25 pts) - Trade 10 SOL
- **Whale Trade** (100 pts) - Single trade over 25 SOL
- **Market Maker** (500 pts) - Trade 1,000 SOL total

#### 🚀 Launch Quests
- **The Creator** (50 pts) - Deploy first token
- **Serial Launcher** (200 pts) - Deploy 5+ tokens
- **Legendary Launch** (1000 pts) - Token reaches $1M mcap

</td>
<td width="50%">

#### 🎮 Achievement Quests
- **Sniper** (75 pts) - Buy within 30s of launch
- **Pioneer Trader** (50 pts) - Top 10 early buyer
- **Unicorn Hunter** (250 pts) - Early buyer of $100k+ token
- **HODLer** (100 pts) - Hold for 24+ hours before sell

#### 👥 Social Quests
- **Socialite** (10 pts) - Post first comment
- **Community Pillar** (150 pts) - Post 25+ comments
- **Diversifier** (100 pts) - Trade 25+ different tokens

</td>
</tr>
</table>

**View all 30+ quests in-app** → [Live Demo](https://zec.eliaos.io)

---

## 🚀 Deployment

### Render.com (Recommended)

1. **Create Web Service**
   - Connect GitHub repository
   - Build Command: `npm install`
   - Start Command: `npm start`

2. **Add Persistent Disk**
   - Mount Path: `/data`
   - Size: 1GB minimum

3. **Configure Environment Variables**
```
   WALLET_SECRET=<your_base58_keypair>
   PINATA_JWT=<your_pinata_jwt>
   PORT=3000
   RENDER=true
```

4. **Deploy** 🚀

### Docker Deployment
```bash
# Build image
docker build -t elia-launchpad .

# Run container
docker run -p 3000:3000 \
  -e WALLET_SECRET=<secret> \
  -e PINATA_JWT=<jwt> \
  -v $(pwd)/data:/data \
  elia-launchpad
```

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide
```bash
# Fork the repository
# Clone your fork
git clone https://github.com/YOUR_USERNAME/elia-launchpad.git

# Create feature branch
git checkout -b feature/AmazingFeature

# Make changes and commit
git commit -m 'Add some AmazingFeature'

# Push to your fork
git push origin feature/AmazingFeature

# Open Pull Request on GitHub
```

### Code of Conduct

- ✅ Be respectful and inclusive
- ✅ Provide constructive feedback
- ✅ Focus on what's best for the community
- ✅ Show empathy towards other contributors

---

## 📊 Project Stats

<div align="center">

![Lines of Code](https://img.shields.io/badge/Lines%20of%20Code-15K+-blue)
![Files](https://img.shields.io/badge/Files-37-green)
![Quests](https://img.shields.io/badge/Quests-30+-orange)
![API Endpoints](https://img.shields.io/badge/API%20Endpoints-10+-red)

</div>

### Development Statistics

| Metric | Count |
|:-------|------:|
| Total Lines of Code | 15,000+ |
| JavaScript | 1,850 |
| HTML | 3,500 |
| CSS | 730 |
| Documentation | 2,000+ |
| API Endpoints | 10+ |
| Quest Achievements | 30+ |
| Supported Wallets | 3 |

---

## 🔐 Security

- **Smart Contract Audits**: Meteora protocol (audited)
- **Transaction Signing**: Client-side wallet signatures
- **Content Moderation**: Forbidden keyword filtering
- **Rate Limiting**: API protection against abuse
- **CORS Protection**: Restricted origins

**Report vulnerabilities**: security@eliaos.io

---

## 📝 License

This project is licensed under the **MIT License** - see [LICENSE](LICENSE) file for details.
```
MIT License - Copyright (c) 2025 ELIA OS

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

## 🔗 Links & Resources

<div align="center">

| Resource | Link |
|:---------|:-----|
| 🌐 **Live Platform** | [zec.eliaos.io](https://zec.eliaos.io) |
| 🐦 **Twitter** | [@ELIAosvm](https://x.com/ELIAosvm) |
| 💬 **GitHub** | [ELIA-OS](https://github.com/ELIA-OS) |
| 📊 **Dexscreener** | [View $ELIA](https://dexscreener.com/solana/eb6y7jhircxsevog2bkew866lakqtmcqui6fdq6dah4q) |
| 📖 **Docs** | [Documentation](docs/) |
| 🐛 **Issues** | [Report Bug](https://github.com/ELIA-OS/elia-launchpad/issues) |

</div>

---

## 🗺️ Roadmap

### ✅ Phase 1: Launch (Q4 2024)
- [x] Token creation & deployment
- [x] Bonding curve integration
- [x] Jupiter DEX integration
- [x] Quest system
- [x] Leaderboard & rewards

### 🚧 Phase 2: Growth (Q1 2025)
- [ ] Mobile app (React Native)
- [ ] Advanced portfolio analytics
- [ ] Multi-language support
- [ ] DAO governance launch
- [ ] Staking mechanics

### 🔮 Phase 3: Expansion (Q2 2025)
- [ ] Cross-chain bridge (Ethereum, BSC)
- [ ] NFT integration
- [ ] Launchpad IDO platform
- [ ] AI-powered token analyzer
- [ ] Professional market maker tools

---

## 💬 Community & Support

<div align="center">

**Join our growing community of token creators and traders!**


[![Twitter](https://img.shields.io/badge/Twitter-Follow%20Us-1DA1F2?logo=twitter&logoColor=white)](https://x.com/ELIAosvm)

**Need help?** Open an [issue](https://github.com/ELIA-OS/elia-launchpad/issues) or reach out on social media.

</div>

---

## 🙏 Acknowledgments

- **Solana Foundation** - Blockchain infrastructure
- **Meteora** - Bonding curve protocol
- **Jupiter** - DEX aggregation
- **Pinata** - IPFS storage
- **Our Community** - Feedback and support

---

<div align="center">

### 🚀 Ready to launch your token?

---

**Made with ❤️ by the ELIA team**

[![GitHub stars](https://img.shields.io/github/stars/ELIA-OS/elia-launchpad?style=social)](https://github.com/ELIA-OS/elia-launchpad)
[![GitHub forks](https://img.shields.io/github/forks/ELIA-OS/elia-launchpad?style=social)](https://github.com/ELIA-OS/elia-launchpad/fork)
[![GitHub watchers](https://img.shields.io/github/watchers/ELIA-OS/elia-launchpad?style=social)](https://github.com/ELIA-OS/elia-launchpad)

</div>
