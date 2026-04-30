## Assembly learning

This repo contains notes and examples to setup and start learning assembly language. 

## Steps to setup everything locally

### 1) Build the Docker image

```bash
docker build --platform linux/amd64 -t asm-env .
```

### 2) Run the container

```bash
docker run --platform linux/amd64 -it --rm -v $(pwd):/workspace asm-env
```

- **Important**: `--rm` **removes the container** after it exits.

### 3) Check the architecture in the environment

```bash
uname -m
```

- **Expected**: `x86_64`.

### 4) Assemble (`.asm` → `.o`)

Takes a `.asm` file and compiles it into machine code, producing an object file `.o`.

```bash
nasm -f elf64 02-hello/main.asm -o hello.o
```

Or using Make:

```bash
make compile SRC=02-hello/main.asm OUT=hello.o
```

### 5) Link (`.o` → executable)

Turns the `.o` file into an executable program.

```bash
ld hello.o -o hello
```

Or using Make:

```bash
make link SRC=hello.o OUT=hello
```

### 6) Run the program

```bash
./hello
```