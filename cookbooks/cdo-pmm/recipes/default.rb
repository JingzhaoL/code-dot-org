include_recipe 'chef-apt-docker'

docker_installation_package 'default' do
  action :create
end

# docker_service_manager 'default' do
#   storage_driver :overlay2
#   action :start
# end

docker_image 'percona/pmm-server' do
  tag 'latest'
  action :pull
  notifies :redeploy, 'docker_container[pmm_server]'
end

docker_container 'pmm_data' do
  repo 'percona/pmm-server'
  tag 'latest'
  volumes %w(
    /opt/prometheus/data
    /opt/consul-data
    /var/lib/mysql
    /var/lib/grafana
  )
  command 'true'
  action :create
end

docker_container 'pmm_server' do
  repo 'percona/pmm-server'
  tag 'latest'
  port "#{node['cdo-pmm']['server']['port']}:80"
  volumes_from 'pmm_data'
  restart_policy 'always'
  env ['DISABLE_TELEMETRY=true']
end
