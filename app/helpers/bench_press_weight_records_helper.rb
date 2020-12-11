module BenchPressWeightRecordsHelper
  # チャートの最大値を設定するメソッド
  def bench_press_max_value(user, range)
    max_weight = user.bench_press_weight_records.where(bench_press_day: range).maximum(:bench_press_weight)
    max_weight.round + 1 if max_weight
  end

  # チャートの最小値を設定するメソッド
  def bench_press_min_value(user, range)
    min_weight = user.bench_press_weight_records.where(bench_press_day: range).minimum(:bench_press_weight)
    min_weight.round - 1 if min_weight
  end

  # チャート表示用
  def bench_press_chart_graph(user, range)
    chart_max = bench_press_max_value(user, range)
    chart_min = bench_press_min_value(user, range)
    line_chart user.bench_press_weight_records.group_by_day(:bench_press_day, range: range, series: false).sum(:bench_press_weight), min: chart_min, max: chart_max, points: false, colors: ['orange']
  end

  # 範囲内に記録があるか確認するメソッド
  def chart_data?(user, range)
    user.bench_press_weight_records.where(bench_press_day: range).present?
  end
end
