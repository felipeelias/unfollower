Unfollower
----------

Para rodar a "app":

Copie o exemplo de configuração do twitter (você precisará de uma [app no twitter](http://dev.twitter.com/apps)):

    cp twitter.yml.example twitter.yml

Configure no arquivo twitter.yml os tokens da sua app.

Rode a aplicação:

    shotgun application.rb

Acesse [http://localhost:9393/](http://localhost:9393/)

TODO
----

1. Fazer autorização pela web
2. Verificar unfollowers de tempos em tempos
3. Mostrar status (n de followers/following)