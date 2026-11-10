# AGENTS.md — platform-modules

Versioned Terraform building blocks for the `platform-live` demo platform
(DevFest Berlin 2026). Project docs live in `../platform-live/docs/`.
Used from PLAN step 8 on; before that, modules live in `platform-live/modules/`.

## Layout
```
modules/vm-group/   private VMs with the platform defaults (see platform-live AGENTS.md)
examples/           minimal callers for CI `terraform validate`
.github/workflows/  ci.yml (fmt, validate, tflint, trivy) / release.yml (semantic-release)
```

## Versioning
- Released only from `main` by semantic-release (tag + GitHub Release, no commit back).
- Conventional Commits are mandatory:
  `fix:` → patch · `feat:` → minor · `feat!:` or `BREAKING CHANGE:` footer → major.
  A commit without a type produces no release and is missing from the notes.
- Breaking = callers must change their code, OR Terraform would destroy/recreate
  existing resources (changed for_each keys, names, or force-new attributes).

## Hard rules
Same as platform-live: no apply, no keys, pin everything (actions by SHA),
stable for_each keys, nothing from employer/customer environments,
`make check` before finishing, update `../platform-live/docs/STATUS.md` at session end.
