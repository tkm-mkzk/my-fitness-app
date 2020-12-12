module SquatWeightRecordsHelper
  # チャートの最大値を設定するメソッド
  def squat_max_value(user, range)
    max_weight = user.squat_weight_records.where(squat_day: range).maximum(:squat_weight)
    max_weight.round + 1 if max_weight
  end

  # チャートの最小値を設定するメソッド
  def squat_min_value(user, range)
    min_weight = user.squat_weight_records.where(squat_day: range).minimum(:squat_weight)
    min_weight.round - 1 if min_weight
  end

  # チャート表示用
  def squat_chart_graph(user, range)
    chart_max = squat_max_value(user, range)
    chart_min = squat_min_value(user, range)
    line_chart user.squat_weight_records.group_by_day(:squat_day, range: range, series: false).average(:squat_weight), min: chart_min, max: chart_max, points: false, colors: ['crimson']
  end

  # 範囲内に記録があるか確認するメソッド
  def chart_data?(user, range)
    user.squat_weight_records.where(squat_day: range).present?
  end
end
