#!/bin/bash
# debloat-tecno.sh — for TECNO SPARK 40C (KM4k)
# Usage: ./debloat-tecno.sh [remove|restore]

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== TECNO Bloat Manager ===${NC}"

action="${1:-}"
if [[ ! "$action" =~ ^(remove|restore)$ ]]; then
    echo "Usage: $0 [remove|restore]"
    echo "  remove  → uninstall/disable Tecno bloat"
    echo "  restore → re-enable all removed/disabled apps"
    exit 1
fi

adb wait-for-device
echo -e "${GREEN}Device detected.${NC}"

# === Regular bloat: full uninstall (safe to remove)
TECNO_UNINSTALL_PACKAGES=(
    com.transsion.intercom
    com.transsion.ella
    com.transsion.chromecustomization
    com.android.dreams.basic
    com.android.messaging
    com.android.musicfx
    com.google.ar.core
    com.facebook.appmanager
    com.facebook.system
    com.facebook.services
    com.transsion.sk
    com.infinix.xshare
    moe.shizuku.privileged.api
    com.google.android.inputmethod.japanese
    com.google.android.projection.gearhead
    net.bat.store
    com.transsion.aftersalecalibrationtool
    com.transsion.carlcare
    com.transsion.oraimosound
    com.transsion.phoenix
    com.transsion.tecnospot
    com.transsion.magicshow
    com.talpa.hibrowser
    com.transsnet.store
    com.gallery20
    com.transsion.aisettings
    com.transsion.audiosmartconnect
    com.transsion.healthlife
    com.talpa.hiservice
    com.transsion.letswitch
    com.transsion.magazineservice.hios
    com.transsion.mol
    com.transsion.trancare
    com.transsion.manualguide
    com.transsion.filemanagerx
    com.idea.questionnaire
    com.transsion.kolun.assistant
    com.transsion.calculator
    com.transsion.plat.appupdate
)

# === AI Bloat: ONLY clear + disable (not uninstall)
TECNO_DISABLE_PACKAGES=(
    com.transsion.aiwallpaper
    com.transsion.aiwriting
    com.transsion.aiassistantlifestyle
    com.transsion.aivoiceassistant
    com.transsion.aicore.main
)

# Process regular packages (uninstall)
process_uninstall_packages() {
    for pkg in "${TECNO_UNINSTALL_PACKAGES[@]}"; do
        if [[ "$action" == "remove" ]]; then
            echo -e "${YELLOW}Uninstalling: $pkg${NC}"
            if adb shell pm list packages | grep -q "package:$pkg"; then
                adb shell pm clear "$pkg" 2>/dev/null || true
                adb shell pm uninstall --user 0 "$pkg"
                echo -e "  ${GREEN}✓ Uninstalled${NC}"
            else
                echo "  → Not installed. Skipping."
            fi
        elif [[ "$action" == "restore" ]]; then
            echo -e "${YELLOW}Restoring: $pkg${NC}"
            adb shell cmd package install-existing "$pkg" 2>/dev/null && \
                echo -e "  ${GREEN}✓ Restored${NC}" || \
                echo "  → Not a system app or already active."
        fi
        echo
    done
}

# Process AI packages (disable only)
process_disable_packages() {
    for pkg in "${TECNO_DISABLE_PACKAGES[@]}"; do
        if [[ "$action" == "remove" ]]; then
            echo -e "${YELLOW}Disabling: $pkg${NC}"
            if adb shell pm list packages | grep -q "package:$pkg"; then
                adb shell pm clear "$pkg" 2>/dev/null || true
                adb shell pm disable-user "$pkg"
                echo -e "  ${GREEN}✓ Disabled${NC}"
            else
                echo "  → Not installed. Skipping."
            fi
        elif [[ "$action" == "restore" ]]; then
            echo -e "${YELLOW}Re-enabling: $pkg${NC}"
            adb shell pm enable "$pkg" 2>/dev/null && \
                echo -e "  ${GREEN}✓ Re-enabled${NC}" || \
                echo "  → Not disabled or not found."
        fi
        echo
    done
}

# Run both sets
if [[ "$action" == "remove" ]]; then
    read -p "⚠️  This will uninstall/disable Tecno bloat. Continue? (y/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && { echo "Aborted."; exit 1; }
fi

process_uninstall_packages
process_disable_packages

echo -e "${GREEN}=== Tecno bloat management complete! ===${NC}"
