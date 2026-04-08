# Debian-dev

This is a robust Debian-based development environment designed to behave like a full virtual machine.

**Key Features:**

- **Systemd Enabled:** Manage services using `systemctl` just like a real VM.
- **Pre-configured SSH:** Ready for remote development with VS Code or terminal.
- **Dev-ready Toolchain:** Optimized for modern workflows (Fish shell, Vim, Git, Curl, and more).

## Usage

> [!NOTE]
> **OrbStack** is highly recommended for macOS users for better host integration and performance.

```bash
# Build and Run
docker build -t debian-dev .
docker run -d \
    --name debian-dev \
    --privileged \
    --cgroupns=host \
    --tmpfs /run \
    --tmpfs /run/lock \
    -p 2222:22 \
    -v /Volumes/Projects:/home/devuser/projects `# optional: mount your projects directory` \
    debian-dev

# Access the container via SSH port mapping
ssh -p 2222 devuser@localhost
# or And if using OrbStack on macOS, you can directly access it via:
ssh devuser@debian-dev.orb.local
```

Default credentials are `devuser:devuser`.

## Customization

To add your own tools, simply append them to the `apt-get install` list in the Dockerfile.
The default shell is `fish`. If you need to persist your shell configurations, remember
to mount a volume for `/home/devuser`.

## License

This project is licensed under the [MIT License](LICENSE.md).
