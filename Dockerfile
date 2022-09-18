FROM baseImage
RUN useradd -ms /bin/bash ces
RUN echo "root:redhat" | chpasswd
# 同步時區
RUN apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN TZ=Asia/Taipei \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# 之後的行為操作都使用 ces 這個 user
USER ces
WORKDIR /home/ces

ENTRYPOINT [ "ttyd","-p","8080","-u","1000","-g","1000","-c" ]
CMD [ "ces:pass", "bash" ]
