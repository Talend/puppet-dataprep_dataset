# == Class: dataprep_dataset
#
# Installs and configures dataprep-dataset service for TIC.
#
# === Parameters
#
#
# [*version*]
#   The application version to install. E.g 1.2.0
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dataprep_dataset':
#    version     => '1.2.0'
#  }
#
# === Authors
#
# Talend <sbaryakov@talend.com>
#
# === Copyright
#
# Copyright 2016 Talend SA
#
class dataprep_dataset(
  $version        = $dataprep_dataset::params::version,
  $java_args      = $dataprep_dataset::params::java_args,
  $app_args       = $dataprep_dataset::params::app_args,
  $yum_s3_enabled = $dataprep_dataset::params::yum_s3_enabled,
  $yum_s3_gpg     = $dataprep_dataset::params::yum_s3_gpg,
  $yum_base_url   = $dataprep_dataset::params::yum_base_url
) inherits dataprep_dataset::params {

  validate_hash($java_args)
  validate_hash($app_args)
  validate_bool($yum_s3_enabled)
  validate_bool($yum_s3_gpg)

  $env_java_args = join_keys_to_values($java_args, '=')
  $env_app_args = join_keys_to_values($app_args, '=')

#  class { 'dataprep_dataset::repos': } ->
  class { 'dataprep_dataset::install': } ->
  class { 'dataprep_dataset::config': } ~>
  class { 'dataprep_dataset::service': }
#  contain 'dataprep_dataset::repos'
  contain 'dataprep_dataset::install'
  contain 'dataprep_dataset::config'
  contain 'dataprep_dataset::service'

}
