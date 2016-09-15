module.exports = function(robot) {
  robot.respond(/go (.*)/i, function(msg) {
    var PokemonGO = require('./pokelib/poke.io.js');
    var a = new PokemonGO.Pokeio();
    var fs = require("fs");
    var json = JSON.parse(fs.readFileSync('./lib/pokemons-ja.json', 'utf8'));
    var your_location = msg.match[1]

    var location = {
        type: 'name',
        name: process.env.PGO_LOCATION || your_location
    };

    var username = process.env.PGO_USERNAME || 'user';
    var password = process.env.PGO_PASSWORD || 'password';
    var provider = process.env.PGO_PROVIDER || 'ptc';

    a.init(username, password, location, provider, function(err) {
        if (err) throw err;

        console.log('Current location: ' + a.playerInfo.locationName);
        console.log('lat/long/alt: : ' + a.playerInfo.latitude + ' ' + a.playerInfo.longitude + ' ' + a.playerInfo.altitude);
        msg.send(a.playerInfo.locationName + 'に来たよ');

        a.GetProfile(function(err, profile) {
            if (err) throw err;

            var count = 0;
            var intervalID = setInterval(function(){
                a.Heartbeat(function(err,hb) {
                    if(err) {
                        console.log(err);
                    }

                    for (var i = hb.cells.length - 1; i >= 0; i--) {
                        if(hb.cells[i].NearbyPokemon[0]) {
                            //console.log(a.pokemonlist[0])
                            var pokemon = a.pokemonlist[parseInt(hb.cells[i].NearbyPokemon[0].PokedexNumber)-1];
                            // console.log('There is a ' + pokemon.name + ' at ' + hb.cells[i].NearbyPokemon[0].DistanceMeters.toString() + ' meters');
                            for(var j = 0 ; j<json.length ; j++ ){
                              if(json[j].en === pokemon.name){
                                msg.send(json[j].ja + ' がいるよ');
                                msg.send(pokemon.img);
                              }
                            };
                        }
                    }

                });
                if (++count === 5) {
                     clearInterval(intervalID);
                 }
            }, 5000);

        });
    });

  });
};