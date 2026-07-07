# <リポジトリ名>

<!-- このファイルは新規 repo 用の CLAUDE.md ひな型です。
     リポジトリ固有の説明はマーカーの外（上下）に自由に書いてください。
     spica-doctrine の区間は HQ(onmt/spica) から自動同期され、ここを直接編集しても上書きされます。 -->

<!-- spica-doctrine:start · 正本 onmt/spica:sync/CLAUDE-doctrine-block.md（中は直接編集しない／HQ更新→自動同期PR） -->
## 先人に学ぶ（着手前の必須プロセス）

新機能・新規実装に着手する前に、Spica HQ の「巨人の肩に立つ ― 先人の発明に学ぶ」ドクトリンに従って横断調査を回す。
HQ は `onmt/spica`（`spica-doctrine-learn-from-predecessors.md` ＝恒久原則、`spica-oss-research-directive.md` ＝標準手順・テンプレ・隣接マップ）。
**HQ にアクセスできない場合も、以下の要点だけで運用は成立する（自己完結）。**

- 題材でなく **問題の形** で探す。**調査の深さは賭け金に比例**（要所だけ深く・小変更や毎回のルーチンは軽く／高コストな自動リサーチは要所のみ）。**残った課題＝発明すべき新しいアイデア（残差）** を特定する。
- コードは **複製せず理解して書き直す**。GPL/AGPL/NONC の **コード複製は禁止**、NONC は依存採用も不可。
- 寛容ライセンス（MIT/BSD/Apache-2.0）を**依存として**使う場合は **帰属表示 / NOTICE** を整備する。
- **着手前に HQ の prior-art 索引（`onmt/spica:prior-art/INDEX.md`）で既存研究を探し、あれば再利用**（再調査しない）。結果は本 repo の `docs/prior-art/<feature>.md`（HQ集約用の frontmatter 付き）に残し、HQ へ1行報告する（報告→集約→再利用＝良サイクル）。
<!-- spica-doctrine:end -->
