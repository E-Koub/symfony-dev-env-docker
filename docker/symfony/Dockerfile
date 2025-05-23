FROM php:8.2-fpm-alpine

# Variables d'environnement pour configurer Symfony
ARG SYMFONY_VERSION=7.4

# Installer les dépendances de PHP nécessaires pour Symfony et zsh
RUN apk add --no-cache \
    postgresql-dev \
    git \
    zsh \
    bash \
    curl \
    util-linux \
    && docker-php-ext-install pdo pdo_pgsql

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Dossier de travail
WORKDIR /var/www/app

# Copy the entrypoint script
COPY docker/symfony/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# Installer oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installer le thème Powerlevel10k pour zsh
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Configurer Powerlevel10k
RUN echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc \
    && echo 'source ~/.p10k.zsh' >> ~/.zshrc \
    && cp /root/.oh-my-zsh/custom/themes/powerlevel10k/config/p10k-robbyrussell.zsh ~/.p10k.zsh

# Exposer le port PHP-FPM
EXPOSE 9000

# CMD pour démarrer zsh au lieu de sh par défaut

CMD ["php-fpm", "-F","zsh"]

