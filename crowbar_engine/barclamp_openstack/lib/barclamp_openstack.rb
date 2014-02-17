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
require 'rubygems'
require 'chef/encrypted_data_bag_item'

module BarclampOpenstack

  def store_credential(bc, type, user, password)

    Rails.logger.info("Adding encrypted credentials into encrypted data bags" )
    Rails.logger.info("BC: " + bc )
    Rails.logger.info("Type: " + type )
    Rails.logger.info("User: " + user )
    Rails.logger.info("Password: " + password)

    data_bag_dir = "/var/tmp/barclamps/#{bc}/chef-solo/data_bags"
    secret_file = "#{data_bag_dir}/openstack_data_bag_secret"
    if(type == 'secrets')
      data_bag = "#{type}"
    else
      data_bag = "#{type}_passwords"
    end

    data_bag_file_path = "#{data_bag_dir}/#{data_bag}/"

    if ! File.directory?( data_bag_file_path )
      %x( mkdir -p #{data_bag_file_path} )
    end

    if ! File.exists?( secret_file )
      %x( openssl rand -base64 512 | tr -d '\r\n' > #{secret_file} )
      File.chmod( 0400, secret_file )
    end

    data_bag_file = "#{data_bag_file_path}/#{user}.json"

    data = {"id" =>  "#{user}", "#{user}" =>  "#{password}"} 

    secret = Chef::EncryptedDataBagItem.load_secret(secret_file)
    encrypted_data = Chef::EncryptedDataBagItem.encrypt_data_bag_item(data, secret)

    data_bag_data = { "name" => "data_bag_item_#{data_bag}_#{user}",
                      "json_class" => "Chef::DataBagItem",
                      "chef_type" => "data_bag_item",
                      "data_bag" => data_bag,
                      "raw_data" => encrypted_data
                    }
    File.open(data_bag_file, 'w') do |f|
      f.print data_bag_data.to_json
    end
    Rails.logger.info("data_bag_file: " + data_bag_file )
  end
end
