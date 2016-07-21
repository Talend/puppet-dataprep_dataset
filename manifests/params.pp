class dataprep_dataset::params {

  $java_args      = {}
  $version        = 'installed'
  $yum_s3_enabled = false
  $yum_s3_gpg     = false
  $yum_base_url   = 'https://s3.amazonaws.com/us-east-1-pub-devops-talend-com/yum-oss/talend'

  $installation_prefix = '/opt/talend/dataprep/data'

  $app_args = {
    '--dataset.content.store.file.location'  => "${installation_prefix}/content",
    '--dataset.metadata.store.file.location' => "${installation_prefix}/metadata",
    '--user.data.store.file.location'        => "${installation_prefix}/userdata",
    '--folder.store.file.location'           => "${installation_prefix}/files"
  }

}
