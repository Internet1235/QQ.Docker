FROM ubuntu:24.04

ARG TARGETARCH

RUN echo "Acquire::https::Verify-Peer \"false\";" > /etc/apt/apt.conf.d/99ignore-ssl && \
    echo "Acquire::https::Verify-Host \"false\";" >> /etc/apt/apt.conf.d/99ignore-ssl


# 安装核心依赖（包含 GUI 基础库）
RUN apt-get update && apt-get install -y \
    tzdata \
    xvfb \
    x11-utils \
    wget \
    unzip \
    libgtk-3-0 \
    libxcb-xinerama0 \
    libgl1-mesa-dri \
    libnotify4 \
    libnss3 \
    xdg-utils \
    libsecret-1-0 \
    libappindicator3-1 \
    libgbm1 \
    libasound2t64 \
    fonts-noto-cjk \
    libxss1 \
    && rm -rf /var/lib/apt/lists/*

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# 下载并安装 QQ Linux 版
RUN \
    wget https://github.com/Rodert/qq-versions/releases/download/qq-packages-20260720-ffedf7c6/QQ_3.2.31_260710_amd64_$TARGETARCH_01.deb -O qq.deb \
    && apt-get install -f -y ./qq.deb \
    && rm qq.deb
