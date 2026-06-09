#!/usr/bin/env bash
set -euo pipefail

systemctl list-units --type=service --state=running --no-legend --no-pager | awk '{print $1}'