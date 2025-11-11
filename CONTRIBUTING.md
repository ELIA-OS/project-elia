# Contributing to ELIA OS

Thank you for your interest in contributing to ELIA OS! This document provides guidelines for contributing to the project.

## 🤝 Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## 🐛 Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title** - Descriptive and specific
- **Description** - Detailed explanation of the issue
- **Steps to reproduce** - Numbered list of steps
- **Expected behavior** - What should happen
- **Actual behavior** - What actually happens
- **Screenshots** - If applicable
- **Environment** - Browser, OS, Node version

Example:
```markdown
### Bug: Wallet connection fails on Firefox

**Description:** Phantom wallet fails to connect when using Firefox browser.

**Steps to Reproduce:**
1. Open ELIA OS in Firefox
2. Navigate to Agent Profile
3. Click "PHANTOM" button
4. Error appears: "Wallet not found"

**Expected:** Phantom extension opens and connects
**Actual:** Error message displayed

**Environment:**
- Browser: Firefox 120
- OS: Windows 11
- Node: 16.20.0
```

## ✨ Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- Use a clear and descriptive title
- Provide detailed description of the enhancement
- Explain why this enhancement would be useful
- List any alternative solutions considered

## 🔧 Development Process

### 1. Fork the Repository

Click the "Fork" button at the top right of the repository page.

### 2. Clone Your Fork

```bash
git clone https://github.com/your-username/elia-os.git
cd elia-os
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

Branch naming conventions:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation changes
- `refactor/` - Code refactoring
- `test/` - Adding tests

### 4. Make Changes

- Write clean, readable code
- Follow existing code style
- Add comments for complex logic
- Update documentation if needed

### 5. Test Your Changes

```bash
npm test
npm run lint
```

### 6. Commit Changes

```bash
git add .
git commit -m "Add: Description of your changes"
```

Commit message format:
- `Add:` - New feature
- `Fix:` - Bug fix
- `Update:` - Update existing feature
- `Remove:` - Remove feature/file
- `Docs:` - Documentation only
- `Refactor:` - Code refactoring

### 7. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 8. Create Pull Request

- Go to your fork on GitHub
- Click "New Pull Request"
- Select your branch
- Fill in PR template
- Submit PR

## 📝 Pull Request Guidelines

### PR Title Format

```
[Type] Brief description
```

Examples:
- `[Feature] Add wallet disconnect confirmation dialog`
- `[Fix] Resolve terminal command parsing error`
- `[Docs] Update API documentation`

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
Describe testing performed

## Screenshots
If applicable

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests pass
- [ ] No new warnings
```

## 💻 Code Style Guidelines

### JavaScript

```javascript
// Use const for immutable values
const API_URL = '/api/wallet/register';

// Use let for mutable values
let connectedWallet = null;

// Use arrow functions
const connectWallet = async (type) => {
    // Implementation
};

// Add JSDoc comments
/**
 * Generate unique agent ID from wallet address
 * @param {string} walletAddress - Solana wallet public key
 * @param {string} fingerprint - Browser fingerprint
 * @returns {string} Unique agent ID in format ELIA-XXXX-XXXX-XXXX
 */
function generateUniqueId(walletAddress, fingerprint) {
    // Implementation
}

// Use meaningful variable names
const walletAddress = await getWalletAddress();
const uniqueAgentId = generateUniqueId(walletAddress);
```

### HTML

```html
<!-- Use semantic HTML -->
<section class="wallet-section">
    <h2>Wallet Authentication</h2>
    <!-- Content -->
</section>

<!-- Use data attributes for JS hooks -->
<button data-wallet-type="phantom" onclick="connectWallet('phantom')">
    PHANTOM
</button>

<!-- Keep indentation consistent (2 spaces) -->
<div class="container">
  <div class="content">
    <p>Text</p>
  </div>
</div>
```

### CSS

```css
/* Use BEM naming convention */
.wallet-section { }
.wallet-section__header { }
.wallet-section__button--active { }

/* Group related properties */
.button {
    /* Positioning */
    position: relative;
    
    /* Box model */
    display: flex;
    width: 100%;
    padding: 1rem;
    
    /* Typography */
    font-family: var(--font-mono);
    font-size: 0.9rem;
    
    /* Visual */
    background: var(--green);
    border: 2px solid var(--green);
    
    /* Animation */
    transition: all 0.3s ease;
}

/* Use CSS variables */
:root {
    --green: #0f0;
    --black: #000;
    --font-mono: 'Courier New', monospace;
}
```

## 🧪 Testing Guidelines

### Unit Tests

```javascript
// tests/wallet.test.js
describe('Wallet Connection', () => {
    test('should generate unique agent ID', () => {
        const id = generateUniqueId('wallet123', 'fingerprint');
        expect(id).toMatch(/^ELIA-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}$/);
    });
    
    test('should detect duplicate wallet', () => {
        // Test implementation
    });
});
```

### Integration Tests

```javascript
// tests/api.test.js
describe('API Endpoints', () => {
    test('POST /api/wallet/register returns unique ID', async () => {
        const response = await request(app)
            .post('/api/wallet/register')
            .send({
                walletAddress: 'test123',
                browserFingerprint: 'test',
                walletType: 'phantom'
            });
            
        expect(response.status).toBe(200);
        expect(response.body.success).toBe(true);
        expect(response.body.uniqueUserId).toBeDefined();
    });
});
```

## 📚 Documentation

When adding new features:

1. Update README.md if user-facing
2. Add JSDoc comments to functions
3. Update API documentation if adding endpoints
4. Add examples for complex features
5. Update relevant markdown files in docs/

## 🎨 Design Guidelines

- Follow cyberpunk/hacker aesthetic
- Use Matrix-style colors (green on black)
- Keep UI minimalist
- Add glitch effects where appropriate
- Use monospace fonts for technical content
- Maintain consistent spacing and alignment

## ⚡ Performance Guidelines

- Minimize DOM manipulations
- Use CSS animations over JavaScript
- Optimize images (compress, use WebP)
- Lazy load images when possible
- Avoid memory leaks (clean up event listeners)
- Use debounce/throttle for frequent events

## 🔐 Security Guidelines

- Never commit sensitive data (API keys, passwords)
- Sanitize user inputs
- Use HTTPS in production
- Implement rate limiting
- Validate all API inputs
- Use parameterized queries
- Keep dependencies updated

## 📦 Dependencies

When adding new dependencies:

1. Justify the need
2. Check package size
3. Verify maintenance status
4. Review security advisories
5. Add to package.json
6. Update documentation

## 🚀 Release Process

1. Update version in package.json
2. Update CHANGELOG.md
3. Create git tag
4. Push to GitHub
5. Create GitHub release
6. Deploy to production

## ❓ Questions?

- Open a GitHub Discussion
- Contact @biiiiymeister on X (Twitter)
- Check existing issues and documentation

## 🙏 Thank You!

Your contributions make ELIA OS better for everyone. Thank you for taking the time to contribute!

---

**Happy coding! 🚀**
