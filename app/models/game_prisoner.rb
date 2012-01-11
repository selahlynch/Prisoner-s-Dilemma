class GamePrisoner < ActiveRecord::Base
  belongs_to :game #, :validate => true
  belongs_to :prisoner #, :validate => true

  #make sure (:game_id, :prisoner_id) is unique
  ###this is also done in the database with a unique index
  validates_uniqueness_of :game_id, :scope => :prisoner_id, :message => "game/prisoner pair is not unique"
  

  validates_presence_of :game  ##distinct from :game_id
  validates_presence_of :prisoner  ##distinct from :prisoner_id

  #make sure that two entries for the current game don't already exist
  validate :validates_game_has_room_for_new_prisoner, :on => :create ,:if => :game_exists?
  
  def game_exists?
    ! game.nil?
  end
  
  def game_has_room_for_new_prisoner?
    game.prisoners.count < 2
  end
  
  def validates_game_has_room_for_new_prisoner
    if !(game_has_room_for_new_prisoner?)
      errors.add(:game_id, "game does not have room for new prisoners")
    end
  end
  
  
end
