# Pin npm packages by running ./bin/importmap
pin "application"
pin "highcharts" # @12.1.2
pin "chartkick" # @5.0.1
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "controllers"
#pin_all_from "app/javascript/controllers", under: "controllers"
