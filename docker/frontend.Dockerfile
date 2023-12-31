FROM node:16 as builder
## Stage 1: Build the frontend

CMD mkdir /app

## Set the working directory
WORKDIR /app

## Copy all the relevant files
COPY ./package.json ./yarn.lock ./
COPY ./ ./

## Carry out the build
RUN yarn install
RUN yarn build

## Second stage, use nginx to serve files that have been built
## alpine is a small footprint linux image
FROM nginx:1.21-alpine
COPY --from=builder /app/dist /usr/share/nginx/html/