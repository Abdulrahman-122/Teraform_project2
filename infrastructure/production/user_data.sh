
#!/bin/bash

apt update -y
apt install -y  docker.io docker-compose-plugin git
systemctl enable docker
systemctl start docker
sleep 10
cd /home/ubuntu
git clone https://github.com/Abdulrahman-122/Terrafrom2_project.git
cd Terrafrom2_project/gym_using_flask 

cat > .env <<EOF
DATABASE_URL=mysql+pymysql://${db_username}:${db_password}@${db_endpoint}/${db_name}
FLASK_APP=run.py
SECRET_KEY='9a8d782e874f3e779dfa49e6dacb27ec5a4d4992d732506b9911ead37820c357'
SESSION_COOKIE_SAMESITE='Lax'
EOF
cd gym_frontend_vite 
echo "VITE_API_URL=http://localhost:5000">.env.docker
cd ..

docker compose up -d --build
