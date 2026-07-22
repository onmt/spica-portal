# spica-portal — Spica Image Creation ポータルサイト

会社トップ（事業紹介）＋製品 LP（`/prompter/`・`/ffkit/`・`/kokohawatashiga/`）の静的サイト。
本番 = Cloudflare Pages（https://spica-portal-8f8.pages.dev ・main への push で自動デプロイ）。
構成・運用方針は [README.md](README.md) を参照。

<!-- このファイルは新規 repo 用の CLAUDE.md ひな型です。
     リポジトリ固有の説明はマーカーの外（上下）に自由に書いてください。
     spica-doctrine の区間は HQ(onmt/spica) から自動同期され、ここを直接編集しても上書きされます。 -->

## 公開・デプロイ前の関門（必須・省略不可）

**公開・デプロイの前に、pre-release-check の関門（サイト向け S1〜S5）を必ず通し、
通過記録 `release-checks/RELEASE_CHECK-YYYY-MM-DD.md` をコミットする。**
（同じ日に複数回公開する場合は、区別のため題名サフィックスを付けてよい＝
`release-checks/RELEASE_CHECK-YYYY-MM-DD-<題名>.md`。日付入りで `release-checks/` 直下に置くのが規約であり、
サフィックスの有無は関門の合否に関係しない。）

- 関門の正本は `onmt/claude-config` の `claude/skills/pre-release-check/SKILL.md`。
- このセッションから正本が読めない場合は、Koji.O に SKILL.md の中身の貼り付けを求めること。
- **関門を通していない状態で公開してはならない。**

> ここで言う「公開・デプロイ」= main への push（Cloudflare Pages が自動デプロイするため）、
> 独自ドメインの割り当て、その他サイトを外部に出す一切の操作。作業を始める前にこの関門を要求すること。

## アプリ仕様の追従（主張台帳・巡回）

このサイトは別リポのアプリ（spica-prompter・receipt_flutter・ffkit・whisper）の仕様を語る。
**アプリについて何か書く・答える前に [`docs/app-claims-ledger.md`](docs/app-claims-ledger.md) を開く**
（各主張の正本の在り処と最終確認日がある。記憶で語らない）。アプリ側の仕様が動いたら、まずこの台帳を更新し、
定期巡回（S1 の裏取りを定期実行にしたもの）で乖離・新機能を拾う。手順は同ファイル末尾。

<!-- spica-doctrine:start · 正本 onmt/spica:sync/CLAUDE-doctrine-block.md（中は直接編集しない／HQ更新→自動同期PR） -->
## 先人に学ぶ（着手前の必須プロセス）

新機能・新規実装に着手する前に、Spica HQ の「巨人の肩に立つ ― 先人の発明に学ぶ」ドクトリンに従って横断調査を回す。
HQ は `onmt/spica`（`spica-doctrine-learn-from-predecessors.md` ＝恒久原則、`spica-oss-research-directive.md` ＝標準手順・テンプレ・隣接マップ）。
**HQ にアクセスできない場合も、以下の要点だけで運用は成立する（自己完結）。**

- 題材でなく **問題の形** で探す。**調査の深さは賭け金に比例**（要所だけ深く・小変更や毎回のルーチンは軽く／高コストな自動リサーチは要所のみ）。**残った課題＝発明すべき新しいアイデア（残差）** を特定する。
- コードは **複製せず理解して書き直す**。GPL/AGPL/NONC の **コード複製は禁止**、NONC は依存採用も不可。
- 寛容ライセンス（MIT/BSD/Apache-2.0）を**依存として**使う場合は **帰属表示 / NOTICE** を整備する。
- **着手前に HQ の prior-art 索引（`onmt/spica:prior-art/INDEX.md`）で既存研究を探し、あれば再利用**（再調査しない）。結果は本 repo の `docs/prior-art/<feature>.md`（HQ集約用の frontmatter 付き）に残し、HQ へ1行報告する（報告→集約→再利用＝良サイクル）。

## 構造変更は「調査 → 設計 → 承認 → 実装」の順で（着手前の必須プロセス）

新規モジュール・状態管理・データスキーマ・処理経路の一本化など、**構造に触れる実装（L3相当）はいきなり書き始めない**。次の順を踏む：

1. **現状調査** — 関連コードの実体を grep/read で確定する（推測で設計しない）
2. **設計提示** — 変更方針・やること / やらないこと・検証方法を明文化して Human に出す
3. **承認** — Human の承認を得る
4. **実装** — 承認されたスコープ内だけを実装し、逸脱が要るなら止めて設計を改訂する

小さな修正（単一ファイル・既存パターン踏襲＝L1/L2相当）はこの限りでない。**賭け金の大きい変更ほど順序を守る**（調査前の設計・承認前の実装が手戻りと暴走の主因）。
<!-- spica-doctrine:end -->
