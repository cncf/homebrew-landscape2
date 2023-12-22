class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  version "0.4.0"
  on_macos do
    on_arm do
      url "https://github.com/cncf/landscape2/releases/download/v0.4.0/landscape2-aarch64-apple-darwin.tar.xz"
      sha256 "24cda813ef1ff9ff68e5b0cb33b03c66009e52a7dbc764049445931c09945e43"
    end
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.4.0/landscape2-x86_64-apple-darwin.tar.xz"
      sha256 "2454847cf2dd203c4baf88b2729731909edd2ee88ff6bb3bb67ad58b024b7c52"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/cncf/landscape2/releases/download/v0.4.0/landscape2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed134135387d03fca21e16e3dc44db8f9df1f2bb9b5242384375685f82ab9b40"
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
