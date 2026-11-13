# platform-modules

Versioned Terraform modules for the [`platform-live`](https://github.com/mofach90/platform-live) demo platform.

| Module | What it creates |
|--------|-----------------|
| [`modules/vm-group`](modules/vm-group) | a group of identical private VMs with the platform defaults: no external IP, OS Login, Shielded VM, own service account, daily snapshots, labels |

## Use
Always pin a released tag, never a branch:
```hcl
module "vm_group" {
  source = "git::https://github.com/mofach90/platform-modules.git//modules/vm-group?ref=v1.0.0"
  # …
}
```

## Versions
Semantic Versioning. A change is **breaking** (major) when callers must change their code
or Terraform would destroy and recreate existing resources.

## Develop
`make check` runs fmt, validate (through `examples/`), tflint, trivy and gitleaks.
