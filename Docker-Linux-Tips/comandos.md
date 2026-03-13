## Informações gerais
A instalação do docker `curl -fsSL httos://get.docker.com | bash` não faz gambiarra. No primeiro momento o script identifica qual a distro atual. Adiciona o repositório do docker na máquina e por fim faz a instalação do docker ce através do `apt-get`.\
\
Para gerenciar o docker á partir de usuário comum utilize o comando `sudo usermod -aG docker <user>`.\
\
É importante mencionar que o principal processo de um contâiner é chamado de __*entry point*__ é o. Se este processo morre o contâiner é encerrado. Como exemplo temos a imagem Debian, após subir a imagem dê um `docker container ls` e veja na coluna _COMMAND_.\
\
Ctrl+p+q Sai do container sem encerrar.\
\
Quando subimos a imagem do nginx por exemplo com `docker container run -ti nginx` note que ele irá acessar o contâiner mais ficarà travado no console. Isso significa que foi iniciado no entrypoint da imagem do nginx que é o próprio processo no nginx e não um terminal como o bash. Neste caso pode ser utilizado o comando `docker container run -d nginx`. Utilize `docker container exec -ti nginx bash` para acessar o shell na imagem do nginx.



## Listagem de comandos
🔹Instalação do docker:
```
curl -fsSL https://get.docker.com | bash
```
\
🔹Lista todos os containers ativos e inativos:
```
docker container ls -a
```
\
🔹 Inicia o container em seu entry point:
```
docker container run -it <imagem>
```
\
🔹Abre ou volta para o container desejado:
```
docker container attach <imagem>
```
\
🔹Sobe um contâiner como deamon:
```
docker container run -d <imagem>
```
\
🔹Executa o shell bash dentro do cantâiner:
```
docker container exec -ti <imagem> bash
```
\
🔹Para o contâiner:
```
docker container stop <imagem>
```
\
🔹Retoma um container parado:
```
docker container start <imagem>
```
\
🔹Restart um container:
```
docker container restart <imagem>
```
\
🔹Inspecionar container:
```
docker container inspect <imagem>
```
\
🔹Pausar um contâiner:
```
docker container pause <imagem>
```
\
🔹Remove a pausa de um contâiner:
```
docker container unpause <imagem>
```
\
🔹Acompanha o log geral do contâiner em tempo real:
```
docker container logs -f <imagem>
```