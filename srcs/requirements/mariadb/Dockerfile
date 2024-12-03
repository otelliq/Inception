FROM    debian:bookworm

RUN     apt-get update && \ 
        apt-get install -y mariadb-server

COPY ./tools/script.sh /

RUN chmod +x /script.sh

EXPOSE  3306

ENTRYPOINT ["sh", "script.sh"]

CMD ["mariadbd", "--user=root", "--bind-address=0.0.0.0"] 