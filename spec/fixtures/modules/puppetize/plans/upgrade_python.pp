plan puppetize::upgrade_python (
  TargetSpec $nodes
) {
  $versions = run_command("python --version", $nodes, _catch_errors => true)

  ## Parsing Results
  $python2 = $versions.ok_set.filter_set |$v| {
    $v.value['stderr'] =~ /^Python 2*/
  }
  $python3 = $versions.ok_set.filter_set |$v| {
    $v.value['stderr'] =~ /^Python 3*/
  }

  ## Handling Errors
  $versions.error_set.each |$err| {
    unless $err.value['stderr'] =~ /command not found/ {
      run_command("echo '${$err.target} failed with error: ${$err.value}' >> errors", 'localhost')
    }
  }

  ## Logging
  out::message("Python 2.x targets:\n${$python2.targets}")
  warning("\nPython 3.x targets:\n${$python3.targets}")
  notice("I'm only printed when run with --verbose")

  # Upgrade Python
  run_command("yum install -y python3", $python2.targets)
  run_command("ln -sf /usr/bin/python3 /usr/bin/python", $python2.targets)
  return run_command("python --version", $python2.targets)
}
