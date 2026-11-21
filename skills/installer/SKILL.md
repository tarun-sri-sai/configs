---
name: installer
description: Installs, updates, removes, and verifies programs with apt-get on Debian-based systems.
---

## Rules

- Use `apt-get` to install and manage programs.
- Always run `apt-get update -qq` before installing anything.
- Pass `-qq -y` flags to every `apt-get` command that makes changes.
- Prepend `DEBIAN_FRONTEND=noninteractive` to every `apt-get` command.
- Only install one program per command invocation.
- Do not chain commands.
- Do not read the command output when the exit code is success.
- When a command fails, read its output, identify the error, and report it. Do not retry the same command more than once.
- If not running as root, prepend `sudo` to each command.

## Install

1. `DEBIAN_FRONTEND=noninteractive apt-get update -qq`
2. `DEBIAN_FRONTEND=noninteractive apt-get install -qq -y <package>`

- If the user describes software instead of naming a package, search first with `apt-cache search <term>` and inspect the candidate with `apt-cache policy <candidate>`. Install the best match and state which package you chose.
- After a successful install, verify with `command -v <binary>` or `dpkg-query -W <package>`.

## Update

1. `DEBIAN_FRONTEND=noninteractive apt-get update -qq`
2. `DEBIAN_FRONTEND=noninteractive apt-get upgrade -qq -y`

- Never use `apt-get dist-upgrade`; it may remove or replace core packages.

## Remove

- Remove a package: `DEBIAN_FRONTEND=noninteractive apt-get remove -qq -y <package>`
- Also drop dependencies nothing else needs: `DEBIAN_FRONTEND=noninteractive apt-get autoremove -qq -y`
- `apt-get update` is not needed before removing.
- State which package is being removed before running the command.

## Verify

- Installed version: `dpkg-query -W -f='${Version}\n' <package>`
- Candidate and installed versions: `apt-cache policy <package>`
- Binary location: `command -v <binary>`
