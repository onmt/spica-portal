# RELEASE_CHECK-2026-07-10（対象: spica-portal サイト / www.spicaimg.com・コピー改訂反映前チェック）

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | **PASS（一部 未検証）** | **サイト自身**=収集ゼロ/外部送信なしを実証（fetch/XHR/analytics/外部URL 0・CSP `script-src 'self'`）。**Spica Prompter**=`onmt/spica-prompter` 精査でネットワーク/テレメトリ皆無・マイクは getUserMedia のみでアップロード無し（端末内処理）＝「台本・音声が端末から出ない」を裏取り。数値主張（RMS 0.04px/0.09px・¥0/¥3,000/¥14,800 等）は 2026-07-09 記録から不変。**ffkit/ココハワタシガ/文字起こし** のオフライン主張はリポ未接続で独立検証できず → [#10](https://github.com/onmt/spica-portal/issues/10) で追跡。今回のコピー改訂は「誠実/正直」の自己申告を状態バッジの事実へ置換・プライバシー主張を重複削減＝S1 姿勢はむしろ改善。 |
| S2 公開してはいけない情報 | PASS | 内部パス（/workspace 等）0・秘密情報パターン0・画像 EXIF/GPS 全て無し。新コピーで新規リスクなし。 |
| S3 表記・法定 | **FAIL** | プライバシー方針/EULA/特商法の3ページ在・事業者情報（屋号）・連絡先 support@spicaimg.com 在・内部リンク全有効。**ただし特商法の「運営統括責任者」が `＿＿（要記入）` のまま** → [#9](https://github.com/onmt/spica-portal/issues/9)。現状サイトに販売/申込フロー無し＝通信販売の表記義務は未発生だが、**有料販売の開始前に要記入**。 |
| S4 技術品質 | PASS | 全7ページ スマホ幅(390px)横スクロールなし・h1 各1・meta description 在・alt欠落0・JS/コンソールエラー0。**（新規サブ項目）法定ページの JSなしクローラー可視性**: `legal/*.html` は `<script>` 0 の静的HTML＝SPAでない。JS無効レンダで privacy 本文1076字を確認。生HTMLに「プライバシー方針/特定商取引法/販売価格」等を確認＝アプリ審査ボット・検索エンジンが中身を取得可能。**（改善）**メインページの `.rv`(opacity:0→JSで表示) に `<noscript>` フォールバックを追加し、JS無効でも本文可視（lead.opacity=1 を確認）。 |
| S5 外部送信 | PASS | 外部URL参照0・fetch/XHR/analytics/gtag 0・script は自ホスト `/app.js` のみ。CSP（`script-src 'self'`・外部依存ゼロ）およびフッター「外部リソースを一切読み込まない」と完全一致。 |

判定: **条件付き公開可** — S3 が FAIL（特商法 運営統括責任者 未記入）。現状は販売フロー無し・本コピー改訂は特商法ページに無関係のため、コピー改訂の反映自体は S3 を悪化させない。ただし**有料販売の開始は S3 解消（[#9](https://github.com/onmt/spica-portal/issues/9)）までブロック**。S1 の他アプリ検証は [#10](https://github.com/onmt/spica-portal/issues/10) で追跡。

FAIL/未達の issue 化: [#9](https://github.com/onmt/spica-portal/issues/9)（S3 特商法）・[#10](https://github.com/onmt/spica-portal/issues/10)（S1 他アプリ検証負債）

実行コンテキスト: **開発セッション内で実施**（SKILL.md 大原則②「別コンテキスト・懐疑的視点」からの逸脱を明記。S1〜S5 は客観的機械チェックが中心のため本セッションで実施可能と判断。各アプリのストア提出等 高リスク節目では別セッション＋当該アプリの A1〜A7 で再実行を推奨）

対象: 静的サイト spica-portal（本番 https://www.spicaimg.com ・Cloudflare Pages）
実行者: Claude Code セッション（2026-07-10）
本記録がカバーする変更: 会社トップのコピー改訂（AI臭低減）＋メインページの `<noscript>` フォールバック追加
