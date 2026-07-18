# RELEASE_CHECK-2026-07-17（対象: spica-portal サイト — findability 整備「押さないが、見つかる」）

対象変更: 露出方針の半歩調整（Koji.O 承認 2026-07-17）に基づく「見つかりやすさ」の土台整備。
sitemap.xml / robots.txt / 全ページ canonical / OGP 画像（assets/og.png 1200×630・夜テーマ）/
JSON-LD 構造化データ（index=Organization+WebSite、prompter・ffkit=SoftwareApplication 最小）/
README に方針を明文化。見た目・本文コピーの変更なし（head メタと新規2ファイルのみ）。

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | PASS | JSON-LD・OGP の記述は**ページ既存の meta/本文の文言をそのまま引用**（新しい主張ゼロ）。ffkit の operatingSystem（macOS/Windows/Linux）も既存 meta の主張と同一。価格・状態バッジ等の変動主張は JSON-LD に入れていない（offers なし） |
| S2 公開してはいけない情報 | PASS | gate-mechanical PASS。新規 og.png は Chromium レンダの生成画像で EXIF 0（Pillow 導入の上で機械確認） |
| S3 表記・法定 | PASS | 法務ページは canonical 追加のみ（文面不変）。kokohawatashiga の privacy/terms は正本（receipt_flutter）尊重のため**無変更**・sitemap 掲載のみ |
| S4 技術品質 | PASS | ローカル実レンダ（Chromium・375px）で全8ページ横スクロールなし・自前コードのコンソールエラーなし。JSON-LD は3ファイルとも JSON 構文検証 OK（実行されないデータブロックのため CSP script-src 'self' と非干渉） |
| S5 外部送信 | PASS | 新たな外部送信ゼロ。og:image は自ドメイン絶対 URL。gate S5 PASS（許可ホスト＝自ドメイン＋解析2ホストのまま不変） |
| S6 辛口監査（軽） | PASS | 「名刺代わり・押さないが見つかる」に照らし過不足を点検: 営業 CTA 追加なし・煽りなし。ココハワタシガに夜テーマ OG 画像を**あえて充てない**（ライトテーマ独立方針を尊重、canonical のみ）。sitemap のページ増減追従は README に運用として明記 |

判定: **公開可**

実行コンテキスト: 開発セッションの継続（簡易実施）。変更は head メタ・静的2ファイル・OG画像に限定され、
本文・挙動への影響なし。

## 公開後の手動確認（推奨・5分）
1. X / Slack / LINE に `https://www.spicaimg.com/` を貼り、**大きな OGP 画像**が出ることを確認。
2. [Google Search Console](https://search.google.com/search-console) にプロパティ登録（未登録なら）→ sitemap.xml を送信。
   ※ findability の効果測定はここと Web Analytics の検索流入で行う。
3. 数日後、`site:spicaimg.com` 検索で全ページがインデックスされ始めているか確認。
