class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.3.3/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "833963c3eb0504318755e4ef5e7bd7d3dfd4acae5169ecbbaaa32dcbac2e9cc6"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.3.3/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "630cdf92b419ffff8090a87fd52bbc8044553eb6b4a0ef9305e4b16da90029ff"
  end
  version "0.3.3"
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
