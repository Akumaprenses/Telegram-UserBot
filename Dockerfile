# Biz Alpine Latest kullanıyoruz
FROM alpine:latest

#
# Bazı paketler için topluluk reposunun eklenmesi gerek
#
RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories

#
# Paketleri yükle
#
RUN apk add --no-cache=true --update \
        bash \
    build-base \
    bzip2-dev \
    curl \
    figlet \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    gcc \
    g++ \
    git \
    sudo \
    aria2 \
    util-linux \
    libevent \
    jpeg-dev \
    libffi-dev \
    libpq \
    libwebp-dev \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    musl \
    neofetch \
    openssl-dev \
    postgresql \
    postgresql-client \
    postgresql-dev \
    openssl \
    pv \
    jq \
    wget \
    python \
    python-dev \
    python3 \
    python3-dev \
    readline-dev \
    sqlite \
    ffmpeg \
    sqlite-dev \
    sudo \
    chromium \
    chromium-chromedriver \
    zlib-dev \
    jpeg 
    
  


RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /usr/lib/python*/ensurepip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#
# Repoyu klonla ve çalışma dizinini hazırla
#
RUN git clone -b seden https://github.com/TeamDerUntergang/Telegram-UserBot /root/userbot
RUN mkdir /root/userbot/bin/
WORKDIR /root/userbot/

#
# Oturum ve yapılandırmayı kopyala (varsa)
#
COPY ./sample_config.env ./userbot.session* ./config.env* /root/userbot/

#
# Gereksinimleri yükle
#
RUN pip3 install -r requirements.txt
CMD ["python3","main.py"]
