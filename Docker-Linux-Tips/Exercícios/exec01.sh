# 001 - Crie um volume com nome dbdados e também dois contâiners com imagem do postgres com nome pgsql01 e pgsql02 usando diferents portas externamente. As duas imagens devem ter o mesmo volume.

# Criando o volume dbdados
docker volume create dbdados

# Criando o primeiro contâiner na imagem do postgres com variáveis de ambiente.
docker container run -d -p 5432:5432 --name pgsql01 --mount type=volume,src=dbdados,dst=/var/lib/postgresql -e POSTGRES_USER=docker -e POSTGRES_PASSWORD=docker -e POSTGRES_DB=docker postgres

# Criando a segundo contâiner na imagem do postgres com variáveis de ambiente.
docker container run -d -p 5433:5432 --name pgsql02 --mount type=volume,src=dbdados,dst=/var/lib/postgresql -e POSTGRES_USER=docker -e POSTGRES_PASSWORD=docker -e POSTGRES_DB=docker postgres

# A partir da versão 18, a imagem oficial do PostgreSQL foi reconfigurada para:
#Versão: < 18
#Mount Point Recomendado: /var/lib/postgresql/data
#Comportamento: Dados salvos diretamente no mount

#Versão: ≥ 18
#Mount Point Recomendado: /var/lib/postgresql
#Comportamento: Dados salvos em subdiretório versionado (ex: data/18/main)
#Isso foi feito para compatibilidade com pg_ctlcluster e para facilitar upgrades com pg_upgrade --link sem problemas de boundary de mount points.