#
# Cookbook Name:: sysctl
# Recipe:: default
#
# Copyright (C) 2013 DOYOUSOFT
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

package "procps" do
  action :upgrade
end

service "procps"

interfaces=node[:network][:interfaces].keys.map { |a| a.to_s.sub(".","/") }

# Build sysctl file
template "#{node[:sysctl][:file]}" do
  mode 0644
  owner "root"
  group "root"
  source "sysctl.erb"
  variables(:parameters => node[:sysctl][:parameters])
  notifies(:start,"service[procps]", :immediately)
  action :nothing
end

# Parse defined parameters and automatically create interface specific default attributes
#  for each net.ipv4.conf.{default+all} and net.ipv6.conf.{default+all} parameters
ruby_block 'network_extend' do
  block do
    if (node[:sysctl][:parameters].has_key?(:net))
      %w{ipv4 ipv6}.each do |proto|
        if (node[:sysctl][:parameters][:net].has_key?(proto) and
            node[:sysctl][:parameters][:net][proto].has_key?(:conf) and
            node[:sysctl][:parameters][:net][proto][:conf].has_key?(:default) and
            node[:sysctl][:parameters][:net][proto][:conf].has_key?(:all) )

          node[:sysctl][:parameters][:net][proto][:conf][:default].each do |k,v|
            if (node[:sysctl][:parameters][:net][proto][:conf][:all].has_key?(k))
              interfaces.each do |i|
                if (not (node[:sysctl][:parameters][:net][proto][:conf].has_key?(i) and
                         node[:sysctl][:parameters][:net][proto][:conf][i].has_key?(k)))
                  node.default[:sysctl][:parameters][:net][proto][:conf][i][k]=v
                end
              end
            end
          end
        end
      end
    end
  end
  notifies :create, "template[#{node[:sysctl][:file]}]", :immediately
  action :nothing
end

ruby_block 'delayed sysctl generation' do
  block do
    true
  end
  notifies :create, "ruby_block[network_extend]", :delayed
end
