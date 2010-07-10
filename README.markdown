Unfollower
----------

Para rodar a "app":

Copie o exemplo de configuração do twitter (você precisará de uma [app no twitter](http://dev.twitter.com/apps)):

    cp twitter.yml.example twitter.yml

Configure no arquivo twitter.yml os tokens da sua app.

Rode a primeira vez:

    ruby track_followers.rb

O browser deverá abrir, autorize a sua apliação, e copie o pin retornado e cole no terminal.

Rode mais uma vez (ainda vou remover esse passo), você recebera a mensagem

    "> Now you're authorized!"

Rode de novo! (ok, ok... esse passo vou remover também), e o programa vai salvar dentro do diretório "dump" a lista de ids dos seus followers.

TODO
----

1. Remover passos de autorização inúteis
2. Fazer diff dos ids dos followers desde a última vez que o programa rodou (assim da pra saber quem deixou de te seguir)
3. Só salvar um novo "dump" se houver diferenças
4. Transformar em web app
5. Rodar de tempos em tempos?