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
#  butcher_id      :integer
#  ranch_id        :integer
#  host_id         :integer
#  beta            :boolean          default(TRUE)
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

  scope :admins, where(:admin => true)
  scope :butchers, where(:is_butcher => true)
  scope :ranchers, where(:is_rancher => true)
  scope :hosts, where(:is_host => true)

  def end_apology
    update_attribute(:apology, false) if apology
  end

  def associated_packages(animal)
    animal.orders.includes(:packages).map(&:packages).flatten
  end

  def animal_orders(animal)
    self.orders.where(:animal_id => animal.id)
  end

  private

    def zip_test
      if unacceptable_zip
        # Send an email and prohibit orders
        # Add to expansion list
      end
    end

    def unacceptable_zip
      bay_area_zips = ["94114"]
      !bay_area_zips.include?(z)
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
