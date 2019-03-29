# WikipediaLiveView :sparkles:

Just a little demo to test out some phoenix_live_view features.  
I use the SSE provided from the wikimedia Kafka clusters.  
  * Event Platform/EventStreams https://wikitech.wikimedia.org/wiki/Event_Platform/EventStreams  


## Demo

You can find a deployed version under https://darkslategray-dental-vicuna.gigalixirapp.com

<img src="./assets/static/images/wiki_live_view.gif" width="500" />

## Develop
To start your local Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
