class FullContactLookup < ActiveRecord::Base
  require 'fullcontact'

  validates :email, presence: true, uniqueness: true
  serialize :data

  def self.by_email(email)
    user = FullContactLookup.find_by(email: email)

    if !user
      user_info = FullContact.person(email: email)
      user = FullContactLookup.new(email: email, data: user_info)
      user.save!
    end

    user.data
  end
end
