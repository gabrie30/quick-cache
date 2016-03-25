  require 'fullcontact'

  FullContact.configure do |config|
      config.api_key = Rails.application.secrets.full_contact_API_key
  end