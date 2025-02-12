# frozen_string_literal: true

#
# Cookbook Name:: ms_dotnet
# Recipe:: regiis
# Author: Kendrick Martin(<kendrick.martin@webtrends.com>)
#
# This recipe registers .NET 4 with IIS to install ISAPI filters
#
# Copyright 2012, Webtrends, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
return unless platform? 'windows'

guard_file = ::File.join(::Chef::Config['file_cache_path'], 'aspnet_regiis')
# register once and only if IIS is installed
execute 'aspnet_regiis' do
  action :run
  command "%WINDIR%\\Microsoft.Net\\Framework64\\v4.0.30319\\aspnet_regiis.exe -i -enable > #{guard_file}"
  creates guard_file
  only_if 'sc.exe query W3SVC'
end
