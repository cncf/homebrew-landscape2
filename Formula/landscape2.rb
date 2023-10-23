class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.2.0/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "902c817f7ea236a56150fa09a8973a4bdf2d0d925af35a60b9d041018904d62c"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.2.0/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "e177ae014ec7eb81161a2beb5daeb519d4e5a4854bc07f8d7b923827ce84d65a"
  end
  version "0.2.0"
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
