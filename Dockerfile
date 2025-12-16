# syntax = docker/dockerfile:1

# Etapa 1: Base com Ruby
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Diretório de trabalho dentro do container
WORKDIR /rails

# Variáveis de ambiente de produção
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Atualiza pacotes do sistema e instala dependências básicas
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config

# --- Etapa 2: Build (Instala Gems e Pré-compila assets) ---
FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl nodejs npm

# Copia os arquivos de definição do NPM (note a troca de yarn.lock por package-lock.json)
COPY package.json package-lock.json ./

# Instala as dependências do JS usando npm
RUN npm install

# Instala Gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copia o código da aplicação
COPY . .

# Pré-compila assets (se usar SECRET_KEY_BASE_DUMMY permite buildar sem a chave real)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# --- Etapa 3: Imagem Final (O que vai pro Render) ---
FROM base

# Instala pacotes necessários para rodar (mas não para buildar, pra ficar leve)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia artefatos da etapa de build
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Configura usuário não-root (segurança)
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Script de entrada (explico abaixo)
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Porta e Comando padrão
EXPOSE 3000
CMD ["./bin/rails", "server"]