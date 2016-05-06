class dataprep_dataset::config {


  if empty($dataprep_dataset::env_java_args) {
    $java_opts_ensure = absent
  } else {
    $java_opts_ensure = present
  }

  if empty($dataprep_dataset::env_app_args) {
    $app_opts_ensure = absent
  } else {
    $app_opts_ensure = present
  }

  shellvar {
    'JAVA_OPTS':
      ensure     => $java_opts_ensure,
      target     => '/etc/sysconfig/dataprep-dataset',
      array_type => 'string',
      value      => $dataprep_dataset::env_java_args;

    'APP_OPTS':
      ensure     => $app_opts_ensure,
      target     => '/etc/sysconfig/dataprep-dataset',
      array_type => 'string',
      value      => $dataprep_dataset::env_app_args;
  }

}
