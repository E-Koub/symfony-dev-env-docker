FROM php:8.2-fpm-alpine

ARG SYMFONY_VERSION=7.4

RUN apk add --no-cache \
    postgresql-dev \
    git \
    zsh \
    bash \
    curl \
    util-linux \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/app

RUN if ! command -v symfony &> /dev/null; then \
    curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony; \
    fi

COPY docker/symfony/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

RUN echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc \
    && echo 'source ~/.p10k.zsh' >> ~/.zshrc \
    && cp /root/.oh-my-zsh/custom/themes/powerlevel10k/config/p10k-robbyrussell.zsh ~/.p10k.zsh

EXPOSE 9000

CMD ["php-fpm"]
