class dataprep_dataset::install {

  contain ::java
  package {
    'dataprep-dataset':
      ensure => $dataprep_dataset::version
  }

}
