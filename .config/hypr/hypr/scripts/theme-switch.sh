#!/usr/bin/env bash

#  Usage:
#    theme-switch.sh day     → Catppuccin Latte
#    theme-switch.sh night   → Catppuccin Mocha
#    theme-switch.sh auto    → tự detect qua astral (Python)
#    theme-switch.sh toggle  → đảo ngược theme hiện tại
#    theme-switch.sh status  → xem trạng thái + giờ mọc/lặn

# ── Cấu hình ─────────────────────────────────────────────────
ASTRAL_SCRIPT="${ASTRAL_SCRIPT:-$HOME/.config/hypr/scripts/is-daytime.py}"

GTK_THEME_DAY="Catppuccin-Mauve-Light"
GTK_THEME_NIGHT="Catppuccin-Mauve-Dark"

# Wallpaper
WALLPAPER_DAY="$HOME/Pictures/Wallpapers/light/"
WALLPAPER_NIGHT="$HOME/Pictures/Wallpapers/dark/"

# Waybar — chỉ swap file màu, style.css không bị đụng
WAYBAR_COLOR_DIR="$HOME/.config/waybar/colors"
WAYBAR_COLOR_ACTIVE="$WAYBAR_COLOR_DIR/catppuccin.css"
WAYBAR_COLOR_DAY="$WAYBAR_COLOR_DIR/latte.css"
WAYBAR_COLOR_NIGHT="$WAYBAR_COLOR_DIR/mocha.css"

# File lưu trạng thái
STATE_FILE="$HOME/.cache/current-theme"

# ── Helpers ───────────────────────────────────────────────────
reload_waybar() {
    pkill -SIGUSR2 waybar 2>/dev/null
}

check_astral() {
    if ! python3 -c "import astral" 2>/dev/null; then
        echo "❌ astral chưa cài. Chạy: pip install astral"
        exit 1
    fi
    if [[ ! -f "$ASTRAL_SCRIPT" ]]; then
        echo "❌ Không tìm thấy $ASTRAL_SCRIPT"
        exit 1
    fi
}

# ── Áp dụng theme ─────────────────────────────────────────────
apply_day() {
    echo "☀️  Switching to Latte (day)..."

    # GTK3
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_DAY"
    # GTK4 / libadwaita
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    # Icon
    #gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME_DAY"

    # Waybar
    if [[ -f "$WAYBAR_COLOR_DAY" ]]; then
        ln -sf "$WAYBAR_COLOR_DAY" "$WAYBAR_COLOR_ACTIVE"
        reload_waybar
    fi

    ./walset.sh $WALLPAPER_DAY

    echo "day" > "$STATE_FILE"
    #notify-send -i weather-clear "Theme" "Đã đổi sang Catppuccin Latte ☀️" 2>/dev/null
    echo "✓ Done: Catppuccin Latte"
}

apply_night() {
    echo "🌙 Switching to Mocha (night)..."

    # GTK3
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_NIGHT"
    # GTK4 / libadwaita
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    # Waybar
    if [[ -f "$WAYBAR_COLOR_NIGHT" ]]; then
        ln -sf "$WAYBAR_COLOR_NIGHT" "$WAYBAR_COLOR_ACTIVE"
        reload_waybar
    fi

    ./walset.sh $WALLPAPER_NIGHT

    echo "night" > "$STATE_FILE"
    #notify-send -i weather-clear-night "Theme" "Đã đổi sang Catppuccin Mocha 🌙" 2>/dev/null
    echo "✓ Done: Catppuccin Mocha"
}

# ── Auto detect qua astral ────────────────────────────────────
auto_detect() {
    check_astral
    if python3 "$ASTRAL_SCRIPT"; then
        apply_day
    else
        apply_night
    fi
}

# ── Toggle ────────────────────────────────────────────────────
toggle() {
    current=$(cat "$STATE_FILE" 2>/dev/null)
    if [[ "$current" == "day" ]]; then
        apply_night
    else
        apply_day
    fi
}

# ── Status ────────────────────────────────────────────────────
status() {
    check_astral
    python3 "$ASTRAL_SCRIPT" --print
    echo ""
    echo "Current theme: $(cat "$STATE_FILE" 2>/dev/null || echo 'unknown')"
}

# ── Main ──────────────────────────────────────────────────────
case "${1:-auto}" in
    day)    apply_day    ;;
    night)  apply_night  ;;
    auto)   auto_detect  ;;
    toggle) toggle       ;;
    status) status       ;;
    *)
        echo "Usage: $0 [day|night|auto|toggle|status]"
        exit 1
        ;;
esac
