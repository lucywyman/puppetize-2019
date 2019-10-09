plan puppetize::error_plan (
  Boolean $serious = false
) {
  if $serious {
    fail_plan('PANIC', 'puppetize/panic')
  } else {
    fail_plan('Log partition 99% full', 'puppetize/log-full')
  }
}
