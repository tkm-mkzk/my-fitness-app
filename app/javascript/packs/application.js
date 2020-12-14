// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// グラフ
require("chartkick")
require("chart.js")
// 体重関係
require('body_weights/chart-change')
require('body_weights/modal')
// ベンチプレス関係
require('bench_press_weight_records/chart-change')
require('bench_press_weight_records/modal')
// デッドリフト関係
require('dead_lift_weight_records/chart-change')
require('dead_lift_weight_records/modal')
// スクワット関係
require('squat_weight_records/chart-change')
require('squat_weight_records/modal')
// bootstrap
import 'bootstrap'
import '../stylesheets/application'
// フラッシュメッセージを一定時間で消す
require('layouts/flash-message')
// videoの高さ分だけコンテンツを下げる
// require('layouts/top')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
