FROM debian:11.6

# Install useful packages
RUN apt-get -y update \
	&& apt-get -y upgrade \
	&& apt-get -y install \
		curl \
		gnupg \
		netcat \
		vim \
		wget \
	&& rm -rf /var/cache/apt/archives/* \
	&& rm -rf /var/lib/apt/lists/*

# Add Koha repository
RUN echo 'deb [signed-by=/usr/share/keyrings/koha-keyring.gpg] https://debian.koha-community.org/koha 22.11 main' > /etc/apt/sources.list.d/koha.list

# Add Koha signing gpg key
RUN wget -qO - https://debian.koha-community.org/koha/gpg.asc | gpg --dearmor -o /usr/share/keyrings/koha-keyring.gpg

# Install koha-common
RUN apt-get -y update \
	&& apt-get -y install \
		koha-common \
	&& /etc/init.d/koha-common stop \
	&& rm -rf /var/cache/apt/archives/* \
	&& rm -rf /var/lib/api/lists/*

EXPOSE 8080 8081

RUN mkdir /templates

COPY templates /templates

COPY docker-entrypoint.sh /

ENTRYPOINT "/docker-entrypoint.sh"
