FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

ARG VITE_REACT_APP_TEST_1
ENV VITE_REACT_APP_TEST_1=${VITE_REACT_APP_TEST_1}

RUN echo THE VAL IS $VITE_REACT_APP_TEST_1

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
