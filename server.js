const express = require('express');
const cors = require('cors');
const crypto = require('crypto');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('.'));

// In-memory database (in production, use PostgreSQL/MongoDB)
const database = {
    wallets: new Map(), // wallet_address -> agent_data
    sessions: new Map(), // session_id -> session_data
    intelligence: new Map(), // intel_id -> intel_data
    operations: new Map() // operation_id -> operation_data
};

// Utility: Generate unique ID
function generateUniqueId(prefix = 'ELIA') {
    const timestamp = Date.now().toString(36);
    const random = crypto.randomBytes(4).toString('hex').toUpperCase();
    return `${prefix}-${random.slice(0, 4)}-${timestamp.slice(-4)}-${random.slice(-4)}`;
}

// Utility: Hash data
function hashData(data) {
    return crypto.createHash('sha256').update(data).digest('hex');
}

// ==================== WALLET ENDPOINTS ====================

// Register wallet
app.post('/api/wallet/register', (req, res) => {
    const { walletAddress, browserFingerprint, walletType } = req.body;

    if (!walletAddress || !browserFingerprint) {
        return res.status(400).json({
            success: false,
            error: 'Missing required fields'
        });
    }

    // Check if wallet already registered
    if (database.wallets.has(walletAddress)) {
        const existingData = database.wallets.get(walletAddress);
        
        // Check if browser fingerprint matches
        if (existingData.browserFingerprint !== browserFingerprint) {
            return res.status(403).json({
                success: false,
                error: 'DISQUALIFICATION: Wallet registered with different browser',
                disqualified: true
            });
        }

        // Same wallet, same browser - return existing ID
        return res.json({
            success: true,
            uniqueUserId: existingData.uniqueUserId,
            registered: true,
            conflict: false
        });
    }

    // Generate unique agent ID
    const uniqueUserId = generateUniqueId('ELIA');
    const timestamp = new Date().toISOString();

    // Store wallet data
    database.wallets.set(walletAddress, {
        walletAddress,
        walletType,
        browserFingerprint,
        uniqueUserId,
        registeredAt: timestamp,
        lastAccess: timestamp,
        operations: [],
        intelExtracted: 0
    });

    res.json({
        success: true,
        uniqueUserId,
        registered: true,
        conflict: false,
        message: 'Agent authenticated successfully'
    });
});

// Get wallet status
app.get('/api/wallet/:address', (req, res) => {
    const { address } = req.params;

    if (!database.wallets.has(address)) {
        return res.status(404).json({
            success: false,
            error: 'Wallet not registered'
        });
    }

    const walletData = database.wallets.get(address);
    
    res.json({
        success: true,
        data: {
            uniqueUserId: walletData.uniqueUserId,
            walletType: walletData.walletType,
            registeredAt: walletData.registeredAt,
            operations: walletData.operations.length,
            intelExtracted: walletData.intelExtracted
        }
    });
});

// ==================== INTELLIGENCE ENDPOINTS ====================

// Extract intelligence
app.post('/api/intelligence/extract', (req, res) => {
    const { walletAddress, targetId, targetName } = req.body;

    if (!walletAddress || !targetId) {
        return res.status(400).json({
            success: false,
            error: 'Missing required fields'
        });
    }

    // Verify wallet is registered
    if (!database.wallets.has(walletAddress)) {
        return res.status(403).json({
            success: false,
            error: 'Wallet not registered'
        });
    }

    const walletData = database.wallets.get(walletAddress);
    const extractionId = generateUniqueId('EXTR');
    const dataSize = Math.floor(Math.random() * 500) + 100; // 100-600 GB
    const timestamp = new Date().toISOString();

    // Create extraction record
    const extraction = {
        extractionId,
        walletAddress,
        uniqueUserId: walletData.uniqueUserId,
        targetId,
        targetName,
        dataSize: `${dataSize}GB`,
        timestamp,
        status: 'COMPLETED',
        detectionProbability: `${Math.floor(Math.random() * 10) + 1}%`
    };

    database.intelligence.set(extractionId, extraction);

    // Update wallet stats
    walletData.intelExtracted += 1;
    walletData.operations.push(extractionId);
    walletData.lastAccess = timestamp;

    res.json({
        success: true,
        extraction,
        message: 'Intelligence extracted successfully'
    });
});

// Get extraction history
app.get('/api/intelligence/history/:address', (req, res) => {
    const { address } = req.params;

    if (!database.wallets.has(address)) {
        return res.status(404).json({
            success: false,
            error: 'Wallet not registered'
        });
    }

    const walletData = database.wallets.get(address);
    const extractions = walletData.operations.map(id => 
        database.intelligence.get(id)
    ).filter(Boolean);

    res.json({
        success: true,
        count: extractions.length,
        extractions
    });
});

// ==================== OPERATIONS ENDPOINTS ====================

// Get active operations
app.get('/api/operations/active', (req, res) => {
    const operations = [
        {
            id: 'OPS-001',
            target: 'TechCorp Alpha',
            status: 'MONITORING',
            progress: 45,
            eta: '2h 15m'
        },
        {
            id: 'OPS-002',
            target: 'PharmaCo Beta',
            status: 'INFILTRATED',
            progress: 87,
            eta: '45m'
        },
        {
            id: 'OPS-003',
            target: 'FinanceGroup Gamma',
            status: 'EXTRACTING',
            progress: 73,
            eta: '2h 47m'
        }
    ];

    res.json({
        success: true,
        count: operations.length,
        operations
    });
});

// ==================== SYSTEM ENDPOINTS ====================

// System status
app.get('/api/system/status', (req, res) => {
    res.json({
        success: true,
        status: 'OPERATIONAL',
        version: '2.0.0',
        uptime: process.uptime(),
        stats: {
            totalAgents: database.wallets.size,
            activeOperations: database.operations.size,
            intelExtracted: Array.from(database.wallets.values())
                .reduce((sum, w) => sum + w.intelExtracted, 0)
        },
        encryption: 'AES-256-GCM',
        network: 'TOR CASCADE (7 nodes)',
        anonymity: 'MAXIMUM'
    });
});

// Health check
app.get('/api/health', (req, res) => {
    res.json({
        success: true,
        status: 'healthy',
        timestamp: new Date().toISOString()
    });
});

// ==================== MARKETPLACE ENDPOINTS ====================

// Get marketplace products
app.get('/api/market/products', (req, res) => {
    const products = [
        {
            id: 1,
            name: 'Zero-Knowledge Proof SDK v3.0',
            category: 'CRYPTOGRAPHIC',
            price: 50000,
            currency: 'USD',
            status: 'AVAILABLE'
        },
        {
            id: 2,
            name: 'Competitive Patent Intelligence Scanner',
            category: 'RECONNAISSANCE',
            price: 10000,
            currency: 'USD',
            status: 'AVAILABLE'
        },
        {
            id: 3,
            name: 'Corporate Stealth Operations Suite',
            category: 'INFILTRATION',
            price: 25000,
            currency: 'USD',
            status: 'AVAILABLE'
        }
    ];

    res.json({
        success: true,
        count: products.length,
        products
    });
});

// ==================== ERROR HANDLING ====================

// 404 handler
app.use((req, res) => {
    res.status(404).json({
        success: false,
        error: 'Endpoint not found',
        path: req.path
    });
});

// Error handler
app.use((err, req, res, next) => {
    console.error('Server error:', err);
    res.status(500).json({
        success: false,
        error: 'Internal server error'
    });
});

// ==================== START SERVER ====================

app.listen(PORT, () => {
    console.log('');
    console.log('███████╗██╗     ██╗ █████╗     ██████╗ ███████╗');
    console.log('██╔════╝██║     ██║██╔══██╗   ██╔═══██╗██╔════╝');
    console.log('█████╗  ██║     ██║███████║   ██║   ██║███████╗');
    console.log('██╔══╝  ██║     ██║██╔══██║   ██║   ██║╚════██║');
    console.log('███████╗███████╗██║██║  ██║   ╚██████╔╝███████║');
    console.log('╚══════╝╚══════╝╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝');
    console.log('');
    console.log('🔐 ELIA OS Server Running');
    console.log(`📡 Port: ${PORT}`);
    console.log(`🌐 URL: http://localhost:${PORT}`);
    console.log(`🔒 Encryption: AES-256-GCM`);
    console.log(`🛡️  Anonymity: MAXIMUM`);
    console.log('');
    console.log('Endpoints:');
    console.log('  POST /api/wallet/register');
    console.log('  GET  /api/wallet/:address');
    console.log('  POST /api/intelligence/extract');
    console.log('  GET  /api/operations/active');
    console.log('  GET  /api/system/status');
    console.log('');
});

module.exports = app;
