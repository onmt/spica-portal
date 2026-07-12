# RELEASE_CHECK-2026-07-12（対象: prompter 機能比較表＋課金線v3 反映 / www.spicaimg.com）

> 対象コミット: `449fa3d`（機能比較表 新設）・`bd8d8e2`（Solo 6機能展開＋役割ラベル）・`63c9693`（課金線v3反映: Solo反転+QRリモコン／Pro縦書き・千鳥書き）・`1e7240b`（台帳: prompter 3機能追記）。
> 変更ファイル: `prompter/index.html`・`style.css`・`docs/app-claims-ledger.md`。

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | PASS | 表の全行を正本で裏取り。**課金線v3 の正本**＝`onmt/spica` `billing/catalog.yaml`（PR #19 を先行マージ済み・2026-07-12 Koji確定）。**実装の裏取り**（fetch 済み origin/main 基準）: 千鳥書き＝engine.js 自動整形 Phase A-C＋kuromoji 文節（`3259396` 等）／メイン画面の反転＝PR #33（2026-07-12 マージ・verify-selfflip.js ALL PASS）／縦書き・声追従・カード/カンペ・自動ルビ・QRリモコン等は既存確認済み。価格 ¥0/¥3,000/¥14,800・5台¥59,800/10台¥99,800・返金30日・認証台数 1/2/2 は catalog・product-lineup §3/§6 と一致。**未実装機能（画面共有除外オーバーレイ・可読エリア/傾きの紹介）は表に載せていない**（誇張なし）。Free「14日」表記はハイブリッド型トライアルの正直表現。 |
| S2 公開してはいけない情報 | PASS | 差分全文に秘密情報パターン・本名・メール・内部絶対パスの混入なしを機械確認。 |
| S3 表記・法定 | PASS | 価格表記は正本と一致（二重価格表示なし・「時間で切れません」は事実に基づく機能表記で他社名の比較広告なし）。法務ページ変更なし。 |
| S4 技術品質 | PASS | サイトルート模擬配信＋Playwright 実測: 390px/1280px ともページ横スクロールなし・比較表は 390px でラッパー内部のみ横スクロール（Free 列が覗きスクロール可能と視認できる）・コンソールエラー 0・reveal 後 opacity 1。表は `<table>`＋scope 属性＋aria-label でアクセシブル。 |
| S5 外部送信 | PASS | 差分に外部 URL・スクリプト参照の追加ゼロ（機械確認）。CSP 不変・追加は純 HTML/CSS のみ。 |

判定: **公開可（PASS）**。

実行コンテキスト: 開発セッション内で実施（SKILL.md 大原則②からの逸脱を明記。S1 は fetch 済み origin/main への実コード裏取りで実施）。
対象: 静的サイト spica-portal（本番 https://www.spicaimg.com ・Cloudflare Pages）
実行者: Claude Code セッション（2026-07-12）
