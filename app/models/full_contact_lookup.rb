class FullContactLookup < ActiveRecord::Base
  require 'fullcontact'

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /@/
  serialize :data

  def self.by_email(email=nil)
      return nil if email.nil?
      return nil unless email.to_s.include?("@")

      @user = FullContactLookup.find_by(email: email)

      if !@user
        begin
          user_info = FullContact.person(email: email)

        rescue => e
          # to preserve our rate limit, cache bad emails
          logger.error "#{e}"
          save_lookup(email, nil, e)
        end

        if user_info && user_info.status == 200
          save_lookup(email, user_info)
        elsif user_info && user_info.status
          logger.info "#{user_info}"
          return "#{user_info}"
        end
      end

    @user.data
  end

  private

  def self.save_lookup(email, data, error=nil)
    @user = FullContactLookup.new(email: email, data: data, error: error)
    @user.save!
  end
end