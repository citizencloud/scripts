#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

REFRESH_INTERVAL="30"

function usa::wat_why_tho() {
  curl --retry 3 -sSL \
    "https://static01.nyt.com/elections-assets/2020/data/api/2021-01-05/state-page/georgia.json" |
    jq -C \
      '.data.races[]
          | select(.race_type == "senate")
          | (.candidates[] | select(.party_id == "democrat") | .candidate_key) as $dem
          | (.candidates[] | select(.party_id == "republican") | .candidate_key) as $gop
          | { 
            dem: $dem,
            gop: $gop,
            diff: .counties 
             | map((.results[$dem] - .results[$gop]) as $diff 
               | ($diff / (.votes / .tot_exp_vote)) as $projected 
               | {current: $diff, projected: $projected}) 
             | {
               current: (map(.current) | add), 
               projected: (map(.projected) | add)
             }
          }'
}

function main() {
  if [[ $# == 0 ]]; then
    watch -c -n "${REFRESH_INTERVAL?}" bash "${BASH_SOURCE[0]}" y tho
  else
    usa::wat_why_tho
  fi
}

main "${@}"
