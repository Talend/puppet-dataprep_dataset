require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'
require 'rspec/retry'

run_puppet_install_helper

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  c.formatter = :documentation
  hosts.each do |host|
    copy_module_to(host, :source => proj_root, :module_name => 'dataprep_dataset')

    on host, puppet('module', 'install', 'puppetlabs-stdlib'), acceptable_exit_codes: [0, 1]
    on host, puppet('module', 'install', 'puppetlabs-java'), acceptable_exit_codes: [0, 1]
    on host, puppet('module', 'install', 'herculesteam-augeasproviders_core'), acceptable_exit_codes: [0, 1]
    on host, puppet('module', 'install', 'herculesteam-augeasproviders_shellvar'), acceptable_exit_codes: [0, 1]

  end
end
