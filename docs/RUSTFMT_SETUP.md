# Rustfmt Setup Guide

This document explains how to properly set up `rustfmt` with your Neovim configuration.

## About the Deprecation

The warning "rustfmt should not be installed via rustup" indicates that the recommended way to install `rustfmt` has changed. Previously, it was commonly installed via rustup component, but now it should be installed using cargo directly.

## Installing rustfmt properly

1. Install rustfmt using cargo:

```bash
cargo install rustfmt
```

This will install rustfmt in your cargo bin directory, which should be in your PATH.

## Configuration in Neovim

The configuration has already been updated to:

1. Remove rustfmt from the Mason ensure_installed list
2. Configure conform.nvim to use the cargo-installed rustfmt
3. Update rustaceanvim's configuration to properly handle rustfmt

## Verifying the Installation

You can verify that rustfmt is properly installed and accessible by running:

```bash
rustfmt --version
```

If installed correctly, you should see the version information without any deprecation warnings.

## Troubleshooting

If you're still seeing the deprecation warning after following these steps:

1. Check if you have multiple copies of rustfmt installed:
   ```bash
   which -a rustfmt
   ```

2. Make sure your cargo bin directory (`~/.cargo/bin` by default) comes before rustup directories in your PATH.

3. If necessary, remove the rustup-installed version:
   ```bash
   rustup component remove rustfmt
   ```

## Benefits of Using Cargo-Installed rustfmt

- Better integration with conform.nvim formatting workflow
- No deprecation warnings
- More consistent behavior between different tools
- Easier to upgrade independently of the Rust toolchain

## References

- [Rustfmt Github Issue #5300](https://github.com/rust-lang/rustfmt/issues/5300)
- [Conform.nvim Documentation](https://github.com/stevearc/conform.nvim) 