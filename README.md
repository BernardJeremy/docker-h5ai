# docker-h5ai
h5ai in a Docker container

## How to run

Just mount the directories you want to show via H5AI:

```
docker run \
   -p 8080:80 \
   -v </path/to/target/dir/>:/var/www/html/<user_dir>:ro \
   -v </path/to/custom/h5ai/conf/>:/conf \
   bernardjeremy/docker-h5ai
```
## Configuration

See [options.json](https://github.com/BernardJeremy/docker-h5ai/blob/master/defaults/options.json) for default options.
Put you config file into the mounted directory pointing to the container's `/conf` (see the command above) 
