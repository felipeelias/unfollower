[Unfollower Tracker](http://unfollower.heroku.com)
----------

Link da app rodando no heroku: [http://unfollower.heroku.com](http://unfollower.heroku.com)

Para rodar a "app":

- Crie sua app no Twitter [aqui](http://dev.twitter.com/)
- `bundle install`

Configure algumas env vars com os tokens da sua app no Twitter:

    export CONSUMER_TOKEN=sua-app-token
    export CONSUMER_SECRET=sua-app-secret
    export OAUTH_CALLBACK=http://localhost:9292/auth

Run!

    shotgun config.ru -p 9292

Acesse [http://localhost:9292/](http://localhost:9292/)

TODO
----

1. Cron task p/ verificar unfollowers de tempos em tempos
2. Mostrar status (n de followers/following)
3. Mostrar pessoas que vc segue que não te seguem
4. Notificar por email novos unfollowers