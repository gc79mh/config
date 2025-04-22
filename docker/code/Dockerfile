FROM ubuntu:latest


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    python3 \
    r-base \
    r-base-dev \
    python3-venv \
    jupyter-notebook \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && sudo apt-get install -y wget gpg && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg && \
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null && \ 
    rm -f packages.microsoft.gpg && \ 
    sudo apt-get install -y apt-transport-https && \ 
    sudo apt-get update && \
    sudo apt-get install -y code

#RUN Rscript -e "install.packages('IRkernel', repos='https://cran.mi2.ai/'); IRkernel::installspec(); install.packages('languageserver', repos='https://cran.mi2.ai/'); install.packages('tidyverse', repos='https://cran.mi2.ai/')"

RUN mkdir -p /root/.config/"Code - OSS"/User && \
    echo '{' > /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"workbench.colorTheme": "Tokyo Night",' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"editor.fontFamily": "'JetBrainsMono Nerd Font Mono', 'JetBrains Mono', monospace",' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"editor.fontLigatures": true' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '}' >> /root/.config/"Code - OSS"/User/settings.json

RUN echo "linters: linters_with_defaults(line_length_linter=line_length_linter(200))" > /root/.lintr 

ENV ELECTRON_OZONE_PLATFORM_HINT=wayland

CMD code --enable-proposed-api ms-toolsai.jupyter --no-sandbox --verbose --user-data-dir /root
