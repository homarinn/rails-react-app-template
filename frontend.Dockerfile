FROM --platform=amd64 node:19.9

ENV APP_NAME myapp

WORKDIR /${APP_NAME}

CMD ["npm", "start"]