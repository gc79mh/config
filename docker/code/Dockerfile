FROM archlinux:latest

RUN pacman -Syu --noconfirm \
    wayland \
    base-devel \
    python \
    r \
    python-pip \
    jupyter-notebook \
    code \
    && pacman -Scc --noconfirm

RUN Rscript -e "install.packages('IRkernel', repos='https://cran.mi2.ai/'); IRkernel::installspec(); install.packages('languageserver', repos='https://cran.mi2.ai/')"

ENV ELECTRON_OZONE_PLATFORM_HINT=wayland

CMD code --enable-proposed-api ms-toolsai.jupyter --no-sandbox --verbose
