FROM amberframework/amber:v0.11.3

WORKDIR /app

COPY shard.* /app/
RUN shards install 

COPY . /app

RUN rm -rf /app/node_modules

CMD amber watch
