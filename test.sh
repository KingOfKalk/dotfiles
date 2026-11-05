#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_SCRIPT="test.sh"
# Optional: path to write a JUnit XML report to.
JUNIT_OUTPUT="${JUNIT_OUTPUT:-}"

log() { printf "[dotfiles] %s\n" "$1"; }

xml_escape() {
  local s="$1"
  s="${s//&/&amp;}"
  s="${s//</&lt;}"
  s="${s//>/&gt;}"
  s="${s//\"/&quot;}"
  printf '%s' "${s}"
}

# Microseconds since epoch (strips the locale-dependent decimal separator).
now_us() { printf '%s' "${EPOCHREALTIME//[!0-9]/}"; }

# Formats a microsecond duration as seconds, e.g. 0.123456.
seconds() { printf '%d.%06d' $(($1 / 1000000)) $(($1 % 1000000)); }

# Turns a feature's PASS/FAIL/SKIP lines into a JUnit <testsuite>.
junit_suites=""
junit_suite() {
  local name="$1" output="$2" rc="$3" time="$4"
  local cases="" tests=0 failures=0 skipped=0 line status msg
  local pattern='^\[[^]]+\] (PASS|FAIL|SKIP) (.*)$'
  while IFS= read -r line; do
    [[ "${line}" =~ ${pattern} ]] || continue
    status="${BASH_REMATCH[1]}"
    msg="$(xml_escape "${BASH_REMATCH[2]}")"
    tests=$((tests + 1))
    case "${status}" in
      PASS) cases+="    <testcase classname=\"${name}\" name=\"${msg}\"/>"$'\n' ;;
      FAIL)
        failures=$((failures + 1))
        cases+="    <testcase classname=\"${name}\" name=\"${msg}\"><failure message=\"${msg}\"/></testcase>"$'\n'
        ;;
      SKIP)
        skipped=$((skipped + 1))
        cases+="    <testcase classname=\"${name}\" name=\"${msg}\"><skipped/></testcase>"$'\n'
        ;;
    esac
  done <<<"${output}"
  if [ "${rc}" -ne 0 ] && [ "${failures}" -eq 0 ]; then
    tests=$((tests + 1))
    failures=$((failures + 1))
    cases+="    <testcase classname=\"${name}\" name=\"${TEST_SCRIPT}\"><failure message=\"exited with code ${rc}\"/></testcase>"$'\n'
  fi
  junit_suites+="  <testsuite name=\"${name}\" tests=\"${tests}\" failures=\"${failures}\" skipped=\"${skipped}\" time=\"${time}\">"$'\n'
  junit_suites+="${cases}  </testsuite>"$'\n'
}

log "Starting dotfiles tests from: ${SCRIPT_DIR}"
run_start="$(now_us)"

passed=()
failed=()
for dir in "${SCRIPT_DIR}"/*/; do
  [ -d "${dir}" ] || continue
  if [ -f "${dir}${TEST_SCRIPT}" ]; then
    name="$(basename "${dir}")"
    log "Running ${dir}${TEST_SCRIPT}"
    rc=0
    start="$(now_us)"
    output="$(cd "${dir}" && bash "${TEST_SCRIPT}" 2>&1)" || rc=$?
    duration="$(seconds $(($(now_us) - start)))"
    printf '%s\n' "${output}"
    if [ "${rc}" -eq 0 ]; then
      passed+=("${name}")
    else
      failed+=("${name}")
    fi
    junit_suite "${name}" "${output}" "${rc}" "${duration}"
  fi
done

log "Summary: ${#passed[@]} passed, ${#failed[@]} failed."
for name in "${passed[@]}"; do
  log "  PASS ${name}"
done
for name in "${failed[@]}"; do
  log "  FAIL ${name}"
done

if [ -n "${JUNIT_OUTPUT}" ]; then
  mkdir -p "$(dirname "${JUNIT_OUTPUT}")"
  {
    printf '<?xml version="1.0" encoding="UTF-8"?>\n<testsuites time="%s">\n' \
      "$(seconds $(($(now_us) - run_start)))"
    printf '%s' "${junit_suites}"
    printf '</testsuites>\n'
  } >"${JUNIT_OUTPUT}"
  log "Wrote JUnit report to ${JUNIT_OUTPUT}"
fi

[ "${#failed[@]}" -eq 0 ]
