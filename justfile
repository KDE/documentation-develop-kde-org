extract:
  cd {{invocation_directory()}} && PACKAGE=documentation-develop-kde-org hugoi18n extract pot
generate:
  cd {{invocation_directory()}} && PACKAGE=documentation-develop-kde-org hugoi18n generate -k
