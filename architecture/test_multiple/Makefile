
clean:
		docker ps -a -q | xargs -id docker rm -f d
		docker images -q | xargs -id docker rmi d

build:
		docker build -t swt_jmeter jmeter/.

compose:
		docker-compose up -d

copy:
		docker cp swt_jmeter_1:/root/data/output.txt output_1.txt
		docker cp swt_jmeter_2:/root/data/output.txt output_2.txt
