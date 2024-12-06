#!/bin/bash

set -x
set -eo pipefail

rm -rf generated && ytt -f . --output-files generated/ --ignore-unknown-comments --file-mark '*.yaml:exclusive-for-output=true'  --file-mark '*.yml:exclusive-for-output=true' --file-mark 'clustergroups/**/*:exclusive-for-output=true' --file-mark 'values-examlpe.yaml:exclude=true'
(cd generated && tanzu deploy --nested-contexts)