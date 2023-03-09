FROM pihole/pihole:latest

RUN apt-get update --yes --quiet -o APT::Update::Error-Mode=any
RUN apt-get install --yes --quiet --no-install-recommends socat net-tools tcpdump tmux strace htop iperf

COPY start.sh /

ENTRYPOINT ["/bin/bash", "/start.sh"]

