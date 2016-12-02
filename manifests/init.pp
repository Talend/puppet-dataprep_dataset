class dataprep_dataset (

  $version        = $dataprep_dataset::params::version,
  $java_args      = $dataprep_dataset::params::java_args,
  $app_args       = $dataprep_dataset::params::app_args,
  $yum_s3_enabled = $dataprep_dataset::params::yum_s3_enabled,
  $yum_s3_gpg     = $dataprep_dataset::params::yum_s3_gpg,
  $yum_base_url   = $dataprep_dataset::params::yum_base_url,
  $service_ensure = $dataprep_dataset::params::service_ensure,
  $service_enable = $dataprep_dataset::params::service_enable,

) inherits dataprep_dataset::params {

  validate_hash($java_args)
  validate_hash($app_args)
  validate_bool($yum_s3_enabled)
  validate_bool($yum_s3_gpg)

  $env_java_args = join_keys_to_values($java_args, '=')
  $env_app_args = join_keys_to_values($app_args, '=')

  class { 'dataprep_dataset::repos': } ->
  class { 'dataprep_dataset::install': } ->
  class { 'dataprep_dataset::config': } ~>
  class { 'dataprep_dataset::service': }
  contain 'dataprep_dataset::repos'
  contain 'dataprep_dataset::install'
  contain 'dataprep_dataset::config'
  contain 'dataprep_dataset::service'

}
