# Sailing Map

A simple Heroku application for tracking sailing boats (or anything really) that emit Iridium Go tracking e-mails on a Google Map.

## Dependencies

- Ruby 2.5.5

## Running

```bash
docker-compose up
docker exec `docker ps -f label=web --format '{{.ID}}'` bundle exec rake db:setup
```

### Heroku Setup

You need an application with the following add-ons, free tier works fine:

- CloudMainIn
- Heroku Postgres

#### CloudMailIn

Configuration:

- **Receiving Email At** - This is the e-mail that the Iridium Go e-mails should be sent to.
- **Forwarding to** - This should point to the mails controller with HTTP POST, for example: `https://sailing-map.herokuapp.com/mails via HTTP POST`
- **Format** - This should be `json+n` (normalized JSON)

#### Google API Key

You need to configure a google cloud account with the necessary configuration to use Google Maps. Then add an _Config Var_ called `GOOGLE_API_KEY` with an API key for that account (with the  necessary permissions).

## Example

Any Iridium Go e-mails sent to the following address will get tracked on the website, there is a dropdown at the top of the screen that allows you to pick which sailing boat you want o see at the moment. By default it shows the most recently updated one:

- **E-mail** - `adcb958ebb558077e511@cloudmailin.net`
- **Website** - https://sailing-map.herokuapp.com/
