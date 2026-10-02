kind: manual

# System side of ChairLift (Control Center). The GUI is a user-scoped
# Homebrew cask, which cannot place root-owned files, so the image ships the
# fixed-path privileged helper, its PolicyKit policy, and the GSettings
# schemas from the same checksummed release archive the cask installs.
# The helper path is pinned by the policy's exec.path annotation. Keep this
# release in step with the cask's version (ublue-os/homebrew-tap
# Casks/chairlift.rb). The bootc policy and /usr/share/chairlift/config.yml
# come from common.bst.
sources:
- kind: tar
  (?):
  - arch == "x86_64":
      url: github_files:projectbluefin/chairlift/releases/download/v26.09.0-alpha.4/chairlift_26.09.0-alpha.4_linux_amd64.tar.gz
      ref: e6a56064d6df42e86d2f34da9a25e461e1466cd6778fb525cdffca15a59b4f81
  - arch == "aarch64":
      url: github_files:projectbluefin/chairlift/releases/download/v26.09.0-alpha.4/chairlift_26.09.0-alpha.4_linux_arm64.tar.gz
      ref: 554bddb1f91b09ad4a91789d50beda6b1c17245bd3bca9af78b05f203865b53d
  base-dir: ""

build-depends:
- core/sandbox-tools.bst
- freedesktop-sdk.bst:public-stacks/runtime-minimal.bst

depends:
- freedesktop-sdk.bst:components/polkit.bst

variables:
  strip-binaries: ""

config:
  install-commands:
  - |
    install -Dm755 -t "%{install-root}%{bindir}" chairlift-helper
  - |
    install -Dm644 -t "%{install-root}%{datadir}/polkit-1/actions" \
      data/io.projectbluefin.chairlift.ublue.policy
  - |
    install -Dm644 -t "%{install-root}%{datadir}/glib-2.0/schemas" \
      data/io.projectbluefin.chairlift.livery.gschema.xml \
      data/io.projectbluefin.chairlift.updates.gschema.xml \
      data/io.projectbluefin.chairlift.firstrun.gschema.xml
  - |
    %{install-extra}
