class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.3.0/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "eefbdf926c302d5ba78b5d157ef09a329fa4a57f61678f087995f98032f0e72b"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.3.0/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "fb3f347fee58ece4f32ed9b58ee7e22ced390d1487cb96432e79b8d7a95d4a43"
  end
  version "0.3.0"
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
