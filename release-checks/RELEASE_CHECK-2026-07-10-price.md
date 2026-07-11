# RELEASE_CHECK-2026-07-10（対象: ココハワタシガ 価格改定 ¥600→¥1,200 の反映）

> 変更: ココハワタシガ 年度パスを **定価 ¥1,200**（旧¥600）へ改定。半額セール¥600 は確定申告シーズン等の"本物の期間限定"運用（景表法・CHARTER不変条件4 順守）。3リポ横断（`onmt/spica` catalog / `receipt_flutter` StoreKit・release docs / `spica-portal` LP・特商法・terms）。本記録は spica-portal（公開サイト）分。

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | PASS | 価格 ¥1,200 が **3リポで完全一致**（`billing/catalog.yaml` price:1200＝正本／`receipt_flutter` StoreKit displayPrice 1200×7・app_store_metadata／`spica-portal` LP・特商法・terms）。実際に客が払う額は ASC 設定が binding・アプリ内表示は動的取得（#1175 でハードコード撤去済）＝サイト表記と実勢が乖離しない。 |
| S2 公開してはいけない情報 | PASS | 価格文字列のみの変更。秘密・内部パス・本名の混入なし。 |
| S3 表記・法定 | PASS | 特商法の販売価格例を ¥1,200 に更新。LP・terms も同額。旧 ¥600 の残存なし。半額セールは「本物の期間限定のみ・永久セール（架空定価）は景表法二重価格表示違反ゆえ禁止」を catalog 正本に明文化。 |
| S4 技術品質 | PASS | ココハワタシガ LP を JSなし(クローラー相当)で描画確認: 二段階価格（無料 0円 / 年度パス 1,200円）維持・横スクロールなし・エラーなし・旧「600円」残存なし。 |
| S5 外部送信 | PASS（不変） | 価格テキスト変更のみ・外部参照は増減なし。 |

判定: **公開可（PASS）**。価格 ¥600→¥1,200 をサイト全体で整合反映。
実行コンテキスト: 開発セッション内で実施（大原則②逸脱を明記）。
対象: 静的サイト spica-portal（本番 https://www.spicaimg.com ）／連動: `onmt/spica`・`onmt/receipt_flutter`（各リポで別 PR）
実行者: Claude Code セッション（2026-07-10）
