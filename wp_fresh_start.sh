# update package list 
apt-get –y update
# Install WP-CLI
wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
chmod +x wp-cli.phar 
sudo mv wp-cli.phar /usr/local/bin/wp

# Remove Bitnami banner config file
#sed -i 's/search_string/replace_string/' filename

# Clear posts, comments & pages
wp post delete $(wp post list --post_type='page' --format=ids) --force
wp post delete $(wp post list --post_type='post' --format=ids) --force
sudo wp comment delete $(sudo wp comment list --format=ids) --force

# Deactivate all plugins & uninstall
wp plugin deactivate --all
wp plugin uninstall --all

# Install Hello theme & activate
wp theme install hello-elementor --activate

# Uninstall all themes except the active one
wp theme delete --all

# Install default plugins
wp plugin install elementor woocommerce seo-by-rank-math --activate

# Create static homepage & set as default
wp post create --post_type=page --post_name='homepage' --post_title='Homepage' --post_status='publish'
sudo wp option update page_on_front $(sudo wp post list --post_type=page --post_name='homepage' --fields=ID)

# Set new default settings
wp option set blog_public 0
wp option set blogname 'Puffin Site'
wp option set blogdescription 'Just another puffin website'

# Set permalink structure to post_name
wp rewrite structure '/%postname%/'

# Update default user
# wp db query "UPDATE wp_users SET user_login = 'cp_admin' WHERE user_login = 'user'"
