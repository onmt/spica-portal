---
feature: ffkit-lp
title: ffkit LP 夜テーマ改訂 — 既存研究・社内先例の再利用（新規調査なし）
status: reuse
date: 2026-07-07
method: 既存 prior-art（ffkit 5件・spica design-system / indie-go-to-market）＋社内先例（prompter LP 構造）を再利用。新規の深掘り調査なし
relates_to: ffkit/index.html
---

# ffkit LP — prior-art 再利用記録

旧 LP（legacy.css・旧ポータル移植）を夜テーマ（style.css 共用）に全面改訂。対象は映像プロのため
Spica ブランド夜テーマが適合（ココハワタシガとは逆の判断）。

## 再利用したもの

- `onmt/ffkit` **README.md** — 機能・コピーの正本（deliver ワンソース→全納品 / deliver-batch 管制塔・冪等・例外通知 / flicker・optimize / verify レポート / package / capabilities）。
- `onmt/ffkit` prior-art 5件（flicker / ui-redesign 等）— 機能の独自性の裏付けとして参照。
- `onmt/spica` **billing/catalog.yaml** — 価格の正本: コア無料（beta）／商用 ¥5,000 買い切り（**planned・価格暫定**。法務 0005 クリア後に販売開始）。LP では「準備中・暫定」と正直表記。
- 本リポ `prompter/index.html` — ページ構造（hero＋デモ/stats/flags/ledger/plans）と実装状態バッジの流儀。

## 重要な事実（コピーを縛る）

- **onmt/ffkit は private・PyPI 未公開（2026-07-07 に 404 確認）**。旧 LP の「GitHub で見る」
  「pip install ffkit」は一般訪問者には行き止まりだったため、新 LP の GET 節は
  「一般配布の前・先行利用とご相談はメール」の正直表記に変更。**公開後に pip/GitHub 導線へ差し替えること**。
- ディスク検証のお願い（AS-IS・無保証・実機確認）は旧 LP から継承 — 消さないこと。
- ffmpeg 等は同梱せず外部プロセス呼び出し（特許/GPL 回避）・THIRD_PARTY 帰属 — 継承。

## 残差（このLPで新たに作ったもの）

- ターミナル実行イメージのヒーローデモ（CSS のみ・deliver の出力要約）
- ジョブ票（CSV）バッチの視覚化（✓/skip/⚠ 行）
- フリッカー optimize 前後の棒グラフ図（SVG）
