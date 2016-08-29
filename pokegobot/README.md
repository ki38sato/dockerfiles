pokegobot by docker
---
Notify nearby pokemons to slack.

Setup
---
- mv /hubot/run.sh_sample /hubot/run.sh
- set parameters to run.sh
- docker build -t pokegobot . (in /pokegobot)
- docker run pokegobot
- enjoy!

parameters
---
- HUBOT_SLACK_TOKEN: slack token (hubot configuration) [required]
- PGO_NOTIFY_ROOM: slack notify room [required]
- PGO_USERNAME: pokego account username [required]
- PGO_PASSWORD: pokego account password [required]
- PGO_PROVIDER: pokego account type (ptc or google) [required]
- PGO_LATITUDE: center point latitude to check pokemons
- PGO_LONGITUDE: center point longitude to check pokemons
- PGO_ALERT_POKEMONS: channel mension target pokemons (with comma)

