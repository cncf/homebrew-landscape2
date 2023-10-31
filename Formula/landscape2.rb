class Landscape2 < Formula
  desc "Landscape2 CLI tool"
  if Hardware::CPU.type == :arm
    url "https://github.com/cncf/landscape2/releases/download/v0.3.1/landscape2-aarch64-apple-darwin.tar.xz"
    sha256 "71afbb28aee5157fb65b7024844f29d21f36e23d786739d0fe0e4bd9a165603c"
  else
    url "https://github.com/cncf/landscape2/releases/download/v0.3.1/landscape2-x86_64-apple-darwin.tar.xz"
    sha256 "5d5ca98130e8013ac7fc98c729f4af2f8bf1cfd2bb8960e6bbafd1bf4a16acff"
  end
  version "0.3.1"
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
