
clean:
		docker ps -a -q | xargs -id docker rm -f d
		docker images -q | xargs -id docker rmi d

build:
		docker build -t swt_server server/.

compose:
		docker-compose up -d
