# frozen_string_literal: true

require 'spec_helper'

describe 'shared_module' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:hiera_config) { 'hiera-rspec.yaml' }

      tiers = [ 'dog' ]
      datacentres = [ 'blah', 'cats', 'dogs', 'hi', 'hello', 'gday' ]

      tiers.each do |tier|
        context "with tier #{tier}" do
          let(:facts) do
            super().merge({ 'tier' => tier })
          end

          datacentres.each do |datacentre|
            context "with datcentre #{datacentre}" do
              let(:facts) do
                super().merge({ 'datacentre' => datacentre })
              end

              it { is_expected.to compile.with_all_deps }
              it { is_expected.to contain_file('/tmp/shared.txt').with_content('This content is from the shared module.') }
              it { is_expected.to contain_file('/blah.txt').with_content(%r{blah}) }
            end
          end
        end
      end
    end
  end
end
