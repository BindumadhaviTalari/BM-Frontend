FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY frontend/ ./frontend
RUN cd frontend && npm install @angular/cli && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/frontend/dist ./frontend/dist
COPY package*.json ./
RUN npm install
COPY server.js .

EXPOSE 3080

CMD ["node", "server.js"]