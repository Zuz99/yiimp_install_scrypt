#!/bin/bash
#########################################################
# Updated by Vaudois
# Universal prerequisites
# Supported:
#   - Ubuntu 22.04 (jammy)
#   - Ubuntu 24.04 (noble)
#   - Debian 12 (bookworm)
# Adapted for ARM architectures
#########################################################

# Color codes for output
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
CYAN=$ESC_SEQ"36;01m"

echo
echo -e "$CYAN => Checking prerequisites: $COL_RESET"

if [[ ! -f /etc/os-release ]]; then
  echo -e "$RED Unsupported OS (missing /etc/os-release).$COL_RESET"
  exit 1
fi

# shellcheck disable=SC1091
source /etc/os-release

OS_ID="$ID"
OS_VERSION="$VERSION_ID"
DISTRO=""
PHPVERSION=""

case "$OS_ID" in
  ubuntu)
    case "$OS_VERSION" in
      22.04*) DISTRO=22; PHPVERSION=8.1 ;;
      24.04*) DISTRO=24; PHPVERSION=8.3 ;;
      *)
        echo -e "$RED Unsupported Ubuntu version: $OS_VERSION. Supported: 22.04, 24.04$COL_RESET"
        exit 1
        ;;
    esac
    sudo chmod g-w /etc /etc/default /usr >/dev/null 2>&1 || true
    ;;
  debian)
    case "$OS_VERSION" in
      12*) DISTRO=12; PHPVERSION=8.2 ;;
      *)
        echo -e "$RED Unsupported Debian version: $OS_VERSION. Supported: 12 (bookworm)$COL_RESET"
        exit 1
        ;;
    esac
    ;;
  *)
    echo -e "$RED Unsupported OS: $OS_ID $OS_VERSION. Supported: Ubuntu 22/24, Debian 12$COL_RESET"
    exit 1
    ;;
esac

export OS_ID OS_VERSION DISTRO PHPVERSION

# Check architecture and detect CPU type
ARCHITECTURE=$(uname -m)
CPU_TYPE=""

if [[ "$ARCHITECTURE" == "x86_64" ]]; then
  CPU_TYPE="x86_64"
  echo -e "$GREEN Detected CPU: x86_64 (Intel/AMD 64-bit)$COL_RESET"
elif [[ "$ARCHITECTURE" =~ ^arm || "$ARCHITECTURE" =~ ^aarch ]]; then
  if grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
    CPU_TYPE=$(grep "Model" /proc/cpuinfo | sed 's/.*: //')
    echo -e "$GREEN Detected CPU: Raspberry Pi ($CPU_TYPE)$COL_RESET"
  else
    CPU_TYPE="ARM"
    echo -e "$YELLOW Detected CPU: ARM ($ARCHITECTURE)$COL_RESET"
  fi
else
  echo -e "$RED Your architecture is $ARCHITECTURE$COL_RESET"
  echo -e "$RED Unsupported architecture. Supported: x86_64, ARM (armv*, aarch*)$COL_RESET"
  exit 1
fi

# Ensure lsb_release exists (some scripts use it)
if ! command -v lsb_release >/dev/null 2>&1; then
  echo -e "$YELLOW lsb_release not found. Installing lsb-release...$COL_RESET"
  sudo apt-get update -y >/dev/null 2>&1 || true
  sudo apt-get install -y lsb-release >/dev/null 2>&1 || true
fi

echo -e "$GREEN Done... (OS=$OS_ID $OS_VERSION, DISTRO=$DISTRO, PHP=$PHPVERSION)$COL_RESET"
