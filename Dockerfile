# Static site: build with Node, serve with nginx. Built by .github/workflows/deploy.yml
# on every push to main; the cluster runs the resulting image.
FROM node:26-alpine@sha256:6bd9ab43c0ec0190ca7b2d193906cb8b7edf6e7f4afa43ddeccd6452710bffb5 AS builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.31-alpine@sha256:fed7e14be83cbd2661a75cdc5b872d936cf155d46c327084d30b8df19ae88d72
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
