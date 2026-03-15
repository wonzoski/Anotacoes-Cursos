## Informações gerais
A instalação do docker `curl -fsSL httos://get.docker.com | bash` não faz gambiarra. No primeiro momento o script identifica qual a distro atual. Adiciona o repositório do docker na máquina e por fim faz a instalação do docker ce através do `apt-get`.\
\
Para gerenciar o docker á partir de usuário comum utilize o comando `sudo usermod -aG docker <user>`.\
\
É importante mencionar que o principal processo de um contâiner é chamado de __*entry point*__. Se este processo morre o contâiner é encerrado. Como exemplo temos a imagem Debian, após subir a imagem dê um `docker container ls` e veja na coluna _COMMAND_.\
\
![This is an alt text.](/Docker-Linux-Tips/Imagens/Imagem-Entry-Point.png "This is a sample image.")\
\
Saia do container sem encerrar utilizando Ctrl+p+q.\
\
Quando subimos a imagem do nginx por exemplo com `docker container run -ti nginx` note que ele irá acessar o contâiner mais ficarà travado no console. Isso significa que foi iniciado no entrypoint da imagem do nginx que é o próprio processo no nginx e não um terminal como o bash. Neste caso pode ser utilizado o comando `docker container run -d nginx`. Utilize `docker container exec -ti nginx bash` para acessar o shell na imagem do nginx.\
\
No processo de remoção do contâiner `docker container rm` ele não vai deixar remover por padrão de segurança informando que já está em execução. Para forçar utilize a atribuição `-f` para forçar. Para remover todos os contâiners que estão parados use o `docker contâiner prune`\
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

priO comando deve rodar passando como último parâmetro o caminho da pasta onde está o Dockerfile. A imagem vai aparecer após o build chegando com `docker images`, logo após, só efetuar o run como daemon `docker container run -d primeira-imagem:1.1`.

#### Volumes
Tudo que está dentro de um contâiner uma hora morre. Caso tenha algum dado e o contâiner for finalizado todos os dados serão removidos sem possibilidade de recuperação, para isso que serve os volumes com a finalidade de persitência de dados. Uma forma de colocar um filesystem dentro do contâiner.\
\
Vários contâines podem usar o mesmo volume.\
\
Quando falamos de volumes existem duas opções dentro do docker:
* __Tipo bind__: Quando já tem um diretório, por exemplo `/opt/girocops` e deseja montar esse mesmo diretório dentro do contâiner. Utilize o comando `docker container run -it --mount type=bind,src=/opt/giropops,dst=/giropops debian`, após ser definido os parâmetros do volume ainda é possível definir se ele é somente leitura inserindo no final o `ro`, `docker container run -it --mount type=bind,src=/opt/giropops,dst=/giropops,ro debian`, logo não será possível remover os arquivos criados lá.
    * __type__: Tipo do volume, alterna entre bind e volume.
    * __src__: Caminho onde será feito a montagem do volume.
    * __dst__: Caminho onde será feito a montagem do volume no contâiner.
    * __debian__: Imagem base criada.
![This is an alt text.](/Docker-Linux-Tips/Imagens/Imagem-Volume.png "This is a sample image.")


* __Tipo volume__: A criação se dá um base no comando `docker volume create`. No exemplo vamos usar o `docker volume create giropops`. Após a criação podemos inspecionar ele com `docker container inspect giropops`. Observe o caminho de ponto de montagem dele na linha _Mountpoint_. Todo volume criado com tipo _volume_ no docker vai estar neste caminho especificado. 
![This is an alt text.](/Docker-Linux-Tips/Imagens/Imagem-Volume-Caminho-completo.png "This is a sample image.")

    Podemos por exemplo acessar o diretório e criar algo lá o que vai ficar visível no contâiner que tiver esse volume aderido.

    Utilize o comando `docker volume ls` para listar os volumes existentes no sistema.

    Agora para fazendo a adesão desse volume para um contâiner pode ser feito da mesma forma como foi feito no tipo de volume bind. `docker container run -it --mount type=volume,src=giropops,dst=/giropops debian`, o que será alterado é o _type_ e _src_ basicamente.

Sobre o `docker volume rm`, podemos remover um volume apenas se não tiver algum contâiner entrelaçado com ele, mesmo que esse contâiner não esteja ativo é necessário remover ele com `docker container rm`.

Observe que os informações de volume podem ser verificadas através do comando `docker container inspect <container>`

```
"Mounts": [
    {
        "Type": "bind",
        "Source": "/opt/girocops",
        "Destination": "/girocops",
        "Mode": "",
        "RW": true,
        "Propagation": "rprivate"
    }
],
```
Ao mexermos com volumes podemos nos deparar com alguns que podem não estar sendo utilizados por algum contâiner, para remover esses volumes que não está ligados a nenhum contâiner use o `docker volume prune`.





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
🔹Cria um contâiner:
```
docker container create <imagem>
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
🔹Remove contâiners que estão parados:
```
docker container prune
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
\
🔹Criar um volume:
```
docker container run -it --mount type=<bind,volume>,src=<caminho-origem>,dst=<caminho-no-container>,<'os'-para-read-only> <imagem>
```
\
🔹Lista os volumes:
```
docker volume ls
```
\
🔹Remove os volumes:
```
docker volume rm
```
🔹Remove volumes que não estão sendo usados:
```
docker volume prune
```