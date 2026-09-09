# Installing from GitHub Packages

This package is published to GitHub Packages. Only members of the `DenerWilliam` GitHub organization can install it.

## One-time Setup

### 1. Create a GitHub Personal Access Token (PAT)

Go to: https://github.com/settings/tokens

Click "Generate new token (classic)" with:
- **Name**: `github-packages`
- **Expiration**: 30 days (or as you prefer)
- **Scopes**: check `read:packages`

Click "Generate token" and copy the token.

### 2. Configure npm to use the token

Create or edit `~/.npmrc`:

```bash
echo "//npm.pkg.github.com/:_authToken=YOUR_GITHUB_TOKEN" >> ~/.npmrc
```

Replace `YOUR_GITHUB_TOKEN` with the token from step 1.

### 3. Configure npm to use GitHub Packages registry

```bash
npm config set @escodoo:registry https://npm.pkg.github.com
```

## Install the package

```bash
npm install -g @escodoo/skills
```

## Updating

```bash
npm install -g @escodoo/skills@latest
```

## Troubleshooting

### 401 Unauthorized

Make sure your PAT has `read:packages` scope and is still valid.

### EACCES permission denied

If you get permission errors, check your `~/.npmrc` is set up correctly:

```bash
cat ~/.npmrc
```

You should see:
```
//npm.pkg.github.com/:_authToken=ghp_xxxxx
@escodoo:registry=https://npm.pkg.github.com
```

## Token Expiration

GitHub PATs expire. When your token expires:
1. Generate a new PAT at https://github.com/settings/tokens
2. Update `~/.npmrc` with the new token
