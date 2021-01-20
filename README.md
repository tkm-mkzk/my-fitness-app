# Big3Blog

<img width="1665" alt="スクリーンショット 2021-01-19 12 51 26" src="https://user-images.githubusercontent.com/71067058/104985800-20909b80-5a55-11eb-844b-d37621117623.png">

## アプリケーション概要

Big3(ベンチプレス、デッドリフト、スクワットの筋トレの主要な3種目)の最高記録や体重を記録できるアプリです。グラフ機能も備えており、全ての記録をグラフを用いて管理できます。また、行ったトレーニングも写真付きのブログで記録していくことができます。

## URL

www.big3blog.com (トップページからゲストログインすることができます)

## 制作背景

より多くの人のトレーニングの手助けになれればと思いこのアプリを開発しました。

- どのくらいの頻度でどの部位をトレーニングしているのか覚えていない。
- 筋トレやジムに行くモチベーションを上げたい。
- ベンチプレスのMAXや体重を記録しておきたい。

上記のことは私が思っていたことなのですが、トレーニングを行っている人なら一度は考えたことがあるのではないでしょうか。このアプリは上記のことを全て解決します。また、

- ジムを契約したけど続かずに辞めてしまった。
- 最近太ってきたけど気にせずに食べ過ぎてしまう。
- みんながどのようなトレーニングを行っているのか知りたい。

このような話もよく耳にします。トレーニングを記録することは継続を確認することができ、それがモチベーションの向上につながります。

## 工夫したポイント

- グラフ表示を週、月、年単位の三種類用意し、記録の変化を視覚的に見やすくしました。
- 記録を小数点以下まで細かく設定できるようにしました。
- 全て英語を使うことで、日本人だけではなく外国の方などより多くの人に使ってもらえることを意識しました。
- big3の記録表示を自動で計算し表示出来るようにしました。
- デザインはなるべく色を使うことを控え、洗練され、見やすいデザインを意識しました。

## 機能一覧

### ユーザー機能

- ユーザーの新規登録、ログイン、編集
- ゲストログイン

### 記録機能(体重、ベンチプレス、デッドリフト、スクワット)

- 体重や各種目のMAXを記録

<img width="1159" alt="スクリーンショット 2021-01-19 12 56 25" src="https://user-images.githubusercontent.com/71067058/104986530-87fb1b00-5a56-11eb-9d06-a258b6eb7b77.png">

- 保存した記録をグラフに表示（週間、月間、年間の切り替え表示可能）

![624dab787c4aa40d4bb7e79727694189](https://user-images.githubusercontent.com/71067058/104987907-145b0d00-5a5a-11eb-996e-a2296dd94f1d.gif)

- 記録の編集/削除
- マイページにて各記録、そしてベンチプレス、デッドリフト、スクワットのMAXの合計を表示（体重のみ非公開設定可能）

### ブログ投稿機能

- ブログの新規投稿、編集、削除(プレビュー機能付き)
- 記事一覧表示
- コメント機能

### その他

- レスポンシブデザイン
- rubocop
- Rspecによる単体テスト、結合テスト

## 使用技術

- HTML / SCSS
- Javascript
- JQuery
- Bootstrap4
- Ruby 2.6.5
- Rails 6.0.0
- MySQL2
- AWS(EC2, VPC, RDS, Route53, ACM, ALB, S3)
- RSpec
- rubocop

## 今後実装したいこと

- フォロー機能
- big3のランキング表示機能
- docker環境構築
- CircleCIを使った自動デプロイ
- いいね機能

## AWS構成図

![AWS](https://user-images.githubusercontent.com/71067058/105130416-56538400-5b2a-11eb-9594-dac2cb299904.png)

## データベース設計

![big3blog_er drawio](https://user-images.githubusercontent.com/71067058/103068139-deb03900-45ff-11eb-8df3-43d21df2c048.png)

### users テーブル

| Column             | Type    | Options                    |
| ------------------ | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, default: ""   |
| encrypted_password | string  | null: false, default: ""   |
| private            | boolean | null: false, default: true |

#### Association
- has_many :blogs, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :body_weights, dependent: :destroy
- has_many :bench_press_weight_records, dependent: :destroy
- has_many :dead_lift_weight_records, dependent: :destroy
- has_many :squat_weight_records, dependent: :destroy


### blogs テーブル

| Column               | Type       | Options           |
| -------------------- | ---------- | ----------------- |
| title                | string     | null: false       |
| target_site          | string     | null: false       |
| content              | text       | null: false       |
| user                 | references | foreign_key: true |

#### Association

- belongs_to :user
- has_many :comments, dependent: :destroy

### comments テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| text   | text       | null: false       |
| user   | references | foreign_key: true |
| blog   | references | foreign_key: true |

#### Association

- belongs_to :users
- belongs_to :blogs

### body_weights テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| weight       | float      | null: false       |
| day          | date       | null: false       |
| user         | references | foreign_key: true |

#### Association

- belongs_to :user

### bench_press_weight_record テーブル

| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- |
| bench_press_weight  | float      | null: false       |
| bench_press_day     | date       | null: false       |
| user                | references | foreign_key: true |

#### Association

- belongs_to :user

### dead_lift_weight_record テーブル

| Column            | Type       | Options           |
| ----------------- | ---------- | ----------------- |
| dead_lift_weight  | float      | null: false       |
| dead_lift_day     | date       | null: false       |
| user              | references | foreign_key: true |

#### Association

- belongs_to :user

### squat_weight_record テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| squat_weight  | float      | null: false       |
| squat_day     | date       | null: false       |
| user          | references | foreign_key: true |

#### Association

- belongs_to :user
