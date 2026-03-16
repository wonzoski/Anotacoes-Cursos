# 002 - Conforme o exercício 2, cria um terceiro contâiner usando a imagem do debian e realize um backup do volume dbdados.

# Faz a montagem do tipo volume em /dados e também faz a montagem do tipo bind em /backup, por fim executa o compactamento e compressão com tar.
docker container run -ti --mount type=volume,src=dbdados,dst=/dados --mount type=bind,src=/opt/backup,dst=/backup debian tar -czvf /backup/backup_banco.tar.gz /dados