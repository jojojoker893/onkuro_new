//import "@hotwired/turbo-rails"
//import "./controllers"
//import Chartkick from "chartkick"
//import Highcharts from "highcharts"
//Chartkick.use(Highcharts);

// Import modules
//import * as Highcharts from "highcharts";
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

import * as Highcharts from "highcharts"; // 修正

document.addEventListener("turbo:load", function () {
  window.Highcharts.chart("chart_container", {
    chart: { type: "pie" },
    title: { text: "" },
    series: [{
      name: "使用回数",
      colorByPoint: true,
      data: [
        { name: "T-Shirts", y: 10 },
        { name: "Jeans", y: 15 },
        { name: "Jackets", y: 7 },
        { name: "Dresses", y: 5 },
        { name: "Shoes", y: 8 }
      ]
    }],
    tooltip: {
      pointFormat: "{series.name}: <b>{point.y}回</b>"
    }
  });
});


