# RELEASE_CHECK-2026-07-12（対象: 公開済み www.spicaimg.com 全体の完全版 S1〜S5＋是正反映）

> 道先案内所側の外形チェック（法定3ページ実在・JS非実行可読・解析スクリプトゼロ・404 正常）を引き継ぎ、
> 残項目を本セッションで実施。**検査対象は全10ページ**（トップ/prompter/ffkit/kokohawatashiga＋法務5＋404）。
> 本記録は検査と同時に行った是正（後述2件）を含むバッチの公開関門を兼ねる。

## S1 主張の裏取り — **PASS（ffkit/whisper のみ #10 継続）**

サイトの事実主張の総点検。正本＝`docs/app-claims-ledger.md`（全行 2026-07-09〜12 に実コード裏取り済み）。

| 主張（掲載箇所） | 根拠 | 判定 |
|---|---|---|
| サイト自身「外部リソースを一切読み込まない」（フッター） | 全HTML/CSS/JSの外部ドメイン参照 **0 件**（機械走査）＋描画時の外部リクエスト **0 件**（全10ページ Playwright 実測）＋CSP `script-src 'self'` | ✅ |
| app.js に外部送信なし | fetch/XMLHttpRequest/sendBeacon/WebSocket/EventSource/URLリテラル **全て 0**（ソース精査。JS は app.js の1本のみ） | ✅ |
| Prompter 数値主張（RMS 0.04px・後退0フレーム・15ms/4,026字・禁則0件） | spica-prompter verify スイート実測（2026-07-09 記録・不変） | ✅ |
| Prompter「台本は端末から出ない」＋ライセンス通信（Freeゼロ/Solo・Pro 90日に1回） | リポ精査（http/テレメトリ皆無）＋decisions/0007-0009・license-protocol.md（2026-07-12 全面改訂に同日追随済み） | ✅ |
| Prompter 機能比較表の全行（千鳥書き・メイン画面反転含む）・価格・認証台数・返金 | fetch 済み origin/main 実コード＋billing/catalog.yaml（本日 RELEASE_CHECK-2026-07-12-pricing-table.md で個別裏取り済み） | ✅ |
| ココハワタシガ（OCR完全オンデバイス・撮影なし・CSV 単式/複式・年100枚無料・¥1,200） | receipt_flutter 実コード（platform_ocr_service / export_service / NetworkGuard）＋catalog・StoreKit（07-10〜11 裏取り） | ✅ |
| ffkit・文字起こしのオフライン主張 | **リポ未接続で独立検証不能** | ❓ [#10](https://github.com/onmt/spica-portal/issues/10) 継続 |

## S2 公開してはいけない情報 — **PASS**

- 追跡ファイル全体: 秘密情報パターン（key/secret/token/password/秘密鍵ヘッダ）**0**・内部絶対パス **0**・私用メール（gmail）**0**・本名 **0**。
- 画像（assets/ 3点）: **EXIF 項目数 0・GPS なし**（PIL 実測）。

## S3 表記・法定 — **PASS**

- 法定3ページ実在・JS 非実行でも可読（道先案内所確認を引き継ぎ）。
- **連絡先は全ページ support@spicaimg.com に統一済み**（7箇所・変更不要＝受信開通の新規確認も不要）。
- 「運営統括責任者」欄: 現行特商法ページは MoR 構成（当方直販なし）で**該当欄なし＝販売開始前タスクのまま**。指示どおり不触。
- 価格表記（¥1,200 / ¥5,000 / ¥3,000 / ¥14,800）は catalog.yaml と一致を目視確認。

## S4 技術品質 — **PASS（是正2件を本バッチで実施）**

- 全10ページ・390px 実測: 横スクロール 0・h1 各1・コンソール/ページエラー 0。
- **是正①**: `/legal/tokushoho.html` の表がスマホ幅で溢れ（458px）→ legacy.css に折返し規則を追加し解消（再実測で全ページ横スクロール 0）。
- **是正②**: **OGP メタが全ページ皆無** → 全9ページに最小セット（og:title/description/type/url/site_name/locale・twitter:card=summary）を追加。og:url は全て自ドメインを機械確認。
  - 残改善候補: **og:image 用の 1200×630 ブランドカード画像**が未整備（今回は見送り）→ issue 化。

## S5 外部送信 — **PASS**

**外部送信先の完全一覧: 0 件**（HTML/CSS/JS の静的走査＋全10ページ描画時のネットワーク実測の両面で確認。
mailto: リンクはユーザー起動のメール送信でありサイトからの送信ではない）。
プライバシー方針の「収集しない・外部リソースを読み込まない」と完全一致。フォーム・Cookie・ストレージ書込みも無し。

---

判定: **公開可（PASS）**。FAIL 0 件。未検証負債は #10（ffkit/whisper・リポ接続待ち）、改善候補は og:image（issue 化）。
実行コンテキスト: 開発セッション内で実施（SKILL.md 大原則②逸脱を明記。機械チェック中心のため許容と判断）。
対象: 静的サイト spica-portal（本番 https://www.spicaimg.com ・Cloudflare Pages）
実行者: Claude Code セッション（2026-07-12）
