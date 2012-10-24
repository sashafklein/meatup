# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  zip             :string(255)
#  apology         :boolean
#  is_host         :boolean          default(FALSE)
#  is_rancher      :boolean          default(FALSE)
#  is_butcher      :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :order_id, :zip,
                  :is_host, :is_rancher, :is_butcher
  attr_accessible :name, :email, :password, :password_confirmation, :order_id, :zip, 
                  :is_host, :is_rancher, :is_butcher, :admin, :apology, :as => :administrator
  has_many :orders
  has_one :host
  has_one :butcher
  has_one :rancher

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  # after_create :zip_test

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :zip, presence: true, length: { is: 5 }

  def end_apology
    if self.apology
      self.update_attribute(:apology, false)
    end
  end

  private

    def zip_test
      if self.unacceptable_zip
        # Send an email and prohibit orders
        # Add to expansion list
      end
    end

    def unacceptable_zip
      zip = self.zip
      bay_area_zips = ["94114"]

      bay_area_zips.each do |z|
        return false if z == zip
      end

      return true
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
