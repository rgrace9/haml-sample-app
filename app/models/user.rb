class User < ApplicationRecord
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    # before_save { self.email = self.email.downcase } ^^^^equivalent formulation
    # before_save { email.downcase! } ^^^^equivalent formulation
    validates(:name, presence: true, length: {maximum: 50})
    # validates :name, presence: true  ^^^^equivalent formulation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, 
        presence: true, 
        length: {maximum: 255}, 
        format: { with: VALID_EMAIL_REGEX }, 
        uniqueness: true
 
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # class << self
    #     def digest(string)
    #         cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :  BCrypt::Engine.cost
    #         BCrypt::Password.create(string, cost: cost)
    #     end

    #     def new_token
    #         SecureRandom.urlsafe_base64
    #     end
    # end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

end
