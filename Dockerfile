FROM debian:stable

RUN apt-get update && \
	apt-get -y install wget gnupg2

RUN wget -qO - https://debian.koha-community.org/koha/gpg.asc | gpg --dearmor -o /usr/share/keyrings/koha-keyring.gpg && \
	echo 'deb [signed-by=/usr/share/keyrings/koha-keyring.gpg] https://debian.koha-community.org/koha 22.11 main' > /etc/apt/sources.list.d/koha.list && \
	apt-get update && \
	apt-get -y install koha-common

EXPOSE 8080

COPY docker-entrypoint.sh /

ENTRYPOINT "/docker-entrypoint.sh"
