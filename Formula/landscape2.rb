class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.2.1/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "c20b6f378567062f7c165c3f9c18c9bcd6217813e007e4c642d4b55481c10853"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.2.1/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "414cb21f94e046292c07e262bc8521ed9249c65222f04a629a25c4eab2330eed"
  end
  version "0.2.1"
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
