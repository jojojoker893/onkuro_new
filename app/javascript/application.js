//import "@hotwired/turbo-rails"
//import "./controllers"
//import Chartkick from "chartkick"
//import Highcharts from "highcharts"
//Chartkick.use(Highcharts);

// Import modules
import * as Highcharts from "highcharts";
//import * as Chartkick from "chartkick";
//import "chartkick"
//import { Chart } from "chart.js"; // ここを修正！

//window.Chartkick = Chartkick;
//Chartkick.Chart = Chart;

import "@hotwired/turbo-rails";
import "@hotwired/stimulus";
import "@hotwired/stimulus-loading";
import "controllers";

//Debugging: 確認のために Highcharts を出力
// document.addEventListener("turbo:load", function () {
//   console.log("Highcharts:", Highcharts);
// });

//import Chartkick from "chartkick";
//import Chart from "chart.js"; // Chart.jsの最新バージョンを使用

// Chartkick に Chart.js を設定する
//Chartkick.use(Chart);

// import "@hotwired/turbo-rails";
// import "@hotwired/stimulus";
// import "@hotwired/stimulus-loading";
// import "controllers";

