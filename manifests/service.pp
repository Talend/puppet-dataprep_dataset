class dataprep_dataset::service (

  $service_ensure = $dataprep_dataset::service_ensure,
  $service_enable = $dataprep_dataset::service_enable,

) {

  service { 'dataprep-dataset':
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
