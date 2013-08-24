#
# Cookbook Name:: sysctl
# Attributes:: default
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

default[:sysctl][:bin] = '/sbin/sysctl'
default[:sysctl][:file] = '/etc/sysctl.d/99-chef.conf'

if (not File.directory?(File.dirname(node[:sysctl][:file])))
  node[:sysctl][:file]="/etc/sysctl.conf"
end

default[:sysctl][:parameters][:net][:core][:rmem_max] = 16777216
default[:sysctl][:parameters][:net][:core][:wmem_max] = 16777216
default[:sysctl][:parameters][:net][:ipv4][:tcp_rmem] = [ 4096, 87380, 16777216 ]
default[:sysctl][:parameters][:net][:ipv4][:tcp_wmem] = [ 4096, 65536, 16777216 ]

default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:autoconf] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_ra] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_ra_defrtr] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_ra_rtr_pref] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_ra_pinfo] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_source_route] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:accept_redirects] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:default][:forwarding] = 0

default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:autoconf] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_ra] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_ra_defrtr] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_ra_rtr_pref] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_ra_pinfo] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_source_route] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:accept_redirects] = 0
default[:sysctl][:parameters][:net][:ipv6][:conf][:all][:forwarding] = 0
