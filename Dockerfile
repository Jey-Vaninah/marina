# ==== STAGE 1 : Build marina OCaml binary ====
FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y \
    ocaml \
    opam \
    make \
    git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Cloner le projet
RUN git clone https://github.com/hei-school/marina.git marina-src
WORKDIR /build/marina-src

# Initialiser opam et compiler
RUN opam init --disable-sandboxing -y && \
    opam switch create . ocaml-system && \
    bash -c 'eval "$(opam env)" && opam install -y ocamlfind ounit2 && make'

# ==== STAGE 2 : Final image ====
FROM python:3.11-slim-bookworm

WORKDIR /app

# Copier uniquement le binaire compilé depuis le build stage
COPY --from=builder /build/marina-src/marina /app/marina
RUN chmod +x /app/marina

# Copier le reste de l'app (code Python, requirements...)
COPY . .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]
