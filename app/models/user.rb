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
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :order_id, :zip
  attr_accessible :name, :email, :password, :password_confirmation, :order_id, :zip, :admin, :apology, :as => :administrator
  has_many :orders

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

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

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
