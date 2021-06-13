require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  CHECKING_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  CHECKING_USERNAME = /[a-zA-Z0-9_]+/

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, presence: true, on: :create

  validates :email, format: CHECKING_EMAIL
  validates :username, length: { maximum: 40 }
  validates :username, format: CHECKING_USERNAME

  validates :password, :presence =>true, :confirmation =>true

  before_save :encrypt_password

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
end
