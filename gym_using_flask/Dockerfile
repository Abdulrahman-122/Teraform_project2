FROM node:20 AS react-builder
WORKDIR /app
COPY gym_frontend_vite/package*.json ./gym_frontend_vite/
RUN cd gym_frontend_vite && npm install
COPY gym_frontend_vite ./gym_frontend_vite
RUN cd gym_frontend_vite && npm run build -- --mode production

FROM python:3.14-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
COPY --from=react-builder /app/gym_frontend_vite/dist ./gym_frontend_vite/dist
RUN chmod +x entry.sh
EXPOSE 5000
CMD ["./entry.sh"]

