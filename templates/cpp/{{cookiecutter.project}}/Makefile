CC=g++
FLAGS=-std=c++{{cookiecutter.cpp_version}} -ggdb -pipe -Wall
LIBS=-lm -lcrypt

.DEFAULT_GOAL := all

{{cookiecutter.project}}.out: {{cookiecutter.project}}.o
	$(CC) $(LIBS) -o $@ $^

%.o: %.cpp
	$(CC) $(FLAGS) -c $<

clean:
	rm -rf *.o {{cookiecutter.project}}.out

run: {{cookiecutter.project}}.out
	./{{cookiecutter.project}}.out

test: {{cookiecutter.project}}.out
	./checkinputs.sh

debug: {{cookiecutter.project}}.out
	gdb -x debug_cmd  {{cookiecutter.project}}.out

all: {{cookiecutter.project}}.out
