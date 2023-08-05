# Step 1 build geckodriver
FROM rust:latest as builder
COPY ./bash /bash
WORKDIR /bash
RUN /bash/download_geckodriver.sh

#https://ftp.mozilla.org/pub/firefox/releases/116.0.1/linux-x86_64/en-US/firefox-116.0.1.tar.bz2

FROM ubuntu:latest
COPY --from=builder /bash /gecko
#установка firefox
RUN apt-get update && \
    apt-get install -y wget &&\
    apt-get install tar &&\
    apt-get install bzip2 &&\
    apt-get install -y libgtk-3-0 && \
    apt-get install -y libasound2&&\
    apt-get install -y libdbus-glib-1-2 &&\
    apt-get install -y libxt6 &&\
    apt-get install -y libx11-xcb1 &&\
    apt-get install -y libpci3 &&\
    apt-get install -y libgl1-mesa-glx

RUN wget https://ftp.mozilla.org/pub/firefox/releases/116.0.1/linux-x86_64/en-US/firefox-116.0.1.tar.bz2
RUN tar xjf firefox-*.tar.bz2
ENV DISPLAY=:0
RUN mv firefox /opt
RUN ln -s /opt/firefox/firefox /usr/local/bin/firefox


#RUN /gecko/geckodriver &
#RUN /firefox/firefox --headless &
# Запускаем Firefox


CMD ["/gecko/geckodriver", "-p", "9000", "--host", "0.0.0.0"]
#CMD ["/firefox/firefox", "--headless"]

#CMD ["/gecko/geckodriver","firefox"]
