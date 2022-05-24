#!/bin/bash

if [[ $# -lt 4 ]] ; then
  echo -e '\nNot enough parameters! You need to set the necessary parameters:\n'
  echo -e '-e <python environment name> \t\t Python environment name, in order to use your pip dependencies.'
  echo -e '-a <dir name> \t\t\t\t Artifacts directory used for cache files between pipeline scripts.'
  echo -e '\n\nusage: ./running_test_endpoints.sh -e <python environment name> -a <artifacts dir>'
  exit 1
fi

while getopts "e:a:" option 
do
  case "${option}"
  in
  e) env_name=${OPTARG};;
  a) artifacts=${OPTARG};;
  esac
done

echo "Switch to Virtual Environment"
source $env_name/bin/activate

echo "Building the test endpoints"
python3 -m outsystems.pipeline.evaluate_test_results --artifacts "$artifacts"

# Store the exit status from the command above, to make it the exit status of this script
status_code=$?

echo "Leave the Virtual Environment for now"
deactivate

exit $status_code