# Releasing

Pushing a version tag does everything: checks, pub.dev publish and docs deploy.

```
git tag v0.2.0 ──▶ Release: verify ──▶ CI ──▶ publish to pub.dev (OIDC, no token)
                    │         │
                    │         └ analyze, tests on 3 OSes, DST time zone, lowest deps
                    └ tag == pubspec version · CHANGELOG has "## x.y.z" · pub publish --dry-run

Release succeeded ──▶ Deploy docs (runs on main) ──▶ changelog shows the tag date
```

The docs deploy runs as a separate workflow on `main` because the `github-pages`
environment only accepts deployments from `main`, not from tags.

## One-time setup

1. **pub.dev automated publishing.** On https://pub.dev/packages/flutter_date_formatter/admin
   → *Automated publishing* → *Enable publishing from GitHub Actions*:
   - Repository: `thanhhaidev/flutter_date_formatter`
   - Tag pattern: `v{{version}}`
2. **GitHub Pages.** Repository *Settings → Pages → Build and deployment → Source*: **GitHub Actions**.

## Release steps

1. Bump `version:` in `pubspec.yaml` (e.g. `0.2.0`).
2. In `CHANGELOG.md`, move the release notes into a `## 0.2.0` section.
   The docs show it as "Release pending" until the tag exists.
   Before tagging, verify this section covers every change included in the
   release.
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
   git tag -a v0.2.0 -m "v0.2.0"
   git push origin v0.2.0
   ```
6. After publishing a new version, create its docs snapshot from the matching package
   commit and commit the generated `website/versioned_docs/`, `website/versioned_sidebars/`
   and `website/versions.json` files:
   ```bash
   cd website
   npm run docs:version -- 0.2.0
   ```
   The latest released docs are served at `/docs`, development docs at
   `/docs/next`, and earlier releases at `/docs/<version>/...`.
7. Watch the **Release** workflow in the Actions tab. When it finishes, the version is on
   https://pub.dev/packages/flutter_date_formatter and the docs at
   https://thanhhaidev.github.io/flutter_date_formatter/changelog show it as *Latest*.

If a check fails, nothing is published: fix it on `main`, then move the tag
(`git tag -d v0.2.0 && git push --delete origin v0.2.0`) and push it again. A version
that reached pub.dev cannot be published again; release a new patch version instead.

## Docs without a release

Pushes to `main` that touch `lib/`, `website/`, `pubspec.yaml` or `CHANGELOG.md`
redeploy the docs (workflow **Deploy docs**); it can also be run by hand from the Actions tab.
