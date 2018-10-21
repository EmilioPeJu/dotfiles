
run:
	python {{cookiecutter.project}}.py

test:
	./checkinputs.sh

remote-debug: 
	gdbserver :1234 python {{cookiecutter.project}}.py < in_test

all: run
