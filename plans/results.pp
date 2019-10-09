plan puppetize::results (
  TargetSpec $nodes
) {
  $results = run_command('uname -a', $nodes)
  $results.map |$result| {
    out::message("Uname result for ${$result.target.name}:\n    ${$result.value['stdout']}")
  }
}
