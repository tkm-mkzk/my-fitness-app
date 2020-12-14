//videoの高さ分だけコンテンツを下げる
$(function top() {
  let height=$("#video").height();
  $("body").css("margin-top", height + 10);//10pxだけ余裕をもたせる
});
