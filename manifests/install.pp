class dataprep_dataset::install {

  class { '::java':
    package => 'java-1.8.0-openjdk'
  } ->

  package { 'dataprep-dataset':
    ensure => $dataprep_dataset::version
  }

}
