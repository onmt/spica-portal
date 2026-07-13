#!/usr/bin/env bash
# gate-mechanical.sh — pre-release-check の「機械で確定判定できる部分」だけを自動化。
# S2（秘密情報・内部パス・私用メール・画像メタデータ）と S5（外部リソース読み込み）を対象にする。
# S1（主張の裏取り）と S4 の見た目（スマホ幅レンダ）は人＋ブラウザが要るので CI 対象外＝別途 SKILL 手順で。
# 使い方: リポ直下で `bash scripts/gate-mechanical.sh`。違反があれば非ゼロ終了。
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
note(){ printf '  ✗ %s\n' "$1"; fail=1; }

echo "== S2: 秘密情報・内部パス・私用メール =="
# 追跡ファイル全体（Pages は全ファイルを配信するため docs/release-checks も対象）
if git grep -nIE 'BEGIN (RSA|EC|OPENSSH|PGP) PRIVATE KEY|AKIA[0-9A-Z]{16}' -- . ; then
  note "秘密鍵ヘッダ / AWS アクセスキー様の文字列"
fi
if git grep -nIE '(api[_-]?key|secret[_-]?key|access[_-]?token|client[_-]?secret)["'"'"' ]*[:=][[:space:]]*["'"'"'][A-Za-z0-9_\-]{16,}' -- . ; then
  note "APIキー/トークンらしき値の代入"
fi
if git grep -nIE '/workspace/|/home/[a-z]+/' -- . ; then
  note "内部の絶対パス（/workspace, /home/...）"
fi
if git grep -nIiE '[A-Za-z0-9._%+-]+@gmail\.com' -- . ; then
  note "個人 Gmail アドレス（配信されるファイルに含めない）"
fi

echo "== S5: 外部リソースの読み込み（自ドメイン spicaimg.com 以外）=="
# html/css/js の「読み込み」文脈のみを見る（本文中の URL 記述は対象外）。
# 許可される外部ホスト: 自ドメイン spicaimg.com と、サイト解析の Cloudflare Web Analytics
# （static.cloudflareinsights.com のビーコン・cloudflareinsights.com への送信）。詳細は docs/analytics.md。
allow='spicaimg\.com|cloudflareinsights\.com'
ext_html=$(git grep -nIiE '(src|href)[[:space:]]*=[[:space:]]*["'"'"']((https?:)?//)' -- '*.html' \
  | grep -viE "$allow" || true)
[ -n "$ext_html" ] && { echo "$ext_html"; note "HTML の src/href が外部を指す"; }
ext_css=$(git grep -nIiE '(url\([[:space:]]*["'"'"']?https?:|@import[[:space:]])' -- '*.css' \
  | grep -viE "$allow" || true)
[ -n "$ext_css" ] && { echo "$ext_css"; note "CSS の url()/@import が外部"; }
ext_js=$(git grep -nIiE 'fetch\(|XMLHttpRequest|sendBeacon|new WebSocket|EventSource|https?://' -- '*.js' \
  | grep -viE "$allow" || true)
[ -n "$ext_js" ] && { echo "$ext_js"; note "JS に外部送信/外部URL"; }

echo "== サイト解析: プレースホルダ token が残っていないか =="
# 未設定（REPLACE_WITH_...）のまま公開すると解析が動かない。設定手順は docs/analytics.md。
if git grep -nI 'REPLACE_WITH_CF_WEB_ANALYTICS_TOKEN' -- '*.html' ; then
  note "Cloudflare Web Analytics の token が未設定（プレースホルダのまま）"
fi

echo "== S2: 画像の EXIF/GPS =="
imgs=$(git ls-files -- '*.jpg' '*.jpeg' '*.png')
if [ -n "$imgs" ]; then
  python3 - "$imgs" <<'PY' || fail=1
import sys
try:
    from PIL import Image
except Exception:
    print("  ! Pillow 未導入のため EXIF 検査をスキップ"); sys.exit(0)
bad=0
for f in sys.argv[1].split():
    try:
        ex=Image.open(f).getexif()
        if ex and len(ex)>0:
            print(f"  ✗ {f}: EXIF {len(ex)} 項目（0 で書き出すこと）"); bad=1
    except Exception as e:
        print(f"  ! {f}: {e}")
sys.exit(1 if bad else 0)
PY
fi

echo "== 競合マーカー =="
git grep -nIE '^(<<<<<<<|>>>>>>>|=======)$' -- . && note "マージ競合マーカーが残存"

if [ "$fail" -ne 0 ]; then echo "GATE: FAIL"; exit 1; fi
echo "GATE: PASS（機械チェック部分）"
