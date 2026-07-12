#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -euxo pipefail
apt update -y

apt install -y docker.io docker-compose-plugin git

systemctl enable docker
systemctl start docker

sleep 15

cd /home/ubuntu
if [ -d "Teraform_project2" ]; then
  cd Teraform_project2
  git pull
else
  git clone https://github.com/Abdulrahman-122/Teraform_project2.git
  cd Teraform_project2
fi
cd gym_using_flask
cat > .env <<EOF
DATABASE_URL=mysql+pymysql://${db_username}:${db_password}@${db_endpoint}/${db_name}
FLASK_APP=run.py
SECRET_KEY=9a8d782e874f3e779dfa49e6dacb27ec5a4d4992d732506b9911ead37820c357
SESSION_COOKIE_SAMESITE=Lax
EOF

sleep 5
docker compose down || true
docker compose up -d --build