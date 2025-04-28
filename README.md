## Onkuro

『Onkuro』は、クローゼットの中身をオンラインで一元管理できるサービスです。<br>
服を登録することで持ち物の全体像が可視化され、「本当に必要な服」だけを残すための整理・見直し・手放す判断をサポートします。<br>
ミニマリストを目指している方や、クローゼットの中を整理したいと感じている方に向け、服を減らすことに特化したクローゼット管理ツールです。<br>

### リンク: https://onkuro.online/

## テストユーザアカウント
- メールアドレス: test@example.com
- パスワード: password

## トップページ
<img style="width: 70%" alt="トップページ" src="https://github.com/user-attachments/assets/bd703ebc-76f1-4baf-a218-f3c2bb21f9ed" />

## スマホ版

![output](https://github.com/user-attachments/assets/41c70403-b012-4c9c-bca3-7af7e74fdc17)



## インフラ構成図
<img style="width: 50%" alt="インフラ構成図" src="https://github.com/user-attachments/assets/01ffaf34-f3ef-41ed-bd99-45557db55483" />

## ER図

```mermaid
erDiagram
  USERS ||--o{ CLOTHINGS : has
  USERS ||--o{ CLOTHING_USAGE_LOGS : has

  CLOTHINGS ||--o{ CLOTHING_USAGE_LOGS : has
  CLOTHINGS }o--|| CATEGORIES : belongs_to
  CLOTHINGS }o--|| BRANDS : belongs_to
  CLOTHINGS }o--|| COLORS : belongs_to

  CLOTHING_USAGE_LOGS {
    bigint clothing_id
    bigint user_id
    timestamp used_at
  }

  CLOTHINGS {
    bigint user_id
    string name
    bigint category_id
    bigint brand_id
    bigint color_id
    text explanation
  }

  USERS {
    string name
    string email
    string password_digest
  }

  CATEGORIES {
    string name
  }

  BRANDS {
    string name
  }

  COLORS {
    string name
  }
```


## 使用技術スタック
- Ruby 3.3.5
- Ruby on Rails 8.0.1
- MySQL 9.1.0
- AWS (EC2 ELB RDS S3 Route53)
- JavaScript
- HTML/CSS

## 機能・画面
### ログイン機能
- メアドとパスワードでログイン可能、ホーム画面に遷移後に各機能を使用できます。
![login_demo](https://github.com/user-attachments/assets/5eabb2ca-fa0c-49c5-aeba-d318b5580e20)

### ホーム(グラフ画面)
- 自分の所有している服のごと使用回数を円グラフで表示しています。<br>
ヘッダーから期間を指定するとその期間で使用された服の使用回数を表示できます。
![名称未設定 (2)](https://github.com/user-attachments/assets/8d70554b-cff1-4e67-aa86-abb6c10a489b)


### 一覧
- 登録した服の一覧から登録した服の名前で検索、使用回数での並び替え、ジャンルごとの並び替えが可能です。
![名称未設定](https://github.com/user-attachments/assets/7b0e8b3f-77cf-4580-9cb4-5d6a83cb32c6)

### 登録
- 画像、名前、カテゴリ、色、ブランド、備考欄を入力し服を登録します。
- 画像は範囲部分にドラッグ&ドロップで画像を読み込み可能です。
- ブランド名はモーダルウィンドウを使用し文字入力による検索、絞り込みができます。
![brand_modal](https://github.com/user-attachments/assets/cd5e2aa7-3f86-4c8e-814c-54a2fba8b7b9)

### 付近の古着屋、リサイクルショップを表示
- 自身の位置情報を取得し、周辺5kmの古着屋、リサイクルショップの取得をしいらない服の売り場に困りません<br>(身バレ防止の為ランダムな位置情報を入れた画像です。)
- 赤ピンがホバーした際に店の詳細情報が表示されます
<img style="width:67%" alt="位置情報" src="https://github.com/user-attachments/assets/e3417ab4-01b9-4874-8779-a41fd119e968" />

### アカウント管理
- ユーザ名、メールアドレスの更新
- パスワードの変更
- アカウント削除&ログアウトができます
<img style="width:67%" alt="スクリーンショット 2025-04-11 10 49 33" src="https://github.com/user-attachments/assets/8c6688d5-9729-4991-9382-49eb9e944ce5" />

## 技術的に工夫したところ
### 位置情報を保存せず、現在地の取得
- データベースに緯度経度を保持しないことで、ユーザーの追跡・特定リスクを軽減。
- navigator.geolocation を使って現在地をリアルタイム取得
- 毎回その場の現在地を取得して、Google Maps APIと連携。

### 服の使用時に、イベントを発生させイベント管理をしているテーブルに保存し使用回数をグラフで表示できるようにした
Onkuro では、服の使用履歴を CLOTHING_USAGE_LOGS テーブルに1レコードずつ記録する設計を採用しています。<br>
これにより、以下のような柔軟な機能を実現しています。

- 期間指定での使用回数集計（例: 1ヶ月以内に着た服の使用回数を集計する）
- 時系列での使用頻度の可視化（円グラフ表示）
- 将来的な「季節ごとの傾向分析の表示機能」や「直近で使っていない服の提案機能」などへの拡張性を持たせた。

単純な使用回数カウントをUPDATEする方式ではなく、イベントテーブルのレコードとして記録することで、集計を実現しています。

## ユーザ目線で工夫したところ
- 服の管理だけでなく手放すことをサポートする為付近のリサイクルショップ、古着屋を簡単に探せるようにした
- 総使用回数だけでなく、指定した期間の使用回数を取得できるようにした
- ブランド名など項目が多くなる部分はモーダルウィンドウを作成し検索を簡単にした
- 余計な機能やボタンを増やさず、直感的に使用できるレイアウトを意識した
- レスポンシブ対応をしてスマホユーザでも使えるようにした


