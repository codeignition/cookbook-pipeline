# Encoding: utf-8

name             'cookbook-pipeline'
maintainer       'sumit'
maintainer_email 'timusga@gmail.com'
license          'All rights reserved'
description      'Installs/Configures pipline'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

depends 'docker'
depends 'jenkins'
