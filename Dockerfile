# Static site: build with Node, serve with nginx. Built by .github/workflows/deploy.yml
# on every push to main; the cluster runs the resulting image.
FROM node:26-alpine@sha256:40cd011b55415bc894e45b02fdd5a5dfde056921b7d23a64c74f80497af48797 AS builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.31-alpine@sha256:a3554c0d0b48177b1413c26e01f695334428020d9df01243fbae3e11cfd17417
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
