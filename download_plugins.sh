#!/bin/bash
PLUGINS_DIR="./Plugins"
mkdir -p "$PLUGINS_DIR"

download_plugin() {
    local repo="$1"         
    local output_name="$2"  

    echo "Downloading latest release of $repo..."
    local version
    version=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | jq -r .tag_name)

    if [ -z "$version" ]; then
        echo "Failed to get latest version for $repo"
        exit 1
    fi

    echo "Latest version: $version"
    local url="https://github.com/$repo/releases/download/$version/$output_name"
    wget -O "$PLUGINS_DIR/$output_name" "$url"
    echo "$repo downloaded to $PLUGINS_DIR/$output_name"
    echo
}

# Скачиваем плагины
download_plugin "d3156/PingNode" "libPingNodePlugin_1.0.2.so"
download_plugin "d3156/PrometheusExporterPlugin" "libPrometheusExporterPlugin_1.0.1.so"

echo "All plugins downloaded successfully!"
