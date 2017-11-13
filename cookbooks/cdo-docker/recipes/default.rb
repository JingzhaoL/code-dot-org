include_recipe 'cdo-docker::client'

docker_service_manager('default') do
  storage_driver node['cdo-docker']['storage_driver'] if node['cdo-docker']['storage_driver']
end
