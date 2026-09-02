# Static site: build with Node, serve with nginx. Built by .github/workflows/deploy.yml
# on every push to main; the cluster runs the resulting image.
FROM node:22-alpine AS builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.27-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
