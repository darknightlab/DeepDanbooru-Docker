FROM python:3.8-slim-bullseye

RUN mkdir -p /root/deepdanbooru/logs && cd /root/deepdanbooru

RUN apt update && apt install git -y && git clone https://github.com/darknightlab/DeepDanbooru /root/deepdanbooru/DeepDanbooru && cd /root/deepdanbooru/DeepDanbooru && git checkout cpu && pip install --no-cache-dir -r requirements.txt && chmod +x setup.py && pip install . && apt remove git -y && apt autoremove -y && rm -rf /root/deepdanbooru/DeepDanbooru

RUN cd /root/deepdanbooru && apt install wget unzip -y && wget https://github.com/KichangKim/DeepDanbooru/releases/download/v3-20211112-sgd-e28/deepdanbooru-v3-20211112-sgd-e28.zip && mkdir project && unzip -d project/ deepdanbooru-v3-20211112-sgd-e28.zip && rm deepdanbooru-v3-20211112-sgd-e28.zip && apt remove wget unzip -y && apt autoremove -y

WORKDIR /root/deepdanbooru

ENTRYPOINT ["logsave", "/root/deepdanbooru/logs/logs.txt", "deepdanbooru"]

CMD ["web", "--project-path", "/root/deepdanbooru/project", "--port", "80"]
