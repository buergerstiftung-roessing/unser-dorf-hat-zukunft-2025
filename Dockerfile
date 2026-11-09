# Static site: build with Node, serve with nginx. Built by .github/workflows/deploy.yml
# on every push to main; the cluster runs the resulting image.
FROM node:26-alpine@sha256:8996bb5821d62a8fd9bb27c1cb07462f3fdce6e47d640c6a881ead0b064ce216 AS builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.31-alpine@sha256:713fc2ebfd92e8217db451477182ee91944b123d2b1ee9fd5a8c6e91ca6c3a11
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
