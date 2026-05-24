class Claudedot < Formula
  desc "Claude environment sync — cross-machine config and history via git"
  homepage "https://github.com/bpeterme/claudedot"
  url "https://github.com/bpeterme/claudedot/archive/refs/tags/2026.05.24.2.tar.gz"
  sha256 "f04eb34023784465e4310854687dc238d066e9f682a5ac7ad8c2ea392923a9f9"
  license "MIT"

  head "https://github.com/bpeterme/claudedot.git", branch: "dev"

  def install
    version_str = build.head? ? "HEAD-#{`git rev-parse --short HEAD`.chomp}" : version.to_s
    inreplace "cdot.sh", '_CDOT_VERSION="dev"', "_CDOT_VERSION=\"#{version_str}\""
    bin.install "cdot.sh" => "cdot"
    (share/"claudedot").install "cdot.env.example"
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
