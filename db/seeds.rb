# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

prisoners = Prisoner.create([
  {:id => 1, :name => 'Bonnie'},
  {:id => 2, :name => 'Clyde'}, 
  {:id => 3, :name => 'Thelma'},
  {:id => 4, :name => 'Louise'}
])

games = Game.create([
  {:id => 1, :name => 'Robbing a Bank'},
  {:id => 2, :name => 'Shooting a Man'},
  {:id => 3, :name => 'Public Nudity'},
  {:id => 4, :name => 'Animal Cruelty'}
])

game_prisoners = GamePrisoner.create([
  {:game_id => 1, :prisoner_id => 3, :confess => true},
  {:game_id => 1, :prisoner_id => 4, :confess => false},
  {:game_id => 2, :prisoner_id => 1},
  {:game_id => 2, :prisoner_id => 2},
  {:game_id => 3, :prisoner_id => 3},
  {:game_id => 3, :prisoner_id => 1},
  {:game_id => 4, :prisoner_id => 4},
  {:game_id => 4, :prisoner_id => 2}
])


