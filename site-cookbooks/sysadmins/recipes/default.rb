#
# Cookbook Name:: sysadmins
# Recipe:: default
#
# Copyright 2014, Bèr `berkes` Kessels
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

node[:sysadmins].each do |username, user|
  home_dir = "/home/#{username}"
  # Create a user
  user username do
    home home_dir
    password user["password"] if user["password"]

    shell "/bin/bash"
    manage_home true
    action :create
  end

  # Add ssh-keys to authorized_keys
  # Always create the file and dir, even if user did not provide
  # ssh-keys
  directory "#{home_dir}/.ssh" do
    owner username
    group username
    mode "0700"
  end
  if user["ssh"]
    template "#{home_dir}/.ssh/authorized_keys" do
      source "authorized_keys.erb"
      owner username
      group username
      mode "0600"
      variables keys: user["ssh"]["authorized_keys"]
    end

    template "#{home_dir}/.ssh/id_rsa.pub" do
      source "id_rsa.pub.erb"
      owner username
      group username
      mode "0600"
      variables key: user["ssh"]["id_rsa.pub"]
    end

    template "#{home_dir}/.ssh/id_rsa" do
      source "id_rsa.pub.erb"
      owner username
      group username
      mode "0600"
      variables key: user["ssh"]["id_rsa"]
    end
  end

end

# Add users to the sysadmin group. This is the group used by
# the sudo cookbook to grant users sudo-access.
group "admin" do
  members node[:sysadmins].keys
end
