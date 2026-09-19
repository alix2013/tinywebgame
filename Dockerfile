FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y passwd net-tools vim wget curl lsof git \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN echo "root:passw0rd123!@#" | chpasswd  
RUN useradd -m -d /home/web web 
RUN echo "web:passw0rd123!@#" | chpasswd  

RUN git clone https://github.com/alix2013/tinywebgame.git /home/web/tinywebgame
RUN chown -R web /home/web/tinywebgame

COPY start.sh /start.sh 
RUN chmod a+x /start.sh

EXPOSE 8888

CMD ["sh", "-c", "/start.sh"]


