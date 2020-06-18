#!/bin/bash

set -ex

EXIT_STATUS=0

# Test if the generated code is still up to date
python ./${PACKAGE_NAME}/_tools/gen_exports.py --test \
    || EXIT_STATUS=$?

# Autoformatter *first*, to avoid double-reporting errors
# (we'd like to run further autoformatters but *after* merging;
# see https://forum.bors.tech/t/pre-test-and-pre-merge-hooks/322)
# autoflake --recursive --in-place .
# pyupgrade --py3-plus $(find . -name "*.py")
if ! black --check setup.py ${PACKAGE_NAME}; then
    EXIT_STATUS=1
    black --diff setup.py ${PACKAGE_NAME}
fi

# Run flake8 without pycodestyle and import-related errors
flake8 ${PACKAGE_NAME}/ \
    --ignore=D,E,W,F401,F403,F405,F821,F822\
    || EXIT_STATUS=$?

# Finally, leave a really clear warning of any issues and exit
if [ $EXIT_STATUS -ne 0 ]; then
    cat <<EOF
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Problems were found by static analysis (listed above).
To fix formatting and see remaining errors, run

    pip install -r test-requirements.txt
    black setup.py ${PACKAGE_NAME}
    ./check.sh

in your local checkout.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
EOF
    exit 1
fi
exit 0
