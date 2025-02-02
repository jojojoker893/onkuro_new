import "chartkick"
import "Chart.bundle"
import "@hotwired/turbo-rails"
import "controllers"

import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;

document.addEventListener("DOMContentLoaded", () => {
const flashMessages = document.querySelectorAll(".flash");

flashMessages.forEach((flash) => {
  setTimeout(()=> {
    flash.classList.add("fade");
    setTimeout(()=> flash.remove(), 500);
  }, 3000);
});
});