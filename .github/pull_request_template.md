## Summary

Describe the problem and the change. Link the related issue when one exists.

## Validation

List the checks of the pack (`ci/PackChecks.ps1`) and the manual validation performed.

## Checklist

- [ ] I searched existing issues and pull requests before proposing this change.
- [ ] I did not change generated files (`maester-pack.json`, `entraops-source.json`, `tests/`, `helpers/`); those changes belong in EntraOps (see `CONTRIBUTING.md`).
- [ ] The checks of the pack pass, and the pack stays valid and Low risk (`Uses` in `maester-pack.json` stays empty).
- [ ] Every `.ps1` file contains function definitions only.
- [ ] I updated `README.md`, `TESTS.md` or `maester-pack.guide.json`, or confirmed that this change does not require documentation.
- [ ] I updated `CHANGELOG.md` when this change is release-relevant.
- [ ] I removed secrets, tokens, personal data, and tenant-sensitive data (including `findings.json` and Maester reports) from this pull request.
- [ ] I followed `SECURITY.md` for vulnerabilities instead of disclosing them publicly.
