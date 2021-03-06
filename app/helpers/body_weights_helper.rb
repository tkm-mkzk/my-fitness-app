module BodyWeightsHelper
  # チャートの最大値を設定するメソッド
  def max_value(user, range)
    max_weight = user.body_weights.where(day: range).maximum(:weight)
    max_weight.round + 1 if max_weight
  end

  # チャートの最小値を設定するメソッド
  def min_value(user, range)
    min_weight = user.body_weights.where(day: range).minimum(:weight)
    min_weight.round - 1 if min_weight
  end

  # チャート表示用
  def body_chart_graph(user, range)
    chart_max = max_value(user, range)
    chart_min = min_value(user, range)
    line_chart user.body_weights.group_by_day(:day, range: range, series: false).average(:weight), min: chart_min, max: chart_max, points: false
  end

  # 範囲内に記録があるか確認するメソッド
  def chart_data?(user, range)
    user.body_weights.where(day: range).present?
  end
end
