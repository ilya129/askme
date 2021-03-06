require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000.freeze
  DIGEST = OpenSSL::Digest::SHA256.new.freeze
  CHECKING_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/.freeze
  CHECKING_USERNAME = /\A\w+\z/.freeze

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :username, length: { maximum: 40 }, format: CHECKING_USERNAME
  validates :email, presence: true, uniqueness: true, format: CHECKING_EMAIL
  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :avatar_url, url: true, allow_blank: true
  
  before_save { email.downcase! }
  before_save { username.downcase! }
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end
end
