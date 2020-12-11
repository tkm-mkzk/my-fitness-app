# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association
- has_many :blogs, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :body_weights, dependent: :destroy
- has_many :bench_press_weight_records, dependent: :destroy
- has_many :dead_lift_weight_records, dependent: :destroy
- has_many :squat_weight_records, dependent: :destroy


## blogs テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| title                | string     | null: false                    |
| target_site          | string     | null: false                    |
| menu_and_impressions | text       | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments, dependent: :destroy

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :blogs

## body_weights テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| weight       | integer    |                                |
| day          | date       |                                |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## bench_press_weight_record テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| bench_press_weight  | integer    |                                |
| bench_press_day     | date       |                                |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## dead_lift_weight_record テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| dead_lift_weight  | integer    |                                |
| dead_lift_day     | date       |                                |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## squat_weight_record テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| squat_weight  | integer    |                                |
| squat_day     | date       |                                |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
