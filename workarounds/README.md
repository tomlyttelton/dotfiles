# Workarounds

## Sway

Sway does not officially support proprietary NVIDIA drivers. Older versions require `--unsupported-gpu` to start, and additional environment variables may be necessary.

GDM discovers Wayland sessions from `/usr/share/wayland-sessions/`. Install this session under its own name:

```bash
sudo cp workarounds/sway.desktop /usr/share/wayland-sessions/sway-nvidia.desktop
```

Select **Sway (NVIDIA)** from the GDM session menu.

Using a separate session file avoids modifying the package-managed `sway.desktop`, which may be overwritten during upgrades.
