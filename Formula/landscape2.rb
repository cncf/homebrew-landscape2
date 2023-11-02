class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.3.2/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "3be7a312728f969c2485d8f6449aea58b037e1fd3c2d34d95782330fe97d8a52"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.3.2/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "a68a04a7ea88dd824e6af2dfe5f16a3b8525a7f05b1ae90657324d27b741f8f2"
  end
  version "0.3.2"
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
