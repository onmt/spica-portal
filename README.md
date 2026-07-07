# spica-portal — Spica Image Creation ポータルサイト

Spica のポータルサイト。**メイン＝Spica Prompter の LP**、サブ＝事業紹介（Spica Image Creation）。
ビルド不要の静的サイト（HTML ファースト運用）。ブランド規範は [`onmt/spica`](https://github.com/onmt/spica) の `BRAND.md` / `brand/`（tokens・NIGHT パレット）に準拠。

**本番**: https://spica-portal-8f8.pages.dev （Cloudflare Pages・main への push で自動デプロイ）

> 旧ポータル（`onmt/spica` の `portal/` → `spica.imagecreation.workers.dev`）は本リポへ**統合済み**（2026-07-05）。
> 法務3ページと ffkit LP は文面そのまま移植。旧 Worker は Cloudflare ダッシュボードから削除してよい。

## 構成

```
index.html    ページ本体（LP: ヒーロー/性能/セキュリティ/価格/事業紹介）
style.css     スタイル（@font-face + 全スタイル。色は brand/tokens.json の NIGHT/SPICA 系）
app.js        モーション（星空・スクロールリビール・プロンプターデモ）。外部依存ゼロ
legal/        法務3ページ（プライバシー/EULA/特商法。旧ポータルから文面そのまま移植）
ffkit/        ffkit の LP（旧ポータルから移植・legacy.css 使用）
kokohawatashiga/  ココハワタシガの LP（意図的に夜テーマ非適用・1ファイル完結の独立ライトテーマ。後述）
legacy.css    旧ポータルのスタイル（legal/ と ffkit/ 専用。夜テーマへの統一は今後の改訂で）
fonts/        IBM Plex Latin woff2（自前ホスト。日本語はシステムフォントにフォールバック）
assets/       実機スクリーンショット（開発版 UI）
_headers      Cloudflare Pages 用ヘッダ（CSP: 完全自己完結・script-src 'self'）
```

## 公開（Cloudflare Pages）

手順は `onmt/spica` の `portal/DEPLOY.md` と同じ。要点:

1. Cloudflare ダッシュボード → Workers & Pages → Create → Pages → **Connect to Git** → `onmt/spica-portal`
2. ビルド設定: Framework preset **None** / Build command **（空欄）** / Build output directory **`/`（リポジトリ直下）**
3. Save and Deploy → `https://<project>.pages.dev`。以後 main への push で自動デプロイ
4. 独自ドメインは Pages → Custom domains から（任意・未定）

## 運用メモ

- **外部リソースは一切読み込まない**（CSP で強制）。フォント・画像・JS すべて自前。
- コピーの方針: 性能主導（一字も、揺れない。）＋セキュリティは構造で語る（そして、台本は端末から出ない。）。
  実装状態バッジ（実装済/ベータ/開発中/方針確定)は誇張しない — `onmt/spica-prompter` の実態に追従させること。
- 価格・SKU の正本は `onmt/spica` の `billing/catalog.yaml`。改訂されたら本 LP も追従。
- `assets/` のスクリーンショットは開発環境（Linux）撮影。公開前に Mac 実機の撮り直し推奨。
- 法務ページの文面はここ（`legal/`）が実体。雛形・方針の正本は `onmt/spica`（playbooks/eula-template.md 等）。
- 今後の改訂候補: legal/ と ffkit/ の夜テーマ統一（legacy.css の廃止）。
- **ココハワタシガ LP は例外的に夜テーマを使わない**（Koji.O 判断 2026-07-07）。対象が映像業と無関係な一般ユーザー・IT に不慣れな方・高齢者のため、アプリ実物のアイコン色（#228486）基準のライトテーマ・大きめ文字・専門用語を避けた文面で独立させている。CSS はページ内インライン・JS なし・1ファイル完結。コピーの正本は `onmt/receipt_flutter` の `docs/release/app_store_metadata.md`。実機スクショ撮影後にイメージ図を差し替えること。
