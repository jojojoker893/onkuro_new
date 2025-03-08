# Pin npm packages by running ./bin/importmap
pin "application"
pin "highcharts", to: "https://code.highcharts.com/highcharts.js" # @12.1.2
pin "chartkick", to: "https://cdn.jsdelivr.net/npm/chartkick@5.0.1/dist/chartkick.min.js" # @5.0.1
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "controllers"
pin_all_from "app/javascript/controllers", under: "controllers"
