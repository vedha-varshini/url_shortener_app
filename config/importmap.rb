# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "application"
pin "@rails/ujs", to: "rails-ujs.js"
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.16
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.13
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @8.0.200
