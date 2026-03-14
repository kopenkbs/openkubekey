#!/usr/bin/env bash

set -euo pipefail

if ! command -v yq >/dev/null 2>&1; then
  case "$(dpkg --print-architecture)" in
    amd64) yq_arch="amd64" ;;
    arm64) yq_arch="arm64" ;;
    *)
      echo "unsupported architecture for yq"
      exit 1
      ;;
  esac

  sudo curl -fsSL -o /usr/local/bin/yq \
    "https://github.com/mikefarah/yq/releases/download/v4.44.6/yq_linux_${yq_arch}"
  sudo chmod +x /usr/local/bin/yq
fi

go mod download
(cd api && go mod download)
