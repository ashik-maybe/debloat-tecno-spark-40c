#!/bin/bash
# debloat-gapps.sh — for Google Apps on TECNO SPARK 40C
# Usage: ./debloat-gapps.sh [remove|restore]

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Google Apps (GApps) Manager ===${NC}"

action="${1:-}"
if [[ ! "$action" =~ ^(remove|restore)$ ]]; then
    echo "Usage: $0 [remove|restore]"
    echo "  remove  → uninstall Google apps"
    echo "  restore → re-enable them"
    exit 1
fi

adb wait-for-device
echo -e "${GREEN}Device detected.${NC}"

# Safe-to-remove Google apps
# EXCLUDED:
# com.google.android.apps.inputmethod.latin (Gboard)
# — keep unless you have another keyboard
GOOGLE_PACKAGES=(
    com.google.android.apps.messaging
    com.google.android.apps.restore
    com.google.android.apps.googleassistant
    com.android.chrome
    com.google.android.apps.nbu.files
    com.google.android.youtube
    com.google.android.as
    com.google.android.as.oss
    com.google.android.apps.docs
    com.google.android.apps.photos
    com.google.android.apps.safetyhub
    com.google.android.apps.maps
    com.google.android.apps.tachyon
    com.google.android.apps.books
    com.google.android.apps.magazines
    com.google.android.apps.videos
    com.google.android.videos
    com.google.android.apps.nbu.paisa.user
    com.google.android.apps.subscriptions.red
    com.google.android.apps.walletnfcrel
    com.google.android.apps.youtube.music
    com.google.android.play.games
    com.google.android.keep
    com.google.android.apps.tasks
    com.google.android.apps.translate
    com.google.android.gm
    com.google.android.calendar
    com.google.android.googlequicksearchbox
    com.google.android.apps.accessibility.soundamplifier
    com.google.android.apps.accessibility.voiceaccess
    com.google.android.apps.accessibility.magnifier
    com.google.android.accessibility.brailleime
    com.google.android.apps.youtube.kids
    com.google.android.apps.accessibility.audiomodem
    com.google.android.apps.accessibility.switchaccess
    com.google.android.apps.podcasts
)

process_gapps() {
    for pkg in "${GOOGLE_PACKAGES[@]}"; do
        if [[ "$action" == "remove" ]]; then
            echo -e "${YELLOW}Removing: $pkg${NC}"
            if adb shell pm list packages | grep -q "package:$pkg"; then
                adb shell pm clear "$pkg" 2>/dev/null || true
                adb shell pm uninstall --user 0 "$pkg"
                echo -e "  ${GREEN}✓ Removed${NC}"
            else
                echo "  → Not installed. Skipping."
            fi
        elif [[ "$action" == "restore" ]]; then
            echo -e "${YELLOW}Restoring: $pkg${NC}"
            adb shell cmd package install-existing "$pkg" 2>/dev/null && \
                echo -e "  ${GREEN}✓ Restored${NC}" || \
                echo "  → Not found in system or already active."
        fi
        echo
    done
}

if [[ "$action" == "remove" ]]; then
    read -p "⚠️  This will remove Google apps. Continue? (y/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && { echo "Aborted."; exit 1; }
fi

process_gapps
echo -e "${GREEN}=== Google apps management complete! ===${NC}"
