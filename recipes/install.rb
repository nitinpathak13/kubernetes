#
# Cookbook:: kubernetes
# Recipe:: install
#
# Copyright:: 2020, The Authors, All Rights Reserved.

minikube_version = node['minikube']['version']

apt_update
package 'apt-transport-https'

apt_repository 'kubernetes.list' do
  key 'https://packages.cloud.google.com/apt/doc/apt-key.gpg'
  uri 'https://apt.kubernetes.io/'
  distribution 'kubernetes-xenial'
  components ['main']
end

apt_update
package 'kubectl'

remote_file "#{Chef::Config[:file_cache_path]}/minikube_#{minikube_version}-0_amd64.deb" do
  source "https://github.com/kubernetes/minikube/releases/download/v#{minikube_version}/minikube_#{minikube_version}-0_amd64.deb"
end

dpkg_package 'minikube' do
  source "#{Chef::Config[:file_cache_path]}/minikube_#{minikube_version}-0_amd64.deb"
end
