require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true # Проверка заполненности
  validates :email, :username, uniqueness: true # Проверка уникальности
  validates :email, email: true # Проверка формата email
  validates :username, length: { maximum: 40 } # Проверка длины nickname
  validates :username, format: /\A\w+\z/ # Проверка формата nickname

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :username_to_lowercase
  before_save :encrypt

  def encrypt
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  # Перевод nickname в нижний регистр
  def username_to_lowercase
    if self.username.present?
      self.username.downcase!
    end
  end
end
