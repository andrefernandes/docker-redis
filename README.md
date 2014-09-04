docker-redis
============

Redis on CentOS 7.

This image contains a Redis server on CentOS 7. This
work is based on the official Redis image's Dockerfile:

https://registry.hub.docker.com/_/redis/

### What is Redis?

Redis is an open-source, networked, in-memory, key-value data store 
with optional durability. It is written in ANSI C. The development of 
Redis has been sponsored by Pivotal since May 2013; before that, it 
was sponsored by VMware. According to the monthly ranking by 
DB-Engines.com, Redis is the most popular key-value store.
The name Redis means REmote DIctionary Server.

http://wikipedia.org/wiki/Redis

### How to use this image

#### start a redis instance

    docker run --name some-redis -P -d andrefernandes/docker-redis

This image includes EXPOSE 6379 (the redis port), so standard container 
linking will make it automatically available to the linked containers 
(as the following examples illustrate).

#### start with persistent storage

Mounting the container VOLUME "/data" on the "/opt/redis-data" host folder:

    docker run --name some-redis -v /opt/redis-data:/data -d andrefernandes/docker-redis redis-server --appendonly yes

Persistent data for VOLUME "/data" can also be stored in a volume container,
which can be used with --volumes-from some-volume-container:

    docker run --name some-redis-data -d -v /data busybox echo "Data volume container for Redis"
    docker run -d --volumes-from some-redis-data --name some-redis andrefernandes/docker-redis

For more about Redis Persistence, see http://redis.io/topics/persistence.

#### connect to it from an application

    docker run --name some-app --link some-redis:redis -d application-that-uses-redis

#### … or via redis-cli

    docker run -it --link some-redis:redis --rm andrefernandes/docker-redis sh -c 'exec redis-cli -h "$REDIS_PORT_6379_TCP_ADDR" -p "$REDIS_PORT_6379_TCP_PORT"'


