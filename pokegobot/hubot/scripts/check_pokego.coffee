# Description
#   Check nearby pokemon
#
# Dependencies:
#   Poke.io (Pokemon-GO-node-api)
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   ki38sato
#
cronJob = require('cron').CronJob
PokemonGO = require './pokelib/poke.io.js'
moment = require 'moment'

#loc_coords = {35.623513, 139.774904, 0} #お台場ガンダム
cronTime = "0 * * * * *" #UTC

loc_latitude  = parseFloat(process.env.PGO_LATITUDE || '35.623513')
loc_longitude = parseFloat(process.env.PGO_LONGITUDE || '139.774904')
loc_altitude  = parseFloat(process.env.PGO_ALTITUDE || '0')
username = process.env.PGO_USERNAME
password = process.env.PGO_PASSWORD
provider = process.env.PGO_PROVIDER || 'ptc'
alert_p = process.env.PGO_ALERT_POKEMONS
alert_pokes = alert_p.split(',')
notifyRoom = process.env.PGO_NOTIFY_ROOM

# 緯度はざっくり 100m:0.00027778x6=0.00166668 (186m)
# 経度はざっくり 100m:0.00027778x4=0.00222224 (202m)

coords_diffs = [
  [0, 0, 'C'],
  [0.00166668, 0, 'N'],
  [0,-0.00222224, 'W'],
  [-0.00166668,0, 'S'],
  [0,0.00222224, 'E']
]

findLocation = () ->
  now = moment().format("HHmm")
  min1 = now.substr(3)
  index = parseInt(min1, 10) % coords_diffs.length
  console.log '-----[ index: ' + index + ']-----'
  latitude = loc_latitude + coords_diffs[index][0]
  longitude = loc_longitude + coords_diffs[index][1]
  compass = coords_diffs[index][2]
  return [latitude, longitude, compass]

checkPokemon = (msg, callback) ->
  a = new PokemonGO.Pokeio()
  fs = require("fs");
  json = JSON.parse(fs.readFileSync('./lib/pokemons-ja.json', 'utf8'))
  [loc_lat, loc_lon, compass] = findLocation()
  location = {
    type: 'coords',
    coords: {
      latitude:  loc_lat,
      longitude: loc_lon,
      altitude:  loc_altitude
    }
  }

  a.init username, password, location, provider, (err) ->
    throw err if err

    console.log 'Current location: ' + a.playerInfo.locationName
    console.log 'lat/long/alt: : ' + a.playerInfo.latitude + ' ' + a.playerInfo.longitude + ' ' + a.playerInfo.altitude

    a.GetProfile (err, profile) ->
      throw err if err
      a.Heartbeat (err, hb) ->
        if err
          console.log err
          return
        pokemonList = []
        for i in [0..hb.cells.length-1]
          continue if hb.cells[i].NearbyPokemon.length is 0
          console.log 'found ' + hb.cells[i].NearbyPokemon.length + ' pokemons'
          for p in hb.cells[i].NearbyPokemon
            pokemonList.push p unless p in pokemonList
        for p in pokemonList
          pokemon = a.pokemonlist[parseInt(p.PokedexNumber)-1]
          for j in [0..json.length-1]
            continue if json[j].en isnt pokemon.name
            alert = if json[j].ja in alert_pokes then "@channel " else ""
            info = "[#{compass}] found: #{json[j].ja} #{alert}"
            console.log p
            callback msg, info

callbackRoomSend = (msg, message) ->
  msg.send {room: notifyRoom}, message

module.exports = (robot) ->

  cronjob = new cronJob(
    cronTime: cronTime
    start: true
    timeZone: "UTC"
    onTick: ->
      checkPokemon(robot, callbackRoomSend)
  )
