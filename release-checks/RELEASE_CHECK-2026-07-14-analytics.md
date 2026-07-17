# RELEASE_CHECK-2026-07-14（対象: spica-portal サイト — Cloudflare Web Analytics 導入）

対象変更: サイト解析（Cloudflare Web Analytics）の導入。7ページにビーコン追加、CSP に解析2ホストを許可、
プライバシー方針にサイト解析節を追加、機械ゲートに解析ホスト許可＋token 未設定チェックを追加。
（PR #20 / branch `claude/site-analytics-traffic-h8watw`）

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | PASS | 本変更が新たに足す事実主張は privacy.html 第6条の「Cookie を使わない・個人を識別/追跡しない匿名集計」。根拠＝Cloudflare Web Analytics は Cookie 不使用・プライバシー重視の仕様（Cloudflare 公式仕様）。アプリ側の「テレメトリ皆無」等の主張はアプリコード不変につき影響なし。誇大表示なし。 |
| S2 秘密情報 | PASS | `gate-mechanical.sh` 機械判定 PASS（秘密鍵/APIキー/内部パス/私用Gmail/EXIF いずれも検出ゼロ）。※ `data-cf-beacon` の token（`8f19122a…`）は**クライアントHTMLに埋め込む公開値**であり秘密情報ではない（意図的にコミット）。 |
| S3 表記・法定 | PASS | privacy.html に第6条（サイトの匿名集計の開示）を新設。meta `description`/`og:description` もサイト解析に触れるよう更新（リンクプレビューの齟齬を解消・CodeRabbit 指摘対応）。法務3ページの相互リンク・特商法表記は不変。 |
| S4 技術品質 | PASS（簡易実施） | ローカル実レンダ（Chromium・幅375px）で計測: ビーコン導入の**7ページすべて横スクロールなし（overflow 0）**、`data-cf-beacon` token 設定済み、**自前コード由来のコンソールエラーなし**。kokohawatashiga はビーコン不在（意図通り）。live 環境での CSP×ビーコン挙動の実地確認は、本実行環境のネットワークポリシーで `*.pages.dev` が 403 遮断のため未実施 → **公開後の1分手動確認を推奨**（下記）。CSP は `script-src` に `static.cloudflareinsights.com`、`connect-src` に `cloudflareinsights.com` を明示許可済みのため構文上ブロックは発生しない。 |
| S5 外部送信 | PASS | 外部送信先は Cloudflare Web Analytics のみ（`static.cloudflareinsights.com`＝ビーコン読込、`cloudflareinsights.com`＝匿名集計データ送信）。privacy.html 第6条・`docs/analytics.md` で開示済み。CSP の許可ホストと送信先が完全一致。フォーム送信・その他外部CDNは無し。kokohawatashiga は対象外（ストア提出用の法的ページを汚さない方針）。 |

判定: **公開可**

実行コンテキスト: 開発セッションの継続（別コンテキストではない）＝簡易実施。変更は解析ビーコン追加に限定され副作用面は小さいが、
節目では別セッションでの懐疑的再確認を推奨。

## 公開後の手動確認（推奨・1分）
1. `https://www.spicaimg.com/` を開き devtools コンソールで **CSP 違反エラーが出ないこと**、`beacon.min.js` が 200 で読み込まれることを確認。
2. 数分後、Cloudflare ダッシュボード → Web 分析 で **アクセス数/ページ表示数が 0 から動くこと**を確認（＝計測が生きている証跡）。
3. ページ別 PV・参照元（Referrers）が集計され始めているかを確認。
