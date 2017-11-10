# Installs PMM client pointing at the target MySQL server, which may be local or remote.
apt_repository 'percona' do
  uri 'https://repo.percona.com/apt'
  distribution node[:lsb][:codename]
  components ['main']
  key '8507EFA5'
end

apt_package 'pmm-client'

template "/usr/local/percona/pmm-client/pmm.yml" do
  source 'pmm.yml.erb'
  notifies :run, 'execute[pmm-admin restart]', :immediately
end

execute 'pmm-admin restart' do
  action :nothing
end

execute 'pmm-admin add mysql' do
  command "pmm-admin add mysql --server #{node['cdo-pmm']['mysql']}"
end
