FROM tensorflow/tensorflow:latest-gpu
RUN mkdir -p /root/deepdanbooru/log && cd /root/deepdanbooru
RUN apt update && apt install git -y && \
    git clone https://github.com/darknightlab/DeepDanbooru /root/deepdanbooru/DeepDanbooru && \
    cd /root/deepdanbooru/DeepDanbooru && \
    pip install --no-cache-dir -r requirements.txt && \
    chmod +x setup.py && pip install . && \
    apt remove git -y && apt autoremove -y && rm -rf /root/deepdanbooru/DeepDanbooru && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /root/deepdanbooru
ENTRYPOINT ["logsave", "/root/deepdanbooru/log/log.txt", "deepdanbooru"]
CMD ["web", "--project-path", "/root/deepdanbooru/project", "--port", "80", "--allow-gpu"]
