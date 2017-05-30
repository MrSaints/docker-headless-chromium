FROM node:7.10-alpine

WORKDIR /examples/

COPY package.json package.json
RUN yarn
COPY websiteToPDF.js websiteToPDF.js
