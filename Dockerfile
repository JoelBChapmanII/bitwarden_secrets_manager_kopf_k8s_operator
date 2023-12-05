FROM rust:slim-bookworm
WORKDIR /app

# Install python requirements
RUN apt update && apt install python3-full python3-pip git pkg-config libssl-dev -y && apt clean
COPY python/requirements.txt /app/python/requirements.txt
RUN pip install -r /app/python/requirements.txt --break-system-packages

# Install the bitwarden client
RUN git clone https://github.com/JoelBChapmanII/bitwarden_sdk.git
RUN pip install /app/bitwarden_sdk/languages/python --break-system-packages

COPY python/bws_operator.py /app/python/bws_operator.py
