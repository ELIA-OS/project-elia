# ELIA Launchpad

A decentralized token launchpad built on Solana with integrated trading, analytics, and gamification features.

## 🚀 Features

### Core Functionality
- **Token Creation & Launch**: Deploy custom SPL tokens with configurable parameters
- **Dynamic Bonding Curves**: Automated liquidity provision using Meteora's bonding curve protocol
- **Real-time Trading**: Integrated Jupiter aggregator for seamless token swaps
- **Auto-Migration**: Automatic graduation to full DEX liquidity pools when bonding curve completes

### Analytics & Insights
- **Live Price Charts**: Candlestick charts powered by Lightweight Charts
- **Market Data**: Real-time price, volume, liquidity, and holder metrics
- **Transaction History**: Comprehensive trade tracking and analysis
- **Leaderboard System**: Ranking system for traders and token holders

### Gamification
- **Quest System**: 30+ achievements tracking milestones across trading, launching, and community engagement
- **Points & Rewards**: Earn points for completing quests and climbing the leaderboard
- **Weekly Rewards**: Top traders and token holders receive weekly SOL/USDC distributions

### Social Features
- **Comments System**: Token-specific discussion threads
- **Custom Nicknames**: Personalized user profiles
- **Watchlist**: Track favorite tokens across sessions

## 🛠️ Tech Stack

### Frontend
- **HTML5/CSS3**: Modern, responsive brutalist design system
- **Vanilla JavaScript**: No framework dependencies for optimal performance
- **WebSocket**: Real-time data streaming
- **Chart Libraries**: 
  - Lightweight Charts (candlestick charts)
  - Chart.js (stats visualization)

### Backend
- **Node.js + Express**: RESTful API server
- **LowDB**: JSON-based database for lightweight data persistence
- **WebSocket Server**: Real-time communication layer

### Blockchain Integration
- **Solana Web3.js**: Blockchain interaction
- **@meteora-ag/dynamic-bonding-curve-sdk**: Bonding curve protocol integration
- **Jupiter Aggregator**: Token swap routing
- **Pinata IPFS**: Decentralized metadata storage

### APIs
- **Jupiter Data API**: Token analytics and holder data
- **Meteora Studio API**: Fee claiming and pool management
- **Solscan**: Transaction verification and exploration

## 📁 Project Structure

```
├── public/
│   ├── index.html          # Main application interface
│   ├── *.png               # Asset images
│   └── configs.json        # Bonding curve configurations
├── server.js               # Express server & API endpoints
├── quests5.json           # Quest definitions
├── db.json                # Application database
└── vanity/                # Pre-generated token keypairs
```

## 🔧 Installation

### Prerequisites
- Node.js v16+
- npm or yarn
- Solana wallet with SOL for deployment fees

### Setup

1. **Clone the repository**
```bash
git clone <repository-url>
cd elia-launchpad
```

2. **Install dependencies**
```bash
npm install
```

3. **Configure environment variables**
```bash
# Create .env file
WALLET_SECRET=<base58-encoded-keypair>
PINATA_JWT=<pinata-jwt-token>
PORT=3000
```

4. **Initialize database**
```bash
# Create db.json with default structure
node -e "require('fs').writeFileSync('db.json', JSON.stringify({tokens:[],trades:[],wallets:[],quests:[],comments:[]}, null, 2))"
```

5. **Start the server**
```bash
npm start
```

## 🎮 Usage

### Creating a Token

1. Connect your Solana wallet (Phantom, Solflare, or Backpack)
2. Navigate to the "Create" tab
3. Fill in token details:
   - Name & Symbol
   - Description
   - Image (256x256px recommended)
   - Social links (optional)
   - Quote asset (SOL, USDC, USD1)
   - Initial buy amount (optional)
4. Approve transaction in wallet
5. Wait for confirmation and automatic pool creation

### Trading

- **Quick Buy**: Click the "⚡" button on any token card
- **Advanced Trading**: Use the "Markets" tab for detailed swap interface
- **Portfolio Tracking**: Monitor holdings and PnL in the "Dashboard" tab

### Earning Rewards

#### For Traders
- Complete quests to earn points
- Rank in the top 50 traders for weekly reward distributions
- Rewards are split equally among top 50 (updated dynamically based on platform fees)

#### For Holders
- Hold tokens in top 100 positions
- Weekly rewards distributed proportionally based on holdings
- Bonus rewards for early supporters of successful launches

## 🏆 Quest System

### Categories

**Trading Quests**
- First Steps: Make your first trade
- Volume Milestones: 10 SOL → 15,000 SOL
- Profitable Flips: Successful buy/sell sequences
- Whale Trades: Single trades over 25 SOL

**Launch Quests**
- First Launch: Deploy your first token
- Serial Launcher: Deploy 5+ tokens
- Successful Launch: Reach $10k market cap
- Legendary Launch: Reach $1M market cap

**Community Quests**
- Socialite: Post your first comment
- Community Pillar: Post 25+ comments
- Diversifier: Trade 25+ different tokens

**Special Achievements**
- Sniper: Buy within 30 seconds of launch
- Pioneer Trader: Be among first 10 buyers
- Unicorn Hunter: Early buyer of $100k+ tokens
- Top Ten Trader: Rank in top 10 on leaderboard

## 📊 Tokenomics

### $ELIA Utility Token

**Total Supply**: 1,000,000,000 $ELIA

**Distribution**:
- 90% Public (via bonding curve)
- 10% Team (vested)

**Fee Structure**:
- Meteora LP: ~48%
- Token Deployers: 50%
- Platform: 1.88%

**Platform Share Distribution** (1.88% of all trades):
- 75% Community Rewards
  - 57.5% to Top 100 Holders
  - 42.5% to Top 50 Traders
- 25% Platform Development

## 🔐 Security Features

- **Content Moderation**: Forbidden keyword filtering
- **Rate Limiting**: Protection against spam and abuse
- **Transaction Verification**: Multi-step confirmation process
- **Wallet Signature Validation**: Secure transaction signing
- **CORS Protection**: Restricted API access

## 🌐 API Endpoints

### Public Endpoints

```
GET  /all-tokens              # Fetch all launched tokens
GET  /platform-stats           # Platform-wide statistics
GET  /api/top-tokens          # Top tokens by volume
GET  /api/leaderboard         # Trader rankings
GET  /api/quests              # Available quests
GET  /api/top-holders/:mint   # Token holder distribution
```

### Authenticated Endpoints

```
POST /create                  # Create new token
POST /confirm-creation        # Finalize token launch
POST /claim-fees             # Claim deployer fees
POST /api/comments           # Post comment
POST /api/nickname           # Update user nickname
```

## 🚢 Deployment

### Render.com

1. Create new Web Service
2. Connect GitHub repository
3. Configure environment variables
4. Add persistent disk at `/data` (for database and vanity keypairs)
5. Deploy

### Environment Variables (Production)
```
WALLET_SECRET=<base58-encoded-keypair>
PINATA_JWT=<pinata-jwt-token>
PORT=3000
RENDER=true
```

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Links

- **Platform**: [https://zec.eliaos.io](https://zec.eliaos.io)
- **Twitter**: [@ELIAosvm](https://x.com/ELIAosvm)
- **GitHub**: [ELIA-OS](https://github.com/ELIA-OS)
- **Dexscreener**: [View $ELIA](https://dexscreener.com/solana/eb6y7jhircxsevog2bkew866lakqtmcqui6fdq6dah4q)

## 🐛 Known Issues & Roadmap

### Current Limitations
- Quest system temporarily disabled for maintenance
- Browser storage restrictions in iframe environment
- Rate limiting on fee claim endpoint

### Planned Features
- [ ] Advanced portfolio analytics
- [ ] Mobile app (React Native)
- [ ] Multi-language support
- [ ] DAO governance integration
- [ ] Cross-chain bridge support

## 💬 Support

**Built with ❤️ by the ELIA team**
