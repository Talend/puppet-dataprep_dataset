class dataprep_dataset::service {

  service {
    'dataprep-dataset':
      ensure => running,
      enable => true
  }

}
