# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'rest-client'
Character.destroy_all
Map.destroy_all



raw_characters = RestClient.get('https://api.hotslogs.com/Public/Data/Heroes')
parsed_characters = JSON.parse(raw_characters)

parsed_characters.each do |character_info|
  new_character = Character.new
  new_character.name = character_info["PrimaryName"]
  new_character.role = character_info["Group"]
  new_character.save
end

raw_maps = RestClient.get("http://hotsapi.net/api/v1/maps")
parsed_maps = JSON.parse(raw_maps)

parsed_maps.each do |map_info|
  new_map = Map.new
  new_map.name = map_info.first[1]
  new_map.save
end


x = 1

valid_game_types = ['QuickMatch', 'HeroLeague', 'TeamLeague']
while x < 2500
  raw_page = RestClient.get("http://hotsapi.net/api/v1/replays/paged?page=#{x}&start_date=2017-10-25&with_players=true")
  replay_page = JSON.parse(raw_page)
  unless replay_page['replays'] == []
    replay_page['replays'].each do |replay|
      if valid_game_types.include?(replay['game_type'])
        replay_map = Map.find_by(name: replay['game_map']['name'])
        newReplay = Replay.new
        replay_map.replays << newReplay
        newReplay.save
        replay['players'].each do |player_info|
          unless player_info == []
            newPlayer = Player.new
            newPlayer.character = Character.find_by(name: player_info['hero']['name'])
            newPlayer.winner = player_info['winner']
            newPlayer.map_id = replay_map.id
            newReplay.players << newPlayer
            newPlayer.save
          end
        end
      end
    end
  end
  x+=1
end

# test_replay = RestClient.get("http://hotsapi.net/api/v1/replays/1337")
# test_replay = JSON.parse(test_replay)
#
# replayMap = Map.find_by(name: test_replay['game_map'])
# newReplay = Replay.new
# replayMap.replays << newReplay
# newReplay.save
#
# test_replay['players'].each do |player_info|
#   newPlayer = Player.new
#   newPlayer.character = Character.find_by(name: test_replay['players'].first['hero'])
#   newPlayer.winner = player_info['winner']
#   newReplay.players << newPlayer
#   newPlayer.save
# end
