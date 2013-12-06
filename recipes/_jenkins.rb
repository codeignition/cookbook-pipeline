# Encoding: utf-8
# Cookbook Name:: cookbook-pipeline 
# Recipe:: _jenkins
#
# Copyright (C) 2013 timusg
#
# All rights reserved - Do Not Redistribute

include_recipe 'jenkins::server'

 %w(git).each do |plugin|
   jenkins_cli "install-plugin #{plugin}"
 end

node[:jobs].each do |job|
  job_name = job[:name]
  job_config = File.join(node[:jenkins][:node][:home], "#{job_name}-config.xml")

  template job_config do
    source    'config.xml.erb'
    variables({ :job_name => job_name,
                :git_branch =>job[:git_branch],
                :email_id => node[:git][:email],
                :trigger => job[:trigger],
                :build_steps => job[:build_steps]
    })
  end

  jenkins_job job_name do
    action :create
    config job_config
    notifies :restart , "service[jenkins]"
  end
end

# add jenkins to admin group required for sudo access
admin_group = 'root' 
admin_group = 'sudo' if ['ubuntu', 'debian'].include? node[:platform]

group admin_group do
  action :modify
  members "jenkins"
  append true
end

# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
