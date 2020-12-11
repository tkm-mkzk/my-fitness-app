document.addEventListener('turbolinks:load', function() {
  const daily_btn = document.getElementById("daily-bench-press-chart-btn");
  const weekly_btn = document.getElementById("weekly-bench-press-chart-btn");
  const monthly_btn = document.getElementById("monthly-bench-press-chart-btn");
  const daily_chart = document.getElementById("daily-bench-press-chart");
  const weekly_chart = document.getElementById("weekly-bench-press-chart");
  const monthly_chart = document.getElementById("monthly-bench-press-chart");

  // ボタン、チャートの初期化設定 //
  const remove_active = function() {
    daily_btn.classList.remove("active");
    weekly_btn.classList.remove("active");
    monthly_btn.classList.remove("active");
    daily_chart.classList.remove("active");
    weekly_chart.classList.remove("active");
    monthly_chart.classList.remove("active");
  };

  //ボタンを押したらそれに対応するチャートにactiveクラスを付加//
  $(daily_btn).on('click', function() {
    remove_active();
    $(daily_btn).addClass('active');
		$(daily_chart).addClass('active');
  });

  $(weekly_btn).on('click', function() {
    remove_active();
    $(weekly_btn).addClass('active');
		$(weekly_chart).addClass('active');
  });

  $(monthly_btn).on('click', function() {
    remove_active();
    $(monthly_btn).addClass('active');
		$(monthly_chart).addClass('active');
	});
});
