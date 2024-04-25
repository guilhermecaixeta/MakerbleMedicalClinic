# Pin npm packages by running ./bin/importmap

pin "application"
pin "backoffice"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.esm.min.js", preload: true
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/esm/index.js", preload: true

pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js", preload: true
pin "@kurkle/color", to: "https://cdn.jsdelivr.net/npm/@kurkle/color@0.3.2/dist/color.esm.min.js", preload: true

pin "simplebar", to: "https://cdn.jsdelivr.net/npm/simplebar@6.2.5/+esm" # @6.2.5
pin "can-use-dom", to: "https://cdn.jsdelivr.net/npm/can-use-dom@0.1.0/+esm" # @0.1.0
pin "lodash-es", to: "https://cdn.jsdelivr.net/npm/lodash-es@4.17.21/+esm" # @4.17.21

# https://coreui.io/bootstrap/docs/getting-started/download/
pin "@coreui/coreui", to: "https://cdn.jsdelivr.net/npm/@coreui/coreui@5.0.0/dist/js/coreui.bundle.min.js", preload: true
pin "@coreui/chartjs", to: "https://cdn.jsdelivr.net/npm/@coreui/chartjs@4.0.0/dist/js/coreui-chartjs.min.js"
pin "@coreui/utils", to: "https://cdn.jsdelivr.net/npm/@coreui/utils@2.0.2/dist/umd/index.js"
pin "@coreui/icons", to: "https://cdn.jsdelivr.net/npm/@coreui/icons@3.0.1/dist/esm/index.js"
pin "@coreui/admin", to: "coreui/admin/dist/admin.esm.js"
