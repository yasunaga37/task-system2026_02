# task-system2026_02

## 概要
このプロジェクトは2026年4月新人研修ように作成したものです。

## クライアント環境
- Windows11 Home
- Eclipse2025
-MySQL8.2

## データベースのセットアップ

1. MySQLを起動する
2. 以下のコマンドでデータベースを作成し、SQLをインポート：

```bash
mysql -u root -p
CREATE DATABASE task_db2026_02;
EXIT

mysql -u root -p task_db2026_02 < db/task_db2026_02.sql
