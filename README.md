# spica-portal — Spica Image Creation ポータルサイト

Spica のポータルサイト。**ルート＝スピカ・イメージクリエイションのトップページ（事業紹介: 映像制作＋アプリ群）**、
製品 LP はその配下（`/prompter/`・`/ffkit/`・`/kokohawatashiga/`）。※2026-07-07 に構成変更 — それまでルートだった Spica Prompter LP は `/prompter/` へ移動。
ビルド不要の静的サイト（HTML ファースト運用）。ブランド規範は [`onmt/spica`](https://github.com/onmt/spica) の `BRAND.md` / `brand/`（tokens・NIGHT パレット）に準拠。

**本番**: https://spica-portal-8f8.pages.dev （Cloudflare Pages・main への push で自動デプロイ）

> 旧ポータル（`onmt/spica` の `portal/` → `spica.imagecreation.workers.dev`）は本リポへ**統合済み**（2026-07-05）。
> 法務3ページと ffkit LP は文面そのまま移植。旧 Worker は Cloudflare ダッシュボードから削除してよい。

## 構成

```
index.html    会社トップ（事業紹介: 映像制作 / アプリ星座図・一覧 / 連絡先。夜テーマ）
prompter/     Spica Prompter の LP（ヒーロー/性能/セキュリティ/価格/事業紹介。旧ルート）
style.css     スタイル（@font-face + 全スタイル。色は brand/tokens.json の NIGHT/SPICA 系）
app.js        モーション（星空・スクロールリビール・プロンプターデモ）。外部依存ゼロ
legal/        法務3ページ（プライバシー/EULA/特商法。旧ポータルから文面そのまま移植）
ffkit/        ffkit の LP（夜テーマ・style.css 共用。入手節は一般配布前の正直表記）
kokohawatashiga/  ココハワタシガの LP（意図的に夜テーマ非適用・1ファイル完結の独立ライトテーマ。後述）
legacy.css    旧ポータルのスタイル（legal/ 専用。夜テーマへの統一は今後の改訂で）
fonts/        IBM Plex Latin woff2（自前ホスト。日本語はシステムフォントにフォールバック）
assets/       実機スクリーンショット（開発版 UI・prompter/ が参照）
_headers      Cloudflare Pages 用ヘッダ（CSP: 完全自己完結・script-src 'self'）
```

> 互換メモ: 旧ルート宛てのリンクのうち `/#studio`（事業紹介アンカー）は、新トップの
> アプリ節に同名アンカーを置いて生かしている（legal/ と ffkit/ が参照）。

## 公開（Cloudflare Pages）

手順は `onmt/spica` の `portal/DEPLOY.md` と同じ。要点:

1. Cloudflare ダッシュボード → Workers & Pages → Create → Pages → **Connect to Git** → `onmt/spica-portal`
2. ビルド設定: Framework preset **None** / Build command **（空欄）** / Build output directory **`/`（リポジトリ直下）**
3. Save and Deploy → `https://<project>.pages.dev`。以後 main への push で自動デプロイ
4. 独自ドメインは Pages → Custom domains から（任意・未定）

## 運用メモ

- **このサイトの目的は「名刺代わり」**（Koji.O 方針 2026-07-07）。新規案件の募集はしない。役割は
  (1) 新規取引先からの事業実態確認に応えること、(2) アプリ利用者向けの入口。アプリと同じく
  **露出は控えめ＝それ自体が安心材料**。営業的な CTA（「ご相談ください」「お見積り」等）を置かないこと。
- **外部リソースは一切読み込まない**（CSP で強制）。フォント・画像・JS すべて自前。
- コピーの方針: 性能主導（一字も、揺れない。）＋セキュリティは構造で語る（そして、台本は端末から出ない。）。
  実装状態バッジ（実装済/ベータ/開発中/方針確定)は誇張しない — `onmt/spica-prompter` の実態に追従させること。
- 価格・SKU の正本は `onmt/spica` の `billing/catalog.yaml`。改訂されたら本 LP も追従。
- `assets/` のスクリーンショットは開発環境（Linux）撮影。公開前に Mac 実機の撮り直し推奨。
- 法務ページの文面はここ（`legal/`）が実体。雛形・方針の正本は `onmt/spica`（playbooks/eula-template.md 等）。
- 今後の改訂候補: legal/ の夜テーマ統一（legacy.css の廃止）。
- **ffkit の入手節は一般配布前の正直表記**（onmt/ffkit は private・PyPI 未公開のため、GitHub/PyPI への導線は張らない）。公開されたら LP の GET 節を pip/GitHub 導線に差し替えること。
- **ココハワタシガ LP は例外的に夜テーマを使わない**（Koji.O 判断 2026-07-07）。対象が映像業と無関係な一般ユーザー・IT に不慣れな方・高齢者のため、アプリ実物のアイコン色（#228486）基準のライトテーマ・大きめ文字・専門用語を避けた文面で独立させている。CSS はページ内インライン・JS なし・1ファイル完結。コピーの正本は `onmt/receipt_flutter` の `docs/release/app_store_metadata.md`。実機スクショ撮影後にイメージ図を差し替えること。
