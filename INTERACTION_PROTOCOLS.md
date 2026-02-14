業務プロセスと相互作用 (Interaction Protocols)

この組織は以下のプロトコルに従って駆動します。

### A. 開発・制作フェーズ (Development Protocol)

1. 要求定義: 顧客 → Orchestrator（要件定義書作成）
2. 設計・実装: Orchestrator → Architect / Designer（実装・制作）
* *Side Loop:* Architect ⇄ Operator（ラバーダック・デバッグ）


3. 検証: Architect / Designer → Operator（テスト環境での検証・バグ出し）
* *Side Loop:* Docker操作: Operator → Dockerコンテナでテスト実行（`docker compose exec ...`）
* *Side Loop:* 結果キャプチャ: Operator はDocker操作のログを記録し、テスト結果を分析
4. 承認: Operator（テスト結果報告）→ Orchestrator（受入判定）
5. 納品: Orchestrator → 顧客

### B. 資産運用・アービトラージフェーズ (Investment Protocol)

1. 戦略策定: Catalyst（マクロ視点）+ Architect（定量的視点）
2. 承認・リスク設定: Orchestrator（ドローダウン許容値などの設定）
3. 実装・執行: Architect（Bot実装）+ Operator（監視・ログ確認）
4. 報告: Orchestrator → 顧客（月次レポート：Sharpe Ratio, Alpha値など）

### C. コンサルティング・SNSフェーズ (Engagement Protocol)

1. コンセプト: Catalyst（市場ニーズ）+ Designer（表現）
2. 品質管理: Orchestrator（炎上リスクチェック、ブランド整合性確認）
3. 投稿・実務: Operator（入稿・予約設定・リプライ一次対応）
4. 分析: Operator（データ収集）→ Catalyst / Designer（次回施策へ反映）

### D. Docker操作プロトコル (Docker Operation Protocol)
1. Operator は以下のDocker操作を許可される:
* `docker compose exec <service> <command>` - 既存コンテナ内でのコマンド実行
* `docker ps` - コンテナの状態確認
* `docker logs <container>` - コンテナログの取得

2. 禁止される操作:
* `docker run`, `docker build` - 新しいコンテナの作成
* コンテナの削除（`docker rm`, `docker compose down`）
* Dockerソケットの直接操作

3. セキュリティガードレール:
* 単一操作のタイムアウト: 5分（300秒）
* 全操作は監査ログに記録
* 本番環境への書き込みは禁止（Read Only推奨）
4. トラブルシューティング:
* コンテナが停止している場合 → Orchestratorに報告
* ネットワーク接続エラー → Orchestratorに報告
* 許可外のコマンドが必要 → Orchestratorに相談
