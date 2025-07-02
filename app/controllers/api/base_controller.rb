# app/controllers/api/base_controller.rb
class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session  # disables CSRF for APIs
end
