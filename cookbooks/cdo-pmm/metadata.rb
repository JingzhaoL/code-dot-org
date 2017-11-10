name             'cdo-pmm'
maintainer       'Code.org'
maintainer_email 'will@code.org'
license          'Apache 2.0'
description      'Installs/Configures Percona Monitoring and Management (PMM) server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'apt'
depends 'docker'
depends 'chef-apt-docker'
depends 'cdo-mysql'
