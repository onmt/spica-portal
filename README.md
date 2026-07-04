# spica-portal — Spica Image Creation ポータルサイト

Spica のポータルサイト。**メイン＝Spica Prompter の LP**、サブ＝事業紹介（Spica Image Creation）。
ビルド不要の静的サイト（HTML ファースト運用）。ブランド規範は [`onmt/spica`](https://github.com/onmt/spica) の `BRAND.md` / `brand/`（tokens・NIGHT パレット）に準拠。

## 構成

```
index.html    ページ本体（LP: ヒーロー/性能/セキュリティ/価格/事業紹介）
style.css     スタイル（@font-face + 全スタイル。色は brand/tokens.json の NIGHT/SPICA 系）
app.js        モーション（星空・スクロールリビール・プロンプターデモ）。外部依存ゼロ
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
- 法務ページ（プライバシー/EULA/特商法）は現在プレースホルダ（`#` リンク)。公開前に `onmt/spica` の `portal/legal/` に合わせて用意する。
