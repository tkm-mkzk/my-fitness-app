# Big3Blog

## アプリケーション概要

Big3BlogBig3(ベンチプレス、デッドリフト、スクワット)の最高記録や体重を記録できるアプリです。グラフ機能も備えており、全ての記録をグラフを用いて管理できます。また、行ったトレーニングも写真付きのブログで記録していくことができます。

## URL

13.113.4.169 (トップページからゲストログインすることができます)
Basic認証
ID tkm-mkzk
Pass 7777

## 制作背景

より多くの人のトレーニングの手助けになれればと思いこのアプリを開発しました。

- 私はどのくらいの頻度でどの部位をトレーニングしているのか覚えていない。
- 筋トレやジムに行くモチベーションを上げたい。
- ベンチプレスのMAXや体重を記録しておきたい。

上記のことは私が思っていたことなのですが、トレーニングを行っている人なら一度は考えたことがあるのではないでしょうか。このアプリは上記のことを全て解決します。また、

- ジムを契約したけど続かずに辞めてしまった。
- 最近太ってきたけど気にせずに食べ過ぎてしまう。
- みんながトレーニングを行っているのか知りたい。

このような話もよく耳にします。トレーニングを記録することは継続を確認することができ、それがモチベーションの向上につながります。

## 機能一覧

### ユーザー機能

- ユーザーの新規登録、ログイン、編集
- ゲストログイン

### 記録機能(体重、ベンチプレス、デッドリフト、スクワット)

- 体重や各種目のMAXを記録
- 保存した記録をグラフに表示（週間、月間、年間の切り替え表示可能）
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
