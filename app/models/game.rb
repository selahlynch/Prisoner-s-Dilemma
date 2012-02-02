class Game < ActiveRecord::Base
  has_many :game_prisoners
  has_many :prisoners, :through => :game_prisoners
  
 # accepts_nested_attributes_for :game_prisoners, :allow_destroy => true #, :reject_if => :new_record?

  validates :name, :length => {:minimum => 1, :maximum => 100}

  def prisoner_names
    prisoners.collect{|p| p.name}.join(', ')
  end

  ##VIRTUAL ATTRIBUTE!!!
  def prisoner_ids
    @prisoner_ids || prisoners.collect{|p| p.id}
  end

  def prisoner_ids=(id_array)
    @prisoner_ids = id_array.collect{|id| id.to_i};
  end
    
  after_save :assign_prisoners

  
  private

  def assign_prisoners
    if @prisoner_ids

      new_ids = @prisoner_ids
      old_ids = prisoners.collect{|p| p.id}
      ids_to_delete = old_ids - (old_ids & new_ids)
      ids_to_add = new_ids - (old_ids & new_ids)

      game_id = id
      
      ids_to_delete.each do |prisoner_id|
        GamePrisoner.destroy_all(:game_id => game_id, :prisoner_id => prisoner_id)
      end

      ids_to_add.each do |prisoner_id|
        GamePrisoner.create(:game_id => game_id, :prisoner_id => prisoner_id)
      end

    end
  end


end


