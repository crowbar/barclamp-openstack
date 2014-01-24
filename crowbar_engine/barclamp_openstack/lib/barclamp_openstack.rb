# Copyright 2014, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "barclamp_openstack/engine"

module BarclampOpenstack

  def store_credential(type, user, password)
    CHEF_BASE = "/var/chef"
    DATA_BAGS = "#{CHEF_BASE}/data_bags"

    secret = "#{DATA_BAGS}/openstack_data_bag_secret"
    if ! File.exists?( secret )
      %x( openssl rand -base64 512 | tr -d '\r\n' > #{secret} )
      File.chmod( 0400, secret )
    end

    data_bag = "#{type}_passwords"

    %x( knife solo data bag create #{data_bag} #{user} --json \'{\"id\": \"#{user}\", \"password\": \"#{password}\"}\' -c /etc/chef/solo.rb --secret-file #{secret} )
  end
end
