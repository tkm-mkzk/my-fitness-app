module DeadLiftWeightRecordsHelper
  # チャートの最大値を設定するメソッド
  def dead_lift_max_value(user, range)
    max_weight = user.dead_lift_weight_records.where(dead_lift_day: range).maximum(:dead_lift_weight)
    max_weight.round + 1 if max_weight
  end

  # チャートの最小値を設定するメソッド
  def dead_lift_min_value(user, range)
    min_weight = user.dead_lift_weight_records.where(dead_lift_day: range).minimum(:dead_lift_weight)
    min_weight.round - 1 if min_weight
  end

  # チャート表示用
  def dead_lift_chart_graph(user, range)
    chart_max = dead_lift_max_value(user, range)
    chart_min = dead_lift_min_value(user, range)
    line_chart user.dead_lift_weight_records.group_by_day(:dead_lift_day, range: range, series: false).average(:dead_lift_weight), min: chart_min, max: chart_max, points: false, colors: ['mediumseagreen']
  end

  # 範囲内に記録があるか確認するメソッド
  def chart_data?(user, range)
    user.dead_lift_weight_records.where(dead_lift_day: range).present?
  end
end
