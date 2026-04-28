dbuild:
	docker build --platform linux/amd64 -t asm-env .

dstart:
	docker run --platform linux/amd64 -it --rm -v "$(CURDIR)":/workspace asm-env

compile:
	nasm -f elf64 $(SRC) -o $(OUT)

link:
	ld $(SRC) -o $(OUT)