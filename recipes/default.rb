#
# Cookbook:: amaze_pdns
# Recipe:: default
#
# Copyright:: 2019, Amaze Communication
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ENV['LANG'] = 'en_AU.UTF-8'

locale ENV['LANG'] do
  lang ENV['LANG']
  action :update
end

{
  'pdns' => { id: 400, home: '/var/spool/powerdns' },
  'pdns-admin' => { id: 401, home: '/srv/www/pdns-admin' },
  'pdns-www' => { id: 402, home: '/srv/www/pdns-admin' }
}.each do |name, attrs|
  id = attrs[:id]
  group name do
    gid id
  end
  user name do
    uid id
    gid id
    home attrs[:home]
    manage_home false
    shell '/usr/sbin/nologin'
    password '*'
  end
end

apt_repository 'PowerDNS' do
  uri 'http://repo.powerdns.com/debian'
  components ['main']
  distribution 'buster-auth-42'
  arch 'amd64'
  key 'https://repo.powerdns.com/FD380FBB-pub.asc'
end

apt_preference 'PowerDNS' do
  glob 'pdns-*'
  pin 'origin repo.powerdns.com'
  pin_priority 600
end

apt_package %w( git vim curl sudo dnsutils net-tools postgresql-11 pdns-server pdns-backend-pgsql gunicorn3 python3-pip python3-setuptools python3-psycopg2 python3-jsmin python3-cssmin python3-flask-assets python3-flask-login python3-flask-migrate python3-flask-sqlalchemy python3-simplejson )

postgresql_server_install 'postgresql-11' do
  version '11'
  setup_repo false
end

postgresql_user 'pdns' do
  password 'pdns'
end

postgresql_database 'pdns' do
  owner 'pdns'
  locale ENV['LANG']
end

postgresql_user 'pdns_admin' do
  password 'pdns_admin'
end

postgresql_database 'pdns_admin' do
  owner 'pdns_admin'
  locale ENV['LANG']
end

directory '/srv/www'
directory '/srv/www/pdns-admin' do
  user 'pdns-admin'
  group 'pdns-admin'
end

git '/srv/www/pdns-admin' do
  repository 'https://github.com/AmazeCom/PowerDNS-Admin.git'
  checkout_branch 'master'
  user 'pdns-admin'
  group 'pdns-admin'
  action :checkout
end

