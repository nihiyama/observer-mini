#cloud-config

timezone: "Asia/Tokyo"

ssh_pwauth: false

runcmd:
  # set file
  - mkdir -p /opt/observer-mini
  - echo -n "${compose}" | base64 -d > /opt/observer-mini/compose.yaml
  - echo -n "${apm}" | base64 -d > /opt/observer-mini/apm-server.docker.yml
  
  # set kernel
  - sysctl -w vm.max_map_count=262144 >> /etc/sysctl.conf

  # set docker
  - dnf update
  - dnf install -y docker
  - systemctl start docker
  - chgrp docker /var/run/docker.sock
  - systemctl restart docker
  - systemctl enable docker
  - sudo curl -L "https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  - sudo chmod +x /usr/local/bin/docker-compose
  - sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  - docker -v
  - docker-compose -v

  # start observer-mini
  - cd /opt/observer-mini
  - docker-compose up -d

power_state:
  delay: "+5"
  mode: reboot
  message: Bye Bye
  timeout: 30