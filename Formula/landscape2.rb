class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.5.0"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.5.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "c6bbd732e0ffed55844117d5cbf31cfe0b4270043c57b10928a1b6834968fcf0"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.5.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "749d3e028bbc84ffd966739c29ee77acbf0d88566b670880178921ccaab2a2be"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.5.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a16f1e77c879f4b9a03da89bd9863ad49196daa67d775846e57031ed6436323c"
    end
  end
  license "Apache-2.0"

  def install
    bin.install "landscape2"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
