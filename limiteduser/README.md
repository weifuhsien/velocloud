# Restricted User Setup for Debug Utility (`debug.py`)

This project provides a secure way to create a restricted Linux user account that can only run a specific debug script (`/opt/vc/sbin/debug.py`) with a limited set of allowed parameters via `sudo`, using a restricted shell (`rbash`).

---

## Included Scripts

| Script Name | Purpose |
|-------------|---------|
| `init.sh` | Main entrypoint. Sets up the limited user and wrapper. |
| `create-limiteduser.sh` | Creates a new restricted user with rbash and a dedicated `$HOME/bin`. |
| `create-wrapper-script.sh` | Creates a secure wrapper for `debug.py`, configures environment and sudoers. |

---

## Prerequisites

- Root or sudo access
- `debug.py` must exist at: `/opt/vc/sbin/debug.py`
- Target system supports `rbash` (`/bin/rbash` should exist)
- Tested on: VCE 5.2.3.4+ 

---

## Setup Instructions

1. Clone or copy the project `velocloud` into a working directory.

2. Run the setup script: `init.sh`.

   ```bash
   cd velocloud/limiteduser
   ./init.sh
   ```
   

## Cleanup
- To remove the setup:
    ```bash
   ./uninstall.sh
   ```

