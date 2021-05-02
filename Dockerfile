FROM public.ecr.aws/ubuntu/ubuntu:20.04

EXPOSE 8555
EXPOSE 8444

ENV TZ=Europe/Berlin

COPY docker-entrypoint.sh /usr/local/bin
COPY healthcheck.sh /usr/local/bin

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone
RUN apt-get update && \
    apt-get install python3.8-venv python3.8-distutils sudo git lsb-core -y
RUN git clone https://github.com/Chia-Network/chia-blockchain.git && \
    cd chia-blockchain \
    && git checkout tags/1.1.3
RUN cd chia-blockchain && \
    sh install.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["/usr/local/bin/docker-entrypoint.sh"]
