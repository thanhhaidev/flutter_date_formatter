# Releasing

Pushing a version tag does everything: checks, pub.dev publish and docs deploy.

```
git tag v0.1.0 ──▶ verify ──▶ CI ──▶ publish to pub.dev ──▶ deploy docs
                    │          │       (OIDC, no token)       (changelog gets
                    │          │                               the tag date)
                    │          └ analyze, tests on 3 OSes, DST time zone, lowest deps
                    └ tag == pubspec version · CHANGELOG has "## x.y.z" · pub publish --dry-run
```

## One-time setup

1. **pub.dev automated publishing.** On https://pub.dev/packages/flutter_date_formatter/admin
   → *Automated publishing* → *Enable publishing from GitHub Actions*:
   - Repository: `thanhhaidev/flutter_date_formatter`
   - Tag pattern: `v{{version}}`
2. **GitHub Pages.** Repository *Settings → Pages → Build and deployment → Source*: **GitHub Actions**.

## Release steps

1. Bump `version:` in `pubspec.yaml` (e.g. `0.1.0`).
2. In `CHANGELOG.md`, rename `## Unreleased` to `## 0.1.0` (or add the section).
   The docs show it as "Release pending" until the tag exists.
3. Check locally:
   ```bash
   dart analyze --fatal-infos lib test && dart test
   dart pub publish --dry-run
   (cd website && npm ci && npm run build)
   ```
4. Commit, open a pull request and merge it into `main`.
5. Tag the merge commit with an **annotated** tag (its date becomes the release date) and push it:
   ```bash
   git checkout main && git pull
   git tag -a v0.1.0 -m "v0.1.0"
   git push origin v0.1.0
   ```
6. Watch the **Release** workflow in the Actions tab. When it finishes, the version is on
   https://pub.dev/packages/flutter_date_formatter and the docs at
   https://thanhhaidev.github.io/flutter_date_formatter/changelog show it as *Latest*.

If a check fails, nothing is published: fix it on `main`, then move the tag
(`git tag -d v0.1.0 && git push --delete origin v0.1.0`) and push it again. A version
that reached pub.dev cannot be published again; release a new patch version instead.

## Docs without a release

Pushes to `main` that touch `lib/`, `website/`, `pubspec.yaml` or `CHANGELOG.md`
redeploy the docs (workflow **Deploy docs**); it can also be run by hand from the Actions tab.
