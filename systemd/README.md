# Backup timer

My systemd timer and script that does backup service.

Put scripts under home directory.

Put systemd files under `~/.config/systemd/user/`.

## Instillation

```bash
# test systemd service
systemctl --user start backup.service
systemctl --user status backup.service
systemctl --user stop backup.service

# start systemd timer
systemctl --user start backup.timer
systemctl --user enable backup.timer

# status
systemctl --user status backup.timer
systemctl --user status backup.service

# on changes
systemctl --user daemon-reload
```
