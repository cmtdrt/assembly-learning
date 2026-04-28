dbuild:
	docker build --platform linux/amd64 -t asm-env .

dstart:
	docker run --platform linux/amd64 -it --rm -v "$(CURDIR)":/workspace asm-env

compile-hello:
	nasm -f elf64 01-hello/main.asm -o hello.o

link-hello:
	ld hello.o -o hello

exec-hello:
	./hello
