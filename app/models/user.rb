class User < ActiveRecord::Base
    # must clarify active_relationships modeled by class different name
    has_many :relationships, dependent: :destroy
  
    attr_accessor :remember_token, :activation_token, :reset_token
    # look for fxns below to call before saving
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    # CHANGE THIS TO INCLUDE FORMAT
    validates :phone_number, presence: true, length: { minimum: 10, maximum: 11}, uniqueness: { case_sensitive: false }
    has_secure_password #hash password & compare to hash in db, dont save actual. needs password_digest in table
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    # returns hash digest of given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # returns random token for cookies
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # associate token and its digest by updating remember digest
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    # metaprogramming - either matches password digest or activation with given
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    
    # forgets user
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    # activates account
    def activate(pin)
        if pin == self.activation_digest
            update_attribute(:activated, true)
            update_attribute(:activated_at, Time.zone.now)
            return true
        return false
    end
    
    # sends activation text
    def send_activation_text
        pin = rand(9999)
        send_activation_text(self, pin)
        update_attribute(:activation_digest, "#{pin}")
    end
    
    # sets password reset attributes
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end
    
    #sends password reset email
    def send_password_reset_text

    end
    
    # true if password reset expired
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    # selects all the posts owned by the user (? avoids sql injection)
    def feed
        
    end
    
    # follow other_user
    def follow(stream)
        relationships.create(followed_id: stream.id)
    end
    
    # unfollow other_user
    def unfollow(stream)
        relationships.find_by(followed_id: stream.id).destroy
    end
    
    # true if following other_user
    def following?(stream)
        following.include?(stream)
    end
    
    private
        
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
