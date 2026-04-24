#!/bin/bash

set -e
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "=========================================="
echo "Starting user_data.sh at $(date)"
echo "OS: $(lsb_release -d | cut -f2)"
echo "=========================================="

echo "Updating system packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

echo "Installing Docker on Ubuntu..."

apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  unzip

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker

usermod -aG docker ubuntu

echo "Docker installed: $(docker --version)"

echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws/

echo "AWS CLI installed: $(aws --version)"

echo "Fetching database credentials from Secrets Manager..."
DB_PASSWORD=$(aws secretsmanager get-secret-value \
  --secret-id "${db_secret_name}" \
  --region "${aws_region}" \
  --query SecretString \
  --output text | python3 -c \
  "import sys,json; print(json.load(sys.stdin)['password'])")

DB_HOST="${db_endpoint}"
DB_NAME="${db_name}"
DB_USER="${db_username}"

echo "Database credentials fetched successfully"

echo "Starting Nginx container..."
docker run -d \
  --name nginx-app \
  --restart always \
  -p 80:80 \
  -e DB_HOST="$DB_HOST" \
  -e DB_NAME="$DB_NAME" \
  -e DB_USER="$DB_USER" \
  -e DB_PASSWORD="$DB_PASSWORD" \
  nginx:latest

echo "Creating /health endpoint..."
sleep 5
docker exec nginx-app bash -c \
  "echo 'OK' > /usr/share/nginx/html/health"

echo "Verifying setup..."
curl -f http://localhost/health && \
  echo "Health check passed" || \
  echo "WARNING: health check failed — check Docker logs"

docker ps

echo "=========================================="
echo "user_data.sh completed at $(date)"
echo "EC2 Ubuntu is ready to receive ALB traffic"
echo "=========================================="