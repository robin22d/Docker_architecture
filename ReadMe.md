
# Docker Architecture

This project it to show the difference between having load balacing working and not. It has jmeter test to see the difference.

It also has fail2ban to stop attacks on the server.

useful commands
----
* docker ps -a
* docker logs -f swt_1
* docker logs -f swt_2


one_to_one
----

* cd one_to_one
* docker-compose up -d

			 _________________               ____________
			|                 |             |            |
			|  MYSQL DATABASE | <---------- | SWT_SERVER | <----------
			|_________________|             |____________|


load_balancer
----

* cd load_balancer
* docker build -t swt_server server/. && docker-compose up -d


                                       ______________
				         /|              |
				        //| SWT_SERVER 1 |
				       // |______________|
		__________________    //                  \  
	       |		  |  //                    \
	       |  MYSQL DATABASE  | //                      \
           |      MASTER      | /                        \
	       |__________________|/                          \_____________________
		                 \/                           |                     |
		                 /\                           | NGINX LOAD BALANCER | <----------
		________________/_ \                          |_____________________|
	       |		  | \                         /
	       |  MYSQL DATABASE  |  \                       /
           |      Slave       | \ \                     /
	       |__________________|  \ \                   /
	                              \ \  ______________ /
				       \ \|              |
				        \ | SWT_SERVER 2 |
				         \|______________|         
                                                           
                                                       
				         



## Installing docker

	cd swt_docker_architecture/scripts

	./docker_install.sh

Remeber to log out and log back in

----

If fresh install of docker and not run any tests before when running the
test multiple might need to create the onetoone network

	docker network create onetoone_default

* This is need if there is an error saying network is not found 

----

## one-to-one test

1) Setting up the server

> cd swt_docker_architecture/architecture/one_to_one

> make clean && make compose

2) Viewing the server

> Open a separate terminal

> docker logs -f swt_1

3) Starting up jmeter docker

> cd swt_docker_architecture/architecture/test_one

> make compose

	Should see in the server window jmeter hitting the server

4) Copying across the output file

> from inside swt_docker_architecture/architecture/test_one

> make copy

* Remember this will overwrite an existing output file - rename existing
file before issuing this command 

> cat output_1.txt  ---> if test is finished it will say finished at the
bottom of the file

5) To re-run test make sure server still running

> from inside swt_docker_architecture/architecture/test_one

> make compose


## load balancer test

1) Setting up the servers

> cd swt_docker_architecture/architecture/load_balancer

> make clean && make build && make compose

2) Viewing the servers

> Open a separate terminal

> tmux

> ctrl+b then % to split vertically

> docker logs -f swt_1

> ctrl+b then o to switch to other pane

> docker logs -f swt_2

3) Starting up jmeter dockers

> cd swt_docker_architecture/architecture/test_multiple

> make build && make compose

> Should see in the server windows the two jmeters hitting the servers

4) Copying across the output files

> from inside swt_docker_architecture/architecture/test_multiple

> make copy

* Remember this will overwrite any existing output files - rename
existing files before issuing this command

> cat output_1.txt  ---> if test is finished it will say finished at the
bottom of the file

> cat output_2.txt  ---> if test is finished it will say finished at the
bottom of the file

5) To re-run test make sure servers are still running

> from inside swt_docker_architecture/architecture/test_multiple

> make compose

