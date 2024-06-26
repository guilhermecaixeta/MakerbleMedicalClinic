# Be sure to restart your server when you modify this file.
Rails.application.config.assets.prefix = "/app/assets"

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "coreui", "5.0.0")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "coreui", "admin")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "coreui", "icons-2")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "coreui", "chartjs", "4.0.0", "dist", "css")
Rails.application.config.assets.paths << Rails.root.join("vendor", "assets", "simplebar", "core", "1.4.2", "dist")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( bootstrap.esm.min.js
                                                  popper.js
                                                  index.js
                                                  admin.esm.js )
