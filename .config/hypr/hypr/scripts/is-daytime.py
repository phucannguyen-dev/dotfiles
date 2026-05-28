#!/usr/bin/env python3
# ============================================================
#  is-daytime.py
#  Dùng astral để xác định đang là ngày hay đêm
#
#  Exit codes:
#    0 = ban ngày  (sau sunrise, trước sunset)
#    1 = ban đêm
#
#  Usage:
#    python3 is-daytime.py             → dùng tọa độ mặc định
#    python3 is-daytime.py --print     → in ra giờ mọc/lặn
# ============================================================

import sys
from datetime import datetime
from zoneinfo import ZoneInfo

try:
    from astral import LocationInfo
    from astral.sun import sun
except ImportError:
    print("❌ astral chưa được cài. Chạy: pip install astral", file=sys.stderr)
    sys.exit(2)

# ── Cấu hình ─────────────────────────────────────────────────
LATITUDE  = 21.028
LONGITUDE = 105.854
TIMEZONE  = "Asia/Ho_Chi_Minh"

# ── Logic ─────────────────────────────────────────────────────
tz       = ZoneInfo(TIMEZONE)
location = LocationInfo(latitude=LATITUDE, longitude=LONGITUDE, timezone=TIMEZONE)
s        = sun(location.observer, tzinfo=tz)
now      = datetime.now(tz)

is_day = s["sunrise"] < now < s["sunset"]

if "--print" in sys.argv:
    print(f"Sunrise : {s['sunrise'].strftime('%H:%M:%S')}")
    print(f"Sunset  : {s['sunset'].strftime('%H:%M:%S')}")
    print(f"Now     : {now.strftime('%H:%M:%S')}")
    print(f"Status  : {'☀️  Day' if is_day else '🌙 Night'}")

sys.exit(0 if is_day else 1)
