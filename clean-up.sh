#!/bin/bash

# Functions
run_lint() {
  echo "------------------------------------------------------------"
  echo "$1"
  echo "------------------------------------------------------------"
  
  shift # remove the first argument, the rest are the command and its args
  "$@"
  echo "✅ Done!"
  echo ""
}

# Main Script Execution

# Lint Ruby files
run_lint "Linting .rb files" bundle exec rubocop -a --config config/.rubocop.yml --debug --cache false

# Hint for manual autocorrection
echo "Tip: Manually run 'bundle exec rubocop -A' to force autocorrect."

# Lint ERB files
run_lint "Linting .html.erb files" bundle exec erblint --lint-all --autocorrect --config config/.erb-lint.yml

echo "✅ All Clean!"

# Placeholder for future additions
# run_lint "Linting with Reek" bundle exec reek

exit 0

