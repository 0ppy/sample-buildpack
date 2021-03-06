#!/usr/bin/env bash

install_xdebug() {
  #!/bin/bash
  # Build Path: /app/.heroku/php/
  dep_url=git://github.com/xdebug/xdebug.git
  xdebug_dir=xdebug
  echo "-----> Building Xdbug..."

### Xdebug
  echo "[LOG] Downloading XDebug"
  git clone $dep_url -q
  if [ ! -d "$xdebug_dir" ]; then
    echo "[ERROR] Failed to find xdebug directory $xdebug_dir"
    exit
  fi
  cd $xdebug_dir/

# /app/php/bin/phpize
# ./configure --enable-xdebug --with-php-config=$PHP_ROOT/bin/php-config
# make
# make install
  BUILD_DIR=$0
  ln -s $BUILD_DIR/.heroku /app/.heroku
  export PATH=/app/.heroku/php/bin:$PATH
  phpize && ./configure --enable-phalcon && make && make install
  cd
  echo "important extension xdebug into php.ini"
  echo "extension=xdebug.so" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_host=xdebug-buildpack.herokuapp.com" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_port=9000" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_enable=on" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_handler=dbgp" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_mode=req" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.dump.GET = *" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.dump.PUT = *" >> /app/.heroku/php/etc/php/php.ini
  echo "xdebug.remote_autostart= On" >> /app/.heroku/php/etc/php/php.ini

}
