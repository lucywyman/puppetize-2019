plan puppetize::handle_errors(
  Boolean $serious = false
) {
  $result = run_plan('puppetize::error_plan', 'serious' => $serious, '_catch_errors' => true)
  case $result {
    Error['puppetize/log-full'] : {
      out::message("${result.message}")
    }
    Error : { fail_plan($result) }
  }
  return 'Keep calm and carry on!'
}
