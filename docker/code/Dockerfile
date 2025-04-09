FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    wayland \
    base-devel \
    ttf-jetbrains-mono-nerd \
    python \
    r \
    python-pip \
    jupyter-notebook \
    code \
    && pacman -Scc --noconfirm

RUN Rscript -e "install.packages('IRkernel', repos='https://cran.mi2.ai/'); IRkernel::installspec(); install.packages('languageserver', repos='https://cran.mi2.ai/'); install.packages('tidyverse', repos='https://cran.mi2.ai/')"

RUN mkdir -p /root/.config/"Code - OSS"/User && \
    echo '{' > /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"workbench.colorTheme": "Tokyo Night",' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"editor.fontFamily": "'JetBrainsMono Nerd Font Mono', 'JetBrains Mono', monospace",' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '	"editor.fontLigatures": true' >> /root/.config/"Code - OSS"/User/settings.json && \
    echo '}' >> /root/.config/"Code - OSS"/User/settings.json

RUN echo "linters: linters_with_defaults(line_length_linter=line_length_linter(200))" > /root/.lintr 

ENV ELECTRON_OZONE_PLATFORM_HINT=wayland

CMD code --enable-proposed-api ms-toolsai.jupyter --no-sandbox --verbose
