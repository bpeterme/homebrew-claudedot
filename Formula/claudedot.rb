class Claudedot < Formula
  desc "Claude environment sync — cross-machine config and history via git"
  homepage "https://github.com/bpeterme/claudedot"
  url "https://github.com/bpeterme/claudedot/archive/refs/tags/2026.11.07.1.tar.gz"
  sha256 "5057d81ab6b12eb02391454c98a5bf5e7754b4a9bb1c34e2b2e9b1590327d461"
  license "MIT"

  head "https://github.com/bpeterme/claudedot.git", branch: "dev"

  def install
    version_str = build.head? ? "HEAD-#{`git rev-parse --short HEAD`.chomp}" : version.to_s
    inreplace "cdot.sh", '_CDOT_VERSION="dev"', "_CDOT_VERSION=\"#{version_str}\""
    bin.install "cdot.sh" => "cdot"
    (share/"claudedot").install "cdot.env.example"
    zsh_completion.install "completions/_cdot"
  end

  def caveats
    <<~EOS
      To configure claudedot, copy the example config:
        mkdir -p ~/.config/claudedot
        cp #{share}/claudedot/cdot.env.example ~/.config/claudedot/cdot.env

      Then connect to your sync remote:
        cdot config
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cdot version")
  end
end
