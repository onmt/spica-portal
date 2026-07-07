---
feature: kokohawatashiga-lp
title: ココハワタシガ LP — 既存研究の再利用（新規調査なし）
status: reuse
date: 2026-07-07
method: HQ prior-art 索引を確認 → 既存研究3件＋社内先例2件を再利用。賭け金（静的LP 1ページ）に対し新規の深掘り調査は不要と判断
relates_to: kokohawatashiga/index.html
---

# ココハワタシガ LP — prior-art 再利用記録

新規のリサーチは行わず、以下を再利用した（ドクトリン「報告→集約→再利用」の再利用側）。

## 再利用した既存研究（HQ 索引より）

- `onmt/spica` **design-system** — NIGHT パレット・IBM Plex・誠実トーンの信頼UX。本 LP は portal の `style.css` をそのまま共用。
- `onmt/spica` **indie-go-to-market** — 買い切り(サブスク非既定)・控えめ・ローカルファーストの売り方。価格セクションの「サブスク比較 → 買い切り」構成に反映。
- `onmt/receipt_flutter` **feature_audit_2026-06** — 機能の実態把握に参照。

## 社内先例（コード・コピーの直接の親）

- 本リポ `index.html`（Spica Prompter LP）— ページ構造（hero/デモ/flags/airgap図/ledger/paycmp/plans）と実装状態バッジの流儀を踏襲。airgap 図・ledger はレシート文脈に書き直し（複製でなく同一リポ内の再利用）。
- `onmt/receipt_flutter` `docs/release/app_store_metadata.md` — コピーの正本。「選ぶだけで、整う」「データ最小化図解」「こんな方に」は App Store 説明文と整合させた。

## 残差（このLPで新たに発明したもの）

- レシート→抽出フィールドのスキャンデモ（CSS のみ・インラインJSなし＝CSP準拠）
- 「端末に残るもの → 会計ソフトに渡るもの」データ最小化の2カラム図
- Provenance（由来バッジ）の視覚化を LP 上で再現

## 運用ノート

- 実機スクリーンショット撮影後（App Store 用 6.7" と共通化可能）、hero のイメージ図を実機画像に差し替えること。
- 価格・SKU の正本は `onmt/receipt_flutter`（年度 ¥600・100枚無料・過去5年遡及）。改訂されたら本 LP も追従。
