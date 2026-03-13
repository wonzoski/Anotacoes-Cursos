## Informações gerais
A instalação do docker `curl -fsSL httos://get.docker.com | bash` não faz gambiarra. No primeiro momento o script identifica qual a distro atual. Adiciona o repositório do docker na máquina e por fim faz a instalação do docker ce através do `apt-get`.\
\
Para gerenciar o docker á partir de usuário comum utilize o comando `sudo usermod -aG docker <user>`.\
\
É importante mencionar que o principal processo de um contâiner é chamado de __*entry point*__ é o. Se este processo morre o contâiner é encerrado. Como exemplo temos a imagem Debian, após subir a imagem dê um `docker container ls` e veja na coluna _COMMAND_.\
\
Saia do container sem encerrar utilizando Ctrl+p+q.\
\
Quando subimos a imagem do nginx por exemplo com `docker container run -ti nginx` note que ele irá acessar o contâiner mais ficarà travado no console. Isso significa que foi iniciado no entrypoint da imagem do nginx que é o próprio processo no nginx e não um terminal como o bash. Neste caso pode ser utilizado o comando `docker container run -d nginx`. Utilize `docker container exec -ti nginx bash` para acessar o shell na imagem do nginx.\
\
No processo de remoção do contâiner `docker container rm` ele não vai deixar remover por padrão de segurança informando que já está em execução. Para forçar utilize a atribuição `-f` para forçar.\
\
Para verificarmos o status de consumo podemos usar o comando `docker container stats`(retornar o percentual de utilização do CPU, memória e I/O)  ou `docker container top` (retorna os processos). Para testar os atributos de status do contâiner podemos usar o comando stress instalando no contâiner desejado. `apt update && apt install stress`. Use o comando `stress --cpu 1 --vm-bytes 128M --vm 1`.

#### Docker file
A criação de um Dockerfile envolve o comando `docker image build -t <nome-imagem:1.0> .` que deve ser rodado apenas quando o arquivo estiver devidamente estruturado e criado conforme exemplo:

![This is an alt text.](/Docker-Linux-Tips/Imagens/Imagem-Dockerfile.png "This is a sample image.")

1. A imagem criada será baseada na imagem definida aqui.
1. Cria uma variável de ambiente.
1. Roda o comando definido aqui durante o build da imagem.
1. Roda determinado processo após o build da imagem.

![This is an alt text.](/Docker-Linux-Tips/Imagens/Imagem-Dockerfile-Imagens.png "This is a sample image.")

O comando deve rodar passando como último parâmetro o caminho da pasta onde está o Dockerfile. A imagem vai aparecer após o build chegando com `docker images`, logo após, só efetuar o run como daemon `docker container run -d toskeira:1.0`.

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
\
🔹Remover o contâiner:
```
docker container rm <imagem>
```
\
🔹Retorna o status de utilização de recurso do contâiner:
```
docker container stats <imagem>
```
\
🔹Retorna os processos em execução:
```
docker container top <imagem>
```
\
🔹Inicia um contâiner com limite de memória/cpu:
```
docker container run -it --cpus 0.5 <imagem> /bin/bash
```
\
🔹Atualiza os limites de um contâiner:
```
docker container update --cpus 0.2 <imagem>
```
\
🔹Á partir de um dockerfile cria uma imagem:
```
docker image build -t <nome-imagem:1.0> .
```