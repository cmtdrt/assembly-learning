## Notes — environnement ASM (Docker) & compilation

### 1) Construire l’image Docker

```bash
docker build --platform linux/amd64 -t asm-env .
```

### 2) Lancer le conteneur

```bash
docker run --platform linux/amd64 -it --rm -v $(pwd):/workspace asm-env
```

- **Important**: `--rm` **supprime le conteneur** après l’exécution.

### 3) Vérifier l’architecture dans l’environnement

```bash
uname -m
```

- **Attendu**: `x86_64`.

### 4) Assembler (`.asm` → `.o`)

Prend un fichier `.asm` et le compile en code machine en produisant un fichier objet `.o`.

```bash
nasm -f elf64 01-hello/main.asm -o hello.o
```

### 5) Linker (`.o` → exécutable)

Transforme le fichier `.o` en programme exécutable.

```bash
ld hello.o -o hello
```

### 6) Exécuter le programme

```bash
./hello
```
