include_recipe 'cdo-pmm::server'

# Installs and configures PMM client pointing at the target MySQL server.
apt_repository 'percona' do
  uri 'https://repo.percona.com/apt'
  distribution node[:lsb][:codename]
  components ['main']
  key '8507EFA5'
end

apt_package 'pmm-client'

template "/usr/local/percona/pmm-client/pmm.yml" do
  source 'pmm.yml.erb'
  notifies :run, 'execute[pmm-admin install]', :immediately
end

execute 'pmm-admin install' do
  sensitive true
  command <<-BASH
pmm-admin repair && \
pmm-admin add mysql \
  --host \'#{node['cdo-pmm']['mysql']['host']}\' \
  --port \'#{node['cdo-pmm']['mysql']['port']}\' \
  --user \'#{node['cdo-pmm']['mysql']['user']}\' \
  --password \'#{node['cdo-pmm']['mysql']['password']}\'
  BASH
  action :nothing
end
