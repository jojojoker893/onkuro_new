## Onkuro

『Onkuro』は、クローゼットの中身をオンラインで一元管理できるサービスです。<br>
服を登録することで持ち物の全体像が可視化され、「本当に必要な服」だけを残すための整理・見直し・手放す判断をサポートします。<br>
ミニマリストを目指している方や、クローゼットの中を整理したいと感じている方に向け、服を減らすことに特化したクローゼット管理ツールです。<br>

### リンク: https://onkuro.online/

## トップページ
<img style="width: 80%" alt="トップページ" src="https://github.com/user-attachments/assets/bd703ebc-76f1-4baf-a218-f3c2bb21f9ed" />


## インフラ構成図
<img style="width: 50%" alt="インフラ構成図" src="https://github.com/user-attachments/assets/01ffaf34-f3ef-41ed-bd99-45557db55483" />


## 使用技術スタック
- Ruby on Rails 
- MySQL
- AWS
- JavaScript
- HTML/CSS

## 機能・画面
### ログイン機能
- メアドとパスワードでログイン可能、ホーム画面に遷移後に各機能を使用できます。
![login_demo](https://github.com/user-attachments/assets/5eabb2ca-fa0c-49c5-aeba-d318b5580e20)

### ホーム(グラフ画面)
- 自分の所有している服のごと使用回数を円グラフで表示しています。<br>
ヘッダーから期間を指定するとその期間で使用された服の使用回数を表示できます。
![period_selection](https://github.com/user-attachments/assets/dc3da699-a3c8-4dbf-805e-f46973421979)

### 一覧
- 登録した服の一覧から登録した服の名前で検索、使用回数での並び替え、ジャンルごとの並び替えが可能です。
![sort_list](https://github.com/user-attachments/assets/63649b9c-4c90-4fda-ab4f-d953a4714e3c)

### 登録
- 画像、名前、カテゴリ、色、ブランド、備考欄を入力し服を登録します。
- 画像は範囲部分にドラッグ&ドロップで画像を読み込み可能です。
- ブランド名はモーダルウィンドウを使用し文字入力による検索、絞り込みができます。
![brand_modal](https://github.com/user-attachments/assets/cd5e2aa7-3f86-4c8e-814c-54a2fba8b7b9)

### 付近の古着屋、リサイクルショップを表示
- 自身の位置情報を取得し、周辺5kmの古着屋、リサイクルショップの取得をしいらない服の売り場に困りません<br>(身バレ防止の為ランダムな位置情報を入れた画像です。)
- 赤ピンがホバーした際に店の詳細情報が表示されます
<img style="width:80%" alt="位置情報" src="https://github.com/user-attachments/assets/e3417ab4-01b9-4874-8779-a41fd119e968" />

### アカウント管理
- ユーザ名、メールアドレスの更新
- パスワードの変更
- アカウント削除&ログアウトができます
<img style="width:80%" alt="スクリーンショット 2025-04-11 10 49 33" src="https://github.com/user-attachments/assets/8c6688d5-9729-4991-9382-49eb9e944ce5" />
