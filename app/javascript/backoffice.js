// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "chart.js";
import "@kurkle/color";

import "@coreui/coreui";
import "@coreui/icons";
import "@coreui/utils";
import "@coreui/chartjs";
import "@coreui/admin";

const header = document.querySelector("header.header");

document.addEventListener("scroll", () => {
  if (header) {
    header.classList.toggle(
      "shadow-sm",
      document.documentElement.scrollTop > 0
    );
  }
});
