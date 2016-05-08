require 'spec_helper'
describe 'dataprep_dataset' do

  centos7_default_facts = {
      :osfamily               => 'RedHat',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '7.1'
    }

  context 'with defaults for all parameters' do

    let(:facts) { centos7_default_facts }

    it { should contain_class('dataprep_dataset') }
    it { should contain_class('dataprep_dataset::params') }
    it { should contain_class('dataprep_dataset::repos') }
    it { should contain_class('dataprep_dataset::install') }
    it { should contain_class('dataprep_dataset::config') }
    it { should contain_class('dataprep_dataset::service') }

    it { should contain_yumrepo('talend').without({'s3_enabled' => '1' }) }
    it { should contain_yumrepo('talend').with({'gpgcheck' => '0' }) }

    it { should contain_package('dataprep-dataset') }

    it { should contain_shellvar('APP_OPTS').with(
          {"value" => [
             "--dataset.content.store.file.location=/opt/talend/dataprep/data/content",
             "--dataset.metadata.store.file.location=/opt/talend/dataprep/data/metadata",
             "--user.data.store.file.location=/opt/talend/dataprep/data/userdata",
             "--folder.store.file.location=/opt/talend/dataprep/data/files"]})}

    it { should contain_shellvar('JAVA_OPTS').with({"value" => []} )}

    it { should contain_service('dataprep-dataset').with(
                {
                  'ensure' => 'running',
                  'enable' => 'true'
                }
                ) }
  end

  context 'with s3_yum repo' do

    let(:facts) { centos7_default_facts }

    let(:params) {{ 'yum_s3_enabled' => true }}

    it { should contain_yumrepo('talend').with({'s3_enabled' => '1' }) }

  end

end
