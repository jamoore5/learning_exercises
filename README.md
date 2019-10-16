# Test && Commit || Revert
[Blog introducing TCR](https://medium.com/@tdeniffel/tcr-test-commit-revert-a-test-alternative-to-tdd-6e6b03c22bec)

I am using a variant of TCR that only reverts when I change none test files. That way I can use use TDD and get the benefits of the red-green-refactor cycle.

Here are the bash functions I am using
```
function only_test_changes() { if [ "$(git status | grep -c lib)" -eq 0 ]; then echo 'only test changes'; else false; fi; }

function tcr() { rake test && (git add . && git commit -m "working code") || only_test_changes || git reset --hard; }
```
