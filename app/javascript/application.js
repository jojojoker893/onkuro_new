import "@hotwired/turbo-rails"
import "controllers"
import Chartkick from "chartkick";
import Highcharts from "highcharts";
Chartkick.use(Highcharts);
window.Highcharts = Highcharts;

//import { Turbo } from "@hotwired/turbo-rails";
//Turbo.session.drive = false;

document.addEventListener("turbo:load", () => {
const flashMessages = document.querySelectorAll(".flash");

flashMessages.forEach((flash) => {
  setTimeout(()=> {
    flash.classList.add("fade");
    setTimeout(()=> flash.remove(), 500);
  }, 3000);
});
});
