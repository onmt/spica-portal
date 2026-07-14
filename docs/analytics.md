# サイト解析（アクセス集計）運用メモ

このサイト（www.spicaimg.com）は **Cloudflare Web Analytics** で匿名のアクセス集計を取っている。
目的は「サイトの健全性」と「訪問者の関心がどこにあるか（＝どのアプリが読まれているか／どこから来ているか）」を
把握し、**アプリをどこで宣伝すべきかを相談するときの指標の一つ**にすること（Koji.O 方針 2026-07-13）。

- **Cookie を使わない・個人を追跡しない**匿名集計。GA4 のような重い行動解析は入れていない（「名刺代わり・露出控えめ」方針に合わせて意図的に軽く）。
- プライバシー方針は `legal/privacy.html` 第6条に明記。**アプリ側の「データを集めない」方針は不変**（サイト訪問の匿名集計と、アプリのテレメトリ皆無は別問題）。

## 仕組みと、触った箇所

- 各 HTML の `</body>` 直前に Cloudflare のビーコンを 1 行入れている:
  ```html
  <script defer src="https://static.cloudflareinsights.com/beacon.min.js" data-cf-beacon='{"token": "…"}'></script>
  ```
- `_headers` の CSP に例外を追加済み（`script-src` に `static.cloudflareinsights.com`、`connect-src` に `cloudflareinsights.com`）。これがサイト唯一の外部リソース例外。
- `scripts/gate-mechanical.sh`（pre-release-check の S5 機械判定）はこの 2 ホストを許可済み。加えて **token 未設定（プレースホルダのまま）だと FAIL** する安全策を入れてある。

### ビーコンを入れているページ / 入れていないページ

| ページ | ビーコン | 備考 |
|---|---|---|
| `index.html`（会社トップ） | ✅ | |
| `prompter/`・`ffkit/` LP | ✅ | どのアプリが読まれているかの主対象 |
| `legal/`（privacy・eula・tokushoho） | ✅ | |
| `404.html` | ✅ | 迷子リンク・誤リンクの発見用 |
| `kokohawatashiga/`（LP・privacy・terms） | ❌（計測しない） | 下記の理由で 3 ファイルとも意図的に対象外にしている |

### ココハワタシガを計測対象外にしている理由（安易に変えないこと）

- **`privacy.html` / `terms.html` は App Store / Google Play への提出用の法的ページ**（サポート/プライバシー
  URL の実体）で、正本は `onmt/receipt_flutter`。これらは「データを収集しない」と明記しているページであり、
  そこに第三者トラッカー（解析ビーコン）を載せると**文面と矛盾**し、ストア審査上のリスクにもなる。→ **載せない。**
- **LP（`index.html`）** は「JSなし・大きめ文字・専門用語を避ける」が Koji.O 判断（2026-07-07）。
  対象が IT に不慣れな一般ユーザー・高齢者のため、既定で載せない。

> **将来ココハワタシガの関心度も知りたくなったら**: LP だけにビーコンを足すことは可能だが、
> **privacy/terms（ストア提出ページ）には決して足さないこと**。より筋が良いのは、ストアの法的ページを
> 一切汚さずに測れる **方式B（DNS を Cloudflare へ移し、サーバー側で集計＝スクリプト不要）**。
> その場合は receipt_flutter 側の正本とプライバシー表記の整合も合わせて確認する。

## セットアップ（token の発行と設定）— 公開前に一度だけ

1. Cloudflare ダッシュボード → **Analytics & Logs → Web Analytics** →「Add a site」。
2. ホスト名 `www.spicaimg.com` を登録すると、`data-cf-beacon` に入れる **token** が発行される。
   - ※ Pages プロジェクト側の「Web Analytics を有効化（自動注入）」でも計測できるが、本サイトは
     ソース上で明示する方針（HTML ファースト）にしているので、**手貼りの token 方式**を採る。両方は不要。
3. リポジトリ内のプレースホルダ `REPLACE_WITH_CF_WEB_ANALYTICS_TOKEN` を発行された token に一括置換:
   ```bash
   grep -rl REPLACE_WITH_CF_WEB_ANALYTICS_TOKEN --include='*.html' . \
     | xargs sed -i 's/REPLACE_WITH_CF_WEB_ANALYTICS_TOKEN/＜ここに token＞/g'
   ```
   （token を Koji.O から渡してもらえれば、こちらで置換する。）
4. `bash scripts/gate-mechanical.sh` が PASS することを確認（token 未設定だと FAIL する）。
5. **公開は pre-release-check（S1〜S5）通過が必須**。main への push で Cloudflare Pages が本番反映される。

## 集めた数字の読み方（3 つの目的にどう答えるか）

Web Analytics のダッシュボードで見る。

- **どのアプリに関心があるか** → **Page views を path 別**に見る。`/prompter/` `/ffkit/` `/kokohawatashiga/`※ `/` の比較。
  伸びている LP＝いま関心が集まっているアプリ。
- **どこで宣伝すべきか** → **Referrers（流入元）** と **Country / 地域**。
  - すでに流入がある参照元＝相性が良い場所（強化候補）。
  - 逆に「宣伝したのに流入が無い」場所＝メッセージや導線の見直し候補。
  - 宣伝リンクには **UTM パラメータ**（例: `?utm_source=x&utm_campaign=ffkit_launch`）を付けておくと、
    どの告知から来たかが Referrers 上で切り分けられる。宣伝を打つたびに source を変えるのがコツ。
- **サイトの健全性** → **総 Visits/Page views の推移**（急落＝障害やリンク切れの兆候）、
  **404 の発生**（誤リンク・古い URL の発見）、提供されていれば **Core Web Vitals**（表示速度）。

> 判断はこの数字「だけ」で決めない。母数が小さいうちはノイズが大きい。傾向（週・月単位の変化）で見て、
> 宣伝先の相談材料の一つとして使う。

## 台帳・追従

- 方式やページ範囲を変えたら、このファイルと `legal/privacy.html` 第6条・`_headers` のコメントを揃えて更新する。
- ダッシュボードの数字は Cloudflare 側にあり、リポジトリには保存しない（個人情報も保存しない）。
