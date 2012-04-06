class PlayController < ApplicationController

  before_filter :confirm_logged_in
  before_filter :confirm_game_access, :only => [:play_game, :plead]


  def choose_game
    prisoner_id = session[:prisoner_id]
    @prisoner = Prisoner.find(prisoner_id)
    @games = @prisoner.games  
  end

  
  def play_game
    
    if(params[:game_id])
      session[:game_id] = params[:game_id]
    end

    prisoner_id = session[:prisoner_id]
    game_id = session[:game_id]
    @prisoner = Prisoner.find(prisoner_id)
    @game = Game.find(game_id)

    ##assuming two prisoners already in this game ##is this safe??
    @other_prisoner = nil
    @game.prisoners.each do |thispris| 
      if thispris.id.to_i != prisoner_id.to_i  ##those to_i's are important
        @other_prisoner = thispris
      end
    end
    
    @you_went = ! @prisoner.game_prisoners.find_by_game_id(game_id).confess.nil?
    @they_went = ! @other_prisoner.game_prisoners.find_by_game_id(game_id).confess.nil?

    if(@you_went && @they_went)
      you_squealed = @prisoner.game_prisoners.find_by_game_id(game_id).confess
      they_squealed = @other_prisoner.game_prisoners.find_by_game_id(game_id).confess
      sentance(you_squealed, they_squealed)
    end
    
  end


  def plead
    confirm_game_access

    prisoner_id = session[:prisoner_id]
    game_id = session[:game_id]

    gp = GamePrisoner.where(:prisoner_id => prisoner_id, :game_id => game_id).first
    gp.confess = params[:confess]
    gp.save!

    redirect_to(:action => 'play_game', :message => 'plead_guilty')
  end  
  
  private
  
  def sentance(you_squeal, they_squeal)
    if you_squeal && they_squeal
      @your_sentance = 3
      @their_sentance = 3
    elsif !you_squeal && !they_squeal
      @your_sentance = 1
      @their_sentance = 1
    elsif you_squeal && !they_squeal
      @your_sentance = 0
      @their_sentance = 12
    elsif !you_squeal && they_squeal
      @your_sentance = 12
      @their_sentance = 0
    end  
  end
  
  
end


