require 'spec_helper_acceptance'

describe 'dataprep_dataset class' do

  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'dataprep_dataset': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('dataprep-dataset') do
      it { should be_installed }
    end

    describe user('talend') do
      it { should belong_to_group 'talend' }
      it { should have_login_shell '/sbin/nologin' }
      it { should have_home_directory '/opt/talend' }
    end

    describe file('/opt/talend') do
      it { should be_directory }
      it { should be_writable.by_user('talend') }
    end

    describe service('dataprep-dataset') do
      it { should be_running }
    end

    describe port(8080) do
      it 'port 8080 should be listenting',  :retry => 20, :retry_wait => 10 do
         should be_listening
      end
    end

    describe 'content and metadata files', :retry => 2, :retry_wait => 20 do

      dataset_name = rand(36**5).to_s(36)
      let(:dataset_id) { command("curl --silent -X POST http://127.0.0.1:8080/datasets/?name=#{dataset_name} -H \"Content-type: text/csv\" -d \"1,2,3\"").stdout }

      it 'should have correct content file' do
        expect {file("/opt/talend/dataprep/data/content/#{dataset_id}").to be_file }
        expect {file("/opt/talend/dataprep/data/content/#{dataset_id}").to be_writable.by_user('talend') }
      end

      it 'should have correct metadata file' do
        expect {file("/opt/talend/dataprep/data/metadata/#{dataset_id}").to be_file }
        expect {file("/opt/talend/dataprep/data/metadata/#{dataset_id}").to be_writable.by_user('talend') }
      end

    end
  end
end
