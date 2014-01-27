require_relative "spec_helper"

describe "openstack-common::default" do
  describe "ubuntu" do
    before do
      opts = ::UBUNTU_OPTS.merge :step_into => ["apt_repository"]
      @chef_run = ::ChefSpec::Runner.new(opts) do |n|
        n.set["lsb"]["codename"] = "precise"
      end
      @chef_run.converge "openstack-common::default"
    end

    it "installs ubuntu-cloud-keyring package" do
      expect(@chef_run).to install_package "ubuntu-cloud-keyring"
    end

    it "configures openstack repository" do
      file = "/etc/apt/sources.list.d/openstack-ppa.list"
      expected = "deb     http://ubuntu-cloud.archive.canonical.com/ubuntu  precise-updates/havana main"

      expect(@chef_run).to render_file(file).with_content(expected)
    end
  end
end
