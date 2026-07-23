# RELEASE_CHECK-2026-07-23（対象: spica-portal サイト全体 — リブランド公開）

対象ブランチ: `claude/spica-portal-design-xvbns3`（main へ fast-forward で公開）
今回の公開内容（要点）:
- LP 刷新: **verikan**（旧 ffkit・映像納品：検品→生成→検証）／**Spica Legato**（旧 Spica Prompter・プロ用プロンプター）。
- 会社トップ・legal 3ページ（夜テーマ移植）・404・sitemap・OGP/canonical/schema を全同期。
- 旧URL `/prompter/`→`/legato/`・`/ffkit/`→`/verikan/` を `_redirects` で 301。
- 暫定名「ヒカエ」却下につき文字起こしLP `/hikae/`・専用スクショは今回の公開から除外（履歴に保存）。

| 関門 | 結果 | 備考 |
|---|---|---|
| S1 主張の裏取り | PASS | 価格・機能・プライバシー主張は正本（`onmt/spica` catalog.yaml／各アプリ実コード）と一致。前回唯一の FAIL（旧 ffkit「Python 標準ライブラリのみ」）は「Python 製（外部ツールは別プロセス委譲）」へ是正済み。verikan のデモコマンド先行表示は下記条件つきで許容（誇大でない）。 |
| S2 秘密情報・内部パス・EXIF | PASS | `gate-mechanical.sh` PASS。内部パス・鍵・私用 Gmail・画像 EXIF/GPS なし。除外した hikae スクショは git 追跡から消滅。 |
| S3 表記・法定 | PASS | 特商法（verikan商用¥5,000／Legato Solo¥3,000・Pro¥14,800／ココハ¥1,200＝catalog 一致）・プライバシー・EULA・運営者情報・問い合わせ先すべて健在。全内部リンク実在（MISSING 0件）。 |
| S4 技術品質 | PASS | 全ページ 375px 幅で status200・横スクロールなし・コンソールエラー0。CF 解析ビーコンのローカル遮断はサンドボックス由来で本番解消（許可済み・FAIL 非該当）。`_redirects` はローカル未処理・本番 Cloudflare Pages で 301。 |
| S5 外部送信 | PASS | 送信先は自ドメイン＋`static.cloudflareinsights.com`／`cloudflareinsights.com`（Cookieなし匿名解析）のみ。`_headers` CSP・privacy.html 第6条と一致。 |

判定: **公開可**
実行コンテキスト: **新規サブエージェント（開発セッションとは別・懐疑的視点）** で S1〜S5 を実行（大原則②準拠）。改名前・改名後の2回実施。

## 公開後の必須フォロー（リリースゲート条件）
1. **verikan の一般配布（PyPI/GitHub 公開）より前に、CLI/リポ名を `ffkit`→`verikan` へ統一する**（`onmt/ffkit` に申し送り済み `docs/handoff-rename-verikan.md`）。LP が先行表示している `verikan` コマンドと実体を一致させること。※LP 掲出（配布前）自体はこの条件を侵さない。
2. **Spica Legato の正式な商標調査**（J-PlatPat 等）。「Legato」は Legato Audio Inc.(2024) 等の一般語につき、常に "Spica Legato" で用い、確定前に調査する。
3. **文字起こしアプリの名称確定**後、LP `/hikae/`（履歴に保存）を再命名して復帰させる。
