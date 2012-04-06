require 'digest/sha1' #for encrypting

class Prisoner < ActiveRecord::Base
  has_many :game_prisoners
  has_many :games, :through => :game_prisoners
  
  validates :name, :length => {:minimum => 1, :maximum => 100}
  
  attr_protected :encrypted_password, :salt
  #attributes that we DONT EVER want to update using a FORM

  validates :password, :length => {:in => 4..25, :on => :create, :on => :update}, :confirmation => true, :unless => :no_password_update? 
  validates :password_confirmation, :presence => true, :unless => :no_password_update?
    
  #not stored in database, but available as part of object
  attr_accessor :password
  attr_accessor :no_password_update
  
  before_save :create_hashed_password
  after_save :clear_password
  

  def is_in_game?(game_id)
    games.collect{|g| g.id}.include? game_id
  end


  def self.authenticate(username="", password="")
    thispris = Prisoner.find_by_name(username)
    if thispris && thispris.password_match?(password)
      return thispris
    else
      return false
    end
  end
  
  def password_match?(password="")
    encrypted_password == Prisoner.hash_with_salt(password, salt)
  end

  def self.make_salt(seed="")
    ##pretty much a random number
    Digest::SHA1.hexdigest(seed.to_s + Time.now.to_s) 
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put some #{salt} on my #{password}")
  end
  
  private

  def create_hashed_password
    if ! password.blank?
      self.salt = Prisoner.make_salt(name)
      self.encrypted_password = Prisoner.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
    self.password_confirmation = nil
  end  
  
  def no_password_update?
    no_password_update
  end
  
end





