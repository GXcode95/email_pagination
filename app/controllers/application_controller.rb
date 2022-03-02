class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale


  def extract_locale
    parsed_locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end


  private
  
  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
end
