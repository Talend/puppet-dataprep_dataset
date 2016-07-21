class dataprep_dataset::repos {

  if $dataprep_dataset::yum_s3_enabled {
    $s3_enabled_value = '1'
  } else {
    $s3_enabled_value = 'absent'
  }

  yumrepo { 'talend':
    baseurl    => $dataprep_dataset::yum_base_url,
    gpgcheck   => 0,
    s3_enabled => $s3_enabled_value
  }

}
