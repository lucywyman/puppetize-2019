require 'bolt_spec/plans'
require 'puppetlabs_spec_helper/module_spec_helper'

# Load puppet, initialize logger
BoltSpec::Plans.init

describe 'upgrade_python' do
  include BoltSpec::Plans

  it 'installs python3 on python2 targets' do
    expect_command("python --version")
      .be_called_times(2)
      .with_targets(["foo", "bar"])
      .always_return("stderr" => "Python 2.7.5")

    expect_out_message

    expect_command("yum install -y python3")
      .with_targets(["foo", "bar"])
    expect_command("ln -sf /usr/bin/python3 /usr/bin/python")
      .with_targets(["foo", "bar"])

    result = run_plan('puppetize::upgrade_python', 'nodes' => 'foo, bar')
    expect(result.ok?).to eq(true)
  end
end
