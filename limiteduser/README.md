# Restricted User Setup for Debug Utility (`debug.py`)

This project provides a secure way to create a restricted Linux user account that can only run a specific debug script (`/opt/vc/sbin/debug.py`) with a limited set of allowed parameters via `sudo`, using a restricted shell (`rbash`).

---

## Included Scripts

| Script Name | Purpose |
|-------------|---------|
| `init.sh` | Main entrypoint. Sets up the limited user and wrapper. |
| `create-limiteduser.sh` | Creates a new restricted user with rbash and a dedicated `$HOME/bin`. |
| `create-wrapper.sh` | Creates a secure wrapper for `debug.py`, configures environment and sudoers. |

---

## Wrapper lists

| Wrapper Name | Purpose |
|-------------|---------|
| `debugpy` | Run `debug.py` wrapper script (restricted options only) |
| `cmdlist` | Show allowed commands and their descriptions |

---

## Prerequisites

- Root or sudo access
- `debug.py` must exist at: `/opt/vc/sbin/debug.py`
- Target system supports `rbash` (`/bin/rbash` should exist)
- Tested on: VCE 5.2.3.4+ 

---

## Setup Instructions

1. Download the repository file `velocloud` into a working directory
   - Click the **Code** button on the GitHub page.
   - Select **Download ZIP** to download the entire project.

2. Upload to the VCE using SFTP
   ```bash
   sftp <username>@<host IP>
   put velocloud-main.zip
   bye
   ```

3. Log in to the remote host
   ```bash
   ssh <username>@<host IP>
   ```

4. Unzip and run the setup script
   ```bash
   unzip velocloud-main.zip
   cd velocloud-main/limiteduser
   ./init.sh
   ```

## Cleanup
- To remove the setup, run:
    ```bash
    cd velocloud-main/limiteduser
   ./uninstall.sh
   ```

## VeloCloud Script's parameter description

| VC Script | Parameter | Purpose |
|-------------|---------|---------| 
| `debug.py` | --ha [verp \| lstate ] | Dump the HA verp state of the edge or the interfacemac/ip related information   |  
| `debug.py` | --health | Dump health information  | 
| `debug.py` | --ifaces [include-tunnels] | Show interfaces | 
| `debug.py` | --path | Dump the current path stats | 
| `debug.py` | --routes | Dump the unified vc route table | 
| `debug.py` | --uptime | Dump process uptime | 

