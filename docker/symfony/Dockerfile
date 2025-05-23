FROM php:8.2-fpm-alpine

# Variables d'environnement pour configurer Symfony
ARG SYMFONY_VERSION=7.4

# Installer les dépendances nécessaires
RUN apk add --no-cache \
    postgresql-dev \
    git \
    zsh \
    bash \
    curl \
    nodejs \
    npm \
    yarn \
    util-linux \
    && docker-php-ext-install pdo pdo_pgsql

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Dossier de travail
WORKDIR /var/www/app

# Copier le script d'entrée
COPY docker/symfony/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Installer oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installer le thème Powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Configurer zsh et powerlevel10k
RUN echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc \
    && echo 'source ~/.p10k.zsh' >> ~/.zshrc \
    && cp /root/.oh-my-zsh/custom/themes/powerlevel10k/config/p10k-robbyrussell.zsh ~/.p10k.zsh

# Exposer le port PHP-FPM
EXPOSE 9000

# Lancer php-fpm en mode foreground
CMD ["php-fpm", "-F"]
