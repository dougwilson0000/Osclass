FROM php:8.1-apache

# Enable Apache mod_rewrite (Osclass needs it)
RUN a2enmod rewrite

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql mysqli gd

# Set the working directory
WORKDIR /var/www/html

# Copy your app files to the container
COPY . /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port (Render will auto-detect 80)
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
