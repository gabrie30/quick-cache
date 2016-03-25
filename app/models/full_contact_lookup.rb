class FullContactLookup < ActiveRecord::Base
  require 'fullcontact'

  validates :email, presence: true, uniqueness: true
  serialize :data

  def self.by_email(email=nil)
      return ArgumentError.new("Please provide an email for lookup") if email.nil?
      
      user = FullContactLookup.find_by(email: email)

      if !user
        begin
          user_info = FullContact.person(email: email)
        rescue FullContact::Invalid => invalid_error 
          return "Invalid request: #{invalid_error}"
        rescue FullContact::NotFound => not_found_error
          return "Email not found: #{not_found_error}"
        end

        if user_info.status == 200
          user = FullContactLookup.new(email: email, data: user_info)
          user.save!
        else
          return "#{user_info}"
        end
      end

      user.data
  end
end


# handles no arguments being passed => ""
# handles emails that do not exist  => "lalaalllala@kfjfjdkdkjf.com"
# handles invalid emails            => 33234, "jfjfj"
# handles valid emails              => "jgabriels30@gmail.com"

# Only saves 202 responses
